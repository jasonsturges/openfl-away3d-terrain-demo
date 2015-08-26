# OpenFL Away3D Terrain Demo
3D terrain demo using OpenFL, Away3D, and Haxe


# Getting started

This is a [Haxe](http://haxe.org/) project, demonstrating a basic 3D terrain with water and skybox, built with [OpenFL](http://www.openfl.org/) and [Away3D](http://away3d.com/).

### Install Haxe

If you don't already have Haxe installed, start by [installing](http://haxe.org/download/) either Mac, Linux, or Windows packages.

### Library Dependencies

If this is your first time running haxelib, setup by executing the following command:

    $ haxelib setup

Install Lime:

    $ haxelib install lime
    $ haxelib run lime setup
    
Install OpenFL:

    $ haxelib install openfl
    $ haxelib run openfl setup
    
Install Away3D:

    $ haxelib install away3d

Note that with the current production Away3D v1.1.0 from haxelib, you may receive an error from `ArrayUtils.hx` when running this example:

> /usr/lib/haxe/lib/away3d/1,1,0/away3d/utils/ArrayUtils.hx:76: characters 15-89 : Type not found : A

Until the Away3D haxelib is updated, use the latest git repository by cloning the repo for use as a development haxelib:

	$ git clone https://github.com/away3d/away3d-core-openfl.git
	$ haxelib dev away3d ./away3d-core-openfl


# Building and running

To run, call `openfl` with a target, such as:

    $ cd openfl-away3d-terrain-demo/
    $ openfl test flash

And you end up with:

![screen-capture](http://labs.jasonsturges.com/openfl/openfl-away3d-terrain-demo/openfl-away3d-terrain-demo.jpg)

- Mouse down &mdash; move camera
- <kbd>f</kbd> &mdash; Launch Full Screen
- <kbd>w</kbd> or <kbd>Arrow Up</kbd> &mdash; forward
- <kbd>s</kbd> or <kbd>Arrow Down</kbd> &mdash; backward
- <kbd>a</kbd> or <kbd>Arrow Left</kbd> &mdash; left
- <kbd>d</kbd> or <kbd>Arrow Right</kbd> &mdash; right
