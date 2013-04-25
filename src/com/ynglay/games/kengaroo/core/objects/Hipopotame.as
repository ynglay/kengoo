/**
 * Created by YNGLAY.
 * Author: Roman Zarichnyi
 * Date: 22.04.13
 * Time: 17:58
 */
package com.ynglay.games.kengaroo.core.objects {
import com.ynglay.games.kengaroo.consts.AssetName;
import com.ynglay.games.textures.TextureManager;

import flash.geom.Rectangle;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;

public class Hipopotame extends Sprite
{
    public static const LEFT:int = -1;
    public static const NONE:int = 0;
    public static const RIGHT:int = 1;

    public static const DEFAULT_WIDTH:int = 150;
    public static const DEFAULT_HEIGHT:int = 40;
    public static const DEFAULT_SPEED:Number = 5;

    private var texture:Image;
    private var moveArea:Rectangle;

    private var _speed:Number;
    private var _mainDirection:int;
    private var _leftDirection:int;
    private var _rightDirection:int;

    public function Hipopotame(moveArea:Rectangle)
    {
        super();

        this.moveArea = moveArea;

        addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
    }

    public function get speed():Number { return _speed; }
    public function get mainDirection():Number { return _mainDirection; }
    public function get leftDirection():Number { return _leftDirection; }
    public function get rightDirection():Number { return _rightDirection; }

    private function initialize():void
    {
        stopMovement();
        _speed = DEFAULT_SPEED;

        texture = new Image(TextureManager.getInstance().getTexture(AssetName.T_HIPOPOTAME));
        texture.width = DEFAULT_WIDTH;
        texture.height = moveArea.height;
        texture.x = texture.y = 0;
        addChild(texture);
    }

    override public function dispose():void
    {
        texture.dispose();
        removeChild(texture);

        super.dispose();
    }

    public function updatePosition(deltaTime:Number):void
    {
        if (mainDirection == LEFT)
            x -= speed;
        else if (mainDirection == RIGHT)
            x += speed;

        if (x <= moveArea.x || (x + width) >= moveArea.width)
            stopMovement();
    }

    public function setLeftDirection(value:Boolean):void
    {
        if (value)
        {
            if (x > moveArea.x)
                _leftDirection = LEFT;
            if (mainDirection == NONE)
                _mainDirection = leftDirection;
        }
        else
        {
            _leftDirection = NONE;
            _mainDirection = rightDirection;
        }
    }

    public function setRightDirection(value:Boolean):void
    {
        if (value)
        {
            if (x + width < moveArea.width)
                _rightDirection = RIGHT;
            if (mainDirection == NONE)
                _mainDirection = rightDirection;
        }
        else
        {
            _rightDirection = NONE;
            _mainDirection = leftDirection;
        }
    }

    public function stopMovement():void
    {
        _mainDirection = NONE;
        _leftDirection = NONE;
        _rightDirection = NONE;
    }

    private function onAddedToStageHandler(event:Event):void
    {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
        initialize();
    }
}
}
