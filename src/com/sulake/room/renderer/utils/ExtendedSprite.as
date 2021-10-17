package com.sulake.room.renderer.utils
{
    import flash.display.Bitmap;
    import flash.geom.Point;
    import flash.display.BitmapData;

    public class ExtendedSprite extends Bitmap 
    {

        private var var_5540:int = 128;
        private var var_5541:Boolean = false;
        private var var_5542:Point;
        private var var_3491:String = "";
        private var var_2620:String = "";
        private var var_4698:Boolean = false;
        private var var_5516:Boolean = false;
        private var _bitmapData:ExtendedBitmapData = null;
        private var var_2731:int = 0;
        private var _height:int = 0;
        private var var_5543:int = -1;
        private var var_5544:int = -1;

        public function ExtendedSprite():void
        {
            this.var_5542 = new Point();
            cacheAsBitmap = false;
            this.enableAlpha();
        }

        public function get alphaActive():Boolean
        {
            return (this.var_5541);
        }

        public function get alphaTolerance():int
        {
            return (this.var_5540);
        }

        public function set alphaTolerance(param1:int):void
        {
            this.var_5540 = param1;
        }

        public function get tag():String
        {
            return (this.var_3491);
        }

        public function set tag(param1:String):void
        {
            this.var_3491 = param1;
        }

        public function get identifier():String
        {
            return (this.var_2620);
        }

        public function set identifier(param1:String):void
        {
            this.var_2620 = param1;
        }

        public function get varyingDepth():Boolean
        {
            return (this.var_5516);
        }

        public function set varyingDepth(param1:Boolean):void
        {
            this.var_5516 = param1;
        }

        public function get clickHandling():Boolean
        {
            return (this.var_4698);
        }

        public function set clickHandling(param1:Boolean):void
        {
            this.var_4698 = param1;
        }

        public function dispose():void
        {
            if (this._bitmapData != null)
            {
                this._bitmapData.dispose();
                this._bitmapData = null;
            };
        }

        override public function set bitmapData(param1:BitmapData):void
        {
            var _loc2_:ExtendedBitmapData;
            if (param1 == bitmapData)
            {
                return;
            };
            if (this._bitmapData != null)
            {
                this._bitmapData.dispose();
                this._bitmapData = null;
            };
            if (param1 != null)
            {
                this.var_2731 = param1.width;
                this._height = param1.height;
                _loc2_ = (param1 as ExtendedBitmapData);
                if (_loc2_ != null)
                {
                    _loc2_.addReference();
                    this._bitmapData = _loc2_;
                };
            }
            else
            {
                this.var_2731 = 0;
                this._height = 0;
                this.var_5543 = -1;
                this.var_5544 = -1;
            };
            super.bitmapData = param1;
        }

        public function needsUpdate(param1:int, param2:int):Boolean
        {
            if (((!(param1 == this.var_5543)) || (!(param2 == this.var_5544))))
            {
                this.var_5543 = param1;
                this.var_5544 = param2;
                return (true);
            };
            if (((!(this._bitmapData == null)) && (this._bitmapData.disposed)))
            {
                return (true);
            };
            return (false);
        }

        public function disableAlpha():void
        {
            this.var_5541 = false;
        }

        public function enableAlpha():void
        {
            this.disableAlpha();
            this.var_5541 = true;
        }

        override public function hitTestPoint(param1:Number, param2:Number, param3:Boolean=false):Boolean
        {
            return (this.hitTest(param1, param2));
        }

        public function hitTest(param1:int, param2:int):Boolean
        {
            if (((this.var_5540 > 0xFF) || (bitmapData == null)))
            {
                return (false);
            };
            if (((((param1 < 0) || (param2 < 0)) || (param1 >= this.var_2731)) || (param2 >= this._height)))
            {
                return (false);
            };
            return (this.hitTestBitmapData(param1, param2));
        }

        private function hitTestBitmapData(x:int, y:int):Boolean
        {
            var pixel:uint;
            var retVal:Boolean;
            try
            {
                if (((!(this.var_5541)) || (!(bitmapData.transparent))))
                {
                    retVal = true;
                }
                else
                {
                    pixel = bitmapData.getPixel32(x, y);
                    pixel = (pixel >> 24);
                    retVal = (pixel > this.var_5540);
                };
            }
            catch(e:Error)
            {
            };
            return (retVal);
        }


    }
}