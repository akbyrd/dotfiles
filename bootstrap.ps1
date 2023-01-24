# TODO: Install winget?
winget install -s winget Git.Git
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";"
$env:Path += [System.Environment]::GetEnvironmentVariable("Path","User")
git clone https://github.com/akbyrd/config.git
./config/setup.ps1
