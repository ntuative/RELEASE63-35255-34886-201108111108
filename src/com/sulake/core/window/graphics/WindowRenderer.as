package com.sulake.core.window.graphics
{
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.Dictionary;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContext;
    import com.sulake.core.window.events.WindowDisposeEvent;
    import flash.display.BitmapData;

    public class WindowRenderer implements IWindowRenderer 
    {

        private var _debug:Boolean = false;
        private var _disposed:Boolean;
        private var var_2751:Array;
        private var var_2752:Point;
        private var var_2753:Rectangle;
        private var var_2754:Rectangle;
        private var _skinContainer:ISkinContainer;
        private var var_2755:Dictionary;
        private var _drawBufferAllocator:DrawBufferAllocator;

        public function WindowRenderer(param1:ISkinContainer)
        {
            this._disposed = false;
            this.var_2751 = new Array();
            this.var_2752 = new Point();
            this.var_2753 = new Rectangle();
            this.var_2754 = new Rectangle();
            this.var_2755 = new Dictionary(true);
            this._skinContainer = param1;
            this._drawBufferAllocator = new DrawBufferAllocator();
        }

        private static function getDrawLocationAndClipRegion(param1:WindowController, param2:Rectangle, param3:Point, param4:Rectangle):Boolean
        {
            var _loc7_:int;
            var _loc5_:Rectangle = param1.rectangle.clone();
            var _loc6_:Boolean = true;
            param4.x = 0;
            param4.y = 0;
            param4.width = _loc5_.width;
            param4.height = _loc5_.height;
            if (!param1.testParamFlag(WindowParam.var_713))
            {
                param3.x = 0;
                param3.y = 0;
                if (((param1.parent) && (param1.testParamFlag(WindowParam.WINDOW_PARAM_FORCE_CLIPPING))))
                {
                    return (WindowController(param1.parent).childRectToClippedDrawRegion(_loc5_, param4));
                };
            }
            else
            {
                if (param1.parent)
                {
                    _loc6_ = WindowController(param1.parent).childRectToClippedDrawRegion(_loc5_, param4);
                    param3.x = _loc5_.x;
                    param3.y = _loc5_.y;
                }
                else
                {
                    param3.x = 0;
                    param3.y = 0;
                };
            };
            if (param2.x > param4.x)
            {
                _loc7_ = (param2.x - param4.x);
                param3.x = (param3.x + _loc7_);
                param4.x = (param4.x + _loc7_);
                param4.width = (param4.width - _loc7_);
            };
            if (param2.y > param4.y)
            {
                _loc7_ = (param2.y - param4.y);
                param3.y = (param3.y + _loc7_);
                param4.y = (param4.y + _loc7_);
                param4.height = (param4.height - _loc7_);
            };
            if (param2.right < param4.right)
            {
                _loc7_ = (param4.right - param2.right);
                param4.width = (param4.width - _loc7_);
            };
            if (param2.bottom < param4.bottom)
            {
                _loc7_ = (param4.bottom - param2.bottom);
                param4.height = (param4.height - _loc7_);
            };
            return (((_loc6_) && (param4.width > 0)) && (param4.height > 0));
        }


        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get allocatedByteCount():uint
        {
            return (this._drawBufferAllocator.allocatedByteCount);
        }

        public function set debug(param1:Boolean):void
        {
            this._debug = param1;
        }

        public function get debug():Boolean
        {
            return (this._debug);
        }

        public function dispose():void
        {
            var _loc1_:Object;
            if (!this._disposed)
            {
                this._disposed = true;
                this.var_2751 = null;
                for (_loc1_ in this.var_2755)
                {
                    delete this.var_2755[_loc1_];
                };
                this.var_2755 = null;
                this._drawBufferAllocator.dispose();
                this._drawBufferAllocator = null;
            };
        }

        public function update(param1:uint):void
        {
            this.render();
            this.flushRenderQueue();
        }

        public function addToRenderQueue(param1:IWindow, param2:Rectangle, param3:uint):void
        {
            var _loc4_:WindowController;
            var _loc5_:IDesktopWindow;
            if (this.getWindowRendererItem(param1).invalidate(param1, param2, param3))
            {
                _loc5_ = param1.context.getDesktopWindow();
                this.var_2754.x = (param2.x - param1.x);
                this.var_2754.y = (param2.y - param1.y);
                this.var_2754.width = param2.width;
                this.var_2754.height = param2.height;
                if (param1.testParamFlag(WindowParam.var_713))
                {
                    while (true)
                    {
                        if (!param1.testParamFlag(WindowParam.var_713)) break;
                        _loc4_ = (param1.parent as WindowController);
                        if (_loc4_ == null)
                        {
                            return;
                        };
                        if (_loc4_ == _loc5_) break;
                        if (_loc4_.visible == false)
                        {
                            return;
                        };
                        this.var_2754.offset(param1.x, param1.y);
                        param1 = _loc4_;
                    };
                };
                this.getWindowRendererItem(param1).invalidate(param1, this.var_2754, WindowRedrawFlag.var_1193);
                if (this.var_2751.indexOf(param1) == -1)
                {
                    this.var_2751.push(param1);
                };
            };
        }

        public function flushRenderQueue():void
        {
            do 
            {
            } while (this.var_2751.pop() != null);
        }

        public function invalidate(param1:IWindowContext, param2:Rectangle):void
        {
            var _loc5_:WindowController;
            var _loc3_:IDesktopWindow = param1.getDesktopWindow();
            var _loc4_:uint = _loc3_.numChildren;
            while (_loc4_-- > 0)
            {
                _loc5_ = (_loc3_.getChildAt(_loc4_) as WindowController);
                this.addToRenderQueue(_loc5_, _loc5_.rectangle, WindowRedrawFlag.var_1194);
            };
        }

        protected function getWindowRendererItem(param1:IWindow):WindowRendererItem
        {
            var _loc2_:WindowRendererItem = (this.var_2755[param1] as WindowRendererItem);
            if (_loc2_ == null)
            {
                this.registerRenderable(param1);
                _loc2_ = this.var_2755[param1];
            };
            return (_loc2_);
        }

        public function registerRenderable(param1:IWindow):void
        {
            var _loc2_:WindowRendererItem = (this.var_2755[param1] as WindowRendererItem);
            if (_loc2_ == null)
            {
                _loc2_ = new WindowRendererItem(this, this._drawBufferAllocator, this._skinContainer);
                this.var_2755[param1] = _loc2_;
                param1.addEventListener(WindowDisposeEvent.var_1195, this.windowDisposedCallback);
            };
        }

        public function removeRenderable(param1:IWindow):void
        {
            param1.removeEventListener(WindowDisposeEvent.var_1195, this.windowDisposedCallback);
            var _loc2_:WindowRendererItem = (this.var_2755[param1] as WindowRendererItem);
            if (_loc2_ != null)
            {
                _loc2_.dispose();
                delete this.var_2755[param1];
            };
        }

        private function windowDisposedCallback(param1:WindowDisposeEvent):void
        {
            this.removeRenderable(param1.window);
        }

        public function getDrawBufferForRenderable(param1:IWindow):BitmapData
        {
            var _loc2_:WindowRendererItem = (this.var_2755[param1] as WindowRendererItem);
            return ((_loc2_ != null) ? _loc2_.buffer : null);
        }

        public function render():void
        {
            var _loc1_:WindowController;
            var _loc3_:WindowRendererItem;
            var _loc4_:uint;
            var _loc2_:uint = this.var_2751.length;
            _loc4_ = 0;
            while (_loc4_ < _loc2_)
            {
                _loc1_ = (this.var_2751.pop() as WindowController);
                if (!_loc1_.disposed)
                {
                    _loc3_ = this.getWindowRendererItem(_loc1_);
                    this.var_2754.x = _loc3_.dirty.x;
                    this.var_2754.y = _loc3_.dirty.y;
                    this.var_2754.width = _loc3_.dirty.width;
                    this.var_2754.height = _loc3_.dirty.height;
                    this.renderWindowBranch(_loc1_, this.var_2754, _loc1_.rectangle.clone());
                };
                _loc4_++;
            };
        }

        private function renderWindowBranch(param1:WindowController, param2:Rectangle, param3:Rectangle):void
        {
            var _loc4_:uint;
            var _loc5_:WindowController;
            var _loc6_:Rectangle;
            var _loc7_:Rectangle;
            var _loc8_:uint;
            if (param1.visible)
            {
                if (getDrawLocationAndClipRegion(param1, param2, this.var_2752, this.var_2753))
                {
                    if (this.getWindowRendererItem(param1).render(param1, this.var_2752, this.var_2753))
                    {
                        _loc4_ = param1.numChildren;
                        if (param1.clipping)
                        {
                            _loc6_ = new Rectangle(Math.max(param2.x, 0), Math.max(param2.y, 0), Math.min(param2.width, param1.width), Math.min(param2.height, param1.height));
                            param3 = param3.intersection(param1.rectangle);
                        }
                        else
                        {
                            _loc6_ = param2;
                        };
                        param3.offset(-(param1.x), -(param1.y));
                        _loc8_ = 0;
                        while (_loc8_ < _loc4_)
                        {
                            _loc5_ = (param1.getChildAt(_loc8_) as WindowController);
                            _loc7_ = _loc5_.rectangle;
                            if (_loc7_.intersects(_loc6_))
                            {
                                if (_loc5_.testParamFlag(WindowParam.var_713))
                                {
                                    _loc6_.offset(-(_loc7_.x), -(_loc7_.y));
                                    this.renderWindowBranch(_loc5_, _loc6_, param3);
                                    _loc6_.offset(_loc7_.x, _loc7_.y);
                                }
                                else
                                {
                                    if (_loc5_.testParamFlag(WindowParam.WINDOW_PARAM_FORCE_CLIPPING))
                                    {
                                        this.renderWindowBranch(_loc5_, _loc6_, param3);
                                    };
                                };
                            }
                            else
                            {
                                if (!_loc7_.intersects(param3))
                                {
                                    if (_loc5_.hasGraphicsContext())
                                    {
                                        _loc5_.getGraphicContext(true).visible = false;
                                    };
                                };
                            };
                            _loc8_++;
                        };
                    };
                }
                else
                {
                    if (!param1.testParamFlag(WindowParam.var_713))
                    {
                        if (param1.testParamFlag(WindowParam.WINDOW_PARAM_FORCE_CLIPPING))
                        {
                            param1.getGraphicContext(true).setDrawRegion(param1.rectangle, false, this.var_2753);
                            param1.getGraphicContext(true).visible = false;
                        };
                    };
                };
            };
        }


    }
}