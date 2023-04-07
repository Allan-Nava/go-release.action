# Go Release Binary GitHub Action V2

Automate publishing Go build artifacts for GitHub releases through GitHub Actions.

Detects a build.sh in the go repo and will use that instead.  Expects a list of
file artifacts in a single, space delimited line as output for packaging.

Extra environment variables:
* CMD_PATH
  * Pass extra commands to go build
* EXTRA_FILES
  * Pass a list of extra files for packaging.
    * Example: EXTRA_FILES: "README.md LICENSE"

```yaml
# .github/workflows/release.yaml

on: release
name: Build Release
jobs:
  release-linux-386:
    name: release linux/386
    runs-on: ubuntu-latest
    permissions: write-all
    steps:
    - uses: actions/checkout@master
    - name: compile and release
      uses: Allan-Nava/go-release.action@vv1.4.0
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GOARCH: "386"
        GOOS: linux
        EXTRA_FILES: "LICENSE"
        #CMD_PATH: "cmd/main.go"  for example
    #
  release-linux-amd64:
    name: release linux/amd64
    runs-on: ubuntu-latest
    permissions: write-all
    steps:
    - uses: actions/checkout@master
    - name: compile and release
      uses: Allan-Nava/go-release.action@vv1.4.0
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GOARCH: amd64
        GOOS: linux
        EXTRA_FILES: "LICENSE"
        #CMD_PATH: "cmd/main.go"  for example
    #
  release-linux-arm:
    name: release linux/386
    runs-on: ubuntu-latest
    permissions: write-all
    steps:
    - uses: actions/checkout@master
    - name: compile and release
      uses: Allan-Nava/go-release.action@vv1.4.0
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GOARCH: "arm"
        GOOS: linux
        EXTRA_FILES: "LICENSE"
        #CMD_PATH: "cmd/main.go"  for example
    #
  release-linux-arm64:
    name: release linux/amd64
    runs-on: ubuntu-latest
    permissions: write-all
    steps:
    - uses: actions/checkout@master
    - name: compile and release
      uses: Allan-Nava/go-release.action@vv1.4.0
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GOARCH: arm64
        GOOS: linux
        EXTRA_FILES: "LICENSE"
        #CMD_PATH: "cmd/main.go"  for example
    #
  release-darwin-amd64:
    name: release darwin/amd64
    runs-on: ubuntu-latest
    permissions: write-all
    steps:
    - uses: actions/checkout@master
    - name: compile and release
      uses: Allan-Nava/go-release.action@vv1.4.0
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GOARCH: amd64
        GOOS: darwin
        EXTRA_FILES: "LICENSE"
        #CMD_PATH: "cmd/main.go"  for example
    #
  release-windows-386:
    name: release windows/386
    runs-on: ubuntu-latest
    permissions: write-all
    steps:
    - uses: actions/checkout@master
    - name: compile and release
      uses: Allan-Nava/go-release.action@vv1.4.0
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GOARCH: "386"
        GOOS: windows
        EXTRA_FILES: "LICENSE"
        #CMD_PATH: "cmd/main.go"  for example
    #
  release-windows-amd64:
    name: release windows/amd64
    runs-on: ubuntu-latest
    permissions: write-all
    steps:
    - uses: actions/checkout@master
    - name: compile and release
      uses: Allan-Nava/go-release.action@vv1.4.0
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GOARCH: amd64
        GOOS: windows
        EXTRA_FILES: "LICENSE"
        #CMD_PATH: "cmd/main.go"  for example
```