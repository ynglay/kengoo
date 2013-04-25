/**
 * Created by YNGLAY.
 * Author: Roman Zarichnyi
 * Date: 22.04.13
 * Time: 14:55
 */
package com.ynglay.games.kengaroo.core.screens {
import com.ynglay.games.core.screens.ScreenBase;

import starling.text.TextField;

public class LoadingScreen extends ScreenBase
{
    private var loadingTextField:TextField;

    public function LoadingScreen(requireLoadingAssets:Boolean = false)
    {
        super(requireLoadingAssets);
    }

    override public function initialize():void
    {
        super.initialize();

        loadingTextField = new TextField(300, 80, "LOADING", "BadaBoom", 36, 0xffffff);
        loadingTextField.x = stage.stageWidth - loadingTextField.width >> 1;
        loadingTextField.y = stage.stageHeight - loadingTextField.height >> 1;
        addChild(loadingTextField);
    }

    override public function dispose():void
    {
        loadingTextField.dispose();
        removeChild(loadingTextField);
        loadingTextField = null;

        super.dispose();
    }
}
}
