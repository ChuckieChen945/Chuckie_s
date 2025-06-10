

$variables = @(
    @{ name = 'version'; value = $version },
    @{ name = 'architecture'; value = $architecture },
    @{ name = 'bucket'; value = $bucket },
    @{ name = 'bucketsdir'; value = $bucketsdir },
    @{ name = 'persist_dir'; value = $persist_dir },
    @{ name = 'global'; value = $global },
    @{ name = 'env:SCOOP'; value = $env:SCOOP },
    @{ name = 'dir'; value = $dir },
    @{ name = 'extract_dir'; value = $extract_dir },
    @{ name = 'manifest_path'; value = $manifest_path },
    @{ name = 'cache_dir'; value = $cache_dir },
    @{ name = 'config_dir'; value = $config_dir },
    @{ name = 'env:SCOOP_HOME'; value = $env:SCOOP_HOME },
    @{ name = 'app'; value = $app },
    @{ name = 'env:AppData'; value = $env:AppData },
    @{ name = 'env:LocalAppData'; value = $env:LocalAppData },
    @{ name = 'pwd'; value = $pwd },
    @{ name = 'PSScriptRoot'; value = $PSScriptRoot },
    @{ name = 'MyInvocation'; value = $MyInvocation },
    @{ name = 'manifest'; value = $manifest },
    @{ name = 'url'; value = $url }
)




function Show-VarInfo {
    param (
        [string]$name,
        $value
    )

    if ($null -ne $value) {
        $type = $value.GetType().Name
        Write-Host ("  • `$${name}".PadRight(24) + "$value".PadRight(40) + "($type)") -ForegroundColor DarkCyan
    }
    else {
        Write-Host ("  • `$${name}".PadRight(24) + "<null>".PadRight(40) + "(null)") -ForegroundColor DarkGray
    }
}


function Show-VarInfoList {

    foreach ($item in $variables) {
        Show-VarInfo -name $item.name -value $item.value
    }


}
