/**
 * Created by YNGLAY.
 * Author: Roman Zarichnyi
 * Date: 22.04.13
 * Time: 17:04
 */
package com.ynglay.games.kengaroo.core.screens {
import com.ynglay.games.assets.AssetsManager;
import com.ynglay.games.consts.GameState;
import com.ynglay.games.core.screens.ScreenBase;
import com.ynglay.games.events.ScreenEvent;
import com.ynglay.games.kengaroo.assets.creators.GameAssetsCreator;
import com.ynglay.games.kengaroo.components.dialogs.ShieldTextDialog;
import com.ynglay.games.kengaroo.consts.AssetName;
import com.ynglay.games.kengaroo.core.objects.Hipopotame;
import com.ynglay.games.kengaroo.core.objects.Kengoo;
import com.ynglay.games.kengaroo.core.objects.Kengoo;
import com.ynglay.games.textures.TextureManager;
import com.ynglay.games.utils.GeometryUtil;

import flash.geom.Rectangle;

import flash.utils.setTimeout;

import starling.display.Button;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.utils.deg2rad;

public class GameScreen extends ScreenBase
{
    private var backButton:Button;
    private var hipopotame:Hipopotame;
    private var kengoo:Kengoo;
    private var leftButton:Button;
    private var rightButton:Button;
    private var shieldDialog:ShieldTextDialog;

    private var stageWidth:Number;
    private var stageHeight:Number;

    private var screenBounds:Rectangle;
    private var touch:Touch;
    private var gameOver:Boolean;

    public function GameScreen(requireLoadingAssets:Boolean = false)
    {
        super(requireLoadingAssets);

        assetsCreator = new GameAssetsCreator(AssetsManager.getInstance());
    }

    override public function initialize():void
    {
        super.initialize();

        stageWidth = stage.stageWidth;
        stageHeight = stage.stageHeight;

        screenBounds = new Rectangle(0, 0, stageWidth, stageHeight - Hipopotame.DEFAULT_HEIGHT); // need change to max height

        backButton = new Button(TextureManager.getInstance().getTexture(AssetName.T_BUTTON_BACK));
        backButton.width = backButton.height = 65;
        backButton.x = backButton.y = 20;

        hipopotame = new Hipopotame(new Rectangle(5, stageHeight - Hipopotame.DEFAULT_HEIGHT,
                stageWidth - 5, Hipopotame.DEFAULT_HEIGHT));
        hipopotame.x = stageWidth - Hipopotame.DEFAULT_WIDTH >> 1;
        hipopotame.y = stageHeight - Hipopotame.DEFAULT_HEIGHT;

        kengoo = new Kengoo(new Rectangle(0, 0, stageWidth, stageHeight));
        kengoo.x = stageWidth - 130 >> 1;
        kengoo.y = 130;

        leftButton = new Button(TextureManager.getInstance().getTexture(AssetName.T_BUTTON_BACK));
        leftButton.x = 20;
        leftButton.y = stageHeight - 65 - 20;
        leftButton.alpha = 0.3;

        rightButton = new Button(TextureManager.getInstance().getTexture(AssetName.T_BUTTON_BACK));
        rightButton.x = stageWidth - 20;
        rightButton.y = stageHeight - 65 - 20;
        rightButton.scaleX = -1;
        rightButton.alpha = 0.3;

        shieldDialog = new ShieldTextDialog("TAP TO START");

        addChild(backButton);
        addChild(hipopotame);
        addChild(kengoo);
        addChild(leftButton);
        addChild(rightButton);
        addChild(shieldDialog);

        pause();

        backButton.addEventListener(Event.TRIGGERED, onBackButtonClickHandler);
        leftButton.addEventListener(TouchEvent.TOUCH, onLeftButtonTouchHandler);
        rightButton.addEventListener(TouchEvent.TOUCH, onRightButtonTouchHandler);
        addEventListener(TouchEvent.TOUCH, onShieldClickHandler);
    }

    override public function dispose():void
    {
        backButton.removeEventListener(Event.TRIGGERED, onBackButtonClickHandler);
        leftButton.removeEventListener(TouchEvent.TOUCH, onLeftButtonTouchHandler);
        rightButton.removeEventListener(TouchEvent.TOUCH, onRightButtonTouchHandler);

        backButton.dispose();
        hipopotame.dispose();
        kengoo.dispose();
        leftButton.dispose();
        rightButton.dispose();

        removeChild(backButton);
        removeChild(hipopotame);
        removeChild(kengoo);
        removeChild(leftButton);
        removeChild(rightButton);

        backButton = null;
        hipopotame = null;
        kengoo = null;
        leftButton = null;
        rightButton = null;

        super.dispose();
    }

    override public function update(deltaTime:Number):void
    {
        if (!isPause && !gameOver)
        {
            updateKengoo(deltaTime);
            updateHipo(deltaTime);

            checkCollisions();
            checkGameOver();
        }
    }

    private function updateKengoo(deltaTime:Number):void
    {
        kengoo.updatePosition(deltaTime);
    }

    private function updateHipo(deltaTime:Number):void
    {
        hipopotame.updatePosition(deltaTime);
    }

    private function checkCollisions():void
    {
        if (kengoo.falling && GeometryUtil.detectCollisionByBoundingBox(kengoo, hipopotame))
        {
            if (hipopotame.mainDirection != Hipopotame.NONE)
            {
                kengoo.addAngle(hipopotame.speed * hipopotame.mainDirection)
            }
            kengoo.jump();
        }
    }

    private function checkGameOver():void
    {
        if (kengoo.y > stageHeight)
        {
            pause();
            gameOver = true;

            shieldDialog = new ShieldTextDialog("TAP TO GO BACK");
            addChild(shieldDialog);
            addEventListener(TouchEvent.TOUCH, onShieldClickHandler);
        }
    }

    private function onShieldClickHandler(event:TouchEvent):void
    {
        removeEventListener(TouchEvent.TOUCH, onShieldClickHandler);

        shieldDialog.dispose();
        removeChild(shieldDialog);
        shieldDialog = null;

        if (!gameOver)
            resume();
        else
            dispatchEvent(new ScreenEvent(ScreenEvent.CHANGE_SCREEN, GameState.MENU));
    }

    private function onLeftButtonTouchHandler(event:TouchEvent):void
    {
        touch = event.getTouch(this, TouchPhase.BEGAN);
        if (touch)
            hipopotame.setLeftDirection(true);

        touch = event.getTouch(this, TouchPhase.ENDED);
        if (touch)
            hipopotame..setLeftDirection(false);
    }

    private function onRightButtonTouchHandler(event:TouchEvent):void
    {
        touch = event.getTouch(this, TouchPhase.BEGAN);
        if (touch)
            hipopotame.setRightDirection(true);

        touch = event.getTouch(this, TouchPhase.ENDED);
        if (touch)
            hipopotame.setRightDirection(false);
    }

    private function onBackButtonClickHandler(event:Event):void
    {
        dispatchEvent(new ScreenEvent(ScreenEvent.CHANGE_SCREEN, GameState.MENU));
    }
}
}
