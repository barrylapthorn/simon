#!/usr/bin/env pwsh

[CmdletBinding()]
param (
  [Parameter()]
  [string]
  $action = "dev"
)

$scriptpath = $MyInvocation.MyCommand.Path
$projectDir = Split-Path $scriptpath
$theme = "hugo-theme-earth"

function Run-NodeJs() {
  Copy-Item $projectDir\themes\$theme\package*json $projectDir\
  $old = $env:NODE_ENV
  $env:NODE_ENV = ""
  #  We want the dev dependencies installed.
  #  https://stackoverflow.com/a/34719468
  npm install
  $env:NODE_ENV = $old
}

function Run-HugoServeDev() {
  Run-NodeJs
  $env:NODE_ENV = "development"
  hugo serve
}

function Run-HugoServeProd() {
  Run-NodeJs
  $env:NODE_ENV = "production"
  hugo -e production --minify serve
}

function Run-HugoProdBuild() {
  Run-NodeJs
  $env:NODE_ENV = "production"
  hugo -e production --minify
}

switch ($action) {
  "dev" {
    Run-HugoServeDev
  }
  "prod" {
    Run-HugoServeProd
  }
  "build" {
    Run-HugoProdBuild
  }
  Default {
    Write-Host "One of:  dev/prod/build"
  }
}
