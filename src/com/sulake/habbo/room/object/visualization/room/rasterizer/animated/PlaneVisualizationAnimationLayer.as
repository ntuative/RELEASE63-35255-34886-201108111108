package com.sulake.habbo.room.object.visualization.room.rasterizer.animated
{
    import com.sulake.core.runtime.IDisposable;
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import flash.geom.Point;
    import com.sulake.room.utils.IVector3d;

    public class PlaneVisualizationAnimationLayer implements IDisposable 
    {

        private var _color:uint = 0;
        private var _bitmapData:BitmapData = null;
        private var var_1023:Boolean = false;
        private var _items:Array = [];

        public function PlaneVisualizationAnimationLayer(param1:XML, param2:IGraphicAssetCollection)
        {
            var _loc3_:XMLList;
            var _loc4_:int;
            var _loc5_:XML;
            var _loc6_:String;
            var _loc7_:IGraphicAsset;
            var _loc8_:BitmapDataAsset;
            var _loc9_:BitmapData;
            var _loc10_:AnimationItem;
            super();
            if (((!(param1 == null)) && (!(param2 == null))))
            {
                _loc3_ = param1.item;
                _loc4_ = 0;
                while (_loc4_ < _loc3_.length())
                {
                    _loc5_ = (_loc3_[_loc4_] as XML);
                    if (_loc5_ != null)
                    {
                        _loc6_ = _loc5_.@asset;
                        _loc7_ = param2.getAsset(_loc6_);
                        if (_loc7_ != null)
                        {
                            _loc8_ = (_loc7_.asset as BitmapDataAsset);
                            if (_loc8_ != null)
                            {
                                _loc9_ = (_loc8_.content as BitmapData);
                                if (_loc9_ != null)
                                {
                                    _loc10_ = new AnimationItem(parseFloat(_loc5_.@x), parseFloat(_loc5_.@y), parseFloat(_loc5_.@speedX), parseFloat(_loc5_.@speedY), _loc9_);
                                    this._items.push(_loc10_);
                                };
                            };
                        };
                    };
                    _loc4_++;
                };
            };
        }

        public function get disposed():Boolean
        {
            return (this.var_1023);
        }

        public function dispose():void
        {
            var _loc1_:int;
            var _loc2_:AnimationItem;
            this.var_1023 = true;
            if (this._bitmapData != null)
            {
                this._bitmapData.dispose();
                this._bitmapData = null;
            };
            if (this._items != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this._items.length)
                {
                    _loc2_ = (this._items[_loc1_] as AnimationItem);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    };
                    _loc1_++;
                };
                this._items = [];
            };
        }

        public function clearCache():void
        {
            if (this._bitmapData != null)
            {
                this._bitmapData.dispose();
                this._bitmapData = null;
            };
        }

        public function render(param1:BitmapData, param2:int, param3:int, param4:IVector3d, param5:int, param6:int, param7:int, param8:int, param9:Number, param10:Number, param11:int):BitmapData
        {
            var _loc12_:int;
            var _loc13_:AnimationItem;
            var _loc14_:Point;
            if ((((param1 == null) || (!(param1.width == param2))) || (!(param1.height == param3))))
            {
                if ((((this._bitmapData == null) || (!(this._bitmapData.width == param2))) || (!(this._bitmapData.height == param3))))
                {
                    if (this._bitmapData != null)
                    {
                        this._bitmapData.dispose();
                    };
                    this._bitmapData = new BitmapData(param2, param3, true, 0xFFFFFF);
                }
                else
                {
                    this._bitmapData.fillRect(this._bitmapData.rect, 0xFFFFFF);
                };
                param1 = this._bitmapData;
            };
            if (((param7 > 0) && (param8 > 0)))
            {
                _loc12_ = 0;
                while (_loc12_ < this._items.length)
                {
                    _loc13_ = (this._items[_loc12_] as AnimationItem);
                    if (_loc13_ != null)
                    {
                        _loc14_ = _loc13_.getPosition(param7, param8, param9, param10, param11);
                        _loc14_.x = (_loc14_.x - param5);
                        _loc14_.y = (_loc14_.y - param6);
                        if (_loc13_.bitmapData != null)
                        {
                            if (((((_loc14_.x > -(_loc13_.bitmapData.width)) && (_loc14_.x < param1.width)) && (_loc14_.y > -(_loc13_.bitmapData.height))) && (_loc14_.y < param1.height)))
                            {
                                param1.copyPixels(_loc13_.bitmapData, _loc13_.bitmapData.rect, _loc14_, null, null, true);
                            };
                            if ((((((_loc14_.x - param7) > -(_loc13_.bitmapData.width)) && ((_loc14_.x - param7) < param1.width)) && (_loc14_.y > -(_loc13_.bitmapData.height))) && (_loc14_.y < param1.height)))
                            {
                                param1.copyPixels(_loc13_.bitmapData, _loc13_.bitmapData.rect, new Point((_loc14_.x - param7), _loc14_.y), null, null, true);
                            };
                            if (((((_loc14_.x > -(_loc13_.bitmapData.width)) && (_loc14_.x < param1.width)) && ((_loc14_.y - param8) > -(_loc13_.bitmapData.height))) && ((_loc14_.y - param8) < param1.height)))
                            {
                                param1.copyPixels(_loc13_.bitmapData, _loc13_.bitmapData.rect, new Point(_loc14_.x, (_loc14_.y - param8)), null, null, true);
                            };
                            if ((((((_loc14_.x - param7) > -(_loc13_.bitmapData.width)) && ((_loc14_.x - param7) < param1.width)) && ((_loc14_.y - param8) > -(_loc13_.bitmapData.height))) && ((_loc14_.y - param8) < param1.height)))
                            {
                                param1.copyPixels(_loc13_.bitmapData, _loc13_.bitmapData.rect, new Point((_loc14_.x - param7), (_loc14_.y - param8)), null, null, true);
                            };
                        };
                    };
                    _loc12_++;
                };
            };
            return (param1);
        }


    }
}