package com.sulake.habbo.room.object.visualization.room.rasterizer.animated
{
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneRasterizer;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneVisualization;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneMaterial;
    import com.sulake.room.utils.XMLValidator;
    import com.sulake.habbo.room.object.visualization.room.utils.Randomizer;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneVisualizationLayer;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
    import com.sulake.room.utils.IVector3d;

    public class LandscapeRasterizer extends PlaneRasterizer 
    {

        private static const var_1047:int = 500;

        private var var_4769:int = 0;
        private var var_4770:int = 0;


        override public function initializeDimensions(param1:int, param2:int):Boolean
        {
            if (param1 < 0)
            {
                param1 = 0;
            };
            if (param2 < 0)
            {
                param2 = 0;
            };
            this.var_4769 = param1;
            this.var_4770 = param2;
            return (true);
        }

        override protected function initializePlanes():void
        {
            if (data == null)
            {
                return;
            };
            var _loc1_:XMLList = data.landscapes;
            if (_loc1_.length() > 0)
            {
                this.parseLandscapes(_loc1_[0]);
            };
        }

        private function parseLandscapes(param1:XML):void
        {
            var _loc6_:XML;
            var _loc7_:String;
            var _loc8_:XMLList;
            var _loc9_:LandscapePlane;
            var _loc10_:int;
            var _loc11_:XML;
            var _loc12_:int;
            var _loc13_:String;
            var _loc14_:String;
            var _loc15_:Number;
            var _loc16_:Number;
            var _loc17_:int;
            var _loc18_:PlaneVisualization;
            var _loc19_:int;
            var _loc20_:XML;
            var _loc21_:XML;
            var _loc22_:PlaneMaterial;
            var _loc23_:int;
            var _loc24_:String;
            var _loc25_:int;
            var _loc26_:String;
            var _loc27_:uint;
            var _loc28_:String;
            var _loc29_:String;
            var _loc30_:XMLList;
            var _loc31_:XML;
            var _loc32_:int;
            var _loc33_:XML;
            var _loc34_:int;
            var _loc35_:String;
            var _loc36_:Number;
            var _loc37_:Number;
            var _loc38_:Number;
            var _loc39_:Number;
            if (param1 == null)
            {
                return;
            };
            var _loc2_:Array = ["id", "assetId"];
            var _loc3_:int = int((Math.random() * 654321));
            var _loc4_:XMLList = param1.landscape;
            var _loc5_:int;
            while (_loc5_ < _loc4_.length())
            {
                _loc6_ = _loc4_[_loc5_];
                if (XMLValidator.checkRequiredAttributes(_loc6_, ["id"]))
                {
                    _loc7_ = _loc6_.@id;
                    _loc8_ = _loc6_.animatedVisualization;
                    _loc9_ = new LandscapePlane();
                    _loc10_ = 0;
                    while (_loc10_ < _loc8_.length())
                    {
                        _loc11_ = _loc8_[_loc10_];
                        if (XMLValidator.checkRequiredAttributes(_loc11_, ["size"]))
                        {
                            _loc12_ = parseInt(_loc11_.@size);
                            _loc13_ = _loc11_.@horizontalAngle;
                            _loc14_ = _loc11_.@verticalAngle;
                            _loc15_ = LandscapePlane.var_2228;
                            if (_loc13_ != "")
                            {
                                _loc15_ = parseFloat(_loc13_);
                            };
                            _loc16_ = LandscapePlane.var_2229;
                            if (_loc14_ != "")
                            {
                                _loc16_ = parseFloat(_loc14_);
                            };
                            _loc17_ = (_loc11_.visualizationLayer.length() + _loc11_.animationLayer.length());
                            _loc18_ = _loc9_.createPlaneVisualization(_loc12_, _loc17_, getGeometry(_loc12_, _loc15_, _loc16_));
                            if (_loc18_ != null)
                            {
                                Randomizer.setSeed(_loc3_);
                                _loc19_ = 0;
                                while (_loc19_ < _loc11_.children().length())
                                {
                                    _loc20_ = _loc11_.children()[_loc19_];
                                    if (_loc20_.name() == "visualizationLayer")
                                    {
                                        _loc21_ = _loc20_;
                                        _loc22_ = null;
                                        _loc23_ = PlaneVisualizationLayer.ALIGN_DEFAULT;
                                        if (XMLValidator.checkRequiredAttributes(_loc21_, ["materialId"]))
                                        {
                                            _loc29_ = _loc21_.@materialId;
                                            _loc22_ = getMaterial(_loc29_);
                                        };
                                        _loc24_ = _loc21_.@offset;
                                        _loc25_ = PlaneVisualizationLayer.var_2230;
                                        if (_loc24_.length > 0)
                                        {
                                            _loc25_ = parseInt(_loc24_);
                                        };
                                        _loc26_ = _loc21_.@color;
                                        _loc27_ = LandscapePlane.var_1446;
                                        if (_loc26_.length > 0)
                                        {
                                            _loc27_ = parseInt(_loc26_);
                                        };
                                        _loc28_ = _loc21_.@align;
                                        if (_loc28_ == "bottom")
                                        {
                                            _loc23_ = PlaneVisualizationLayer.var_2111;
                                        }
                                        else
                                        {
                                            if (_loc28_ == "top")
                                            {
                                                _loc23_ = PlaneVisualizationLayer.var_2225;
                                            };
                                        };
                                        _loc18_.var_2231(_loc19_, _loc22_, _loc27_, _loc23_, _loc25_);
                                    }
                                    else
                                    {
                                        if (_loc20_.name() == "animationLayer")
                                        {
                                            _loc30_ = _loc20_.animationItem;
                                            _loc31_ = <animation/>
                                            ;
                                            _loc32_ = 0;
                                            while (_loc32_ < _loc30_.length())
                                            {
                                                _loc33_ = (_loc30_[_loc32_] as XML);
                                                if (_loc33_ != null)
                                                {
                                                    if (XMLValidator.checkRequiredAttributes(_loc33_, _loc2_))
                                                    {
                                                        _loc34_ = parseInt(_loc33_.@id);
                                                        _loc35_ = _loc33_.@assetId;
                                                        _loc36_ = 0;
                                                        _loc37_ = 0;
                                                        _loc36_ = this.getCoordinateValue(_loc33_.@x, _loc33_.@randomX);
                                                        _loc37_ = this.getCoordinateValue(_loc33_.@y, _loc33_.@randomY);
                                                        _loc38_ = 0;
                                                        _loc39_ = 0;
                                                        _loc38_ = parseFloat(_loc33_.@speedX);
                                                        _loc39_ = parseFloat(_loc33_.@speedY);
                                                        _loc31_.appendChild(new (XML)((((((((((('<item x="' + _loc36_) + '" y="') + _loc37_) + '" speedX="') + _loc38_) + '" speedY="') + _loc39_) + '" asset="') + _loc35_) + '"/>')));
                                                    };
                                                };
                                                _loc32_++;
                                            };
                                            _loc18_.setAnimationLayer(_loc19_, _loc31_, assetCollection);
                                        };
                                    };
                                    _loc19_++;
                                };
                            };
                        };
                        _loc10_++;
                    };
                    if (!addPlane(_loc7_, _loc9_))
                    {
                        _loc9_.dispose();
                    };
                };
                _loc5_++;
            };
        }

        private function getCoordinateValue(param1:String, param2:String):Number
        {
            var _loc4_:Number;
            var _loc5_:Array;
            var _loc6_:Number;
            var _loc3_:Number = 0;
            if (param1.length > 0)
            {
                if (param1.charAt((param1.length - 1)) == "%")
                {
                    param1 = param1.substr(0, (param1.length - 1));
                    _loc3_ = (parseFloat(param1) / 100);
                };
            };
            if (param2.length > 0)
            {
                _loc4_ = 10000;
                _loc5_ = Randomizer.getValues(1, 0, _loc4_);
                _loc6_ = (_loc5_[0] / _loc4_);
                if (param2.charAt((param2.length - 1)) == "%")
                {
                    param2 = param2.substr(0, (param2.length - 1));
                    _loc3_ = (_loc3_ + ((_loc6_ * parseFloat(param2)) / 100));
                };
            };
            return (_loc3_);
        }

        override public function render(param1:BitmapData, param2:String, param3:Number, param4:Number, param5:Number, param6:IVector3d, param7:Boolean, param8:Number=0, param9:Number=0, param10:Number=0, param11:Number=0, param12:int=0):PlaneBitmapData
        {
            var _loc13_:LandscapePlane = (getPlane(param2) as LandscapePlane);
            if (_loc13_ == null)
            {
                _loc13_ = (getPlane(var_2232) as LandscapePlane);
            };
            if (_loc13_ == null)
            {
                return (null);
            };
            if (param1 != null)
            {
                param1.fillRect(param1.rect, 0xFFFFFF);
            };
            var _loc14_:BitmapData = _loc13_.render(param1, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12);
            if (((!(_loc14_ == null)) && (!(_loc14_ == param1))))
            {
                _loc14_ = _loc14_.clone();
            };
            var _loc15_:PlaneBitmapData;
            if (((!(_loc13_.isStatic(param5))) && (var_1047 > 0)))
            {
                _loc15_ = new PlaneBitmapData(_loc14_, ((Math.round((param12 / var_1047)) * var_1047) + var_1047));
            }
            else
            {
                _loc15_ = new PlaneBitmapData(_loc14_, -1);
            };
            return (_loc15_);
        }

        override public function getTextureIdentifier(param1:Number, param2:IVector3d):String
        {
            if (param2 != null)
            {
                if (param2.x < 0)
                {
                    return (String((param1 + "_0")));
                };
                return (String((param1 + "_1")));
            };
            return (super.getTextureIdentifier(param1, param2));
        }


    }
}