package com.sulake.room.object.visualization.utils
{
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.IAsset;
    import flash.display.BitmapData;

    public class GraphicAsset implements IGraphicAsset 
    {

        private var var_2568:String;
        private var var_5511:String;
        private var var_2736:BitmapDataAsset;
        private var var_2574:Boolean;
        private var var_2575:Boolean;
        private var var_5512:Boolean;
        private var _offsetX:int;
        private var var_2703:int;
        private var var_2731:int;
        private var _height:int;
        private var var_2709:Boolean;

        public function GraphicAsset(param1:String, param2:String, param3:IAsset, param4:Boolean, param5:Boolean, param6:int, param7:int, param8:Boolean=false)
        {
            this.var_2568 = param1;
            this.var_5511 = param2;
            var _loc9_:BitmapDataAsset = (param3 as BitmapDataAsset);
            if (_loc9_ != null)
            {
                this.var_2736 = _loc9_;
                this.var_2709 = false;
            }
            else
            {
                this.var_2736 = null;
                this.var_2709 = true;
            };
            this.var_2574 = param4;
            this.var_2575 = param5;
            this._offsetX = param6;
            this.var_2703 = param7;
            this.var_5512 = param8;
        }

        public function dispose():void
        {
            this.var_2736 = null;
        }

        private function initialize():void
        {
            var _loc1_:BitmapData;
            if (((!(this.var_2709)) && (!(this.var_2736 == null))))
            {
                _loc1_ = (this.var_2736.content as BitmapData);
                if (_loc1_ != null)
                {
                    this.var_2731 = _loc1_.width;
                    this._height = _loc1_.height;
                };
                this.var_2709 = true;
            };
        }

        public function get flipV():Boolean
        {
            return (this.var_2575);
        }

        public function get flipH():Boolean
        {
            return (this.var_2574);
        }

        public function get width():int
        {
            this.initialize();
            return (this.var_2731);
        }

        public function get height():int
        {
            this.initialize();
            return (this._height);
        }

        public function get assetName():String
        {
            return (this.var_2568);
        }

        public function get libraryAssetName():String
        {
            return (this.var_5511);
        }

        public function get asset():IAsset
        {
            return (this.var_2736);
        }

        public function get usesPalette():Boolean
        {
            return (this.var_5512);
        }

        public function get offsetX():int
        {
            if (!this.var_2574)
            {
                return (this._offsetX);
            };
            return (-(this.width + this._offsetX));
        }

        public function get offsetY():int
        {
            if (!this.var_2575)
            {
                return (this.var_2703);
            };
            return (-(this.height + this.var_2703));
        }

        public function get originalOffsetX():int
        {
            return (this._offsetX);
        }

        public function get originalOffsetY():int
        {
            return (this.var_2703);
        }


    }
}