# Advanced Electronics Laboratory (MFN1324) <br/> University of Torino

Git repository for the Advanced Electronics Laboratory course (MFN1324) at University of Torino, Physics Department


# Contents

* [**Git configuration**](#git-configuration)
* [**Repository download**](#repository-download)
* [**UNIX environment setup**](#environment-setup)
* [**Sample simulation flow**](#sample-simulation-flow)
* [**Basic git commands**](#basic-git-commands)
* [**Webex lectures**](#webex-lectures)


# Git configuration
[**[Contents]**](#contents)

### Linux installation

In case `git` is not installed on your machine, use

```
% sudo yum install git
```

or

```
linux % sudo apt-get install git
```


### Windows installation

For Windows users, download and install **Git for Windows** from the project official page : 

```
https://gitforwindows.org
```


### Initial configuration

The first time you use `git`, type:

```
% git config --global user.name "Your Name"
% git config --global user.email your.email@example.com
```

You can check your configuration at any time with:

```
% git config --list
```


# Repository download
[**[Contents]**](#contents)

Download the repository using:


```
% cd Desktop
% git clone https://github.com/lpacher/lae.git [optional target directory]
```

By default a new `lae/` directory containing the repository will be created where you invoked the above `git` command, unless
you specify a different target directory as optional parameter.

As an example :


```
% cd Desktop
% git clone https://github.com/lpacher/lae.git LAE
```


You can create a `git root` alias to easily locate the Git top-level directory:

```
% cd lae
% git config --global alias.root "rev-parse --show-toplevel"
% git root
```

For setting up the proper command-line runtime environment, refer to section [**Environment setup**](#environment-setup).

** **WARN:** All `git` commands **must be invoked** inside the top `lae/` directory or from any other sub-directory of the repository !


# Environment setup
[**[Contents]**](#contents)

Sample scripts `sample/bashrc` and `sample/cshrc` for Linux, as well `sample/login.bat` for Windows are provided to support 
both `csh/tcsh` and `sh/bash/zsh` Linux shells and the Windows Command Prompt and to help students to setup the proper UNIX/Windows
runtime environment.

# Sample simulation flow
[**[Contents]**](#contents)

A small Verilog simulation example is provided to **test your environment setup** and **tools installation**.<br/>
Step-by-step instruction explaining how to run this test flow can be found [**here**](test/README.md).


# Basic git commands
[**[Contents]**](#contents)

A small collection of most frequentely used `git` **command-line syntax** for your day-to-day work and common tasks can be found [**here**](doc/git/README.md).
A more complete guide to the basic `git` commands can be found [**here**](http://doc.gitlab.com/ee/gitlab-basics/start-using-git.html).



# Webex lectures
[**[Contents]**](#contents)

* Lecture 1</br>
[Webek link](https://unito.webex.com/unito/j.php?MTID=m43898a5fdd9844dbfb3abc4dcf49b780)</br>
[Record link](https://unito.webex.com/recordingservice/sites/unito/recording/bf7ac1a2dc3d43dba524390112ee13db)

* Lecture 2 - TODO

