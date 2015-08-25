/*
     |      | _)  |    |   _)
     __ \   |  |  __|  __|  |  __ \    _` |
     |   |  |  |  |    |    |  |   |  (   |
    _.__/  _| _| \__| \__| _| _|  _| \__, |
                                     |___/
    Blitting, http://blitting.com
    Copyright (c) 2015 Jason Sturges, http://jasonsturges.com
*/
package;

import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.ui.Keyboard;
import openfl.events.KeyboardEvent;
import away3d.controllers.FirstPersonController;

class Away3dFirstPersonViewport extends Away3dViewport {

//------------------------------
//  model
//------------------------------

    public var cameraController:FirstPersonController;

    public var distanceIncrement:Float = 0;
    public var distanceSpeed:Float = 1000;
    public var panIncrement:Float = 0;
    public var panSpeed:Float = 2;
    public var tiltIncrement:Float = 0;
    public var tiltSpeed:Float = 2;

    public var moving:Bool = false;
    public var lastPanAngle:Float;
    public var lastTiltAngle:Float;
    public var lastMouseX:Float;
    public var lastMouseY:Float;

    public var drag:Float = 0.5;
    public var walkIncrement:Float = 2;
    public var strafeIncrement:Float = 2;
    public var walkSpeed:Float = 0;
    public var strafeSpeed:Float = 0;
    public var walkAcceleration:Float = 0;
    public var strafeAcceleration:Float = 0;


//------------------------------
//  lifecycle
//------------------------------

    public function new() {
        super();
    }

    override public function initialize():Void {
        super.initialize();
    }

    override public function initializeCamera():Void {
        super.initializeCamera();

        cameraController = new FirstPersonController(camera, 180, 0, -80, 80);
    }

    override public function prerender():Void {
        super.prerender();

        if (moving) {
            cameraController.panAngle = 0.3 * (stage.mouseX - lastMouseX) + lastPanAngle;
            cameraController.tiltAngle = 0.3 * (stage.mouseY - lastMouseY) + lastTiltAngle;
        }

        if (walkSpeed != 0 || walkAcceleration != 0) {
            walkSpeed = (walkSpeed + walkAcceleration) * drag;
            if (Math.abs(walkSpeed) < 0.01)
                walkSpeed = 0;
            cameraController.incrementWalk(walkSpeed);
        }

        if (strafeSpeed != 0 || strafeAcceleration != 0) {
            strafeSpeed = (strafeSpeed + strafeAcceleration) * drag;
            if (Math.abs(strafeSpeed) < 0.01)
                strafeSpeed = 0;
            cameraController.incrementStrafe(strafeSpeed);
        }
    }

    override public function keyDownHandler(event:KeyboardEvent):Void {
        super.keyDownHandler(event);

        switch (event.keyCode) {
            case Keyboard.UP, Keyboard.W:
                walkAcceleration = walkIncrement;
            case Keyboard.DOWN, Keyboard.S:
                walkAcceleration = ~walkIncrement;
            case Keyboard.LEFT, Keyboard.A:
                strafeAcceleration = ~strafeIncrement;
            case Keyboard.RIGHT, Keyboard.D:
                strafeAcceleration = strafeIncrement;
        }
    }

    override public function keyUpHandler(event:KeyboardEvent):Void {
        super.keyUpHandler(event);

        switch (event.keyCode) {
            case Keyboard.UP, Keyboard.W,
                 Keyboard.DOWN, Keyboard.S:
                walkAcceleration = 0;
            case Keyboard.LEFT, Keyboard.A,
                 Keyboard.RIGHT, Keyboard.D:
                strafeAcceleration = 0;
        }
    }

    override public function mouseDownHandler(event:MouseEvent):Void {
        super.mouseDownHandler(event);

        moving = true;

        lastPanAngle = cameraController.panAngle;
        lastTiltAngle = cameraController.tiltAngle;
        lastMouseX = stage.mouseX;
        lastMouseY = stage.mouseY;
    }

    override public function mouseUpHandler(event:MouseEvent):Void {
        super.mouseUpHandler(event);

        moving = false;
    }

    override public function mouseLeaveHandler(event:Event):Void {
        super.mouseLeaveHandler(event);

        moving = false;
    }

    override public function mouseWheelHandler(event:MouseEvent):Void {
        super.mouseWheelHandler(event);

        if (event.delta > 0)
            distanceIncrement = distanceSpeed;
        else if (event.delta < 0)
            distanceIncrement = -distanceSpeed;
    }

    override public function dispose():Void {
        super.dispose();

        cameraController = null;
    }


}
