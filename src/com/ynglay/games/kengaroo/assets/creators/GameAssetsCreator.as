/**
 * Created by YNGLAY.
 * Author: Roman Zarichnyi
 * Date: 22.04.13
 * Time: 17:26
 */
package com.ynglay.games.kengaroo.assets.creators {
import com.ynglay.games.assets.AssetsManager;
import com.ynglay.games.assets.loaders.TextureAtlasLoader;
import com.ynglay.games.assets.supportClasses.AssetsCreatorBase;
import com.ynglay.games.kengaroo.consts.AssetName;
import com.ynglay.games.textures.TextureManager;

import starling.textures.TextureAtlas;

public class GameAssetsCreator extends AssetsCreatorBase
{
    public function GameAssetsCreator(assetsManager:AssetsManager)
    {
        super(assetsManager);
    }
    override public function registerLoaders():void
    {
        super.registerLoaders();

        assetsManager.addToQueue(new TextureAtlasLoader(AssetName.TA_GAME, "../resources/graphics/game_sprites.png",
                "../resources/graphics/game_sprites.xml"));
    }

    override public function prepareScreenData():void
    {
        var atlas:TextureAtlas = assetsManager.getFromAsset(AssetName.TA_GAME);

        TextureManager.getInstance().addTextureAtlas(AssetName.TA_GAME, atlas);
        TextureManager.getInstance().addTexture(AssetName.T_KENGOO, atlas.getTexture(AssetName.T_KENGOO));
        TextureManager.getInstance().addTexture(AssetName.T_HIPOPOTAME, atlas.getTexture(AssetName.T_HIPOPOTAME));
        TextureManager.getInstance().addTexture(AssetName.T_BUTTON_BACK, atlas.getTexture(AssetName.T_BUTTON_BACK));

        disposeAssets();
    }

    override public function disposeAssets():void
    {
        assetsManager.removeAssets([AssetName.TA_GAME]);
    }

    override public function disposeTextures():void
    {
        TextureManager.getInstance().removeTextures([AssetName.TA_GAME, AssetName.T_KENGOO, AssetName.T_HIPOPOTAME,
            AssetName.T_BUTTON_BACK]);
    }
}
}
