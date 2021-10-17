package com.sulake.habbo.room.object.visualization.room.publicroom.rasterizer
{
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.core.utils.Map;
    import flash.geom.Point;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
    import flash.display.BlendMode;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import flash.display.BitmapData;

    public class LayoutRasterizer 
    {

        private var var_4749:IGraphicAssetCollection;
        private var var_4752:XMLList;
        private var _offsetX:int;
        private var var_2703:int;
        private var var_4753:Vector3d;
        private var var_4754:String;
        private var var_4312:Map = null;
        private var var_4755:String = "";
        private var _adBgIndex:int = -1;
        private var _adImgIndex:int = -1;
        private var var_4756:Boolean = false;
        private var var_4757:String = "";
        private var var_4758:int = 0;
        private var var_4759:Boolean = true;
        private var var_4760:Array = [];
        private var var_4761:Array = [];
        private var var_4762:Array = [];
        private var var_4763:Point = null;
        private var var_4764:LayoutRasterizerData = null;

        public function LayoutRasterizer()
        {
            this.var_4312 = new Map();
            this.var_4754 = "";
            this.var_4763 = new Point();
        }

        public function get graphicsChanged():Boolean
        {
            return (this.var_4759);
        }

        public function set layout(param1:String):void
        {
            if (param1 != this.var_4754)
            {
                this.var_4754 = param1;
                this._adBgIndex = -1;
                this._adImgIndex = -1;
                this.var_4764 = this.var_4312.getValue(this.var_4754);
            };
        }

        public function dispose():void
        {
            var _loc1_:int;
            var _loc2_:LayoutRasterizerData;
            this.var_4749 = null;
            this.var_4752 = null;
            this.var_4760 = null;
            this.var_4761 = null;
            this.var_4762 = null;
            if (this.var_4312 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_4312.length)
                {
                    _loc2_ = (this.var_4312.getWithIndex(_loc1_) as LayoutRasterizerData);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    };
                    _loc1_++;
                };
                this.var_4312.dispose();
                this.var_4312 = null;
            };
            this.var_4764 = null;
        }

        public function initialize(param1:XML):void
        {
            var _loc2_:String = String(param1.@name);
            var _loc3_:LayoutRasterizerData = new LayoutRasterizerData(param1);
            this.var_4312.add(_loc2_, _loc3_);
            this.var_4753 = new Vector3d(-0.5, 0.5, 0);
            this.var_4759 = false;
        }

        public function initializeGeometry(param1:IRoomGeometry):void
        {
            var _loc2_:Point = param1.getScreenPoint(new Vector3d(0, 0, 0));
            var _loc3_:Point = param1.getScreenPoint(this.var_4753);
            _loc3_.x = (_loc3_.x - _loc2_.x);
            _loc3_.y = (_loc3_.y - _loc2_.y);
            _loc3_.x = Math.round(_loc3_.x);
            _loc3_.y = Math.round(_loc3_.y);
            this.var_4763.x = _loc3_.x;
            this.var_4763.y = _loc3_.y;
        }

        public function initializeAds(param1:int, param2:IRoomObjectSpriteVisualization):void
        {
            var _loc7_:XML;
            var _loc8_:XMLList;
            var _loc9_:XML;
            var _loc10_:String;
            var _loc11_:String;
            this.var_4758 = param1;
            var _loc3_:LayoutRasterizerData = this.var_4312.getValue(this.var_4754);
            if (_loc3_ == null)
            {
                return;
            };
            var _loc4_:XMLList = _loc3_.elementList;
            if (_loc4_ == null)
            {
                return;
            };
            var _loc5_:IRoomObjectSprite;
            var _loc6_:int;
            while (_loc6_ < _loc4_.length())
            {
                _loc7_ = _loc4_[_loc6_];
                if (_loc7_ != null)
                {
                    _loc8_ = _loc7_.visualization;
                    if (((_loc8_.length() > 0) && (_loc8_.visualizationLayer.length() > 0)))
                    {
                        _loc9_ = _loc8_.visualizationLayer[0];
                        if (_loc9_ != null)
                        {
                            if (_loc7_.@id.toString().length > 0)
                            {
                                _loc10_ = String(_loc7_.@id);
                                if (_loc10_ == "billboard_bg")
                                {
                                    this._adBgIndex = _loc6_;
                                    _loc11_ = String(_loc9_.@asset);
                                    if (_loc11_.indexOf("left") > -1)
                                    {
                                        this.var_4755 = RoomObjectVariableEnum.var_529;
                                    };
                                    if (_loc11_.indexOf("right") > -1)
                                    {
                                        this.var_4755 = RoomObjectVariableEnum.var_530;
                                    };
                                    if (param2 != null)
                                    {
                                        _loc5_ = param2.getSprite((this.var_4758 + this._adBgIndex));
                                        if (_loc5_ != null)
                                        {
                                            _loc5_.visible = false;
                                            _loc5_.alpha = 0;
                                        };
                                    };
                                };
                                if (_loc10_ == "billboard_img")
                                {
                                    this._adImgIndex = _loc6_;
                                    if (param2 != null)
                                    {
                                        _loc5_ = param2.getSprite((this.var_4758 + this._adImgIndex));
                                        if (_loc5_ != null)
                                        {
                                            _loc5_.visible = false;
                                            _loc5_.alpha = 0;
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
                _loc6_++;
            };
        }

        public function initializeAssetCollection(param1:IGraphicAssetCollection):void
        {
            this.var_4749 = param1;
        }

        public function elementCount():int
        {
            var _loc1_:LayoutRasterizerData = this.var_4312.getValue(this.var_4754);
            if (_loc1_ == null)
            {
                return (0);
            };
            var _loc2_:XMLList = _loc1_.elementList;
            if (_loc2_ == null)
            {
                return (0);
            };
            return (_loc2_.length());
        }

        private function getBlendMode(param1:String):String
        {
            var _loc2_:String = BlendMode.NORMAL;
            switch (param1)
            {
                case "ADD":
                    _loc2_ = BlendMode.ADD;
                    break;
                case "SUBTRACT":
                    _loc2_ = BlendMode.SUBTRACT;
                    break;
                case "DARKEN":
                    _loc2_ = BlendMode.DARKEN;
                    break;
            };
            return (_loc2_);
        }

        public function showAd(param1:IRoomObjectSpriteVisualization, param2:String="", param3:Boolean=false):void
        {
            if (((param2 == this.var_4757) && (param3 == this.var_4756)))
            {
                return;
            };
            if (((this._adBgIndex == -1) || (this._adImgIndex == -1)))
            {
                Logger.log("ERROR! Billboard sprite indices not defined, cannot show room ad!");
                return;
            };
            var _loc4_:IRoomObjectSprite;
            var _loc5_:IRoomObjectSprite;
            if (param1 != null)
            {
                _loc4_ = param1.getSprite((this.var_4758 + this._adBgIndex));
                _loc5_ = param1.getSprite((this.var_4758 + this._adImgIndex));
            };
            if (((_loc4_ == null) || (_loc5_ == null)))
            {
                Logger.log("ERROR! Billboard sprites not defined, cannot show room ad!");
                return;
            };
            if (param3)
            {
                this.exchangeElementGraphics("billboard_img", param2);
            }
            else
            {
                this.exchangeElementGraphics("billboard_img", this.var_4755);
            };
            this.setElementToSprite(this._adBgIndex, _loc4_, param2, param3);
            this.setElementToSprite(this._adImgIndex, _loc5_, param2, param3);
            if (param3)
            {
                _loc5_.capturesMouse = true;
                _loc5_.clickHandling = true;
                _loc5_.tag = RoomObjectVariableEnum.var_787;
            };
            if (param2 != "")
            {
                _loc4_.visible = true;
                _loc4_.alpha = 0xFF;
                _loc5_.visible = true;
                _loc5_.alpha = 0xFF;
            }
            else
            {
                _loc4_.visible = false;
                _loc4_.alpha = 0;
                _loc5_.visible = false;
                _loc5_.alpha = 0;
            };
            _loc5_.offsetX = (_loc5_.offsetX - (_loc5_.width / 2));
            _loc5_.offsetY = (_loc5_.offsetY - (_loc5_.height / 2));
            this.var_4757 = param2;
            this.var_4756 = param3;
        }

        public function setElementToSprite(param1:int, param2:IRoomObjectSprite, param3:String="", param4:Boolean=false):void
        {
            var _loc10_:String;
            if (this.var_4764 == null)
            {
                return;
            };
            var _loc5_:XMLList = this.var_4764.elementList;
            if (_loc5_ == null)
            {
                return;
            };
            if (((param1 < 0) || (param1 >= _loc5_.length())))
            {
                return;
            };
            var _loc6_:XML = _loc5_[param1];
            if (_loc6_ == null)
            {
                return;
            };
            var _loc7_:XMLList = _loc6_.visualization;
            if (((_loc7_.length() == 0) || (_loc7_.visualizationLayer.length() == 0)))
            {
                return;
            };
            var _loc8_:XML = _loc7_.visualizationLayer[0];
            if (_loc8_ == null)
            {
                return;
            };
            var _loc9_:IGraphicAsset = this.var_4749.getAsset(_loc8_.@asset);
            if (((_loc9_ == null) || (_loc9_.asset == null)))
            {
                return;
            };
            param2.visible = true;
            param2.alpha = 0xFF;
            param2.asset = (_loc9_.asset.content as BitmapData);
            param2.offsetX = ((int(_loc8_.@x) + _loc9_.offsetX) + this.var_4763.x);
            param2.offsetY = ((int(_loc8_.@y) + _loc9_.offsetY) + this.var_4763.y);
            param2.blendMode = this.getBlendMode(String(_loc8_.@ink));
            param2.capturesMouse = false;
            if (parseInt(_loc8_.@capturesMouse) > 0)
            {
                param2.capturesMouse = true;
                param2.tag = String(_loc6_.@id);
            };
            if (String(_loc8_.@z) != "")
            {
                param2.relativeDepth = ((-(Number(_loc8_.@z)) / Math.sqrt(2)) - (1E-5 * param1));
            }
            else
            {
                param2.relativeDepth = -(0.001 * param1);
            };
            if (_loc8_.@blend.toString().length > 0)
            {
                param2.alpha = int((Number(_loc8_.@blend) * 2.55));
            };
            if (_loc8_.@flipH.toString().length > 0)
            {
                param2.flipH = Boolean(_loc8_.@flipH);
            };
            if (_loc6_.@id.toString().length > 0)
            {
                _loc10_ = String(_loc6_.@id);
                if (((this.var_4760.indexOf(_loc10_) >= 0) && (this.var_4759)))
                {
                    param1 = this.var_4760.indexOf(_loc10_);
                    if (this.var_4761[param1] != "")
                    {
                        _loc9_ = this.var_4749.getAsset(this.var_4761[param1]);
                        if (((!(_loc9_ == null)) && (!(_loc9_.asset == null))))
                        {
                            param2.asset = (_loc9_.asset.content as BitmapData);
                        }
                        else
                        {
                            param2.asset = null;
                        };
                    };
                    if (this.var_4762[param1] != -1)
                    {
                        param2.alpha = this.var_4762[param1];
                    };
                    this.var_4760.splice(param1, 1);
                    this.var_4761.splice(param1, 1);
                    this.var_4762.splice(param1, 1);
                    if (this.var_4760.length == 0)
                    {
                        this.var_4759 = false;
                    };
                };
            };
        }

        public function exchangeElementGraphics(param1:String, param2:String):void
        {
            this.var_4759 = true;
            var _loc3_:int = this.var_4760.indexOf(param1);
            if (_loc3_ < 0)
            {
                this.var_4760.push(param1);
                this.var_4761.push(param2);
                this.var_4762.push(-1);
            }
            else
            {
                this.var_4761[_loc3_] = param2;
            };
        }

        public function changeElementAlpha(param1:String, param2:Number):void
        {
            this.var_4759 = true;
            var _loc3_:int = this.var_4760.indexOf(param1);
            if (_loc3_ < 0)
            {
                this.var_4760.push(param1);
                this.var_4761.push("");
                this.var_4762.push(param2);
            }
            else
            {
                this.var_4762[_loc3_] = param2;
            };
        }


    }
}