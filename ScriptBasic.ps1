write-output "Hello world"

#region 1 PowerShell scripting - difference between write-output and write-host
function Receive-Output 
{
    process { write-host $_ -ForegroundColor Green}
}

write-output "this is a test" | Receive-Output
write-host "this is a test 2" | Receive-Output
#endregion

#region 2 PowerShell Scripting - difference between ' and "

$name = "John"

Write-output "hello $name"
write-output 'hello $name'

#endregion

#region 3 PowerShell Scripting - Read-Host

$name = Read-host "who are you?"
$pass = Read-Host "what's your password" -AsSecureString
[Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pass))

#endregion

#region 4 PwerShell Scripting - user input

Param(
[Parameter(Mandatory=$true)][string]$computername)
get-CimInstance -ClassName win32_computersystem -ComputerName $computername | format-list numberofprocessors,totalphysicalmemory

Param(
    [Parameter(mandatory=$true)][string[]]$computers)
    foreach ($computername in $computers)
    {
        $win32CSOut = get-CimInstance -ClassName winew_computersystem -ComputerName $computername
        $win32OSOut = get-CimInstance -ClassName win32_operatingsystem -ComputerName $computername
        
        $paramout = @{'ComputerName'=$computername;
            'Memory'=$win32CSOut.totalphysicalmemory;
            'Free Memory'=$win32OSOut.freephysicalmemory;
            'Procs'=$win32CSOut.numberofprocessors;
            'Version'=$win32OSOut.version}

        $outobj = New-Object -TypeName PSObject -Property $paramout
        write-output $outobj
    }

#endregion

