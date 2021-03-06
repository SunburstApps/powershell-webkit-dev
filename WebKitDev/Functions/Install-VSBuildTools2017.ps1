# Copyright (c) 2017, the WebKit for Windows project authors.  Please see the
# AUTHORS file for details. All rights reserved. Use of this source code is
# governed by a BSD-style license that can be found in the LICENSE file.

<#
  .Synopsis
  Installs Visual Studio Build Tools 2017.

  .Description
  Downloads VS Build Tools and installs it silently on the host.

  .Parameter InstallationPath
  The location to install to.
#>
Function Install-VSBuildTools2017 {
  Param(
    [Parameter()]
    [string[]] $workloads = @('Microsoft.VisualStudio.Workload.VCTools'),
    [Parameter()]
    [AllowNull()]
    [string] $installationPath
  )

  $url = 'https://download.microsoft.com/download/5/A/8/5A8B8314-CA70-4225-9AF0-9E957C9771F7/vs_BuildTools.exe';

  $options = @(
    '--quiet',
    '--norestart',
    '--nocache',
    '--wait'
  );

  foreach ($workload in $workloads) {
    $options += @('--add', $workload);
  }

  if ($installationPath) {
    $options += @('--installPath', ('/dir="{0}"' -f $installationPath));
  }

  Install-FromExe -Name 'VSBuildTools2017' -Url $url -Options $options -NoVerify;
}
