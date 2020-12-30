# mowito's Navigation Stack

- [Complete Documentation](https://mowito-navstack.readthedocs.io/)


- [Setting Up Mowito](https://mowito-navstack.readthedocs.io/en/latest/Installation.html)


- [How to use](https://mowito-navstack.readthedocs.io/en/latest/how_to_use.html)

## Instructions for running setup_mowito.sh

- Usage:

`setup_mowito.sh`  

`setup_mowito.sh -h`

`setup_mowito.sh [rosversion]`

`setup_mowito.sh [rosversion] [arch-version] skip-depends`

### Arguements
- `-h`          : Help, display usage
- `rosversion`   : Version of ROS installed(noetic/melodic). Defaults to melodic if not specified
- `arch-version` : Archtecture to be installed (amd64/arm64). Defaults to amd64 if not specified
- `skip-depends` : Skip installing dependencies (optional). Installs dependencies if not specified

## Example
```
./setup_mowito.sh noetic amd64 
```
Installs noetic amd64 debians 
