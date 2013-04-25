/**
 * Created by YNGLAY.
 * Author: Roman Zarichnyi
 * Date: 22.04.13
 * Time: 17:23
 */
package com.ynglay.games.kengaroo.core.objects {
import com.ynglay.games.kengaroo.consts.AssetName;
import com.ynglay.games.textures.TextureManager;

import flash.geom.Rectangle;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.utils.deg2rad;

public class Kengoo extends Sprite
{
    public static const DEFAULT_WIDTH:int = 45;
    public static const DEFAULT_HEIGHT:int = 70;
    public static const START_SPEED:Number = 5;
    public static const JUMP_ACCELERATION:int = 10;
    public static const MAX_FALLING_SPEED:Number = 9.8;
    public static const DEFAULT_ANGLE:Number = 90;
    public static const MIN_ANGLE:Number = 70;
    public static const MAX_ANGLE:Number = 110;

    private var texture:Image;
    private var dx:Number;
    private var dy:Number;
    private var moveArea:Rectangle;

    public var time:Number;
    public var xSpeed:Number;
    public var ySpeed:Number;
    public var angle:Number;

    public var yDirection:int;
    public var xDirection:int;
    public var falling:Boolean;

    public function Kengoo(moveArea:Rectangle)
    {
        super();

        this.moveArea = moveArea;

        addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
    }

    private function initialize():void
    {
       ySpeed = START_SPEED;
       xSpeed = START_SPEED;
       angle = DEFAULT_ANGLE;
       yDirection = 1;
       xDirection = 1;
       dx = Math.cos(deg2rad(angle));
       dy = Math.sin(deg2rad(angle));
       falling = true;

       texture = new Image(TextureManager.getInstance().getTexture(AssetName.T_KENGOO));
       texture.width = DEFAULT_WIDTH;
       texture.height = DEFAULT_HEIGHT;
       texture.x = texture.y = 0;
       addChild(texture);
    }

    override public function dispose():void
    {
        texture.dispose();
        removeChild(texture);

        super.dispose();
    }

    private function onAddedToStageHandler(event:Event):void
    {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
        initialize();
    }

    public function turnLeft():void
    {
        xDirection = -1;
        dx *= -1;
    }

    public function turnRight():void
    {
        xDirection = 1;
        dx *= -1;
    }

    public function fall():void
    {
        yDirection = 1;
        dy *= -1;
        ySpeed = 0;
        falling = true;
    }

    public function jump():void
    {
        yDirection = -1;
        dy *= -1;
        ySpeed = JUMP_ACCELERATION;
        falling = false;
    }

    public function addAngle(angle:Number):void
    {
        if (this.angle + angle <= MAX_ANGLE && this.angle + angle >= MIN_ANGLE)
        {
            this.angle += angle;
            dx = Math.cos(deg2rad(this.angle)) * xDirection;
            dy = Math.sin(deg2rad(this.angle)) * yDirection;
        }
    }

    public function updatePosition(deltaTime:Number):void
    {
        x += xSpeed * dx;
        y += ySpeed * dy;

        if (yDirection == 1 && xSpeed < MAX_FALLING_SPEED)
        {
            ySpeed += 0.2;
        }
        else
        {
            ySpeed -= 0.08;
            if (ySpeed >= 0 && ySpeed <= 0.3)
            {
                fall();
            }
        }

        if (y == moveArea.y)
            fall();
        else if (x + width >= moveArea.width - 10)
            turnLeft();
        else if (x <= moveArea.x + 10)
            turnRight();
    }
}
}
