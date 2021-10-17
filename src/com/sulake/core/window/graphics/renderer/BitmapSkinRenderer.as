package com.sulake.core.window.graphics.renderer
{
    import flash.geom.ColorTransform;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.utils.Dictionary;
    import flash.geom.Matrix;
    import com.sulake.core.window.graphics.BitmapSkinParser;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.display.BitmapData;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.core.window.IWindow;
    import flash.display.IBitmapDrawable;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
    import flash.display.BitmapDataChannel;

    public class BitmapSkinRenderer extends SkinRenderer implements ISkinRenderer 
    {

        private static var ALPHA:ColorTransform = new ColorTransform(1, 1, 1, 1);
        private static var REGION:Rectangle = new Rectangle();
        private static const TOP_LEFT:Point = new Point();

        protected var var_2727:Dictionary;
        protected var var_2728:Dictionary;
        private var var_2729:Matrix;
        private var var_2726:ColorTransform;

        public function BitmapSkinRenderer(param1:String)
        {
            super(param1);
            this.var_2727 = new Dictionary(false);
            this.var_2728 = new Dictionary(false);
            this.var_2729 = new Matrix();
            this.var_2726 = new ColorTransform();
        }

        override public function parse(param1:IAsset, param2:XMLList, param3:IAssetLibrary):void
        {
            BitmapSkinParser.parseSkinDescription((param1.content as XML), param2, this, name, param3);
        }

        override public function dispose():void
        {
            var _loc1_:String;
            var _loc2_:BitmapData;
            if (!disposed)
            {
                super.dispose();
                this.var_2729 = null;
                this.var_2726 = null;
                for (_loc1_ in this.var_2727)
                {
                    _loc2_ = (this.var_2727[_loc1_] as BitmapData);
                    _loc2_.dispose();
                    delete this.var_2727[_loc1_];
                };
                this.var_2727 = null;
                for (_loc1_ in this.var_2728)
                {
                    _loc2_ = (this.var_2728[_loc1_] as BitmapData);
                    _loc2_.dispose();
                    delete this.var_2728[_loc1_];
                };
                this.var_2728 = null;
            };
        }

        override public function isStateDrawable(param1:uint):Boolean
        {
            return (!(_templatesByState[param1] == null));
        }

        override public function draw(param1:IWindow, param2:IBitmapDrawable, param3:Rectangle, param4:uint, param5:Boolean):void
        {
            var _loc9_:uint;
            var _loc10_:SkinLayoutEntity;
            var _loc11_:ISkinTemplateEntity;
            var _loc12_:Boolean;
            var _loc13_:Boolean;
            var _loc14_:int;
            var _loc15_:int;
            var _loc16_:Boolean;
            var _loc17_:uint;
            var _loc18_:BitmapData;
            var _loc19_:BitmapData;
            var _loc20_:int;
            var _loc21_:int;
            var _loc22_:int;
            var _loc23_:int;
            var _loc24_:int;
            var _loc25_:int;
            var _loc26_:Point;
            var _loc27_:Rectangle;
            var _loc28_:Rectangle;
            var _loc29_:uint;
            var _loc30_:int;
            var _loc31_:BitmapData;
            var _loc32_:BitmapData;
            var _loc6_:BitmapData = (param2 as BitmapData);
            var _loc7_:ISkinLayout = var_1993[param4];
            var _loc8_:ISkinTemplate = _templatesByState[param4];
            if (_loc7_ == null)
            {
                Logger.log(("LAYOUT NULL " + param4));
                _loc7_ = var_1993[WindowState.var_1189];
                _loc8_ = _templatesByState[WindowState.var_1189];
            };
            _loc9_ = _loc7_.numChildren;
            if (((!(_loc7_ == null)) && (_loc9_ > 0)))
            {
                _loc14_ = (param3.width - _loc7_.width);
                _loc15_ = (param3.height - _loc7_.height);
                _loc16_ = ((!(param1.background)) && ((param1.color & 0xFFFFFF) < 0xFFFFFF));
                if (_loc16_)
                {
                    this.var_2726.redMultiplier = (((param1.color & 0xFF0000) >> 16) / 0xFF);
                    this.var_2726.greenMultiplier = (((param1.color & 0xFF00) >> 8) / 0xFF);
                    this.var_2726.blueMultiplier = ((param1.color & 0xFF) / 0xFF);
                    this.var_2726.alphaMultiplier = 1;
                };
                _loc17_ = 0;
                while (_loc17_ < _loc9_)
                {
                    _loc10_ = (_loc7_.getChildAt(_loc17_) as SkinLayoutEntity);
                    _loc11_ = (_loc8_.getChildByName(_loc10_.name) as ISkinTemplateEntity);
                    if (_loc11_ != null)
                    {
                        _loc18_ = this.getBitmapFromCache(_loc8_, _loc10_.name);
                        _loc19_ = this.getAlphaFromCache(_loc8_, _loc10_.name);
                        if (((_loc16_) && (_loc10_.colorize)))
                        {
                            _loc18_ = _loc18_.clone();
                            _loc18_.colorTransform(_loc18_.rect, this.var_2726);
                        };
                        _loc12_ = false;
                        _loc13_ = false;
                        REGION.x = (_loc10_.region.x + param3.x);
                        REGION.y = (_loc10_.region.y + param3.y);
                        REGION.width = _loc10_.region.width;
                        REGION.height = _loc10_.region.height;
                        if (_loc10_.var_1994 == SkinLayoutEntity.var_1995)
                        {
                            REGION.x = (REGION.x + _loc14_);
                        }
                        else
                        {
                            if (_loc10_.var_1994 == SkinLayoutEntity.var_1996)
                            {
                                _loc12_ = true;
                                REGION.right = (REGION.right + _loc14_);
                                if (REGION.width < 1) break;
                            }
                            else
                            {
                                if (_loc10_.var_1994 == SkinLayoutEntity.var_1997)
                                {
                                    _loc12_ = true;
                                    REGION.right = (REGION.right + _loc14_);
                                    if (REGION.width < 1) break;
                                }
                                else
                                {
                                    if (_loc10_.var_1994 == SkinLayoutEntity.var_1998)
                                    {
                                        REGION.x = ((param3.width / 2) - (REGION.width / 2));
                                    };
                                };
                            };
                        };
                        if (_loc10_.var_1999 == SkinLayoutEntity.var_1995)
                        {
                            REGION.y = (REGION.y + _loc15_);
                        }
                        else
                        {
                            if (_loc10_.var_1999 == SkinLayoutEntity.var_1996)
                            {
                                _loc13_ = true;
                                REGION.bottom = (REGION.bottom + _loc15_);
                                if (REGION.height < 1) break;
                            }
                            else
                            {
                                if (_loc10_.var_1999 == SkinLayoutEntity.var_1997)
                                {
                                    _loc13_ = true;
                                    REGION.bottom = (REGION.bottom + _loc15_);
                                    if (REGION.height < 1) break;
                                }
                                else
                                {
                                    if (_loc10_.var_1999 == SkinLayoutEntity.var_1998)
                                    {
                                        REGION.y = ((param3.height / 2) - (REGION.height / 2));
                                    };
                                };
                            };
                        };
                        if (((!(_loc12_)) && (!(_loc13_))))
                        {
                            _loc6_.copyPixels(_loc18_, _loc18_.rect, REGION.topLeft, _loc19_, TOP_LEFT, true);
                        }
                        else
                        {
                            if (((_loc10_.var_1999 == SkinLayoutEntity.var_1997) || (_loc10_.var_1994 == SkinLayoutEntity.var_1997)))
                            {
                                _loc20_ = _loc18_.width;
                                _loc21_ = _loc18_.height;
                                _loc22_ = int((REGION.width / _loc20_));
                                _loc23_ = int((REGION.height / _loc21_));
                                _loc24_ = (REGION.width % _loc20_);
                                _loc25_ = (REGION.height % _loc21_);
                                _loc26_ = new Point(REGION.x, REGION.y);
                                _loc27_ = new Rectangle(0, 0, _loc24_, _loc18_.height);
                                _loc28_ = new Rectangle(0, 0, _loc18_.width, _loc25_);
                                _loc29_ = 0;
                                while (_loc29_ < _loc23_)
                                {
                                    _loc26_.x = REGION.x;
                                    _loc30_ = 0;
                                    while (_loc30_ < _loc22_)
                                    {
                                        _loc6_.copyPixels(_loc18_, _loc18_.rect, _loc26_, _loc19_, TOP_LEFT, true);
                                        _loc26_.x = (_loc26_.x + _loc20_);
                                        _loc30_++;
                                    };
                                    if (_loc24_ > 0)
                                    {
                                        _loc6_.copyPixels(_loc18_, _loc27_, _loc26_, _loc19_, TOP_LEFT, true);
                                    };
                                    _loc26_.y = (_loc26_.y + _loc21_);
                                    _loc29_++;
                                };
                                if (_loc25_ > 0)
                                {
                                    _loc26_.x = REGION.x;
                                    _loc29_ = 0;
                                    while (_loc29_ < _loc22_)
                                    {
                                        _loc6_.copyPixels(_loc18_, _loc28_, _loc26_, _loc19_, TOP_LEFT, true);
                                        _loc26_.x = (_loc26_.x + _loc20_);
                                        _loc29_++;
                                    };
                                };
                            }
                            else
                            {
                                if (((_loc18_.width == 1) && (_loc18_.height == 1)))
                                {
                                    this.var_2729.a = REGION.width;
                                    this.var_2729.d = REGION.height;
                                    this.var_2729.tx = REGION.x;
                                    this.var_2729.ty = REGION.y;
                                    ALPHA.alphaMultiplier = ((_loc19_.getPixel32(0, 0) >>> 24) / 0xFF);
                                    _loc6_.draw(_loc18_, this.var_2729, ALPHA);
                                }
                                else
                                {
                                    this.var_2729.a = (REGION.width / _loc18_.width);
                                    this.var_2729.d = (REGION.height / _loc18_.height);
                                    this.var_2729.tx = 0;
                                    this.var_2729.ty = 0;
                                    _loc31_ = new BitmapData(REGION.width, REGION.height, _loc18_.transparent);
                                    _loc31_.draw(_loc18_, this.var_2729);
                                    _loc32_ = new BitmapData(REGION.width, REGION.height, true, 0);
                                    _loc32_.draw(_loc19_, this.var_2729, null);
                                    _loc6_.copyPixels(_loc31_, _loc31_.rect, REGION.topLeft, _loc32_, TOP_LEFT, true);
                                    _loc32_.dispose();
                                    _loc31_.dispose();
                                };
                            };
                        };
                        if (((_loc16_) && (_loc10_.colorize)))
                        {
                            _loc18_.dispose();
                        };
                    };
                    _loc17_++;
                };
            };
        }

        protected function drawStaticLayoutEntity(param1:BitmapData, param2:Rectangle, param3:ISkinLayout, param4:SkinLayoutEntity, param5:ISkinTemplate, param6:ISkinTemplateEntity):void
        {
            var _loc8_:BitmapData;
            var _loc9_:BitmapData;
            var _loc7_:Rectangle = param4.region.clone();
            _loc7_.x = (_loc7_.x + param2.x);
            _loc7_.y = (_loc7_.y + param2.y);
            switch (param6.type)
            {
                case "bitmap":
                    _loc8_ = this.getBitmapFromCache(param5, param4.name);
                    _loc9_ = this.getAlphaFromCache(param5, param4.name);
                    if (param4.var_1994 == SkinLayoutEntity.var_1995)
                    {
                        _loc7_.x = (_loc7_.x + (param2.width - param3.width));
                    };
                    if (param4.var_1999 == SkinLayoutEntity.var_1995)
                    {
                        _loc7_.y = (_loc7_.y + (param2.height - param3.height));
                    };
                    param1.copyPixels(_loc8_, _loc8_.rect, _loc7_.topLeft, _loc9_, null, true);
                    return;
                case "fill":
                    param1.fillRect(_loc7_, param4.color);
                    return;
            };
        }

        private function getBitmapFromCache(param1:ISkinTemplate, param2:String):BitmapData
        {
            var _loc5_:ISkinTemplateEntity;
            var _loc6_:BitmapData;
            var _loc3_:String = ((param2 + "@") + param1.name);
            var _loc4_:BitmapData = this.var_2727[_loc3_];
            if (_loc4_ == null)
            {
                _loc5_ = (param1.getChildByName(param2) as ISkinTemplateEntity);
                if (_loc5_ == null)
                {
                    throw (new Error((("Template entity" + param2) + "not found!")));
                };
                _loc6_ = (BitmapDataAsset(param1.asset).content as BitmapData);
                if (_loc6_ == null)
                {
                    throw (new Error((("Asset " + param1.asset) + " not found!")));
                };
                _loc4_ = new TrackedBitmapData(this, _loc5_.region.width, _loc5_.region.height, false);
                _loc4_.copyPixels(_loc6_, _loc5_.region, _loc4_.rect.topLeft);
                this.var_2727[_loc3_] = _loc4_;
            };
            return (_loc4_);
        }

        private function getAlphaFromCache(param1:ISkinTemplate, param2:String):BitmapData
        {
            var _loc5_:ISkinTemplateEntity;
            var _loc6_:BitmapData;
            var _loc3_:String = ((param2 + "@") + param1.name);
            var _loc4_:BitmapData = this.var_2728[_loc3_];
            if (_loc4_ == null)
            {
                _loc5_ = (param1.getChildByName(param2) as ISkinTemplateEntity);
                if (_loc5_ == null)
                {
                    throw (new Error((("Template entity" + param2) + "not found!")));
                };
                _loc6_ = (BitmapDataAsset(param1.asset).content as BitmapData);
                if (_loc6_ == null)
                {
                    throw (new Error((("Asset " + param1.asset) + " not found!")));
                };
                _loc4_ = new TrackedBitmapData(this, _loc5_.region.width, _loc5_.region.height, true);
                _loc4_.copyChannel(_loc6_, _loc5_.region, _loc4_.rect.topLeft, BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
                this.var_2728[_loc3_] = _loc4_;
            };
            return (_loc4_);
        }

        private function drawBorders(param1:BitmapData, param2:Rectangle, param3:uint):void
        {
            var _loc4_:int;
            var _loc5_:int = (param2.bottom - 1);
            _loc4_ = param2.left;
            while (_loc4_ < (param2.right - 1))
            {
                param1.setPixel32(_loc4_, 0, param3);
                param1.setPixel32(_loc4_, _loc5_, param3);
                _loc4_++;
            };
            _loc5_ = param2.top;
            while (_loc5_ < (param2.bottom - 1))
            {
                param1.setPixel32(0, _loc5_, param3);
                param1.setPixel32(_loc4_, _loc5_, param3);
                _loc5_++;
            };
        }


    }
}