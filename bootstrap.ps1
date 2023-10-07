$SysEnv = [System.Environment]
$EnvVar = [System.EnvironmentVariableTarget]

winget install -s winget Git.Git

$userPath = $SysEnv::GetEnvironmentVariable("Path", $EnvVar::User)
$machPath = $SysEnv::GetEnvironmentVariable("Path", $EnvVar::Machine)

# Add script folder to path
$cwd = (Get-Location).Path
$userPath = "$userPath;$cwd\dotfiles\script"
$SysEnv::SetEnvironmentVariable("Path", $userPath, $EnvVar::User)

# Update Path so git can be used
$env:Path = "$machPath;$userPath"

git clone https://github.com/akbyrd/dotfiles.git
./config/setup.ps1
