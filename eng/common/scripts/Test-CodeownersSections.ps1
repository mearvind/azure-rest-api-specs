# cSpell:ignore CODEOWNERS
<#
  .SYNOPSIS
  Tests that specified CODEOWNERS sections are identical between two file versions.

  .DESCRIPTION
  Uses the azsdk CLI to export named sections from a "before" and "after" copy of
  the CODEOWNERS file.  If any of the specified sections differ between the two
  files the script exits with code 1.

  All filesystem and git setup (creating the before/after files, installing the
  CLI, etc.) is expected to be done by the calling pipeline step template.

  .PARAMETER AzsdkCliPath
  Path to the azsdk CLI executable.

  .PARAMETER BeforeFile
  Path to the CODEOWNERS file representing the base state (e.g. parent commit).

  .PARAMETER AfterFile
  Path to the CODEOWNERS file representing the current state (e.g. PR head).

  .PARAMETER Sections
  An array of section names to compare (e.g. "Client Libraries").

  .PARAMETER TempDirectory
  Scratch directory for intermediate section export files.
#>
[CmdletBinding()]
param (
  [Parameter(Mandatory)]
  [string] $AzsdkCliPath,

  [Parameter(Mandatory)]
  [string] $BeforeFile,

  [Parameter(Mandatory)]
  [string] $AfterFile,

  [Parameter(Mandatory)]
  [string[]] $Sections,

  [string] $TempDirectory = (Join-Path ([System.IO.Path]::GetTempPath()) "codeowners-check")
)

."$PSScriptRoot\common.ps1"

Set-StrictMode -Version 3
$ErrorActionPreference = "Stop"

$codeownersHelpUrl = "https://aka.ms/azsdk/codeowners"
$detailGroupTitle = "Protected CODEOWNERS section validation details"
$collapseValidationDetails = Test-SupportsDevOpsLogging

function getActionableCodeownersFailure([string] $Message) {
  $nextStep = if ($collapseValidationDetails) {
    " Expand '$detailGroupTitle' in the log for the section diffs and export output."
  } else {
    ""
  }

  return "See $codeownersHelpUrl. $Message$nextStep"
}

function writeValidationIssue([string] $Message) {
  if ($collapseValidationDetails) {
    Write-Host "[ERROR] $Message"
  } else {
    LogError $Message
  }
}

# ---------------------------------------------------------------------------
# 1. Validate inputs
# ---------------------------------------------------------------------------
$changedSections = @()
$finalError = $null

try {
  if (-not (Test-Path $BeforeFile)) {
    throw "BeforeFile not found: $BeforeFile"
  }
  if (-not (Test-Path $AfterFile)) {
    throw "AfterFile not found: $AfterFile"
  }
  if (-not (Test-Path $AzsdkCliPath)) {
    throw "azsdk CLI not found: $AzsdkCliPath"
  }

  # ---------------------------------------------------------------------------
  # 2. Ensure temp directory exists
  # ---------------------------------------------------------------------------
  if (-not (Test-Path $TempDirectory)) {
    New-Item -ItemType Directory -Path $TempDirectory -Force | Out-Null
  }

  # ---------------------------------------------------------------------------
  # 3. Export and compare each section
  # ---------------------------------------------------------------------------
  if ($collapseValidationDetails) {
    LogGroupStart $detailGroupTitle
  }

  try {
    $beforePath = Resolve-Path $BeforeFile
    Write-Host "Before file: $beforePath"
    $afterPath  = Resolve-Path $AfterFile
    Write-Host "After file:  $afterPath"

    foreach ($section in $Sections) {
      $safeName      = $section -replace ' ', '_'
      $beforeSection = Join-Path $TempDirectory "before.${safeName}.txt"
      $afterSection  = Join-Path $TempDirectory "after.${safeName}.txt"

      Write-Host "Exporting section '$section' from before file..."
      & $AzsdkCliPath config codeowners export-section --codeowners-path $beforePath --section $section --output-file $beforeSection
      if ($LASTEXITCODE) {
        throw "Failed to export section '$section' from before file (exit code $LASTEXITCODE)."
      }

      Write-Host "Exporting section '$section' from after file..."
      & $AzsdkCliPath config codeowners export-section --codeowners-path $afterPath --section $section --output-file $afterSection
      if ($LASTEXITCODE) {
        throw "Failed to export section '$section' from after file (exit code $LASTEXITCODE)."
      }

      $beforeContent = Get-Content -Path $beforeSection -Raw
      $afterContent  = Get-Content -Path $afterSection -Raw

      if ($beforeContent -ne $afterContent) {
        $changedSections += $section
        writeValidationIssue "Protected CODEOWNERS section '$section' has been modified. Changes to this section are not allowed through normal PRs."
        Write-Host "--- Diff for section '$section' ---"
        Write-Host ""
        git diff --no-index -- $beforeSection $afterSection
      } else {
        Write-Host "Section '$section' is unchanged."
      }
    }
  } finally {
    if ($collapseValidationDetails) {
      LogGroupEnd
    }
  }

  if (@($changedSections).Count -gt 0) {
    $sectionList = ($changedSections | ForEach-Object { "'$_'" }) -join ", "
    $finalError = getActionableCodeownersFailure("Protected CODEOWNERS sections were modified: $sectionList. Revert those section edits or follow the CODEOWNERS update process, then rerun validation.")
  }
} catch {
  $finalError = getActionableCodeownersFailure("Protected CODEOWNERS section validation could not complete: $($_.Exception.Message)")
}

if ($finalError) {
  LogError $finalError
  exit 1
}

Write-Host "All protected CODEOWNERS sections are unchanged. Check passed."
exit 0
