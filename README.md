# Advanced Electronics Laboratory (MFN1324) <br/> University of Torino

Git repository for the _Advanced Electronics Laboratory_ course (MFN1324) at University of Torino, Physics Department.<br/>
Lecture slides and additional course material available
on the [**main CampusNet course page**](https://fisica.campusnet.unito.it/do/corsi.pl/Show?_id=70d4).

# Contents

* [**Git configuration**](#git-configuration)
* [**Repository download**](#repository-download)
* [**Create your personal development branch**](#create-your-personal-development-branch)
* [**UNIX environment setup**](#environment-setup)
* [**Sample Xilinx Vivado simulation flow**](#sample-xilinx-vivado-simulation-flow)
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
% sudo apt-get install git
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


# Create your personal development branch
[**[Contents]**](#contents)

By default, the first time you download the repository you are in the `master` branch.
The `master` branch should always represent the "stable version" of the project :

```
% git branch
*master
```

The asterisk indicates the **current working branch**.


As a first step after downloading the repository for the first time
**create your personal development branch** named `student` :

```
% git branch student
% git checkout student
```

You can now **list all branches** in your local machine with :

```
% git branch
master
*student
```

Please, be sure that the asterisk now points to your own development branch `student` and not to the `master` branch.


# Environment setup
[**[Contents]**](#contents)

Sample scripts `sample/bashrc` and `sample/cshrc` for Linux, as well `sample/login.bat` for Windows are provided to support 
both `csh/tcsh` and `sh/bash/zsh` Linux shells and the Windows Command Prompt and to help students to setup the proper UNIX/Windows
runtime environment.

# Sample Xilinx Vivado simulation flow
[**[Contents]**](#contents)

A small Verilog simulation example is provided to **test your environment setup** and **tools installation**.<br/>
Step-by-step instruction explaining how to run this test flow can be found [**here**](fpga/test/README.md).


# Basic git commands
[**[Contents]**](#contents)

A small collection of most frequentely used `git` **command-line syntax** for your day-to-day work and common tasks can be found [**here**](doc/git/README.md).
A more complete guide to the basic `git` commands can be found [**here**](http://doc.gitlab.com/ee/gitlab-basics/start-using-git.html).



# Webex lectures
[**[Contents]**](#contents)

**PART I - Dott. Pacher [40 h]**

* Lecture 1<br/>
[**[Webex link]**](https://unito.webex.com/unito/j.php?MTID=m43898a5fdd9844dbfb3abc4dcf49b780)<br/>
[**[Record link]**](https://unito.webex.com/recordingservice/sites/unito/recording/bf7ac1a2dc3d43dba524390112ee13db)

* Lecture 2<br/>
[**[Webex link]**](https://unito.webex.com/unito/j.php?MTID=m72f73fcda2b25e3710dfa22e3de0b1af)<br/>
[**[Record link]**](https://unito.webex.com/recordingservice/sites/unito/recording/play/5d89e415fb83422ca4400d35aecdc026)

* Lecture 3<br/>
[**[Webex link]**](https://unito.webex.com/unito/j.php?MTID=med80880534a0d09bb2c23ee393302382)<br/>
[**[Record link]**](https://unito.webex.com/recordingservice/sites/unito/recording/play/462fdafa9e2e45629207c88bdb16e141)


* Lecture 4<br/>
[**[Webex link]**](https://unito.webex.com/unito/j.php?MTID=m313e97db933a759d6ef614e8ce86d2bd)<br/>
[**[Record link]**](https://unito.webex.com/recordingservice/sites/unito/recording/play/4a5d0d36ca234faebb5c0d1396ac13c7)

* Lecture 5<br/>
[**[Webex link]**](https://unito.webex.com/unito/j.php?MTID=m7d5ab6afc3af8e273bb4a331af162868)<br/>
[**[Record link]**](https://unito.webex.com/recordingservice/sites/unito/recording/play/a66b8e5d30c4414388c3ec7f97e36237)

* Lecture 6<br/>
[**[Webex link]**](https://unito.webex.com/unito/j.php?MTID=m05a2f116b9c8118578730741706dec2e)<br/>
[**[Record link]**](https://unito.webex.com/recordingservice/sites/unito/recording/play/268f2f7d725745dd81e2ccbec7ec2736)

* Lecture 7<br/>
[**[Webex link]**](https://unito.webex.com/unito/j.php?MTID=m5105d294f230ba61635913578ad3c967)<br/>
[**[Record link]**](https://unito.webex.com/recordingservice/sites/unito/recording/play/a08974e4489b4cddbb788483470856de)

* Lecture 8<br/>
[**[Webex link]**](https://unito.webex.com/unito/j.php?MTID=m4034eb89f9782fad79c4607b90eedaab)<br/>
[**[Record link]**](https://unito.webex.com/recordingservice/sites/unito/recording/play/a76c8138b3b84b218b9e1939f39da304)

* Lecture 9<br/>
[**[Webex link]**](https://unito.webex.com/unito/j.php?MTID=mac33ab0c4781c9a304a23db6fe0479c9)<br/>
[**[Record link]**](https://unito.webex.com/recordingservice/sites/unito/recording/play/b00e5bce85a64061bd9932628de607aa)

* Lecture 10<br/>
[**[Webex link]**](https://unito.webex.com/unito/j.php?MTID=me5f4409644da9c4af862fc9fbd1375ff)<br/>
[**[Record link]**](https://unito.webex.com/recordingservice/sites/unito/recording/play/299f3d7acbb34901967b4417a7f685b1)

* Lecture 11<br/>
[**[Webex link]**](https://unito.webex.com/unito/j.php?MTID=m61685b12e338a43b0c32d0fd0a3f7a1b)<br/>
[**[Record link]**](https://unito.webex.com/recordingservice/sites/unito/recording/play/9a752bb09cde401ab3450d2545118d67)

* Lecture 12<br/>
[**[Webex link]**](https://unito.webex.com/unito/j.php?MTID=mef337034b18e93a0eecaefb7585358e8)<br/>
[**[Record link]**](https://unito.webex.com/unito/ldr.php?RCID=d19145725fe94734923fa7b7a3ba1f17)

* Lecture 13<br/>
[**[Webex link]**](https://unito.webex.com/unito/j.php?MTID=m51569265f9f7afd063580f9e77a92421)<br/>
[**[Record link]**](https://unito.webex.com/recordingservice/sites/unito/recording/play/0d7235d75566466790ee6d0019592ab5)

* Lecture 14<br/>
[**[Webex link]**](https://unito.webex.com/unito/j.php?MTID=m5c893d768da7289d65884936d26eba03)<br/>
[**[Record link]**](https://unito.webex.com/recordingservice/sites/unito/recording/play/7e3a27cb407f4b089a5a59c16c6a4326)

* Lecture 15<br/>
[**[Webex link]**](https://unito.webex.com/unito/j.php?MTID=mff702cc24ddbcf389a6260e041e29c6c)<br/>
[**[Record link]**](https://unito.webex.com/recordingservice/sites/unito/recording/playback/b6ef302c3f0b4c89b6f36dc1acbd6337)

* Lecture 16</br>
[**[Webex link]**](https://unito.webex.com/unito/j.php?MTID=m1a1ea0cb3ca628b6d2d65e7c2be24c18)<br/>
[**[Record link]**](https://unito.webex.com/recordingservice/sites/unito/recording/play/d5eab66c10984caa9bf464efe3eeb574)

* Lecture 17</br>
[**[Webex link]**](https://unito.webex.com/unito/j.php?MTID=m0b5d1dc9116ace3b104316e6f4a2b919)<br/>
[**[Record link]**](https://unito.webex.com/recordingservice/sites/unito/recording/play/a5bafd58d8c4498191ee5cf47b259e86)

* Lecture 18</br>
