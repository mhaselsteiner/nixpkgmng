## Install via nix
Nix is used as a package manager.
To check avaiable software packages on this machine run:
```
nix-env -qaP
```
since nix version 2.0 you can search for packages using
```
nix search
```
to install software packages globally run:
```
nix-env -iA nixpkgs.[package name]
```
BETTER:
add all desired packages to myPkgs in config.nix.
Then run:
```
nix-env -iA nixpkgs.myPkgs
```
This way you always have a good overview of all the installed software.

## Python
When using different maybe conflicting python version install one globally,
set up all others as environments in your config and use them in nix-shells.
To change the python environment in the nix shell run
```
nix-shell -p [ name of customized python package e.g. 'myPythonEnv3']
```

To install single packages in the shell run
```
nix-shell -p [attribute name without nixpkg.]
```
## Configure Software
If possible configure software in config.nix.
This ensures, especially for pluggins, all libaries and dependcies are managed properly and avoids conflicts.
Also you only have to put only one file in your vc, that provides the entire info.

## Garbage collection
Do not use garbage collection yourself. 
It might remove stuff, that will take ages to be downloaded and running again when needed next time. 

