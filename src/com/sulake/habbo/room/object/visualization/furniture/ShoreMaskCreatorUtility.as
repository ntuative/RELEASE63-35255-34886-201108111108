package com.sulake.habbo.room.object.visualization.furniture
{
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import com.sulake.room.utils.Rasterizer;

    public class ShoreMaskCreatorUtility 
    {

        public static const var_1509:int = 0;
        public static const var_1511:int = 1;
        public static const var_1510:int = 2;
        private static const var_2237:int = 3;
        private static const MASK_COLOR_TRANSPARENT:uint = 0;
        private static const MASK_COLOR_SOLID:uint = 0xFFFFFFFF;


        public static function createEmptyMask(param1:int, param2:int):BitmapData
        {
            return (new BitmapData(param1, param2, true, MASK_COLOR_TRANSPARENT));
        }

        public static function getInstanceMaskName(param1:int, param2:int):String
        {
            return ((("instance_mask_" + param1) + "_") + param2);
        }

        public static function getBorderType(param1:int, param2:int):int
        {
            return (param1 + (param2 * var_2237));
        }

        public static function getInstanceMask(param1:int, param2:int, param3:IGraphicAssetCollection, param4:IGraphicAsset):IGraphicAsset
        {
            var _loc7_:BitmapDataAsset;
            var _loc8_:BitmapData;
            var _loc5_:String = getInstanceMaskName(param1, param2);
            var _loc6_:IGraphicAsset = param3.getAsset(_loc5_);
            if (_loc6_ == null)
            {
                if (param4 != null)
                {
                    _loc7_ = (param4.asset as BitmapDataAsset);
                    if (_loc7_ != null)
                    {
                        _loc8_ = (_loc7_.content as BitmapData);
                        if (_loc8_ != null)
                        {
                            param3.addAsset(_loc5_, new BitmapData(_loc8_.width, _loc8_.height, true, MASK_COLOR_TRANSPARENT), false, param4.offsetX, param4.offsetY);
                            _loc6_ = param3.getAsset(_loc5_);
                        };
                    };
                };
            };
            return (_loc6_);
        }

        public static function disposeInstanceMask(param1:int, param2:int, param3:IGraphicAssetCollection):void
        {
            var _loc4_:String = getInstanceMaskName(param1, param2);
            param3.disposeAsset(_loc4_);
        }

        public static function createShoreMask2x2(param1:BitmapData, param2:int, param3:Array, param4:Array, param5:IGraphicAssetCollection):BitmapData
        {
            var _loc7_:String;
            var _loc8_:IGraphicAsset;
            var _loc9_:BitmapData;
            param1.fillRect(param1.rect, MASK_COLOR_TRANSPARENT);
            var _loc6_:int;
            while (_loc6_ < param3.length)
            {
                if (param3[_loc6_] == true)
                {
                    _loc7_ = ((((("mask_" + param2) + "_") + _loc6_) + "_") + param4[_loc6_]);
                    _loc8_ = param5.getAsset(_loc7_);
                    if (((!(_loc8_ == null)) && (!(_loc8_.asset == null))))
                    {
                        _loc9_ = (_loc8_.asset.content as BitmapData);
                        if (_loc9_ != null)
                        {
                            param1.copyPixels(_loc9_, _loc9_.rect, new Point(0, 0), _loc9_, new Point(0, 0), true);
                        };
                    };
                };
                _loc6_++;
            };
            return (param1);
        }

        public static function initializeShoreMasks(param1:int, param2:IGraphicAssetCollection, param3:IGraphicAsset):Boolean
        {
            var _loc4_:String;
            var _loc5_:BitmapDataAsset;
            var _loc6_:BitmapData;
            var _loc7_:Array;
            var _loc8_:Array;
            var _loc9_:BitmapData;
            var _loc10_:int;
            if (param2 != null)
            {
                _loc4_ = ("masks_done_" + param1);
                if (param2.getAsset(_loc4_) == null)
                {
                    if (param3 != null)
                    {
                        _loc5_ = (param3.asset as BitmapDataAsset);
                        if (_loc5_ != null)
                        {
                            _loc6_ = (_loc5_.content as BitmapData);
                            _loc7_ = [var_1509, var_1511, var_1510, var_1509, var_1511, var_1510];
                            _loc8_ = [var_1511, var_1511, var_1511, var_1510, var_1510, var_1510];
                            _loc9_ = null;
                            _loc10_ = 0;
                            if (_loc6_ != null)
                            {
                                _loc10_ = 0;
                                while (((_loc10_ < _loc7_.length) && (_loc10_ < _loc8_.length)))
                                {
                                    _loc9_ = createMaskLeft(_loc6_.width, _loc6_.height);
                                    cutLeftMask(_loc9_, param1, _loc7_[_loc10_], _loc8_[_loc10_]);
                                    storeLeftMask(param2, _loc9_, param1, _loc7_[_loc10_], _loc8_[_loc10_]);
                                    _loc9_ = createMaskRight(_loc6_.width, _loc6_.height);
                                    cutRightMask(_loc9_, param1, _loc8_[_loc10_], _loc7_[_loc10_]);
                                    storeRightMask(param2, _loc9_, param1, _loc8_[_loc10_], _loc7_[_loc10_]);
                                    _loc10_++;
                                };
                            };
                        };
                        param2.addAsset(_loc4_, new BitmapData(1, 1), false);
                        return (true);
                    };
                    return (false);
                };
                return (true);
            };
            return (false);
        }

        private static function createMaskLeft(param1:int, param2:int):BitmapData
        {
            var _loc3_:BitmapData = new BitmapData(param1, param2, true, MASK_COLOR_TRANSPARENT);
            fillTopLeftCorner(_loc3_, (_loc3_.width / 2), ((_loc3_.height / 2) - 1), 1, MASK_COLOR_SOLID);
            return (_loc3_);
        }

        private static function cutLeftMask(param1:BitmapData, param2:int, param3:int, param4:int):void
        {
            if (param3 == var_1511)
            {
                cutLeftMaskOuterCorner(param1, param2, false);
            }
            else
            {
                if (param3 == var_1510)
                {
                    cutLeftMaskOuterCorner(param1, param2, true);
                };
            };
            if (param4 == var_1510)
            {
                cutLeftMaskInnerCorner(param1, param2);
            };
        }

        private static function cutLeftMaskOuterCorner(param1:BitmapData, param2:int, param3:Boolean):void
        {
            var _loc4_:int = int(((param1.height / 2) - (param2 / 2)));
            var _loc5_:int = int((param1.width / 2));
            if (param3)
            {
                param1.fillRect(new Rectangle(_loc5_, 0, param1.width, _loc4_), MASK_COLOR_TRANSPARENT);
            }
            else
            {
                fillTopLeftCorner(param1, _loc5_, (_loc4_ - 1), 1, MASK_COLOR_TRANSPARENT);
            };
        }

        private static function cutLeftMaskInnerCorner(param1:BitmapData, param2:int):void
        {
            var _loc3_:int = int(((param1.width / 2) + (param2 / 2)));
            param1.fillRect(new Rectangle(_loc3_, 0, param1.width, (param1.height / 2)), MASK_COLOR_TRANSPARENT);
        }

        private static function createMaskRight(param1:int, param2:int):BitmapData
        {
            var _loc3_:BitmapData = new BitmapData(param1, param2, true, MASK_COLOR_TRANSPARENT);
            fillBottomRightCorner(_loc3_, ((_loc3_.width / 2) + 1), ((_loc3_.height / 2) - 1), MASK_COLOR_SOLID);
            return (_loc3_);
        }

        private static function cutRightMask(param1:BitmapData, param2:int, param3:int, param4:int):void
        {
            if (param4 == var_1511)
            {
                cutRightMaskOuterCorner(param1, param2, false);
            }
            else
            {
                if (param4 == var_1510)
                {
                    cutRightMaskOuterCorner(param1, param2, true);
                };
            };
            if (param3 == var_1510)
            {
                cutRightMaskInnerCorner(param1, param2);
            };
        }

        private static function cutRightMaskInnerCorner(param1:BitmapData, param2:int):void
        {
            var _loc3_:int = int(((param1.width / 2) + (param2 / 2)));
            param1.fillRect(new Rectangle(_loc3_, 0, param1.width, ((param1.height / 2) - (param2 / 4))), MASK_COLOR_TRANSPARENT);
        }

        private static function cutRightMaskOuterCorner(param1:BitmapData, param2:int, param3:Boolean):void
        {
            var _loc4_:int = int((param1.height / 2));
            var _loc5_:int = int(((param1.width / 2) + param2));
            if (param3)
            {
                param1.fillRect(new Rectangle(_loc5_, 0, param1.width, _loc4_), MASK_COLOR_TRANSPARENT);
            }
            else
            {
                fillBottomRightCorner(param1, (_loc5_ + 1), (_loc4_ - 1), MASK_COLOR_TRANSPARENT);
            };
        }

        private static function storeLeftMask(param1:IGraphicAssetCollection, param2:BitmapData, param3:int, param4:int, param5:int):void
        {
            var _loc6_:String;
            if (param1 != null)
            {
                _loc6_ = "";
                _loc6_ = ((("mask_" + param3) + "_0_") + getBorderType(param4, param5));
                param1.addAsset(_loc6_, param2, false);
                _loc6_ = ((("mask_" + param3) + "_3_") + getBorderType(param5, param4));
                param1.addAsset(_loc6_, Rasterizer.getFlipVBitmapData(param2), false);
                _loc6_ = ((("mask_" + param3) + "_4_") + getBorderType(param4, param5));
                param1.addAsset(_loc6_, Rasterizer.getFlipHVBitmapData(param2), false);
                _loc6_ = ((("mask_" + param3) + "_7_") + getBorderType(param5, param4));
                param1.addAsset(_loc6_, Rasterizer.getFlipHBitmapData(param2), false);
            };
        }

        private static function storeRightMask(param1:IGraphicAssetCollection, param2:BitmapData, param3:int, param4:int, param5:int):void
        {
            var _loc6_:String;
            if (param1 != null)
            {
                _loc6_ = "";
                _loc6_ = ((("mask_" + param3) + "_1_") + getBorderType(param4, param5));
                param1.addAsset(_loc6_, param2, false);
                _loc6_ = ((("mask_" + param3) + "_2_") + getBorderType(param5, param4));
                param1.addAsset(_loc6_, Rasterizer.getFlipVBitmapData(param2), false);
                _loc6_ = ((("mask_" + param3) + "_5_") + getBorderType(param4, param5));
                param1.addAsset(_loc6_, Rasterizer.getFlipHVBitmapData(param2), false);
                _loc6_ = ((("mask_" + param3) + "_6_") + getBorderType(param5, param4));
                param1.addAsset(_loc6_, Rasterizer.getFlipHBitmapData(param2), false);
            };
        }

        private static function fillTopLeftCorner(param1:BitmapData, param2:int, param3:int, param4:int, param5:uint):void
        {
            var _loc9_:int;
            var _loc6_:int = param2;
            var _loc7_:int = param3;
            var _loc8_:int = param4;
            while (_loc7_ >= 0)
            {
                _loc9_ = _loc7_;
                while (_loc9_ >= 0)
                {
                    param1.setPixel32(_loc6_, _loc9_, param5);
                    _loc9_--;
                };
                if (++_loc8_ >= 2)
                {
                    _loc7_--;
                    _loc8_ = 0;
                };
                _loc6_++;
            };
        }

        private static function fillBottomRightCorner(param1:BitmapData, param2:int, param3:int, param4:uint):void
        {
            var _loc7_:int;
            var _loc5_:int = param2;
            var _loc6_:int = param3;
            while (_loc5_ < param1.width)
            {
                _loc7_ = _loc5_;
                while (_loc7_ < param1.width)
                {
                    param1.setPixel32(_loc7_, _loc6_, param4);
                    _loc7_++;
                };
                _loc6_--;
                _loc5_ = (_loc5_ + 2);
            };
        }


    }
}