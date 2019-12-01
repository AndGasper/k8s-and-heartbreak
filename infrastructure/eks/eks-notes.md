# Amazon Elastic Kubernetes Service (Amazon EKS)

- Because I am a psychopath, apparently.

- [Choclatey: Install](https://chocolatey.org/install)
    - [Install using PowerShell from cmd.exe](https://chocolatey.org/courses/installation/installing?method=install-using-powershell-from-cmdexe)
    - [Chocolatey PS1](https://chocolatey.org/install.ps1)
    - Let's get real: npm install is just as risky a blackbox without reading through the source code, but it is good to know it is available.

- There's a special place in purgatory for the creators of:
- Windows
- Linux (inb4 it's actually GNU Linux or whatever the hell it really it is)
- Really anything; I'm starting to think the Amish might really be onto something.


## Windows Setup
- I'm primarily a linux flavor guy + bash, so join me as I go down the _How the hell do I get a powershell script to run from bash?_ path.

- [Get Process](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-process?view=powershell-6)
    - There's some interesting tidbits in there.

```
Get-Process pwsh -FileVersionInfo
```
```
Get-Process powershell -FileVersionInfo

ProductVersion   FileVersion      FileName
--------------   -----------      --------
10.0.18362.1     10.0.18362.1 ... C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
10.0.18362.1     10.0.18362.1 ... C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe
```

So I don't forget:
```
r - 4
w - 2
x - 1
```
```
user, group, owner
7   ,  5    , 5
rwx, rx, rx
```
- What do you know? One of those computer classes I took in college that everyone was like, "Why?" continues to pay out.

And I think `chmod +x` is a bit broad. Or maybe more narrow. I don't feel like getting into it right now.

### What's the deal with `$(thing)`?
- Command Substitution
- > `$(command)` or `` `command` ``
- I'm _sure_ there's more to it than this, but for now, this'll do.
- So:
```
local powershell_script=$(find_powershell_path)
```