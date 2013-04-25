/**
 * Created by YNGLAY.
 * Author: Roman Zarichnyi
 * Date: 22.04.13
 * Time: 15:15
 */
package com.ynglay.games.kengaroo.assets.creators {
import com.ynglay.games.assets.AssetsManager;
import com.ynglay.games.assets.supportClasses.AssetsCreatorBase;
import com.ynglay.games.kengaroo.consts.AssetName;
import com.ynglay.games.textures.TextureManager;

import starling.textures.Texture;

public class SplashScreenAssetsCreator extends AssetsCreatorBase
{
    public function SplashScreenAssetsCreator(assetsManager:AssetsManager)
    {
        super(assetsManager);
    }

    override public function prepareScreenData():void
    {
        TextureManager.getInstance().addTexture(AssetName.T_LOGO, assetsManager.getFromAsset(AssetName.T_LOGO) as Texture);
        disposeAssets();
    }

    override public function disposeAssets():void
    {
        assetsManager.removeAsset(AssetName.T_LOGO);
    }

    override public function disposeTextures():void
    {
        TextureManager.getInstance().removeTextures([AssetName.T_LOGO]);
    }
}
}
