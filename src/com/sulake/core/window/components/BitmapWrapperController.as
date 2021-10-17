package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.utils.IBitmapDataContainer;
    import flash.display.BitmapData;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.graphics.WindowRedrawFlag;
    import com.sulake.core.window.utils.PropertyDefaults;
    import com.sulake.core.window.utils.PropertyStruct;

    public class BitmapWrapperController extends WindowController implements IBitmapWrapperWindow, IBitmapDataContainer 
    {

        protected var _bitmapData:BitmapData;
        protected var var_2659:Boolean = true;
        protected var var_2660:String;

        public function BitmapWrapperController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function=null, param9:Array=null, param10:Array=null, param11:uint=0)
        {
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
        }

        public function get bitmap():BitmapData
        {
            return (this._bitmapData);
        }

        public function set bitmap(param1:BitmapData):void
        {
            if ((((this.var_2659) && (this._bitmapData)) && (!(param1 == this._bitmapData))))
            {
                this._bitmapData.dispose();
            };
            this._bitmapData = param1;
            _context.invalidate(this, var_1202, WindowRedrawFlag.var_1194);
        }

        public function get bitmapData():BitmapData
        {
            return (this._bitmapData);
        }

        public function set bitmapData(param1:BitmapData):void
        {
            this.bitmap = param1;
        }

        public function get bitmapAssetName():String
        {
            return (this.var_2660);
        }

        public function set bitmapAssetName(param1:String):void
        {
            this.var_2660 = param1;
        }

        public function get disposesBitmap():Boolean
        {
            return (this.var_2659);
        }

        public function set disposesBitmap(param1:Boolean):void
        {
            this.var_2659 = param1;
        }

        override public function clone():IWindow
        {
            var _loc1_:BitmapWrapperController = (super.clone() as BitmapWrapperController);
            _loc1_._bitmapData = this._bitmapData;
            _loc1_.var_2659 = this.var_2659;
            _loc1_.var_2660 = this.var_2660;
            return (_loc1_);
        }

        override public function dispose():void
        {
            if (this._bitmapData)
            {
                if (this.var_2659)
                {
                    this._bitmapData.dispose();
                };
                this._bitmapData = null;
            };
            super.dispose();
        }

        override public function get properties():Array
        {
            var _loc1_:Array = super.properties;
            if (this.var_2659 != PropertyDefaults.var_2013)
            {
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_2012, this.var_2659, PropertyStruct.var_634, true));
            }
            else
            {
                _loc1_.push(PropertyDefaults.var_2042);
            };
            if (this.var_2660 != PropertyDefaults.var_2007)
            {
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_2006, this.var_2660, PropertyStruct.var_636, true));
            }
            else
            {
                _loc1_.push(PropertyDefaults.var_2040);
            };
            return (_loc1_);
        }

        override public function set properties(param1:Array):void
        {
            var _loc2_:PropertyStruct;
            for each (_loc2_ in param1)
            {
                switch (_loc2_.key)
                {
                    case PropertyDefaults.var_2012:
                        this.var_2659 = (_loc2_.value as Boolean);
                        break;
                    case PropertyDefaults.var_2006:
                        this.var_2660 = (_loc2_.value as String);
                        break;
                };
            };
            super.properties = param1;
        }


    }
}