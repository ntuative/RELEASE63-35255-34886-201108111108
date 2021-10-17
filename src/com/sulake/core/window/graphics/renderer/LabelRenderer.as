package com.sulake.core.window.graphics.renderer
{
    import flash.geom.Matrix;
    import com.sulake.core.window.utils.TextStyle;
    import flash.text.TextField;
    import com.sulake.core.window.components.TextLabelController;
    import com.sulake.core.window.utils.TextFieldCache;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import flash.display.IBitmapDrawable;
    import flash.geom.Rectangle;

    public class LabelRenderer extends SkinRenderer 
    {

        protected var var_2725:Matrix;
        protected var var_2730:TextStyle;
        protected var _cachedTextField:TextField;

        public function LabelRenderer(param1:String)
        {
            super(param1);
            this.var_2725 = new Matrix();
        }

        override public function draw(param1:IWindow, param2:IBitmapDrawable, param3:Rectangle, param4:uint, param5:Boolean):void
        {
            var _loc6_:TextLabelController;
            var _loc7_:TextStyle;
            var _loc8_:uint;
            if (param2 != null)
            {
                _loc6_ = TextLabelController(param1);
                _loc7_ = _loc6_.textStyle;
                if (_loc7_ != this.var_2730)
                {
                    this._cachedTextField = TextFieldCache.getTextFieldByStyle(_loc7_);
                    this.var_2730 = _loc7_;
                };
                this.var_2725.tx = _loc6_.drawOffsetX;
                this.var_2725.ty = _loc6_.drawOffsetY;
                this._cachedTextField.text = _loc6_.text;
                _loc8_ = uint(_loc7_.color);
                this._cachedTextField.textColor = ((_loc6_.hasTextColor) ? _loc6_.textColor : _loc8_);
                BitmapData(param2).draw(this._cachedTextField, this.var_2725, null, null, null, false);
                this._cachedTextField.textColor = _loc8_;
            };
        }

        override public function isStateDrawable(param1:uint):Boolean
        {
            return (param1 == 0);
        }


    }
}