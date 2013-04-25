/**
 * Created by YNGLAY.
 * Author: Roman Zarichnyi
 * Date: 22.04.13
 * Time: 12:05
 */
package com.ynglay.games.kengaroo.core {
import com.ynglay.games.assets.AssetsManager;
import com.ynglay.games.assets.loaders.BitmapFontLoader;
import com.ynglay.games.assets.loaders.TextureLoader;
import com.ynglay.games.components.ScreenNavigationItem;
import com.ynglay.games.consts.GameState;
import com.ynglay.games.core.GameBase;
import com.ynglay.games.events.AssetsLoadingEvent;
import com.ynglay.games.events.ScreenEvent;
import com.ynglay.games.kengaroo.consts.AssetName;
import com.ynglay.games.kengaroo.core.screens.GameScreen;
import com.ynglay.games.kengaroo.core.screens.LoadingScreen;
import com.ynglay.games.kengaroo.core.screens.MenuScreen;
import com.ynglay.games.kengaroo.core.screens.SplashScreen;

import starling.text.BitmapFont;

import starling.text.TextField;

public class KangarooJumperGame extends GameBase
{
    private var assetsManager:AssetsManager;

    public function KangarooJumperGame()
    {
        super();
    }

    override public function initialize():void
    {
        super.initialize();

        screenNavigator.register(GameState.SPLASH_SCREEN, new ScreenNavigationItem(SplashScreen));
        screenNavigator.register(GameState.LOADING, new ScreenNavigationItem(LoadingScreen));
        screenNavigator.register(GameState.MENU, new ScreenNavigationItem(MenuScreen, true));
        screenNavigator.register(GameState.GAME, new ScreenNavigationItem(GameScreen, true));

        assetsManager = AssetsManager.getInstance();
        assetsManager.addToQueue(new BitmapFontLoader(AssetName.F_BADA_BOOM, "../resources/fonts/myGlyphs.png",
                "../resources/fonts/myGlyphs.fnt", "BadaBoom"));
        assetsManager.addToQueue(new TextureLoader(AssetName.T_LOGO, "../resources/graphics/logo.jpg"))

        assetsManager.addEventListener(AssetsLoadingEvent.COMPLETE, onLoadingAssetsCompleteHandler);
        assetsManager.load();
    }

    private function registerFonts():void
    {
        TextField.registerBitmapFont(assetsManager.getFromAsset(AssetName.F_BADA_BOOM) as BitmapFont, "BadaBoom")
    }

    private function onLoadingAssetsCompleteHandler(event:AssetsLoadingEvent):void
    {
        assetsManager.removeEventListener(AssetsLoadingEvent.COMPLETE, onLoadingAssetsCompleteHandler);

        registerFonts();

        assetsManager.removeAssets([AssetName.F_BADA_BOOM]);
        assetsManager = null;

        screenNavigator.show(GameState.SPLASH_SCREEN);
    }
}
}
