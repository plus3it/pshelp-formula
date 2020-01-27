[![license](https://img.shields.io/github/license/plus3it/pshelp-formula.svg)](./LICENSE)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/plus3it/pshelp-formula?branch=master&svg=true)](https://ci.appveyor.com/project/plus3it/pshelp-formula)

# pshelp-formula

This salt formula will update PowerShell help files.

## Dependencies
-   PowerShell 3.0 or greater. The formula uses an `onlyif` test to check the
    version and will not attempt to update Powershell help files if this
    dependency is not met.

## Available States

### pshelp

Update PowerShell help files.

## Configuration
No configuration is required.

## Formula Maintenance

To update the pshelp files in this git repo:

-   Deploy a plain vanilla ws2012r2 instance (this procedure will get pshelp
    files that can be used on any system with PowerShell 3.0 or later)
-   Follow AWS doc to attach a volume with the install media:
    -   <https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/windows-optional-components.html>
-   Open Server Manager, go to the "Features" page, and expand every arrow and
    select every feature
-   On the last page, select the option to specify an alternate installation media
    location, and provide the SxS location (for the .NET 3.5 features):
    -   `D:\Sources\SxS`
-   Once the features finish installing, restart the machine. The first login
    may restart the instance again, automatically.
-   Open a PowerShell window and run the following commands:
    -   `mkdir C:\pshelp`
    -   `Save-Help -Module * -DestinationPath C:\pshelp -Force -Verbose -ErrorAction SilentlyContinue`
    -   Ignore any errors...
-   Repeat the above steps for a ws2016 server. Do not install every feature,
    but at least install bitlocker, windows defender, and _all_ the remote server
    administration tools (rsat). Ignore host guardian hyper-v support, if it fails
    because virtualization is not enabled
-   Repeat the above steps for a ws2019 server. Do not install every feature,
    but at least install bitlocker, windows defender, and _all_ the remote server
    administration tools (rsat). Ignore host guardian hyper-v support, if it fails
    because virtualization is not enabled. Ignore network virtualization, if containers
    was selected
-   Purge the `pshelp/files/pshelp-content` directory in this repo of all files
-   Copy the pshelp files from both ws2012r2 and ws2016 to that directory
-   Commit the change
-   Test the formula on ws2008r2, ws2012r2, ws2016, win81, and win10
-   Open a pull request to merge the new content
