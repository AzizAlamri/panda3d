Nirai's Panda3D
=======

Panda3D is a game engine, a framework for 3D rendering and game development for
Python and C++ programs.  Panda3D is open-source and free for any purpose,
including commercial ventures, thanks to its
[liberal license](https://www.panda3d.org/license.php).  To learn more about
Panda3D's capabilities, visit the [gallery](https://www.panda3d.org/gallery.php)
and the [feature list](https://www.panda3d.org/features.php).  To learn how to
use Panda3D, check the [documentation](https://www.panda3d.org/documentation.php)
resources. If you get stuck, ask for help from our active
[community](https://www.panda3d.org/community.php).

Panda3D is licensed under the Modified BSD License.  See the LICENSE file for
more details.

Building Panda3D
================

Windows
-------

You can build Panda3D with the Microsoft Visual C++ 2015 or 2017 compiler,
which can be downloaded for free from the [Visual Studio site](https://visualstudio.microsoft.com/downloads/).
You will also need to install the [Windows 10 SDK](https://developer.microsoft.com/en-us/windows/downloads/windows-10-sdk),
and if you intend to target Windows XP, you will also need the
[Windows 7.1 SDK](https://www.microsoft.com/en-us/download/details.aspx?id=8279).

You will also need to have the third-party dependency libraries available for
the build scripts to use. These are available from the [third-party repository](https://github.com/nirai-compiler/thirdparty). Place the third-party directory into your Panda3D source directory.

After acquiring these dependencies, you may simply build Panda3D from the
command prompt using the following command.  (Change `14.1` to `14` if you are
using Visual C++ 2015 instead of 2017.  Add the `--windows-sdk=10` option if
you don't need to support Windows XP and did not install the Windows 7.1 SDK.)

```bash
compile.bat
postbuild.bat
```

_postbuild_ cleans up the _built_ dir.

Linux
-----

On Linux, you will need to obtain the relevant third-party dependencies for Nirai's Panda3D via means that your distro provides. You may visit [this manual page](https://www.panda3d.org/manual/index.php/Dependencies) for an overview of the various dependencies.

If you are on Ubuntu, this command should cover the
third-party packages:

```bash
sudo apt-get install build-essential pkg-config python-dev libpng-dev libjpeg-dev libtiff-dev zlib1g-dev libssl-dev libx11-dev libgl1-mesa-dev libxrandr-dev libxxf86dga-dev libxcursor-dev bison flex libfreetype6-dev libvorbis-dev libeigen3-dev libopenal-dev libode-dev libbullet-dev nvidia-cg-toolkit libgtk2.0-dev libassimp-dev libopenexr-dev
```

After acquiring the dependencies, you may simply build Panda3D from the terminal
using the following command:

```bash
./compile.sh
./postbuild.sh
```

_postbuild_ cleans up the _built_ dir.

macOS
--------

You will need to have the macOS third-party dependencies available for
the build scripts to use. These are available from the [third-party repository](https://github.com/nirai-compiler/thirdparty). Place the third-party directory into your Panda3D source directory.

After acquiring these dependencies, you may simply build Panda3D from the terminal
using the following command:

```bash
./compile.sh
./postbuild.sh
```

_postbuild_ cleans up the _built_ dir.
