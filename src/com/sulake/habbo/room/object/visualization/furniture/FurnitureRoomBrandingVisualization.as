package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import flash.display.BitmapData;
    import flash.geom.Matrix;

    public class FurnitureRoomBrandingVisualization extends FurnitureVisualization 
    {

        private static const var_1468:String = "branded_image";
        private static const var_1469:int = 0;
        private static const var_1470:int = 1;
        private static const var_1471:int = 2;
        private static const var_1472:int = 3;

        protected var _imageUrl:String;
        protected var var_4695:Boolean = false;
        protected var var_1473:int;
        protected var var_1474:int;
        protected var _paramOffsetZ:int;


        override public function dispose():void
        {
            super.dispose();
            this._imageUrl = null;
        }

        override protected function updateObject(param1:Number, param2:Number):Boolean
        {
            if (super.updateObject(param1, param2))
            {
                if (this.var_4695)
                {
                    this.checkAndCreateImageForCurrentState(param1);
                };
                return (true);
            };
            return (false);
        }

        override protected function updateModel(param1:Number):Boolean
        {
            var _loc3_:IRoomObject;
            var _loc4_:IRoomObjectModel;
            var _loc2_:Boolean = super.updateModel(param1);
            if (_loc2_)
            {
                _loc3_ = object;
                if (_loc3_ != null)
                {
                    _loc4_ = _loc3_.getModel();
                    if (_loc4_ != null)
                    {
                        this.var_1473 = _loc4_.getNumber(RoomObjectVariableEnum.var_770);
                        this.var_1474 = _loc4_.getNumber(RoomObjectVariableEnum.var_771);
                        this._paramOffsetZ = _loc4_.getNumber(RoomObjectVariableEnum.var_772);
                    };
                };
            };
            if (!this.var_4695)
            {
                this.var_4695 = this.checkIfImageReady();
                if (this.var_4695)
                {
                    this.checkAndCreateImageForCurrentState(param1);
                    return (true);
                };
            }
            else
            {
                if (this.checkIfImageChanged())
                {
                    this.var_4695 = false;
                    this._imageUrl = null;
                    return (true);
                };
            };
            return (_loc2_);
        }

        protected function checkIfImageChanged():Boolean
        {
            var _loc2_:IRoomObjectModel;
            var _loc3_:String;
            var _loc1_:IRoomObject = object;
            if (_loc1_ != null)
            {
                _loc2_ = _loc1_.getModel();
                if (_loc2_ != null)
                {
                    _loc3_ = _loc2_.getString(RoomObjectVariableEnum.var_769);
                    if (((!(_loc3_ == null)) && (!(_loc3_ == this._imageUrl))))
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }

        protected function checkIfImageReady():Boolean
        {
            var _loc2_:IRoomObjectModel;
            var _loc3_:String;
            var _loc4_:Number;
            var _loc5_:IGraphicAsset;
            var _loc6_:BitmapData;
            var _loc1_:IRoomObject = object;
            if (_loc1_ != null)
            {
                _loc2_ = _loc1_.getModel();
                if (_loc2_ != null)
                {
                    _loc3_ = _loc2_.getString(RoomObjectVariableEnum.var_769);
                    if (_loc3_ != null)
                    {
                        if (((this._imageUrl == null) || (!(this._imageUrl == _loc3_))))
                        {
                            _loc4_ = _loc2_.getNumber(RoomObjectVariableEnum.var_768);
                            if (_loc4_ == 1)
                            {
                                _loc5_ = assetCollection.getAsset(_loc3_);
                                if (_loc5_ != null)
                                {
                                    _loc6_ = (_loc5_.asset.content as BitmapData);
                                    if (_loc6_ != null)
                                    {
                                        this.imageReady(_loc6_, _loc3_);
                                        return (true);
                                    };
                                };
                            };
                        };
                    };
                };
            };
            return (false);
        }

        override protected function updateSprites(param1:int, param2:Boolean, param3:int):void
        {
            super.updateSprites(param1, param2, param3);
        }

        protected function imageReady(param1:BitmapData, param2:String):void
        {
            Logger.log(("billboard visualization got image from url = " + param2));
            if (param1 != null)
            {
                this._imageUrl = param2;
            }
            else
            {
                this._imageUrl = null;
            };
        }

        override protected function getSpriteAssetName(param1:int, param2:int):String
        {
            var _loc7_:int;
            var _loc3_:int = getSize(param1);
            var _loc4_:String = type;
            var _loc5_:String = "";
            if (param2 < (spriteCount - 1))
            {
                _loc5_ = String.fromCharCode(("a".charCodeAt() + param2));
            }
            else
            {
                _loc5_ = "sd";
            };
            if (_loc3_ == 1)
            {
                _loc4_ = (_loc4_ + ("_icon_" + _loc5_));
            }
            else
            {
                _loc7_ = getFrameNumber(param1, param2);
                _loc4_ = (_loc4_ + ((((((("_" + _loc3_) + "_") + _loc5_) + "_") + direction) + "_") + _loc7_));
            };
            var _loc6_:String = getSpriteTag(param1, direction, param2);
            if (((!(this._imageUrl == null)) && (_loc6_ == var_1468)))
            {
                return ((((this._imageUrl + "_") + _loc3_) + "_") + object.getState(0));
            };
            return (_loc4_);
        }

        private function checkAndCreateImageForCurrentState(param1:int):void
        {
            var _loc8_:BitmapData;
            var _loc14_:Matrix;
            if (((object == null) || (this._imageUrl == null)))
            {
                return;
            };
            var _loc2_:IGraphicAsset = assetCollection.getAsset(this._imageUrl);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:int = object.getState(0);
            var _loc4_:int = getSize(param1);
            var _loc5_:String = ((((this._imageUrl + "_") + _loc4_) + "_") + _loc3_);
            var _loc6_:IGraphicAsset = assetCollection.getAsset(_loc5_);
            if (_loc6_ != null)
            {
                return;
            };
            var _loc7_:BitmapData = (_loc2_.asset.content as BitmapData);
            if (_loc7_ == null)
            {
                Logger.log(("could not find bitmap data for image " + _loc5_));
                return;
            };
            if (_loc4_ == 32)
            {
                _loc14_ = new Matrix();
                _loc14_.scale(0.5, 0.5);
                _loc8_ = new BitmapData((_loc7_.width / 2), (_loc7_.height / 2), true, 0xFFFFFF);
                _loc8_.draw(_loc7_, _loc14_);
            }
            else
            {
                _loc8_ = _loc7_.clone();
            };
            var _loc9_:int;
            var _loc10_:int;
            var _loc11_:Boolean;
            var _loc12_:Boolean;
            switch (_loc3_)
            {
                case var_1469:
                    _loc9_ = 0;
                    _loc10_ = 0;
                    _loc11_ = false;
                    _loc12_ = false;
                    break;
                case var_1470:
                    _loc9_ = -(_loc8_.width);
                    _loc10_ = 0;
                    _loc11_ = true;
                    _loc12_ = false;
                    break;
                case var_1471:
                    _loc9_ = -(_loc8_.width);
                    _loc10_ = -(_loc8_.height);
                    _loc11_ = true;
                    _loc12_ = true;
                    break;
                case var_1472:
                    _loc9_ = 0;
                    _loc10_ = -(_loc8_.height);
                    _loc11_ = false;
                    _loc12_ = true;
                    break;
                default:
                    Logger.log(("could not handle unknown state " + _loc3_));
            };
            var _loc13_:Boolean = assetCollection.addAsset(_loc5_, _loc8_, true, _loc9_, _loc10_, _loc11_, _loc12_);
            if (!_loc13_)
            {
                Logger.log(("could not add asset for image " + _loc5_));
            };
        }


    }
}