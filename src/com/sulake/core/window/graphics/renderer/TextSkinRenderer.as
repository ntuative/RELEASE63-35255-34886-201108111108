package com.sulake.core.window.graphics.renderer
{
    import flash.geom.Matrix;
    import com.sulake.core.window.utils.TextStyleManager;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.utils.ITextFieldContainer;
    import flash.text.TextField;
    import com.sulake.core.window.components.ITextWindow;
    import flash.text.TextFieldAutoSize;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import flash.display.IBitmapDrawable;
    import flash.geom.Rectangle;

    public class TextSkinRenderer extends SkinRenderer 
    {

        protected var var_2725:Matrix;

        public function TextSkinRenderer(param1:String)
        {
            super(param1);
            this.var_2725 = new Matrix();
        }

        override public function parse(param1:IAsset, param2:XMLList, param3:IAssetLibrary):void
        {
            var _loc4_:String = param1.content.toString();
            TextStyleManager.setStyles(TextStyleManager.parseCSS(_loc4_));
        }

        override public function draw(param1:IWindow, param2:IBitmapDrawable, param3:Rectangle, param4:uint, param5:Boolean):void
        {
            var _loc6_:ITextFieldContainer;
            var _loc7_:String;
            var _loc8_:TextField;
            if (param2 != null)
            {
                _loc6_ = ITextFieldContainer(param1);
                _loc7_ = ITextWindow(param1).autoSize;
                _loc8_ = _loc6_.textField;
                this.var_2725.tx = _loc6_.margins.left;
                this.var_2725.ty = _loc6_.margins.top;
                if (_loc7_ == TextFieldAutoSize.RIGHT)
                {
                    this.var_2725.tx = Math.floor((param1.width - _loc8_.width));
                }
                else
                {
                    if (_loc7_ == TextFieldAutoSize.CENTER)
                    {
                        this.var_2725.tx = Math.floor(((param1.width / 2) - (_loc8_.width / 2)));
                    };
                };
                BitmapData(param2).draw(_loc8_, this.var_2725, null, null, null, false);
            };
        }

        override public function isStateDrawable(param1:uint):Boolean
        {
            return (param1 == 0);
        }


    }
}