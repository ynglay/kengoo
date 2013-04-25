/**
 * Created by YNGLAY.
 * Author: Roman Zarichnyi
 * Date: 22.04.13
 * Time: 16:36
 */
package com.ynglay.games.kengaroo.assets.creators {
import com.ynglay.games.assets.AssetsManager;
import com.ynglay.games.assets.loaders.TextureAtlasLoader;
import com.ynglay.games.assets.supportClasses.AssetsCreatorBase;
import com.ynglay.games.kengaroo.consts.AssetName;
import com.ynglay.games.textures.TextureManager;

import starling.textures.TextureAtlas;

public class MenuAssetsCreator extends AssetsCreatorBase
{
    public function MenuAssetsCreator(assetsManager:AssetsManager)
    {
        super(assetsManager);
    }

    override public function registerLoaders():void
    {
        super.registerLoaders();

        assetsManager.addToQueue(new TextureAtlasLoader(AssetName.TA_MENU, "../resources/graphics/menu_spritesheet.png",
                "../resources/graphics/menu_spritesheet.xml"));
    }

    override public function prepareScreenData():void
    {
        var atlas:TextureAtlas = assetsManager.getFromAsset(AssetName.TA_MENU);

        TextureManager.getInstance().addTextureAtlas(AssetName.TA_MENU, atlas);
        TextureManager.getInstance().addTexture(AssetName.T_BUTTON_PLAY_BIG, atlas.getTexture(AssetName.T_BUTTON_PLAY_BIG));

        disposeAssets();
    }

    override public function disposeAssets():void
    {
        assetsManager.removeAssets([AssetName.TA_MENU]);
    }

    override public function disposeTextures():void
    {
        TextureManager.getInstance().removeTextures([AssetName.TA_MENU, AssetName.T_BUTTON_PLAY_BIG]);
    }
}
}
