package com.sulake.core.window.graphics.renderer
{
    import flash.geom.Matrix;
    import flash.geom.ColorTransform;
    import com.sulake.core.window.utils.IBitmapDataContainer;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import flash.display.IBitmapDrawable;
    import flash.geom.Rectangle;

    public class BitmapDataRenderer extends SkinRenderer 
    {

        private var var_2725:Matrix;
        private var var_2726:ColorTransform;

        public function BitmapDataRenderer(param1:String)
        {
            super(param1);
            this.var_2725 = new Matrix();
            this.var_2726 = new ColorTransform();
        }

        override public function draw(param1:IWindow, param2:IBitmapDrawable, param3:Rectangle, param4:uint, param5:Boolean):void
        {
            var _loc6_:BitmapData = IBitmapDataContainer(param1).bitmapData;
            var _loc7_:BitmapData = BitmapData(param2);
            if (((!(param2 == null)) && (!(_loc6_ == null))))
            {
                this.var_2725.a = (param1.width / _loc6_.width);
                this.var_2725.d = (param1.height / _loc6_.height);
                this.var_2726.redMultiplier = (((param1.color & 0xFF0000) >> 16) / 0xFF);
                this.var_2726.greenMultiplier = (((param1.color & 0xFF00) >> 8) / 0xFF);
                this.var_2726.blueMultiplier = ((param1.color & 0xFF) / 0xFF);
                _loc7_.lock();
                _loc7_.draw(_loc6_, this.var_2725, this.var_2726, null, null, false);
                _loc7_.unlock();
            };
        }

        override public function isStateDrawable(param1:uint):Boolean
        {
            return (param1 == 0);
        }


    }
}