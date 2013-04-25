/**
 * Created with IntelliJ IDEA.
 * User: rzarich
 * Date: 22.04.13
 * Time: 21:46
 * To change this template use File | Settings | File Templates.
 */
package com.ynglay.games.kengaroo.components.dialogs {
import com.ynglay.games.components.DialogBase;

import starling.text.TextField;

public class ShieldTextDialog extends DialogBase
{
    private var textField:TextField;
    private var text:String;

    public function ShieldTextDialog(text:String = "", backgroundAlpha:Number = 0.5, backgroundColor:uint = 0xcccccc)
    {
        super(backgroundAlpha, backgroundColor);

        this.text = text;
    }

    override protected function initialize():void
    {
        super.initialize();

        textField = new TextField(200, 150, text, "Verdana", 28);
        textField.x = stage.stageWidth - textField.width >> 1;
        textField.y = stage.stageHeight - textField.height >> 1;
        addChild(textField);
    }

    override public function dispose():void
    {
        textField.dispose();
        removeChild(textField);
        textField = null;

        super.dispose();
    }
}
}
