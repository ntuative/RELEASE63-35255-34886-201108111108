package com.sulake.room.renderer
{
    import flash.geom.Point;
    import com.sulake.room.utils.RoomGeometry;
    import flash.display.Sprite;
    import com.sulake.core.utils.Map;
    import com.sulake.room.renderer.cache.BitmapDataCache;
    import com.sulake.room.renderer.cache.RoomObjectCache;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.events.MouseEvent;
    import com.sulake.room.utils.Vector3d;
    import flash.display.DisplayObject;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.renderer.utils.ExtendedSprite;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.renderer.utils.SortableSprite;
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
    import com.sulake.room.renderer.cache.RoomObjectCacheItem;
    import com.sulake.room.renderer.cache.RoomObjectLocationCacheItem;
    import com.sulake.room.renderer.cache.RoomObjectSortableSpriteCacheItem;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import flash.geom.Rectangle;
    import flash.display.PixelSnapping;
    import com.sulake.room.renderer.utils.ExtendedBitmapData;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.renderer.utils.ObjectMouseData;
    import com.sulake.room.object.logic.IRoomObjectMouseHandler;
    import com.sulake.room.utils.*;

    public class RoomSpriteCanvas implements IRoomRenderingCanvas 
    {

        private static const var_2217:Point = new Point(0, 0);
        private static const var_2214:int = 50;
        private static const var_2215:int = 50;
        private static const var_2213:Number = 60;
        private static const var_2216:Number = 50;
        private static const MAXIMUM_VALID_FRAME_UPDATE_INTERVAL:int = 1000;

        private var _container:IRoomSpriteCanvasContainer;
        private var _geometry:RoomGeometry;
        private var var_5547:int = 0;
        private var var_5545:Sprite;
        private var var_5548:Sprite;
        private var var_5546:Sprite;
        private var var_5549:Map = new Map();
        private var var_5550:Point = new Point();
        private var var_5551:BitmapDataCache;
        private var var_5552:RoomObjectCache;
        private var var_5553:Array = [];
        private var var_5554:Array = [];
        private var var_5555:IRoomRenderingCanvasMouseListener = null;
        private var _id:String = "";
        private var var_5556:Map = null;
        private var var_5502:int = 0;
        private var var_5557:int;
        private var var_5558:int;
        private var var_5559:int;
        private var var_5560:int;
        private var var_5561:int;
        private var var_5562:int;
        private var var_5563:int = -1;
        private var var_5564:Number = -10000000;
        private var var_5565:Number = -10000000;
        private var var_5566:int = 0;
        private var var_5567:Boolean = false;
        private var var_4801:Boolean = false;
        private var var_2726:ColorTransform;
        private var var_5568:Matrix;
        private var var_5127:Number = 0;
        private var var_5126:int = 0;
        private var var_5569:Boolean = false;
        private var var_5570:Boolean = false;
        private var var_5571:int = 0;
        private var var_5572:Boolean = false;
        private var var_5573:Array = [];
        private var var_5574:int = 0;
        private var var_5575:Number = 0;
        private var var_5576:int = 0;
        private var var_5577:int = 0;

        public function RoomSpriteCanvas(param1:IRoomSpriteCanvasContainer, param2:String, param3:int, param4:int, param5:int)
        {
            this._container = param1;
            this._id = param2;
            this.var_5545 = new Sprite();
            this.var_5545.mouseEnabled = false;
            this.var_5546 = new Sprite();
            this.var_5546.name = "canvas";
            this.var_5546.mouseEnabled = false;
            this.var_5545.addChild(this.var_5546);
            this.var_5546.mouseEnabled = true;
            this.var_5546.doubleClickEnabled = true;
            this.var_5546.addEventListener(MouseEvent.CLICK, this.clickHandler);
            this.var_5546.addEventListener(MouseEvent.DOUBLE_CLICK, this.clickHandler);
            this._geometry = new RoomGeometry(param5, new Vector3d(-135, 30, 0), new Vector3d(11, 11, 5), new Vector3d(-135, 0.5, 0));
            this.var_5551 = new BitmapDataCache(16, 32, 1);
            var _loc6_:String;
            if (this._container != null)
            {
                _loc6_ = this._container.roomObjectVariableAccurateZ;
            };
            this.var_5556 = new Map();
            this.var_5552 = new RoomObjectCache(_loc6_);
            this.var_2726 = new ColorTransform();
            this.var_5568 = new Matrix();
            this.initialize(param3, param4);
        }

        public function get width():int
        {
            return (this.var_5557);
        }

        public function get height():int
        {
            return (this.var_5558);
        }

        public function set screenOffsetX(param1:int):void
        {
            this.var_5550.x = (this.var_5550.x - (param1 - this.var_5559));
            this.var_5559 = param1;
        }

        public function set screenOffsetY(param1:int):void
        {
            this.var_5550.y = (this.var_5550.y - (param1 - this.var_5560));
            this.var_5560 = param1;
        }

        public function get screenOffsetX():int
        {
            return (this.var_5559);
        }

        public function get screenOffsetY():int
        {
            return (this.var_5560);
        }

        public function get displayObject():DisplayObject
        {
            return (this.var_5545);
        }

        public function get geometry():IRoomGeometry
        {
            return (this._geometry);
        }

        public function set mouseListener(param1:IRoomRenderingCanvasMouseListener):void
        {
            this.var_5555 = param1;
        }

        public function set useMask(param1:Boolean):void
        {
            if (((param1) && (!(this.var_4801))))
            {
                this.var_4801 = true;
                if (((!(this.var_5548 == null)) && (!(this.var_5545.contains(this.var_5548)))))
                {
                    this.var_5545.addChild(this.var_5548);
                    this.var_5546.mask = this.var_5548;
                };
            }
            else
            {
                if (((!(param1)) && (this.var_4801)))
                {
                    this.var_4801 = false;
                    if (((!(this.var_5548 == null)) && (this.var_5545.contains(this.var_5548))))
                    {
                        this.var_5545.removeChild(this.var_5548);
                        this.var_5546.mask = null;
                    };
                };
            };
        }

        public function dispose():void
        {
            this.cleanSprites(0, true);
            if (this._geometry != null)
            {
                this._geometry.dispose();
                this._geometry = null;
            };
            if (this.var_5548 != null)
            {
                this.var_5548 = null;
            };
            if (this.var_5551 != null)
            {
                this.var_5551.dispose();
                this.var_5551 = null;
            };
            if (this.var_5552 != null)
            {
                this.var_5552.dispose();
                this.var_5552 = null;
            };
            this._container = null;
            if (this.var_5545 != null)
            {
                while (this.var_5545.numChildren > 0)
                {
                    this.var_5545.removeChildAt(0);
                };
                this.var_5545 = null;
            };
            this.var_5546 = null;
            this.var_5548 = null;
            this.var_5553 = [];
            if (this.var_5549 != null)
            {
                this.var_5549.dispose();
                this.var_5549 = null;
            };
            var _loc1_:int;
            if (this.var_5554 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_5554.length)
                {
                    this.cleanSprite((this.var_5554[_loc1_] as ExtendedSprite), true);
                    _loc1_++;
                };
                this.var_5554 = [];
            };
            if (this.var_5556 != null)
            {
                this.var_5556.dispose();
                this.var_5556 = null;
            };
            this.var_5555 = null;
            this.var_2726 = null;
            this.var_5568 = null;
        }

        public function initialize(param1:int, param2:int):void
        {
            if (param1 < 1)
            {
                param1 = 1;
            };
            if (param2 < 1)
            {
                param2 = 1;
            };
            if (this.var_5548 != null)
            {
                this.var_5548.graphics.clear();
            }
            else
            {
                this.var_5548 = new Sprite();
                this.var_5548.name = "mask";
                if (this.var_4801)
                {
                    this.var_5545.addChild(this.var_5548);
                    this.var_5546.mask = this.var_5548;
                };
            };
            this.var_5548.graphics.beginFill(0);
            this.var_5548.graphics.drawRect(0, 0, param1, param2);
            this.var_5557 = param1;
            this.var_5558 = param2;
        }

        public function roomObjectRemoved(param1:String):void
        {
            this.var_5552.removeObjectCache(param1);
        }

        public function render(param1:int):void
        {
            this.var_5570 = (!(this.var_5570));
            var _loc2_:int;
            if (((this._container == null) || (this._geometry == null)))
            {
                return;
            };
            if (param1 == this.var_5563)
            {
                return;
            };
            this.calculateUpdateInterval(param1);
            this.var_5551.compress();
            var _loc3_:int = this._container.getRoomObjectCount();
            var _loc4_:int;
            var _loc5_:int;
            var _loc6_:String = "";
            var _loc7_:IRoomObject;
            var _loc8_:Boolean;
            if (((!(this.var_5557 == this.var_5561)) || (!(this.var_5558 == this.var_5562))))
            {
                _loc8_ = true;
            };
            if (((!(this.var_5546.x == this.var_5559)) || (!(this.var_5546.y == this.var_5560))))
            {
                this.var_5546.x = this.var_5559;
                this.var_5546.y = this.var_5560;
                _loc8_ = true;
            };
            _loc4_ = 0;
            while (_loc4_ < _loc3_)
            {
                _loc7_ = this._container.getRoomObjectWithIndex(_loc4_);
                if (_loc7_ != null)
                {
                    _loc6_ = this._container.getRoomObjectIdWithIndex(_loc4_);
                    _loc5_ = (_loc5_ + this.renderObject(_loc7_, _loc6_, param1, _loc8_, _loc5_));
                };
                _loc4_++;
            };
            this.var_5553.sortOn("z", (Array.DESCENDING | Array.NUMERIC));
            if (_loc5_ < this.var_5553.length)
            {
                this.var_5553.splice(_loc5_);
            };
            var _loc9_:SortableSprite;
            _loc4_ = 0;
            while (_loc4_ < _loc5_)
            {
                _loc9_ = (this.var_5553[_loc4_] as SortableSprite);
                if (_loc9_ != null)
                {
                    this.updateSprite(_loc4_, _loc9_);
                };
                _loc4_++;
            };
            this.cleanSprites(_loc5_);
            this.var_5563 = param1;
            this.var_5561 = this.var_5557;
            this.var_5562 = this.var_5558;
        }

        private function calculateUpdateInterval(param1:int):void
        {
            var _loc2_:int;
            var _loc3_:Number;
            if (this.var_5563 > 0)
            {
                _loc2_ = (param1 - this.var_5563);
                if (_loc2_ > (var_2213 * 3))
                {
                    Logger.log((("Really slow frame update " + _loc2_) + "ms"));
                    this.var_5577 = _loc2_;
                };
                if (_loc2_ <= MAXIMUM_VALID_FRAME_UPDATE_INTERVAL)
                {
                    this.var_5126++;
                    if (this.var_5126 == (var_2214 + 1))
                    {
                        this.var_5127 = _loc2_;
                        this.var_5575 = this.var_5576;
                    }
                    else
                    {
                        if (this.var_5126 > (var_2214 + 1))
                        {
                            _loc3_ = Number((this.var_5126 - var_2214));
                            this.var_5127 = (((this.var_5127 * (_loc3_ - 1)) / _loc3_) + (Number(_loc2_) / _loc3_));
                            this.var_5575 = (((this.var_5575 * (_loc3_ - 1)) / _loc3_) + (Number(this.var_5576) / _loc3_));
                            if (this.var_5126 > (var_2214 + var_2215))
                            {
                                this.var_5126 = var_2214;
                                if (((!(this.var_5569)) && (this.var_5127 > var_2213)))
                                {
                                    this.var_5569 = true;
                                    Logger.log("Room canvas updating really slow - now entering frame skipping mode...");
                                }
                                else
                                {
                                    if (((this.var_5569) && (this.var_5127 < var_2216)))
                                    {
                                        this.var_5569 = false;
                                        Logger.log("Room canvas updating fast again - now entering normal frame mode...");
                                    };
                                };
                                this.var_5577 = 0;
                            };
                        };
                    };
                };
            };
        }

        private function renderObject(param1:IRoomObject, param2:String, param3:int, param4:Boolean, param5:int):int
        {
            var _loc22_:BitmapData;
            var _loc6_:IRoomObjectSpriteVisualization = (param1.getVisualization() as IRoomObjectSpriteVisualization);
            if (_loc6_ == null)
            {
                this.var_5552.removeObjectCache(param2);
                return (0);
            };
            var _loc7_:RoomObjectCacheItem = this.var_5552.getObjectCache(param2);
            var _loc8_:RoomObjectLocationCacheItem = _loc7_.location;
            var _loc9_:RoomObjectSortableSpriteCacheItem = _loc7_.sprites;
            var _loc10_:IVector3d = _loc8_.getScreenLocation(param1, this._geometry);
            if (_loc10_ == null)
            {
                this.var_5552.removeObjectCache(param2);
                return (0);
            };
            _loc6_.update(this._geometry, param3, ((!(_loc9_.isEmpty)) || (param4)), ((this.var_5570) && (this.var_5569)));
            var _loc11_:Boolean = _loc8_.locationChanged;
            if (_loc11_)
            {
                param4 = true;
            };
            if (((!(_loc9_.needsUpdate(_loc6_.getInstanceId(), _loc6_.getUpdateID()))) && (!(param4))))
            {
                return (_loc9_.spriteCount);
            };
            var _loc12_:int = _loc6_.spriteCount;
            var _loc13_:int = _loc10_.x;
            var _loc14_:int = _loc10_.y;
            var _loc15_:Number = _loc10_.z;
            if (_loc13_ > 0)
            {
                _loc15_ = (_loc15_ + (_loc13_ * 1.2E-7));
            }
            else
            {
                _loc15_ = (_loc15_ + (-(_loc13_) * 1.2E-7));
            };
            _loc13_ = int((_loc13_ + int((this.var_5557 / 2))));
            _loc14_ = int((_loc14_ + int((this.var_5558 / 2))));
            var _loc16_:int;
            var _loc17_:SortableSprite;
            var _loc18_:IRoomObjectSprite;
            var _loc19_:int;
            var _loc20_:int;
            var _loc21_:int;
            while (_loc21_ < _loc12_)
            {
                _loc18_ = _loc6_.getSprite(_loc21_);
                if (((!(_loc18_ == null)) && (_loc18_.visible)))
                {
                    _loc22_ = _loc18_.asset;
                    if (_loc22_ != null)
                    {
                        _loc19_ = ((_loc13_ + _loc18_.offsetX) + this.var_5559);
                        _loc20_ = ((_loc14_ + _loc18_.offsetY) + this.var_5560);
                        if (this.rectangleVisible(_loc19_, _loc20_, _loc22_.width, _loc22_.height))
                        {
                            _loc17_ = _loc9_.getSprite(_loc16_);
                            if (_loc17_ == null)
                            {
                                _loc17_ = new SortableSprite();
                                _loc9_.addSprite(_loc17_);
                                this.var_5553.push(_loc17_);
                                _loc17_.name = param2;
                            };
                            _loc17_.sprite = _loc18_;
                            _loc17_.x = (_loc19_ - this.var_5559);
                            _loc17_.y = (_loc20_ - this.var_5560);
                            _loc17_.z = ((_loc15_ + _loc18_.relativeDepth) + (3.7E-11 * param5));
                            _loc16_++;
                            param5++;
                        };
                    };
                };
                _loc21_++;
            };
            _loc9_.setSpriteCount(_loc16_);
            return (_loc16_);
        }

        private function rectangleVisible(param1:int, param2:int, param3:int, param4:int):Boolean
        {
            if ((((param1 < this.var_5557) && ((param1 + param3) >= 0)) && ((param2 < this.var_5558) && ((param2 + param4) >= 0))))
            {
                if (!this.var_5572)
                {
                    return (true);
                };
                return (this.rectangleVisibleWithExclusion(param1, param2, param3, param4));
            };
            return (false);
        }

        private function rectangleVisibleWithExclusion(param1:int, param2:int, param3:int, param4:int):Boolean
        {
            var _loc5_:Rectangle;
            if (param1 < 0)
            {
                param3 = (param3 + param1);
                param1 = 0;
            };
            if (param2 < 0)
            {
                param4 = (param4 + param2);
                param2 = 0;
            };
            if ((param1 + param3) >= this.var_5557)
            {
                param3 = (param3 - ((this.var_5557 + 1) - (param1 + param3)));
            };
            if ((param2 + param4) >= this.var_5558)
            {
                param4 = (param4 - ((this.var_5558 + 1) - (param2 + param4)));
            };
            for each (_loc5_ in this.var_5573)
            {
                if (((((param1 >= _loc5_.left) && ((param1 + param3) < _loc5_.right)) && (param2 >= _loc5_.top)) && ((param2 + param4) < _loc5_.bottom)))
                {
                    return (false);
                };
            };
            return (true);
        }

        private function getSprite(param1:int):ExtendedSprite
        {
            if (((param1 < 0) || (param1 >= this.var_5571)))
            {
                return (null);
            };
            return (this.var_5546.getChildAt(param1) as ExtendedSprite);
        }

        private function createSprite(param1:SortableSprite, param2:int=-1):void
        {
            var _loc3_:ExtendedSprite;
            var _loc4_:IRoomObjectSprite = param1.sprite;
            if (this.var_5554.length > 0)
            {
                _loc3_ = (this.var_5554.pop() as ExtendedSprite);
            };
            if (_loc3_ == null)
            {
                _loc3_ = new ExtendedSprite();
            };
            _loc3_.x = param1.x;
            _loc3_.y = param1.y;
            _loc3_.identifier = param1.name;
            _loc3_.alpha = (_loc4_.alpha / 0xFF);
            _loc3_.tag = _loc4_.tag;
            _loc3_.blendMode = _loc4_.blendMode;
            _loc3_.filters = _loc4_.filters;
            _loc3_.varyingDepth = _loc4_.varyingDepth;
            _loc3_.clickHandling = _loc4_.clickHandling;
            _loc3_.smoothing = false;
            _loc3_.pixelSnapping = PixelSnapping.ALWAYS;
            _loc3_.bitmapData = this.getBitmapData(_loc4_.asset, _loc4_.assetName, _loc4_.flipH, _loc4_.flipV, _loc4_.color);
            if (_loc4_.capturesMouse)
            {
                _loc3_.alphaTolerance = 128;
            }
            else
            {
                _loc3_.alphaTolerance = 0x0100;
            };
            if (((param2 < 0) || (param2 >= this.var_5571)))
            {
                this.var_5546.addChild(_loc3_);
                this.var_5571++;
            }
            else
            {
                this.var_5546.addChildAt(_loc3_, param2);
            };
            this.var_5574++;
        }

        private function updateSprite(param1:int, param2:SortableSprite):Boolean
        {
            var _loc5_:Number;
            var _loc6_:BitmapData;
            if (param1 >= this.var_5571)
            {
                this.createSprite(param2);
                return (true);
            };
            var _loc3_:IRoomObjectSprite = param2.sprite;
            var _loc4_:ExtendedSprite = this.getSprite(param1);
            if (_loc4_ != null)
            {
                if (_loc4_.varyingDepth != _loc3_.varyingDepth)
                {
                    if (((_loc4_.varyingDepth) && (!(_loc3_.varyingDepth))))
                    {
                        this.var_5546.removeChildAt(param1);
                        this.var_5554.push(_loc4_);
                        return (this.updateSprite(param1, param2));
                    };
                    this.createSprite(param2, param1);
                    return (true);
                };
                if (_loc4_.needsUpdate(_loc3_.instanceId, _loc3_.updateId))
                {
                    if (_loc3_.capturesMouse)
                    {
                        _loc4_.alphaTolerance = 128;
                    }
                    else
                    {
                        _loc4_.alphaTolerance = 0x0100;
                    };
                    _loc5_ = (_loc3_.alpha / 0xFF);
                    if (_loc4_.alpha != _loc5_)
                    {
                        _loc4_.alpha = _loc5_;
                    };
                    _loc4_.identifier = param2.name;
                    _loc4_.tag = _loc3_.tag;
                    _loc4_.varyingDepth = _loc3_.varyingDepth;
                    _loc4_.blendMode = _loc3_.blendMode;
                    _loc4_.clickHandling = _loc3_.clickHandling;
                    _loc4_.filters = _loc3_.filters;
                    _loc6_ = this.getBitmapData(_loc3_.asset, _loc3_.assetName, _loc3_.flipH, _loc3_.flipV, _loc3_.color);
                    if (_loc4_.bitmapData != _loc6_)
                    {
                        _loc4_.bitmapData = _loc6_;
                    };
                };
                if (_loc4_.x != param2.x)
                {
                    _loc4_.x = param2.x;
                };
                if (_loc4_.y != param2.y)
                {
                    _loc4_.y = param2.y;
                };
            }
            else
            {
                return (false);
            };
            return (true);
        }

        private function cleanSprites(param1:int, param2:Boolean=false):void
        {
            var _loc4_:int;
            if (this.var_5546 == null)
            {
                return;
            };
            if (param1 < 0)
            {
                param1 = 0;
            };
            var _loc3_:ExtendedSprite;
            if (((param1 < this.var_5574) || (this.var_5574 == 0)))
            {
                _loc4_ = (this.var_5571 - 1);
                while (_loc4_ >= param1)
                {
                    _loc3_ = this.getSprite(_loc4_);
                    this.cleanSprite(_loc3_, param2);
                    _loc4_--;
                };
            };
            this.var_5574 = param1;
        }

        private function cleanSprite(param1:ExtendedSprite, param2:Boolean):void
        {
            if (param1 != null)
            {
                if (!param2)
                {
                    param1.bitmapData = null;
                }
                else
                {
                    param1.dispose();
                };
            };
        }

        private function getSortableSprite(param1:int):SortableSprite
        {
            if (((param1 < 0) || (param1 >= this.var_5553.length)))
            {
                return (null);
            };
            return (this.var_5553[param1] as SortableSprite);
        }

        private function getBitmapData(param1:BitmapData, param2:String, param3:Boolean, param4:Boolean, param5:int):BitmapData
        {
            param5 = (param5 & 0xFFFFFF);
            if ((((!(param3)) && (!(param4))) && (param5 == 0xFFFFFF)))
            {
                return (param1);
            };
            var _loc6_:ExtendedBitmapData;
            var _loc7_:String = "";
            if ((((param3) || (param4)) && (!(param5 == 0xFFFFFF))))
            {
                _loc7_ = ((((param2 + " ") + param5) + ((param3) ? " FH" : "")) + ((param4) ? " FV" : ""));
                if (param2.length > 0)
                {
                    _loc6_ = this.var_5551.getBitmapData(_loc7_);
                };
                if (_loc6_ == null)
                {
                    _loc6_ = this.getColoredBitmapData(param1, param2, param5);
                    if (_loc6_ != null)
                    {
                        _loc6_ = this.getFlippedBitmapData(_loc6_, param2, true, param3, param4);
                        if (param2.length > 0)
                        {
                            this.var_5551.addBitmapData(_loc7_, _loc6_);
                        };
                        return (_loc6_);
                    };
                    _loc6_ = this.getFlippedBitmapData(param1, param2, true, param3, param4);
                    if (_loc6_ != null)
                    {
                        _loc6_ = this.getColoredBitmapData(_loc6_, "", param5, true);
                        if (param2.length > 0)
                        {
                            this.var_5551.addBitmapData(_loc7_, _loc6_);
                        };
                        return (_loc6_);
                    };
                    _loc6_ = this.getColoredBitmapData(param1, param2, param5, true);
                    _loc6_ = this.getFlippedBitmapData(_loc6_, param2, true, param3, param4);
                    if (param2.length > 0)
                    {
                        this.var_5551.addBitmapData(_loc7_, _loc6_);
                    };
                };
            }
            else
            {
                if (((param3) || (param4)))
                {
                    _loc6_ = this.getFlippedBitmapData(param1, param2, true, param3, param4);
                }
                else
                {
                    if (param5 != 0xFFFFFF)
                    {
                        _loc6_ = this.getColoredBitmapData(param1, param2, param5, true);
                    }
                    else
                    {
                        return (param1);
                    };
                };
            };
            return (_loc6_);
        }

        private function getFlippedBitmapData(data:BitmapData, name:String, allowCreation:Boolean=false, flipH:Boolean=true, flipV:Boolean=false):ExtendedBitmapData
        {
            var cacheName:String = ((name + ((flipH) ? " FH" : "")) + ((flipV) ? " FV" : ""));
            var finalData:ExtendedBitmapData;
            if (name.length > 0)
            {
                finalData = this.var_5551.getBitmapData(cacheName);
                if (!allowCreation)
                {
                    return (finalData);
                };
            };
            if (finalData == null)
            {
                try
                {
                    finalData = new ExtendedBitmapData(data.width, data.height, true, 0xFFFFFF);
                }
                catch(e:Error)
                {
                    finalData = new ExtendedBitmapData(1, 1, true, 0xFFFFFF);
                };
                this.var_5568.identity();
                if (flipH)
                {
                    this.var_5568.scale(-1, 1);
                    this.var_5568.translate(data.width, 0);
                };
                if (flipV)
                {
                    this.var_5568.scale(1, -1);
                    this.var_5568.translate(0, data.height);
                };
                finalData.draw(data, this.var_5568);
                if (name.length > 0)
                {
                    this.var_5551.addBitmapData(cacheName, finalData);
                };
            };
            return (finalData);
        }

        private function getColoredBitmapData(data:BitmapData, name:String, color:int, allowCreation:Boolean=false):ExtendedBitmapData
        {
            var r:int;
            var g:int;
            var b:int;
            var tR:Number;
            var tG:Number;
            var tB:Number;
            var cacheName:String = ((name + " ") + color);
            var finalData:ExtendedBitmapData;
            if (name.length > 0)
            {
                finalData = this.var_5551.getBitmapData(cacheName);
                if (!allowCreation)
                {
                    return (finalData);
                };
            };
            if (finalData == null)
            {
                r = ((color >> 16) & 0xFF);
                g = ((color >> 8) & 0xFF);
                b = (color & 0xFF);
                tR = (r / 0xFF);
                tG = (g / 0xFF);
                tB = (b / 0xFF);
                try
                {
                    finalData = new ExtendedBitmapData(data.width, data.height, true, 0xFFFFFF);
                    finalData.copyPixels(data, data.rect, var_2217);
                }
                catch(e:Error)
                {
                    finalData = new ExtendedBitmapData(1, 1, true, 0xFFFFFF);
                };
                this.var_2726.redMultiplier = tR;
                this.var_2726.greenMultiplier = tG;
                this.var_2726.blueMultiplier = tB;
                finalData.colorTransform(finalData.rect, this.var_2726);
                if (name.length > 0)
                {
                    this.var_5551.addBitmapData(cacheName, finalData);
                };
            };
            return (finalData);
        }

        private function getObjectId(param1:ExtendedSprite):String
        {
            var _loc2_:String;
            if (param1 != null)
            {
                return (param1.identifier);
            };
            return ("");
        }

        public function handleMouseEvent(param1:int, param2:int, param3:String, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean):Boolean
        {
            param1 = (param1 - this.var_5559);
            param2 = (param2 - this.var_5560);
            this.var_5550.x = param1;
            this.var_5550.y = param2;
            if (((this.var_5566 > 0) && (param3 == MouseEvent.MOUSE_MOVE)))
            {
                return (this.var_5567);
            };
            this.var_5567 = this.checkMouseHits(param1, param2, param3, param4, param5, param6, param7);
            this.var_5566++;
            return (this.var_5567);
        }

        private function createMouseEvent(param1:int, param2:int, param3:int, param4:int, param5:String, param6:String, param7:Boolean, param8:Boolean, param9:Boolean, param10:Boolean):RoomSpriteMouseEvent
        {
            var _loc11_:Number = (param1 - (this.var_5557 / 2));
            var _loc12_:Number = (param2 - (this.var_5558 / 2));
            var _loc13_:RoomSpriteMouseEvent;
            return (new RoomSpriteMouseEvent(param5, ((this._id + "_") + this.var_5502), this._id, param6, _loc11_, _loc12_, param3, param4, param8, param7, param9, param10));
        }

        private function checkMouseClickHits(param1:Number, param2:Number, param3:Boolean, param4:Boolean=false, param5:Boolean=false, param6:Boolean=false, param7:Boolean=false):Boolean
        {
            var _loc15_:String;
            var _loc8_:Boolean;
            var _loc9_:String = "";
            var _loc10_:ExtendedSprite;
            var _loc11_:RoomSpriteMouseEvent;
            var _loc12_:String = MouseEvent.CLICK;
            if (param3)
            {
                _loc12_ = MouseEvent.DOUBLE_CLICK;
            };
            var _loc13_:Array = [];
            var _loc14_:int;
            _loc14_ = (this.var_5574 - 1);
            while (_loc14_ >= 0)
            {
                _loc10_ = this.getSprite(_loc14_);
                if (((!(_loc10_ == null)) && (_loc10_.clickHandling)))
                {
                    if (_loc10_.hitTest((param1 - _loc10_.x), (param2 - _loc10_.y)))
                    {
                        _loc9_ = this.getObjectId(_loc10_);
                        if (_loc13_.indexOf(_loc9_) < 0)
                        {
                            _loc15_ = _loc10_.tag;
                            _loc11_ = this.createMouseEvent(param1, param2, (param1 - _loc10_.y), (param2 - _loc10_.y), _loc12_, _loc15_, param4, param5, param6, param7);
                            this.bufferMouseEvent(_loc11_, _loc9_);
                            _loc13_.push(_loc9_);
                        };
                    };
                    _loc8_ = true;
                };
                _loc14_--;
            };
            this.processMouseEvents();
            return (_loc8_);
        }

        private function checkMouseHits(param1:int, param2:int, param3:String, param4:Boolean=false, param5:Boolean=false, param6:Boolean=false, param7:Boolean=false):Boolean
        {
            var _loc16_:String;
            var _loc17_:String;
            var _loc18_:int;
            var _loc8_:Boolean;
            var _loc9_:String = "";
            var _loc10_:ExtendedSprite;
            var _loc11_:RoomSpriteMouseEvent;
            var _loc12_:Array = [];
            var _loc13_:ObjectMouseData;
            var _loc14_:int;
            _loc14_ = (this.var_5574 - 1);
            while (_loc14_ >= 0)
            {
                _loc10_ = (this.getSprite(_loc14_) as ExtendedSprite);
                if (((!(_loc10_ == null)) && (_loc10_.hitTestPoint((param1 - _loc10_.x), (param2 - _loc10_.y)))))
                {
                    if (((!(_loc10_.clickHandling)) || ((!(param3 == MouseEvent.CLICK)) && (!(param3 == MouseEvent.DOUBLE_CLICK)))))
                    {
                        _loc9_ = this.getObjectId(_loc10_);
                        if (_loc12_.indexOf(_loc9_) < 0)
                        {
                            _loc16_ = _loc10_.tag;
                            _loc13_ = (this.var_5549.getValue(_loc9_) as ObjectMouseData);
                            if (_loc13_ != null)
                            {
                                if (_loc13_.spriteTag != _loc16_)
                                {
                                    _loc11_ = this.createMouseEvent(0, 0, 0, 0, MouseEvent.ROLL_OUT, _loc13_.spriteTag, param4, param5, param6, param7);
                                    this.bufferMouseEvent(_loc11_, _loc9_);
                                };
                            };
                            if (((param3 == MouseEvent.MOUSE_MOVE) && ((_loc13_ == null) || (!(_loc13_.spriteTag == _loc16_)))))
                            {
                                _loc11_ = this.createMouseEvent(param1, param2, (param1 - _loc10_.x), (param2 - _loc10_.y), MouseEvent.ROLL_OVER, _loc16_, param4, param5, param6, param7);
                            }
                            else
                            {
                                _loc11_ = this.createMouseEvent(param1, param2, (param1 - _loc10_.y), (param2 - _loc10_.y), param3, _loc16_, param4, param5, param6, param7);
                            };
                            if (_loc13_ == null)
                            {
                                _loc13_ = new ObjectMouseData();
                                _loc13_.objectId = _loc9_;
                                this.var_5549.add(_loc9_, _loc13_);
                            };
                            _loc13_.spriteTag = _loc16_;
                            if ((((!(param3 == MouseEvent.MOUSE_MOVE)) || (!(param1 == this.var_5564))) || (!(param2 == this.var_5565))))
                            {
                                this.bufferMouseEvent(_loc11_, _loc9_);
                            };
                            _loc12_.push(_loc9_);
                        };
                        _loc8_ = true;
                    };
                };
                _loc14_--;
            };
            var _loc15_:Array = this.var_5549.getKeys();
            _loc14_ = 0;
            while (_loc14_ < _loc15_.length)
            {
                _loc17_ = (_loc15_[_loc14_] as String);
                _loc18_ = _loc12_.indexOf(_loc17_);
                if (_loc18_ >= 0)
                {
                    _loc15_[_loc14_] = null;
                };
                _loc14_++;
            };
            _loc14_ = 0;
            while (_loc14_ < _loc15_.length)
            {
                _loc9_ = (_loc15_[_loc14_] as String);
                if (_loc9_ != null)
                {
                    _loc13_ = (this.var_5549.remove(_loc9_) as ObjectMouseData);
                    if (_loc13_ != null)
                    {
                        _loc11_ = this.createMouseEvent(0, 0, 0, 0, MouseEvent.ROLL_OUT, _loc13_.spriteTag, param4, param5, param6, param7);
                        this.bufferMouseEvent(_loc11_, _loc9_);
                    };
                };
                _loc14_++;
            };
            this.processMouseEvents();
            this.var_5564 = param1;
            this.var_5565 = param2;
            return (_loc8_);
        }

        private function bufferMouseEvent(param1:RoomSpriteMouseEvent, param2:String):void
        {
            if (((!(this.var_5556 == null)) && (!(param1 == null))))
            {
                this.var_5556.add(param2, param1);
            };
        }

        private function processMouseEvents():void
        {
            var _loc2_:String;
            var _loc3_:RoomSpriteMouseEvent;
            var _loc4_:IRoomObject;
            var _loc5_:IRoomObjectMouseHandler;
            if (((this._container == null) || (this.var_5556 == null)))
            {
                return;
            };
            var _loc1_:int;
            while (_loc1_ < this.var_5556.length)
            {
                _loc2_ = this.var_5556.getKey(_loc1_);
                _loc3_ = this.var_5556.getWithIndex(_loc1_);
                if (((!(_loc2_ == null)) && (!(_loc3_ == null))))
                {
                    _loc4_ = this._container.getRoomObject(_loc2_);
                    if (_loc4_ != null)
                    {
                        if (this.var_5555 != null)
                        {
                            this.var_5555.processRoomCanvasMouseEvent(_loc3_, _loc4_, this.geometry);
                        }
                        else
                        {
                            _loc5_ = _loc4_.getMouseHandler();
                            if (_loc5_ != null)
                            {
                                _loc5_.mouseEvent(_loc3_, this._geometry);
                            };
                        };
                    };
                };
                _loc1_++;
            };
            this.var_5556.reset();
        }

        public function update():void
        {
            if (this.var_5566 == 0)
            {
                this.checkMouseHits(this.var_5550.x, this.var_5550.y, MouseEvent.MOUSE_MOVE);
            };
            this.var_5566 = 0;
            this.var_5502++;
        }

        private function clickHandler(param1:MouseEvent):void
        {
            var _loc2_:Boolean;
            if (((param1.type == MouseEvent.CLICK) || (param1.type == MouseEvent.DOUBLE_CLICK)))
            {
                _loc2_ = (param1.type == MouseEvent.DOUBLE_CLICK);
                this.checkMouseClickHits(param1.localX, param1.localY, _loc2_, param1.altKey, param1.ctrlKey, param1.shiftKey, param1.buttonDown);
            };
        }


    }
}