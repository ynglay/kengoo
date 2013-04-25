package com.ynglay.games.kengaroo {

import com.ynglay.games.config.GameConfig;
import com.ynglay.games.kengaroo.core.KangarooJumperGame;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageQuality;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.text.TextField;

import net.hires.debug.Stats;

import starling.core.Starling;

[SWF(frameRate="60", width="1024", height="768", backgroundColor="0x000000")]
public class KangarooJumperMain extends Sprite
{
    private var stats:Stats;
    private var starling:Starling;

    /*
    * Constructor.
    * */
    public function KangarooJumperMain()
    {
        // initialize if the application added to stage, else add listener
        if (stage)
            initialize();
        else
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
    }

    private function initialize():void
    {
        // show detailed statistic about FPS, RAM; only for debigging
        stats = new Stats();
        addChild(stats);

        stage.scaleMode = StageScaleMode.NO_SCALE; // set no scale application, because Starling scales it automatically
        stage.align = StageAlign.TOP_LEFT; // default align mode of the application
        stage.quality = StageQuality.BEST;

        starling = new Starling(KangarooJumperGame, stage, new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight));
        starling.antiAliasing = 16; // quality of rendering textures on the GPU
        starling.simulateMultitouch = true;
        starling.start(); // start rendering on the GPU

        stage.addEventListener(Event.RESIZE, onStageResizeHandler);
    }

    /*
    * Update view port of the application according to the full screen width/height of the stage.
    * */
    private function updateViewport(fullScreenWidth:uint, fullScreenHeight:uint):void
    {
        starling.viewPort = new Rectangle(0, 0, fullScreenWidth, fullScreenHeight); // set new view port

        // calculation max scale duw to the width and height
        var scaleX:Number = fullScreenWidth / GameConfig.getInstance().targetWidth;
        var scaleY:Number = fullScreenHeight / GameConfig.getInstance().targetHeight;
        var scale:Number = Math.max(scaleX, scaleY);

        // scale width and height of the starling stage
        starling.stage.stageWidth = fullScreenWidth / scale;
        starling.stage.stageHeight = fullScreenHeight / scale;
    }

    /*
    * Added to stage handler. Initialize application.
    * */
    private function onAddedToStageHandler(event:Event):void
    {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
        initialize();
    }

    /*
    * Stage resize handler. Update view port of the application.
    * */
    private function onStageResizeHandler(event:Event):void
    {
        updateViewport(stage.fullScreenWidth, stage.fullScreenHeight);
    }
}
}
