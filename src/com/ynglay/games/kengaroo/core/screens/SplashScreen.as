/**
 * Created by YNGLAY.
 * Author: Roman Zarichnyi
 * Date: 22.04.13
 * Time: 14:52
 */
package com.ynglay.games.kengaroo.core.screens {
import com.ynglay.games.assets.AssetsManager;
import com.ynglay.games.consts.GameState;
import com.ynglay.games.core.screens.ScreenBase;
import com.ynglay.games.events.ScreenEvent;
import com.ynglay.games.kengaroo.assets.creators.SplashScreenAssetsCreator;
import com.ynglay.games.kengaroo.consts.AssetName;
import com.ynglay.games.textures.TextureManager;

import flash.events.TimerEvent;

import flash.utils.Timer;

import starling.display.Image;

public class SplashScreen extends ScreenBase
{
    private var companyLogo:Image;

    private var splashTimer:Timer;

    public function SplashScreen(requireLoadingAssets:Boolean = false)
    {
        super(requireLoadingAssets);

        assetsCreator = new SplashScreenAssetsCreator(AssetsManager.getInstance());
    }

    override public function initialize():void
    {
        super.initialize();

        companyLogo = new Image(TextureManager.getInstance().getTexture(AssetName.T_LOGO));
        companyLogo.width = 435;
        companyLogo.height = 367;
        companyLogo.x = stage.stageWidth - companyLogo.width >> 1;
        companyLogo.y = stage.stageHeight - companyLogo.height >> 1;

        addChild(companyLogo);

        splashTimer = new Timer(2500, 1);
        splashTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerCompleteHandler);
        splashTimer.start();
    }

    override public function dispose():void
    {
        companyLogo.dispose();
        removeChild(companyLogo);

        companyLogo = null;
        splashTimer = null;

        super.dispose();
    }

    private function onTimerCompleteHandler(event:TimerEvent):void
    {
        splashTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerCompleteHandler);

        dispatchEvent(new ScreenEvent(ScreenEvent.CHANGE_SCREEN, GameState.MENU));
    }
}
}
