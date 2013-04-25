/**
 * Created by YNGLAY.
 * Author: Roman Zarichnyi
 * Date: 22.04.13
 * Time: 14:56
 */
package com.ynglay.games.kengaroo.core.screens {
import com.ynglay.games.assets.AssetsManager;
import com.ynglay.games.consts.GameState;
import com.ynglay.games.core.screens.ScreenBase;
import com.ynglay.games.events.ScreenEvent;
import com.ynglay.games.kengaroo.assets.creators.MenuAssetsCreator;
import com.ynglay.games.kengaroo.consts.AssetName;
import com.ynglay.games.textures.TextureManager;

import starling.display.Button;
import starling.events.Event;
import starling.textures.TextureAtlas;

public class MenuScreen extends ScreenBase
{
    private var playButton:Button;

    public function MenuScreen(requireLoadingAssets:Boolean = false)
    {
        super(requireLoadingAssets);

        assetsCreator = new MenuAssetsCreator(AssetsManager.getInstance());
    }

    override public function initialize():void
    {
        super.initialize();

        stage.color = 0xffffff;

        playButton = new Button(TextureManager.getInstance().getTexture(AssetName.T_BUTTON_PLAY_BIG));
        playButton.width = playButton.height = 250;
        playButton.x = stage.stageWidth - playButton.width >> 1;
        playButton.y = stage.stageHeight - playButton.height >> 1;

        addChild(playButton);

        playButton.addEventListener(Event.TRIGGERED, onPlayButtonClickHandler);
    }

    override public function dispose():void
    {
        playButton.removeEventListener(Event.TRIGGERED, onPlayButtonClickHandler);

        playButton.dispose();
        playButton.upState.dispose();
        removeChild(playButton);

        super.dispose();
    }

    private function onPlayButtonClickHandler(event:Event):void
    {
        dispatchEvent(new ScreenEvent(ScreenEvent.CHANGE_SCREEN, GameState.GAME));
    }
}
}
