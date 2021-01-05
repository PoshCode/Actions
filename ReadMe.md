# GitHub Actions for Building and Testing PowerShell modules

I'm working on some actions for myself, but figured I'd put them here where others can use them.

They are currently very much a work in progress, not documented, and the Pester step in particular isn't fully working. Also, because they're all packaged together like this, I'm not versioning them very well for now, so when there are breaking changes, it won't be very clear which task changed.

For an example of how to use these, see my [Configuration](https://github.com/PoshCode/Configuration) module.

## Build-Module

This one's a simple wrapper for [ModuleBuilder](https://github.com/PoshCode/ModuleBuilder) to call Build-Module on every build.psd1 in your repository.

Note that this **requires** you to write the `build.psd1` manifest with appropriate values.

## GitVersion

A simple cross-platform wrapper for [GitVersion](https://github.com/GitTools/GitVersion) which caches the binary and runs gitversion in your repo. All the [GitVersion Output Variables](https://gitversion.net/docs/more-info/variables) are exposed on the output of the action.

Note that you should already have a `gitversion.yml` in your repository for this to work well.

# Install-RequiredModules

This is a wrapper for my [RequiredModules](https://github.com/Jaykul/RequiredModules) installer, which handles installing (and optionally, importing) specific versions of modules for build processes. Although this task is here, several of my other tasks use `Install-RequiredModules.ps1` as their way of ensuring the modules _they_ need are present.

To use this, you will need a `RequiredModules.psd1` in your repository. It does not support specifying your dependencies as inputs.

# Pester

This is a simple wrapper for [Pester](https://github.com/Pester/Pester) which supports Gherkin (if you specify a version of Pester that includes it, like 4.10.1 but not 5.x) and outputs a results.xml and (optionally) coverage.xml

Currently, this doesn't really _handle_ the test results, and does not _publish_ the two output xml files. It fails if pester fails, but there's no test reports or code coverage report or any of that yet. You'll want to add a step to capture this output like:

```yaml
- name: Upload Results
  uses: actions/upload-artifact@v2
  with:
    name: Pester Results
    path: ${{github.workspace}}/*.xml
```