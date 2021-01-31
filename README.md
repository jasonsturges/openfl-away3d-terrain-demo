# OpenFL Away3D Terrain Demo
3D terrain demo using OpenFL, Away3D, and Haxe

Launch demo: https://jasonsturges.github.io/openfl-away3d-terrain-demo/
![screen-capture](http://labs.jasonsturges.com/haxe/openfl/away3d/terrain-demo/screenshot.png)

- Mouse down &mdash; move camera
- <kbd>f</kbd> &mdash; Launch Full Screen
- <kbd>w</kbd> or <kbd>Arrow Up</kbd> &mdash; forward
- <kbd>s</kbd> or <kbd>Arrow Down</kbd> &mdash; backward
- <kbd>a</kbd> or <kbd>Arrow Left</kbd> &mdash; left
- <kbd>d</kbd> or <kbd>Arrow Right</kbd> &mdash; right


## Getting started

This is a [Haxe](http://haxe.org/) project, demonstrating a basic 3D terrain with water and skybox, built with [OpenFL](http://www.openfl.org/) and [Away3D](http://away3d.com/).

### Install Haxe

If you don't already have Haxe installed, start by [installing](http://haxe.org/download/) either Mac, Linux, or Windows packages.

### Library Dependencies

If this is your first time running haxelib, setup by executing the following command:

    $ haxelib setup

#### Install Lime

    $ haxelib install lime
    $ haxelib run lime setup
    
#### Install OpenFL

    $ haxelib install openfl
    $ haxelib run openfl setup
    
#### Install Away3D

    $ haxelib install away3d


## Building and running

To run, call `openfl test` with a target, such as:

    $ cd openfl-away3d-terrain-demo/
    $ openfl test html5


## Troubleshooting

For other compiler errors, make sure libraries are updated to the latest versions by calling:

    $ haxelib upgrade


## License

This project is free, open-source software under the [MIT license](LICENSE.md).

Copyright 2015-2017 [Jason Sturges](http://jasonsturges.com)
