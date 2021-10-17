package com.sulake.core.window.graphics
{
    import com.sulake.core.runtime.IDisposable;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.geom.Matrix;
    import flash.geom.ColorTransform;
    import com.sulake.core.window.graphics.renderer.ISkinRenderer;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.IWindow;
    import flash.geom.Point;
    import com.sulake.core.window.enum.WindowStyle;

    public class WindowRendererItem implements IDisposable 
    {

        private static const var_2001:uint = 0;
        private static const var_2002:uint = 1;
        private static const var_2000:uint = 2;

        private var var_2756:BitmapData;
        private var var_1112:WindowRenderer;
        private var _skinContainer:ISkinContainer;
        private var _drawBufferAllocator:DrawBufferAllocator;
        private var _disposed:Boolean;
        private var var_2758:Boolean;
        private var var_2757:Rectangle;
        private var var_2725:Matrix;
        private var var_2726:ColorTransform;
        private var var_2759:uint;
        private var var_2760:uint;

        public function WindowRendererItem(param1:WindowRenderer, param2:DrawBufferAllocator, param3:ISkinContainer)
        {
            this._disposed = false;
            this.var_1112 = param1;
            this._skinContainer = param3;
            this._drawBufferAllocator = param2;
            this.var_2759 = 0xFFFFFFFF;
            this.var_2760 = 0;
            this.var_2726 = new ColorTransform();
            this.var_2725 = new Matrix();
            this.var_2757 = new Rectangle();
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get buffer():BitmapData
        {
            return (this.var_2756);
        }

        public function get dirty():Rectangle
        {
            return (this.var_2757);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this._disposed = true;
                this.var_1112 = null;
                this._skinContainer = null;
                if (this.var_2756 != null)
                {
                    this._drawBufferAllocator.free(this.var_2756);
                    this.var_2756 = null;
                };
            };
        }

        public function render(param1:IWindow, param2:Point, param3:Rectangle):Boolean
        {
            var _loc4_:BitmapData;
            var _loc12_:Boolean;
            var _loc5_:uint = ((param1.background) ? var_2000 : var_2001);
            var _loc6_:Boolean = ((this.var_2757.width > 0) && (this.var_2757.height > 0));
            var _loc7_:ISkinRenderer = this.resolveSkinRenderer(param1);
            if (_loc7_ != null)
            {
                if (_loc7_.isStateDrawable(this.var_2760))
                {
                    _loc5_ = var_2002;
                };
            };
            var _loc8_:int = Math.max(param1.width, 1);
            var _loc9_:int = Math.max(param1.height, 1);
            var _loc10_:Boolean = true;
            if (_loc5_ != var_2001)
            {
                if (this.var_2756 == null)
                {
                    this.var_2756 = this._drawBufferAllocator.allocate(_loc8_, _loc9_, true, param1.color);
                    this.var_2758 = true;
                    _loc6_ = true;
                    _loc10_ = false;
                }
                else
                {
                    if (((!(this.var_2756.width == _loc8_)) || (!(this.var_2756.height == _loc9_))))
                    {
                        this._drawBufferAllocator.free(this.var_2756);
                        this.var_2756 = this._drawBufferAllocator.allocate(_loc8_, _loc9_, true, param1.color);
                        this.var_2758 = true;
                        _loc6_ = true;
                        _loc10_ = false;
                    };
                };
            };
            var _loc11_:IGraphicContext = IGraphicContextHost(param1).getGraphicContext(false);
            if (_loc11_)
            {
                if (!_loc11_.visible)
                {
                    _loc11_.visible = true;
                };
                _loc12_ = param1.testParamFlag(WindowParam.WINDOW_PARAM_FORCE_CLIPPING);
                _loc11_.setDrawRegion(param1.rectangle, (!(param1.testParamFlag(WindowParam.var_713))), ((_loc12_) ? param3 : null));
                if (_loc12_)
                {
                    param3 = new Rectangle(0, 0, _loc8_, _loc9_);
                };
            };
            if (_loc5_ != var_2001)
            {
                this.var_2759 = this.var_2760;
                _loc4_ = (param1.fetchDrawBuffer() as BitmapData);
                if (_loc4_ != null)
                {
                    _loc4_.lock();
                    if (_loc5_ == var_2002)
                    {
                        _loc6_ = true;
                        if (!param1.testParamFlag(WindowParam.var_713))
                        {
                            _loc4_.fillRect(param3, 0);
                        };
                        if (this.var_2758)
                        {
                            this.var_2758 = false;
                            if (_loc10_)
                            {
                                this.var_2756.fillRect(this.var_2756.rect, param1.color);
                            };
                            _loc7_.draw(param1, this.var_2756, this.var_2756.rect, this.var_2760, false);
                        };
                        if (((param1.blend < 1) && (param1.testParamFlag(WindowParam.var_713))))
                        {
                            this.var_2725.tx = param2.x;
                            this.var_2725.ty = param2.y;
                            this.var_2726.alphaMultiplier = param1.blend;
                            param3.offset(param2.x, param2.y);
                            _loc4_.draw(this.var_2756, this.var_2725, this.var_2726, null, param3, false);
                            param3.offset(-(param2.x), -(param2.y));
                        }
                        else
                        {
                            _loc4_.copyPixels(this.var_2756, param3, param2, null, null, true);
                        };
                    }
                    else
                    {
                        if (_loc5_ == var_2000)
                        {
                            _loc6_ = true;
                            if (param1.testParamFlag(WindowParam.var_713))
                            {
                                this.var_2756.fillRect(this.var_2756.rect, param1.color);
                                _loc4_.copyPixels(this.var_2756, param3, param2, null, null, true);
                            }
                            else
                            {
                                _loc4_.fillRect(new Rectangle(param2.x, param2.y, param3.width, param3.height), param1.color);
                                _loc11_.blend = param1.blend;
                            };
                        };
                    };
                    _loc4_.unlock();
                };
                this.var_2757.left = int.MAX_VALUE;
                this.var_2757.top = int.MAX_VALUE;
                this.var_2757.right = int.MIN_VALUE;
                this.var_2757.bottom = int.MIN_VALUE;
            };
            return (true);
        }

        private function resolveSkinRenderer(param1:IWindow):ISkinRenderer
        {
            var _loc2_:ISkinRenderer = this._skinContainer.getSkinRendererByTypeAndStyle(param1.type, param1.style);
            if (_loc2_ == null)
            {
                if (param1.style != WindowStyle.var_1192)
                {
                    _loc2_ = this._skinContainer.getSkinRendererByTypeAndStyle(param1.type, WindowStyle.var_1192);
                };
            };
            return (_loc2_);
        }

        public function testForStateChange(param1:IWindow):Boolean
        {
            return (!(this._skinContainer.getTheActualState(param1.type, param1.style, param1.state) == this.var_2759));
        }

        public function invalidate(param1:IWindow, param2:Rectangle, param3:uint):Boolean
        {
            var _loc5_:IGraphicContext;
            var _loc4_:Boolean;
            switch (param3)
            {
                case WindowRedrawFlag.var_1194:
                    this.var_2758 = true;
                    _loc4_ = true;
                    break;
                case WindowRedrawFlag.RESIZE:
                    this.var_2758 = true;
                    _loc4_ = true;
                    break;
                case WindowRedrawFlag.var_1216:
                    if (param1.testParamFlag(WindowParam.var_713))
                    {
                        _loc4_ = true;
                    }
                    else
                    {
                        _loc5_ = IGraphicContextHost(param1).getGraphicContext(true);
                        _loc5_.setDrawRegion(param1.rectangle, false, null);
                        if (!_loc5_.visible)
                        {
                            _loc4_ = true;
                        };
                    };
                    break;
                case WindowRedrawFlag.var_1205:
                    this.var_2760 = this._skinContainer.getTheActualState(param1.type, param1.style, param1.state);
                    if (this.var_2760 != this.var_2759)
                    {
                        this.var_2758 = true;
                        _loc4_ = true;
                    };
                    break;
                case WindowRedrawFlag.var_1204:
                    if (param1.testParamFlag(WindowParam.var_713))
                    {
                        this.var_2758 = true;
                        _loc4_ = true;
                    }
                    else
                    {
                        IGraphicContextHost(param1).getGraphicContext(true).blend = param1.blend;
                    };
                    break;
                case WindowRedrawFlag.var_1193:
                    _loc4_ = true;
                    break;
            };
            if (_loc4_)
            {
                this.var_2757.left = Math.min(this.var_2757.left, param2.left);
                this.var_2757.top = Math.min(this.var_2757.top, param2.top);
                this.var_2757.right = Math.max(this.var_2757.right, param2.right);
                this.var_2757.bottom = Math.max(this.var_2757.bottom, param2.bottom);
            };
            return (_loc4_);
        }

        private function drawRect(param1:BitmapData, param2:Rectangle, param3:uint):void
        {
            var _loc4_:int;
            _loc4_ = param2.left;
            while (_loc4_ < param2.right)
            {
                param1.setPixel32(_loc4_, param2.top, param3);
                param1.setPixel32(_loc4_, (param2.bottom - 1), param3);
                _loc4_++;
            };
            _loc4_ = param2.top;
            while (_loc4_ < param2.bottom)
            {
                param1.setPixel32(param2.left, _loc4_, param3);
                param1.setPixel32((param2.right - 1), _loc4_, param3);
                _loc4_++;
            };
        }


    }
}