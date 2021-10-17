package com.sulake.core.window
{
    import com.sulake.core.window.graphics.IGraphicContextHost;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowEventDispatcher;
    import com.sulake.core.window.graphics.IGraphicContext;
    import com.sulake.core.window.utils.WindowRectLimits;
    import flash.geom.Rectangle;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.utils.DefaultAttStruct;
    import com.sulake.core.window.graphics.WindowRedrawFlag;
    import com.sulake.core.window.utils.IRectLimiter;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.graphics.GraphicContext;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;
    import com.sulake.core.window.events.WindowDisposeEvent;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.utils.Map;
    import flash.display.IBitmapDrawable;
    import com.sulake.core.window.services.IMouseListenerService;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.enum.MouseListenerType;
    import flash.display.BitmapData;

    public class WindowController extends WindowModel implements IWindow, IGraphicContextHost 
    {

        private static var var_1196:uint = 0;
        protected static const TAG_EXCLUDE:String = "_EXCLUDE";
        protected static const TAG_INTERNAL:String = "_INTERNAL";
        protected static const var_2065:String = "_COLORIZE";
        protected static const var_1207:String = "_IGNORE_INHERITED_STYLE";
        private static const var_1217:Point = new Point();

        protected var _events:WindowEventDispatcher;
        protected var var_1252:IGraphicContext;
        protected var var_2667:Function;
        protected var var_2666:Boolean = true;
        protected var _parent:WindowController;
        protected var _children:Array;
        protected var _debug:Boolean = false;
        protected var var_2816:WindowRectLimits;
        private var var_2818:Boolean = false;
        private var var_2817:Rectangle;
        private var var_2819:uint;

        public function WindowController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function=null, param9:Array=null, param10:Array=null, param11:uint=0)
        {
            var _loc14_:uint;
            this.var_2819 = var_1196++;
            var _loc12_:XML = param5.getWindowFactory().getLayoutByTypeAndStyle(param2, param3);
            if (param6 == null)
            {
                param6 = new Rectangle(0, 0, ((_loc12_) ? int(_loc12_.attribute("width")) : 10), ((_loc12_) ? int(_loc12_.attribute("height")) : 10));
            };
            super(param11, param1, param2, param3, param4, param5, param6, param10);
            if (!this.var_1252)
            {
                this.var_1252 = this.getGraphicContext((!(testParamFlag(WindowParam.var_713))));
            };
            this._children = new Array();
            this.var_2817 = new Rectangle();
            if (_loc12_ != null)
            {
                var_1197 = new Rectangle(0, 0, int(_loc12_.attribute("width")), int(_loc12_.attribute("height")));
                var_1199 = var_1197.clone();
                var_1202 = var_1197.clone();
                param5.getWindowParser().parseAndConstruct(_loc12_, this, null);
                _loc14_ = var_1198;
                var_1198 = (var_1198 & (~(WindowParam.var_730)));
                this.setRectangle(param6.x, param6.y, param6.width, param6.height);
                var_1198 = _loc14_;
                var_1199.x = param6.x;
                var_1199.y = param6.y;
                var_1199.width = param6.width;
                var_1199.height = param6.height;
            };
            var _loc13_:DefaultAttStruct = param5.getWindowFactory().getDefaultsByTypeAndStyle(param2, param3);
            if (_loc13_)
            {
                var_1213 = _loc13_.blend;
                var_1210 = _loc13_.var_1190;
                if (var_1200 != _loc13_.background)
                {
                    this.background = _loc13_.background;
                };
                if (var_1201 != _loc13_.color)
                {
                    this.color = _loc13_.color;
                };
                if (_loc13_.hasRectLimits())
                {
                    WindowRectLimits(this.limits).assign(_loc13_.width_min, _loc13_.width_max, _loc13_.height_min, _loc13_.height_max);
                };
            };
            if (param9)
            {
                this.properties = param9;
            };
            this.var_2667 = param8;
            if (param7 != null)
            {
                this._parent = (param7 as WindowController);
                WindowController(param7).addChild(this);
                if (this.var_1252)
                {
                    _context.invalidate(this, var_1202, WindowRedrawFlag.var_1194);
                };
            };
        }

        private static function calculateMouseRegion(param1:WindowController, param2:Rectangle):void
        {
            var _loc3_:Rectangle = new Rectangle();
            param1.getGlobalRectangle(_loc3_);
            var _loc4_:int = param1.numChildren;
            var _loc5_:int = _loc3_.x;
            var _loc6_:int = _loc3_.y;
            param2.left = ((_loc5_ < param2.left) ? _loc5_ : param2.left);
            param2.top = ((_loc6_ < param2.top) ? _loc6_ : param2.top);
            param2.right = ((_loc3_.right > param2.right) ? _loc3_.right : param2.right);
            param2.bottom = ((_loc3_.bottom > param2.bottom) ? _loc3_.bottom : param2.bottom);
            var _loc7_:int;
            while (_loc7_ < _loc4_)
            {
                WindowController.calculateMouseRegion((param1.getChildAt(_loc7_) as WindowController), param2);
                _loc7_++;
            };
        }

        public static function expandToAccommodateChild(param1:WindowController, param2:IWindow):void
        {
            var _loc9_:uint;
            var _loc10_:uint;
            var _loc11_:uint;
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:int = param1.width;
            var _loc6_:int = param1.height;
            var _loc7_:Rectangle = param2.rectangle.clone();
            var _loc8_:Boolean;
            if (_loc7_.x < 0)
            {
                _loc3_ = _loc7_.x;
                _loc5_ = (_loc5_ - _loc3_);
                _loc7_.x = 0;
                _loc8_ = true;
            };
            if (_loc7_.right > _loc5_)
            {
                _loc5_ = (_loc7_.x + _loc7_.width);
                _loc8_ = true;
            };
            if (_loc7_.y < 0)
            {
                _loc4_ = _loc7_.y;
                _loc6_ = (_loc6_ - _loc4_);
                _loc7_.y = 0;
                _loc8_ = true;
            };
            if (_loc7_.bottom > _loc6_)
            {
                _loc6_ = (_loc7_.y + _loc7_.height);
                _loc8_ = true;
            };
            if (_loc8_)
            {
                _loc9_ = (param1.param & (WindowParam.WINDOW_PARAM_EXPAND_TO_ACCOMMODATE_CHILDREN | WindowParam.var_723));
                if (_loc9_)
                {
                    param1.setParamFlag(_loc9_, false);
                };
                param1.setRectangle((param1.x + _loc3_), (param1.y + _loc4_), _loc5_, _loc6_);
                if (((!(_loc4_ == 0)) || (!(_loc3_ == 0))))
                {
                    _loc11_ = param1.numChildren;
                    _loc10_ = 0;
                    while (_loc10_ < _loc11_)
                    {
                        IWindow(param1.getChildAt(_loc10_)).offset(-(_loc3_), -(_loc4_));
                        _loc10_++;
                    };
                };
                if (_loc9_)
                {
                    param1.setParamFlag(_loc9_, true);
                };
            };
        }

        public static function resizeToAccommodateChildren(param1:WindowController):void
        {
            var _loc2_:uint;
            var _loc7_:Rectangle;
            var _loc10_:uint;
            var _loc11_:IWindow;
            var _loc12_:Boolean;
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:int = int.MIN_VALUE;
            var _loc6_:int = int.MIN_VALUE;
            var _loc8_:Boolean;
            var _loc9_:uint = param1.numChildren;
            _loc2_ = 0;
            while (_loc2_ < _loc9_)
            {
                _loc7_ = param1.getChildAt(_loc2_).rectangle;
                if (_loc7_.right > _loc5_)
                {
                    _loc5_ = _loc7_.right;
                    _loc8_ = true;
                };
                if (_loc7_.bottom > _loc6_)
                {
                    _loc6_ = _loc7_.bottom;
                    _loc8_ = true;
                };
                _loc2_++;
            };
            if (_loc8_)
            {
                _loc10_ = (param1.param & (WindowParam.WINDOW_PARAM_EXPAND_TO_ACCOMMODATE_CHILDREN | WindowParam.var_723));
                if (_loc10_)
                {
                    param1.setParamFlag(_loc10_, false);
                };
                if (((!(_loc3_ == 0)) || (!(_loc4_ == 0))))
                {
                    _loc2_ = 0;
                    while (_loc2_ < _loc9_)
                    {
                        _loc11_ = param1.getChildAt(_loc2_);
                        _loc12_ = _loc11_.testParamFlag(WindowParam.var_711);
                        if (_loc12_)
                        {
                            _loc11_.setParamFlag(WindowParam.var_711, false);
                        };
                        _loc11_.offset(-(_loc3_), -(_loc4_));
                        if (_loc12_)
                        {
                            _loc11_.setParamFlag(WindowParam.var_711, true);
                        };
                        _loc2_++;
                    };
                };
                param1.width = _loc5_;
                param1.height = _loc6_;
                if (_loc10_)
                {
                    param1.setParamFlag(_loc10_, true);
                };
            };
        }


        public function get properties():Array
        {
            return (new Array());
        }

        public function get procedure():Function
        {
            return ((this.var_2667 != null) ? this.var_2667 : ((this._parent != null) ? this._parent.procedure : this.nullEventProc));
        }

        public function get filters():Array
        {
            return ((this.hasGraphicsContext()) ? this.getGraphicContext(true).filters : []);
        }

        public function get parent():IWindow
        {
            return (this._parent);
        }

        public function get debug():Boolean
        {
            return (this._debug);
        }

        public function get limits():IRectLimiter
        {
            if (!this.var_2816)
            {
                this.var_2816 = new WindowRectLimits(this);
            };
            return (this.var_2816);
        }

        public function set x(param1:int):void
        {
            if (param1 != var_1202.x)
            {
                this.setRectangle(param1, var_1202.y, var_1202.width, var_1202.height);
            };
        }

        public function set y(param1:int):void
        {
            if (param1 != var_1202.y)
            {
                this.setRectangle(var_1202.x, param1, var_1202.width, var_1202.height);
            };
        }

        public function set id(param1:uint):void
        {
            _id = param1;
        }

        public function set name(param1:String):void
        {
            _name = param1;
        }

        public function set width(param1:int):void
        {
            if (param1 != var_1202.width)
            {
                this.setRectangle(var_1202.x, var_1202.y, param1, var_1202.height);
            };
        }

        public function set height(param1:int):void
        {
            if (param1 != var_1202.height)
            {
                this.setRectangle(var_1202.x, var_1202.y, var_1202.width, param1);
            };
        }

        public function set position(param1:Point):void
        {
            this.setRectangle(param1.x, param1.y, var_1202.width, var_1202.height);
        }

        public function set rectangle(param1:Rectangle):void
        {
            this.setRectangle(param1.x, param1.y, param1.width, param1.height);
        }

        public function set background(param1:Boolean):void
        {
            var_1200 = param1;
            var_1201 = ((var_1200) ? (var_1201 | var_1203) : (var_1201 & 0xFFFFFF));
            this.var_2666 = ((this.var_2666) || (param1));
            _context.invalidate(this, var_1202, WindowRedrawFlag.var_1194);
        }

        public function set color(param1:uint):void
        {
            var_1203 = (param1 & 0xFF000000);
            var_1201 = ((var_1200) ? param1 : (param1 & 0xFFFFFF));
            _context.invalidate(this, var_1202, WindowRedrawFlag.var_1194);
        }

        public function set alpha(param1:uint):void
        {
            var_1203 = (param1 << 24);
            var_1201 = ((var_1200) ? (var_1203 | var_1201) : (0xFFFFFF & var_1201));
            _context.invalidate(this, var_1202, WindowRedrawFlag.var_1194);
        }

        public function set blend(param1:Number):void
        {
            var_1213 = ((param1 > 1) ? 1 : ((param1 < 0) ? 0 : param1));
            _context.invalidate(this, var_1202, WindowRedrawFlag.var_1204);
        }

        public function set visible(param1:Boolean):void
        {
            if (param1 != var_1169)
            {
                var_1169 = param1;
                if (this.var_1252)
                {
                    this.var_1252.visible = param1;
                };
                _context.invalidate(this, var_1202, WindowRedrawFlag.var_1194);
            };
        }

        public function set type(param1:uint):void
        {
            if (param1 != _type)
            {
                _type = param1;
                _context.invalidate(this, var_1202, WindowRedrawFlag.var_1194);
            };
        }

        public function set caption(param1:String):void
        {
            param1 = ((param1) ? param1 : "");
            if (param1 != caption)
            {
                var_1214 = param1;
                _context.invalidate(this, var_1202, WindowRedrawFlag.var_1194);
            };
        }

        public function set tags(param1:Array):void
        {
            if (param1 != null)
            {
                var_1209 = param1;
            };
        }

        public function set mouseThreshold(param1:uint):void
        {
            var_1210 = ((param1 > 0xFF) ? 0xFF : param1);
        }

        public function set procedure(param1:Function):void
        {
            this.var_2667 = param1;
        }

        public function set filters(param1:Array):void
        {
            if (this.hasGraphicsContext())
            {
                this.getGraphicContext(true).filters = param1;
            };
        }

        public function set debug(param1:Boolean):void
        {
            this._debug = param1;
        }

        public function set properties(param1:Array):void
        {
        }

        public function set state(param1:uint):void
        {
            if (param1 != _state)
            {
                _state = param1;
                _context.invalidate(this, var_1202, WindowRedrawFlag.var_1205);
            };
        }

        public function set style(param1:uint):void
        {
            var _loc2_:Array;
            var _loc3_:uint;
            var _loc4_:WindowController;
            if (param1 != var_1206)
            {
                var_1206 = param1;
                _loc2_ = new Array();
                this.groupChildrenWithTag(WindowController.TAG_INTERNAL, _loc2_);
                _loc3_ = _loc2_.length;
                while (--_loc3_ > -1)
                {
                    _loc4_ = (_loc2_[_loc3_] as WindowController);
                    if (_loc4_.tags.indexOf(var_1207) == -1)
                    {
                        _loc4_.style = var_1206;
                    };
                };
                _context.invalidate(this, var_1202, WindowRedrawFlag.var_1194);
            };
        }

        public function set clipping(param1:Boolean):void
        {
            if (param1 != var_1208)
            {
                var_1208 = param1;
                _context.invalidate(this, var_1202, WindowRedrawFlag.var_1194);
            };
        }

        public function get host():IWindow
        {
            return ((this._parent == this.desktop) ? this : this._parent.host);
        }

        public function get desktop():IDesktopWindow
        {
            return (_context.getDesktopWindow());
        }

        public function set parent(param1:IWindow):void
        {
            var _loc3_:WindowController;
            var _loc4_:WindowEvent;
            if (param1 == this)
            {
                throw (new Error("Attempted to assign self as parent!"));
            };
            if (((!(param1 == null)) && (!(param1.context == _context))))
            {
                _context = WindowContext(param1.context);
                for each (_loc3_ in this._children)
                {
                    _loc3_.parent = this;
                };
            };
            var _loc2_:IWindow = this._parent;
            if (this._parent != param1)
            {
                if (this._parent != null)
                {
                    this._parent.removeChild(this);
                };
                this._parent = WindowController(param1);
                if (this._parent != null)
                {
                    this.var_2817 = this._parent.rectangle.clone();
                    var_1199.x = var_1202.x;
                    var_1199.y = var_1202.y;
                    var_1199.width = var_1202.width;
                    var_1199.height = var_1202.height;
                    _loc4_ = WindowEvent.allocate(WindowEvent.var_601, this, this._parent);
                    this.update(this, _loc4_);
                }
                else
                {
                    this.var_2817.x = 0;
                    this.var_2817.y = 0;
                    this.var_2817.width = 0;
                    this.var_2817.height = 0;
                    _loc4_ = WindowEvent.allocate(WindowEvent.var_602, this, _loc2_);
                    this.update(this, _loc4_);
                };
                _loc4_.recycle();
            };
        }

        public function hasGraphicsContext():Boolean
        {
            return ((!(this.var_1252 == null)) || (!(testParamFlag(WindowParam.var_713))));
        }

        public function getGraphicContext(param1:Boolean):IGraphicContext
        {
            if (((param1) && (!(this.var_1252))))
            {
                this.var_1252 = new GraphicContext((("GC {" + _name) + "}"), GraphicContext.GC_TYPE_BITMAP, var_1202);
                this.var_1252.visible = var_1169;
            };
            return (this.var_1252);
        }

        public function setupGraphicsContext():IGraphicContext
        {
            var _loc1_:int;
            var _loc2_:WindowController;
            this.var_1252 = this.getGraphicContext(true);
            if (this._parent)
            {
                this._parent.setupGraphicsContext();
            };
            if (this._children.length > 0)
            {
                if (this.var_1252.numChildContexts != this.numChildren)
                {
                    _loc1_ = 0;
                    for each (_loc2_ in this._children)
                    {
                        this.var_1252.addChildContextAt(_loc2_.getGraphicContext(true), _loc1_++);
                    };
                };
            };
            this.var_2818 = true;
            return (this.var_1252);
        }

        public function releaseGraphicsContext():void
        {
            this.var_2818 = false;
            if (this.var_1252)
            {
            };
        }

        public function clone():IWindow
        {
            var _loc1_:Class = (getDefinitionByName(getQualifiedClassName(this)) as Class);
            var _loc2_:WindowController = (new _loc1_(_name, _type, var_1206, var_1198, _context, var_1202, null, this.var_2667, this.properties, var_1209.concat(), _id) as WindowController);
            _loc2_.var_1210 = var_1210;
            _loc2_.var_2666 = this.var_2666;
            _loc2_._debug = this._debug;
            _loc2_.var_2817 = this.var_2817.clone();
            _loc2_.var_1202 = var_1202.clone();
            _loc2_.var_1197 = var_1197.clone();
            _loc2_.var_1199 = var_1199.clone();
            _loc2_.var_1211 = ((var_1211) ? var_1211.clone() : null);
            _loc2_.var_1212 = ((var_1212) ? var_1212.clone() : null);
            _loc2_.var_2816 = ((this.var_2816) ? this.var_2816.clone(_loc2_) : null);
            _loc2_._context = _context;
            _loc2_.var_1201 = var_1201;
            _loc2_.var_1203 = var_1203;
            _loc2_.var_1208 = var_1208;
            _loc2_.var_1169 = var_1169;
            _loc2_.var_1213 = var_1213;
            _loc2_.var_1198 = var_1198;
            _loc2_._state = _state;
            _loc2_._name = _name;
            _loc2_._id = _id;
            _loc2_.caption = var_1214;
            _loc2_.background = var_1200;
            this.cloneChildWindows(_loc2_);
            return (_loc2_);
        }

        protected function cloneChildWindows(param1:WindowController):void
        {
            var _loc2_:WindowController;
            for each (_loc2_ in this._children)
            {
                if (_loc2_.tags.indexOf(WindowController.TAG_EXCLUDE) == -1)
                {
                    param1.addChild(_loc2_.clone());
                };
            };
        }

        override public function dispose():void
        {
            var _loc1_:WindowDisposeEvent;
            if (!_disposed)
            {
                this.var_2667 = null;
                if (!_context.disposed)
                {
                    if (!this.isChildWindow())
                    {
                        if (this.getStateFlag(WindowState.var_743))
                        {
                            this.deactivate();
                        };
                    };
                };
                while (this._children.length > 0)
                {
                    IDisposable(this._children.pop()).dispose();
                };
                this._children = null;
                if (this.parent)
                {
                    this.parent = null;
                };
                if (this._events)
                {
                    _loc1_ = WindowDisposeEvent.allocate(this);
                    this._events.dispatchEvent(_loc1_);
                    _loc1_.recycle();
                    if ((this._events is IDisposable))
                    {
                        IDisposable(this._events).dispose();
                        this._events = null;
                    };
                };
                if (this.var_1252 != null)
                {
                    this.var_1252.dispose();
                    this.var_1252 = null;
                };
                super.dispose();
            };
        }

        public function toString():String
        {
            return ((((((("[" + "Window ") + getQualifiedClassName(this)) + " ") + _name) + " ") + this.var_2819) + "]");
        }

        override public function invalidate(param1:Rectangle=null):void
        {
            if (param1 == null)
            {
                param1 = var_1202;
            };
            _context.invalidate(this, param1, WindowRedrawFlag.var_1194);
        }

        public function resolve():uint
        {
            return (0);
        }

        public function center():void
        {
            if (this._parent != null)
            {
                this.x = ((this._parent.width / 2) - (var_1202.width / 2));
                this.y = ((this._parent.height / 2) - (var_1202.height / 2));
            };
        }

        public function setRectangle(param1:int, param2:int, param3:int, param4:int):void
        {
            var _loc7_:uint;
            var _loc8_:Rectangle;
            var _loc9_:WindowEvent;
            if (this.var_2816)
            {
                param4 = Math.max(this.var_2816.minHeight, param4);
                param4 = Math.min(this.var_2816.maxHeight, param4);
                param3 = Math.max(this.var_2816.minWidth, param3);
                param3 = Math.min(this.var_2816.maxWidth, param3);
            };
            var _loc5_:Boolean = ((!(param1 == var_1202.x)) || (!(param2 == var_1202.y)));
            var _loc6_:Boolean = ((!(param3 == var_1202.width)) || (!(param4 == var_1202.height)));
            if (((_loc6_) && (!(_loc5_))))
            {
                _loc7_ = (var_1198 & WindowParam.var_728);
                if (_loc7_ == WindowParam.var_704)
                {
                    param1 = int((param1 - ((param3 - var_1202.width) / 2)));
                    _loc5_ = true;
                }
                else
                {
                    if (_loc7_ == WindowParam.var_705)
                    {
                        param1 = (param1 - (param3 - var_1202.width));
                        _loc5_ = true;
                    };
                };
                _loc7_ = (var_1198 & WindowParam.var_729);
                if (_loc7_ == WindowParam.var_707)
                {
                    param2 = int((param2 - ((param4 - var_1202.height) / 2)));
                    _loc5_ = true;
                }
                else
                {
                    if (_loc7_ == WindowParam.var_708)
                    {
                        param2 = (param2 - (param4 - var_1202.height));
                        _loc5_ = true;
                    };
                };
            };
            if (testParamFlag(WindowParam.var_711))
            {
                if (this._parent != null)
                {
                    _loc8_ = this._parent.rectangle;
                    param1 = ((param1 < 0) ? 0 : param1);
                    param2 = ((param2 < 0) ? 0 : param2);
                    if (_loc5_)
                    {
                        param1 = (param1 - (((param1 + param3) > _loc8_.width) ? ((param1 + param3) - _loc8_.width) : 0));
                        param2 = (param2 - (((param2 + param4) > _loc8_.height) ? ((param2 + param4) - _loc8_.height) : 0));
                        _loc5_ = ((!(param1 == var_1202.x)) || (!(param2 == var_1202.y)));
                    }
                    else
                    {
                        param3 = (param3 - (((param1 + param3) > _loc8_.width) ? ((param1 + param3) - _loc8_.width) : 0));
                        param4 = (param4 - (((param2 + param4) > _loc8_.height) ? ((param2 + param4) - _loc8_.height) : 0));
                        _loc6_ = ((!(param3 == var_1202.width)) || (!(param4 == var_1202.height)));
                    };
                };
            };
            if (((_loc5_) || (_loc6_)))
            {
                if (_loc5_)
                {
                    _loc9_ = WindowEvent.allocate(WindowEvent.WINDOW_EVENT_RELOCATE, this, null, true);
                    this.update(this, _loc9_);
                    if (_loc9_.isWindowOperationPrevented())
                    {
                        _loc5_ = false;
                    };
                    _loc9_.recycle();
                };
                if (_loc6_)
                {
                    _loc9_ = WindowEvent.allocate(WindowEvent.var_588, this, null, true);
                    this.update(this, _loc9_);
                    if (_loc9_.isWindowOperationPrevented())
                    {
                        _loc6_ = false;
                    };
                    _loc9_.recycle();
                };
                if (_loc5_)
                {
                    var_1199.x = var_1202.x;
                    var_1199.y = var_1202.y;
                    var_1199.width = var_1202.width;
                    var_1199.height = var_1202.height;
                    var_1202.x = param1;
                    var_1202.y = param2;
                };
                if (_loc6_)
                {
                    var_1199.width = var_1202.width;
                    var_1199.height = var_1202.height;
                    var_1202.width = param3;
                    var_1202.height = param4;
                };
                if (_loc5_)
                {
                    _loc9_ = WindowEvent.allocate(WindowEvent.var_587, this, null);
                    this.update(this, _loc9_);
                    _loc9_.recycle();
                };
                if (_loc6_)
                {
                    _loc9_ = WindowEvent.allocate(WindowEvent.var_589, this, null);
                    this.update(this, _loc9_);
                    _loc9_.recycle();
                };
            };
        }

        public function getRegionProperties(param1:Rectangle=null, param2:Rectangle=null, param3:Rectangle=null, param4:Rectangle=null):void
        {
            if (param1 != null)
            {
                param1.x = var_1202.x;
                param1.y = var_1202.y;
                param1.width = var_1202.width;
                param1.height = var_1202.height;
            };
            if (param2 != null)
            {
                param2.x = var_1199.x;
                param2.y = var_1199.y;
                param2.width = var_1199.width;
                param2.height = var_1199.height;
            };
            if (((!(param3 == null)) && (!(var_1211 == null))))
            {
                param3.x = var_1211.x;
                param3.y = var_1211.y;
                param3.width = var_1211.width;
                param3.height = var_1211.height;
            };
            if (((!(param4 == null)) && (!(var_1212 == null))))
            {
                param4.x = var_1212.x;
                param4.y = var_1212.y;
                param4.width = var_1212.width;
                param4.height = var_1212.height;
            };
        }

        public function setRegionProperties(param1:Rectangle=null, param2:Rectangle=null, param3:Rectangle=null):void
        {
            if (param3 != null)
            {
                if (((param3.width < 0) || (param3.height < 0)))
                {
                    throw (new Error("Invalid rectangle; maximized size can't be less than zero!"));
                };
                if (var_1212 == null)
                {
                    var_1212 = new Rectangle();
                };
                var_1212.x = param3.x;
                var_1212.y = param3.y;
                var_1212.width = param3.width;
                var_1212.height = param3.height;
            };
            if (param2 != null)
            {
                if (((param2.width < 0) || (param2.height < 0)))
                {
                    throw (new Error("Invalid rectangle; minimized size can't be less than zero!"));
                };
                if (var_1211 == null)
                {
                    var_1211 = new Rectangle();
                };
                var_1211.x = param2.x;
                var_1211.y = param2.y;
                var_1211.width = param2.width;
                var_1211.height = param2.height;
            };
            if (((param3.width < param2.width) || (param3.height < param2.height)))
            {
                param3.width = param2.width;
                param3.height = param2.height;
                throw (new Error("Maximized rectangle can't be smaller than minimized rectangle!"));
            };
            if (param1 != null)
            {
                this.setRectangle(param1.x, param1.y, param1.width, param1.height);
            };
        }

        public function buildFromXML(param1:XML, param2:Map=null):Boolean
        {
            return (!(_context.getWindowParser().parseAndConstruct(param1, this, param2) == null));
        }

        public function fetchDrawBuffer():IBitmapDrawable
        {
            return ((testParamFlag(WindowParam.var_713)) ? ((this._parent != null) ? this._parent.fetchDrawBuffer() : null) : this.getGraphicContext(true).fetchDrawBuffer());
        }

        public function getDrawRegion(param1:Rectangle):void
        {
            if (!testParamFlag(WindowParam.var_713))
            {
                param1.x = 0;
                param1.y = 0;
                param1.width = var_1202.width;
                param1.height = var_1202.height;
            }
            else
            {
                if (this._parent != null)
                {
                    this._parent.getDrawRegion(param1);
                    param1.x = (param1.x + var_1202.x);
                    param1.y = (param1.y + var_1202.y);
                    param1.width = var_1202.width;
                    param1.height = var_1202.height;
                }
                else
                {
                    param1.x = 0;
                    param1.y = 0;
                    param1.width = 0;
                    param1.height = 0;
                };
            };
        }

        public function update(param1:WindowController, param2:WindowEvent):Boolean
        {
            var _loc3_:IWindow;
            var _loc4_:IMouseListenerService;
            var _loc5_:WindowEvent;
            var _loc6_:Rectangle;
            var _loc7_:uint;
            if (!testParamFlag(WindowParam.var_716))
            {
                this.procedure(param2, this);
                if (_disposed)
                {
                    return (true);
                };
                if (!param2.isWindowOperationPrevented())
                {
                    if (this.hasEventListener(param2.type))
                    {
                        this._events.dispatchEvent(param2);
                        if (_disposed)
                        {
                            return (true);
                        };
                    };
                };
                if (param2.cancelable)
                {
                    if (param2.isWindowOperationPrevented())
                    {
                        return (true);
                    };
                };
            };
            if ((param2 is WindowMouseEvent))
            {
                switch (param2.type)
                {
                    case WindowMouseEvent.var_650:
                        if (this.activate())
                        {
                            if (param2.cancelable)
                            {
                                param2.preventDefault();
                            };
                        };
                        if (disposed)
                        {
                            return (true);
                        };
                        this.setStateFlag(WindowState.var_1185, true);
                        _loc4_ = _context.getWindowServices().getMouseListenerService();
                        _loc4_.begin(this);
                        _loc4_.eventTypes.push(WindowMouseEvent.var_655);
                        _loc4_.areaLimit = MouseListenerType.var_1215;
                        if (testParamFlag(WindowParam.var_692))
                        {
                            _loc3_ = this;
                            while (_loc3_ != null)
                            {
                                if (_loc3_.testParamFlag(WindowParam.var_137))
                                {
                                    _context.getWindowServices().getMouseDraggingService().begin(_loc3_);
                                    break;
                                };
                                _loc3_ = _loc3_.parent;
                            };
                        };
                        if ((var_1198 & WindowParam.var_725) > 0)
                        {
                            _loc3_ = this;
                            while (_loc3_ != null)
                            {
                                if (_loc3_.testParamFlag(WindowParam.var_696))
                                {
                                    _context.getWindowServices().getMouseScalingService().begin(_loc3_, (var_1198 & WindowParam.var_725));
                                    break;
                                };
                                _loc3_ = _loc3_.parent;
                            };
                        };
                        break;
                    case WindowMouseEvent.var_655:
                        if (testStateFlag(WindowState.var_1185))
                        {
                            this.setStateFlag(WindowState.var_1185, false);
                        };
                        _context.getWindowServices().getMouseListenerService().end(this);
                        if (testParamFlag(WindowParam.var_137))
                        {
                            _context.getWindowServices().getMouseDraggingService().end(this);
                        };
                        if (testParamFlag(WindowParam.var_696))
                        {
                            _context.getWindowServices().getMouseScalingService().end(this);
                        };
                        break;
                    case WindowMouseEvent.var_624:
                        if (testStateFlag(WindowState.var_1187))
                        {
                            this.setStateFlag(WindowState.var_1187, false);
                        };
                        if (testStateFlag(WindowState.var_1185))
                        {
                            this.setStateFlag(WindowState.var_1185, false);
                        };
                        break;
                    case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
                        if (!testStateFlag(WindowState.var_1187))
                        {
                            this.setStateFlag(WindowState.var_1187, true);
                        };
                        break;
                    case WindowMouseEvent.var_657:
                        return (false);
                };
            }
            else
            {
                if ((param2 is WindowEvent))
                {
                    switch (param2.type)
                    {
                        case WindowEvent.var_589:
                            _context.invalidate(this, var_1202.union(var_1199), WindowRedrawFlag.RESIZE);
                            if (param1 == this)
                            {
                                _loc5_ = WindowEvent.allocate(WindowEvent.var_604, this, null);
                                this.notifyChildren(_loc5_);
                                _loc5_.recycle();
                                if (testParamFlag(WindowParam.var_687, WindowParam.var_717))
                                {
                                    this.updateScaleRelativeToParent();
                                }
                                else
                                {
                                    if (testParamFlag(WindowParam.var_691, WindowParam.var_718))
                                    {
                                        this.updateScaleRelativeToParent();
                                    };
                                };
                                if (this._parent != null)
                                {
                                    _loc7_ = var_1198;
                                    var_1198 = (var_1198 & (~(WindowParam.var_717 | WindowParam.var_718)));
                                    if (testParamFlag(WindowParam.var_709))
                                    {
                                        this._parent.width = (this._parent.width + (var_1202.width - var_1199.width));
                                    };
                                    if (testParamFlag(WindowParam.var_710))
                                    {
                                        this._parent.height = (this._parent.height + (var_1202.height - var_1199.height));
                                    };
                                    var_1198 = _loc7_;
                                    _loc5_ = WindowEvent.allocate(WindowEvent.var_599, this._parent, this);
                                    this._parent.update(this, _loc5_);
                                    _loc5_.recycle();
                                };
                            };
                            break;
                        case WindowEvent.var_587:
                            _loc6_ = var_1202.union(var_1199);
                            if (this._parent)
                            {
                                if (this._parent.clipping)
                                {
                                    _loc6_.offset(this._parent.x, this._parent.y);
                                    _loc6_ = _loc6_.intersection(this._parent.rectangle);
                                    _loc6_.offset(-(this._parent.x), -(this._parent.y));
                                };
                            };
                            _context.invalidate(this, _loc6_, WindowRedrawFlag.var_1216);
                            if (param1 == this)
                            {
                                _loc5_ = WindowEvent.allocate(WindowEvent.var_603, this, null);
                                this.notifyChildren(_loc5_);
                                _loc5_.recycle();
                                if (this._parent != null)
                                {
                                    _loc5_ = WindowEvent.allocate(WindowEvent.var_598, this._parent, this);
                                    this._parent.update(this, _loc5_);
                                    _loc5_.recycle();
                                };
                            };
                            break;
                        case WindowEvent.var_572:
                            if (param1 == this)
                            {
                                _loc5_ = WindowEvent.allocate(WindowEvent.var_605, this, null);
                                this.notifyChildren(_loc5_);
                                _loc5_.recycle();
                                if (this._parent != null)
                                {
                                    _loc5_ = WindowEvent.allocate(WindowEvent.var_600, this._parent, this);
                                    this._parent.update(this, _loc5_);
                                    _loc5_.recycle();
                                };
                            };
                            break;
                        case WindowEvent.var_601:
                            if (testParamFlag(WindowParam.var_687, WindowParam.var_717))
                            {
                                this.updateScaleRelativeToParent();
                            }
                            else
                            {
                                if (testParamFlag(WindowParam.var_691, WindowParam.var_718))
                                {
                                    this.updateScaleRelativeToParent();
                                };
                            };
                            _context.invalidate(this, var_1202, WindowRedrawFlag.var_1194);
                            break;
                        case WindowEvent.var_604:
                            this._parent.getRegionProperties(null, this.var_2817);
                            this.updateScaleRelativeToParent();
                            break;
                        case WindowEvent.var_596:
                            if (testParamFlag(WindowParam.var_723))
                            {
                                this.scaleToAccommodateChildren();
                            }
                            else
                            {
                                if (testParamFlag(WindowParam.WINDOW_PARAM_EXPAND_TO_ACCOMMODATE_CHILDREN))
                                {
                                    expandToAccommodateChild(this, param2.related);
                                };
                            };
                            break;
                        case WindowEvent.var_597:
                            if (testParamFlag(WindowParam.var_723))
                            {
                                this.scaleToAccommodateChildren();
                            };
                            break;
                        case WindowEvent.var_600:
                            this.activate();
                            break;
                        case WindowEvent.var_599:
                            if (testParamFlag(WindowParam.var_723))
                            {
                                this.scaleToAccommodateChildren();
                            }
                            else
                            {
                                if (testParamFlag(WindowParam.WINDOW_PARAM_EXPAND_TO_ACCOMMODATE_CHILDREN))
                                {
                                    expandToAccommodateChild(this, param2.related);
                                };
                            };
                            break;
                        case WindowEvent.var_598:
                            if (testParamFlag(WindowParam.var_723))
                            {
                                this.scaleToAccommodateChildren();
                            }
                            else
                            {
                                if (testParamFlag(WindowParam.WINDOW_PARAM_EXPAND_TO_ACCOMMODATE_CHILDREN))
                                {
                                    expandToAccommodateChild(this, param2.related);
                                };
                            };
                            break;
                    };
                };
            };
            return (true);
        }

        protected function notifyEventListeners(param1:WindowEvent):void
        {
            this.procedure(param1, this);
            if (!param1.isWindowOperationPrevented())
            {
                if (this.hasEventListener(param1.type))
                {
                    this._events.dispatchEvent(param1);
                };
            };
        }

        private function nullEventProc(param1:WindowEvent, param2:IWindow):void
        {
        }

        private function notifyChildren(param1:WindowEvent):void
        {
            var _loc2_:WindowController;
            for each (_loc2_ in this._children)
            {
                _loc2_.update(this, param1);
            };
        }

        public function childRectToClippedDrawRegion(param1:Rectangle, param2:Rectangle):Boolean
        {
            var _loc4_:Rectangle;
            var _loc3_:Boolean;
            if (testParamFlag(WindowParam.var_713))
            {
                param1.offset(var_1202.x, var_1202.y);
                if (clipping)
                {
                    _loc4_ = param1.intersection(var_1202);
                    if (param1.x < var_1202.x)
                    {
                        param2.x = (param2.x - (param1.x - var_1202.x));
                        param1.x = var_1202.x;
                        _loc3_ = true;
                    };
                    if (param1.y < var_1202.y)
                    {
                        param2.y = (param2.y - (param1.y - var_1202.y));
                        param1.y = var_1202.y;
                        _loc3_ = true;
                    };
                    if (param1.width != _loc4_.width)
                    {
                        param1.width = _loc4_.width;
                        _loc3_ = true;
                    };
                    if (param1.height != _loc4_.height)
                    {
                        param1.height = _loc4_.height;
                        _loc3_ = true;
                    };
                    param2.width = _loc4_.width;
                    param2.height = _loc4_.height;
                };
                if (this._parent != null)
                {
                    _loc3_ = ((WindowController(this._parent).childRectToClippedDrawRegion(param1, param2)) || (_loc3_));
                };
            }
            else
            {
                if (clipping)
                {
                    if (param1.x < 0)
                    {
                        param2.x = (param2.x - param1.x);
                        param1.x = 0;
                        _loc3_ = true;
                    };
                    if (param1.y < 0)
                    {
                        param2.y = (param2.y - param1.y);
                        param1.y = 0;
                        _loc3_ = true;
                    };
                    if (var_1202.width < param1.right)
                    {
                        param2.right = (param2.right - (param1.right - var_1202.width));
                        param1.right = param1.width;
                        _loc3_ = true;
                    };
                    if (var_1202.height < param1.bottom)
                    {
                        param2.bottom = (param2.bottom - (param1.bottom - var_1202.height));
                        param1.bottom = var_1202.height;
                        _loc3_ = true;
                    };
                };
            };
            return ((_loc3_) ? ((param2.width > 0) && (param2.height > 0)) : true);
        }

        public function convertPointFromGlobalToLocalSpace(param1:Point):void
        {
            var _loc2_:Number = param1.x;
            var _loc3_:Number = param1.y;
            if (this._parent == null)
            {
                param1.x = var_1202.x;
                param1.y = var_1202.y;
            }
            else
            {
                this._parent.getGlobalPosition(param1);
                param1.x = (param1.x + var_1202.x);
                param1.y = (param1.y + var_1202.y);
            };
            param1.x = (_loc2_ - param1.x);
            param1.y = (_loc3_ - param1.y);
        }

        public function convertPointFromLocalToGlobalSpace(param1:Point):void
        {
            var _loc2_:Number = param1.x;
            var _loc3_:Number = param1.y;
            if (this._parent == null)
            {
                param1.x = var_1202.x;
                param1.y = var_1202.y;
            }
            else
            {
                this._parent.getGlobalPosition(param1);
                param1.x = (param1.x + var_1202.x);
                param1.y = (param1.y + var_1202.y);
            };
            param1.x = (param1.x + _loc2_);
            param1.y = (param1.y + _loc3_);
        }

        public function getRelativeMousePosition(param1:Point):void
        {
            this.getGlobalPosition(param1);
            param1.x = (_context.getDesktopWindow().mouseX - param1.x);
            param1.y = (_context.getDesktopWindow().mouseY - param1.y);
        }

        public function getAbsoluteMousePosition(param1:Point):void
        {
            param1.x = _context.getDesktopWindow().mouseX;
            param1.y = _context.getDesktopWindow().mouseY;
        }

        public function getLocalPosition(param1:Point):void
        {
            param1.x = var_1202.x;
            param1.y = var_1202.y;
        }

        public function getLocalRectangle(param1:Rectangle):void
        {
            param1.x = var_1202.x;
            param1.y = var_1202.y;
            param1.width = var_1202.width;
            param1.height = var_1202.height;
        }

        public function hitTestLocalPoint(param1:Point):Boolean
        {
            return (var_1202.containsPoint(param1));
        }

        public function hitTestLocalRectangle(param1:Rectangle):Boolean
        {
            return (var_1202.intersects(param1));
        }

        public function validateLocalPointIntersection(param1:Point, param2:BitmapData):Boolean
        {
            return (this.testLocalPointHitAgainstAlpha(param1, param2, var_1210));
        }

        public function getGlobalPosition(param1:Point):void
        {
            if (this._parent != null)
            {
                this._parent.getGlobalPosition(param1);
                param1.x = (param1.x + var_1202.x);
                param1.y = (param1.y + var_1202.y);
            }
            else
            {
                param1.x = var_1202.x;
                param1.y = var_1202.y;
            };
        }

        public function setGlobalPosition(param1:Point):void
        {
            var _loc2_:Point = new Point();
            if (this._parent != null)
            {
                this._parent.getGlobalPosition(_loc2_);
                _loc2_.x = (_loc2_.x + var_1202.x);
                _loc2_.y = (_loc2_.y + var_1202.y);
            }
            else
            {
                _loc2_.x = var_1202.x;
                _loc2_.y = var_1202.y;
            };
            this.x = (x + (param1.x - _loc2_.x));
            this.y = (y + (param1.y - _loc2_.y));
        }

        public function getGlobalRectangle(param1:Rectangle):void
        {
            var _loc2_:Rectangle = var_1202;
            if (this._parent != null)
            {
                this._parent.getGlobalRectangle(param1);
                param1.x = (param1.x + _loc2_.x);
                param1.y = (param1.y + _loc2_.y);
            }
            else
            {
                param1.x = _loc2_.x;
                param1.y = _loc2_.y;
            };
            param1.width = _loc2_.width;
            param1.height = _loc2_.height;
        }

        public function setGlobalRectangle(param1:Rectangle):void
        {
            var _loc2_:Point = new Point();
            if (this._parent != null)
            {
                this._parent.getGlobalPosition(_loc2_);
                _loc2_.x = (_loc2_.x + var_1202.x);
                _loc2_.y = (_loc2_.y + var_1202.y);
            }
            else
            {
                _loc2_.x = var_1202.x;
                _loc2_.y = var_1202.y;
            };
            this.setRectangle((x + (param1.x - _loc2_.x)), (y + (param1.y - _loc2_.y)), param1.width, param1.height);
        }

        public function hitTestGlobalPoint(param1:Point):Boolean
        {
            var _loc2_:Rectangle = new Rectangle();
            this.getGlobalRectangle(_loc2_);
            return (_loc2_.containsPoint(param1));
        }

        public function hitTestGlobalRectangle(param1:Rectangle):Boolean
        {
            var _loc2_:Rectangle = new Rectangle();
            this.getGlobalRectangle(_loc2_);
            return (_loc2_.intersects(param1));
        }

        public function validateGlobalPointIntersection(param1:Point, param2:BitmapData):Boolean
        {
            var _loc3_:Point = new Point();
            this.getGlobalPosition(_loc3_);
            _loc3_.x = (param1.x - _loc3_.x);
            _loc3_.y = (param1.y - _loc3_.y);
            return (this.testLocalPointHitAgainstAlpha(_loc3_, param2, var_1210));
        }

        public function getMouseRegion(param1:Rectangle):void
        {
            var _loc2_:Rectangle;
            this.getGlobalRectangle(param1);
            if (param1.width < 0)
            {
                param1.width = 0;
            };
            if (param1.height < 0)
            {
                param1.height = 0;
            };
            if (testParamFlag(WindowParam.var_713))
            {
                _loc2_ = new Rectangle();
                IWindow(this._parent).getMouseRegion(_loc2_);
                if (param1.left < _loc2_.left)
                {
                    param1.left = _loc2_.left;
                };
                if (param1.top < _loc2_.top)
                {
                    param1.top = _loc2_.top;
                };
                if (param1.right > _loc2_.right)
                {
                    param1.right = _loc2_.right;
                };
                if (param1.bottom > _loc2_.bottom)
                {
                    param1.bottom = _loc2_.bottom;
                };
            };
        }

        protected function testLocalPointHitAgainstAlpha(param1:Point, param2:BitmapData, param3:uint):Boolean
        {
            var _loc5_:BitmapData;
            var _loc4_:Boolean;
            if (((var_1202.width < 1) || (var_1202.height < 1)))
            {
                return (false);
            };
            if (((this.var_2666) && (var_1210 > 0)))
            {
                if (!testParamFlag(WindowParam.var_713))
                {
                    if (((param1.x <= var_1202.width) && (param1.y <= var_1202.height)))
                    {
                        _loc5_ = (this.getGraphicContext(true).fetchDrawBuffer() as BitmapData);
                        if (_loc5_ != null)
                        {
                            _loc4_ = _loc5_.hitTest(var_1217, param3, param1);
                        };
                    };
                }
                else
                {
                    _loc4_ = ((param2 != null) ? param2.hitTest(var_1217, param3, param1) : false);
                };
            }
            else
            {
                if (((param1.x >= 0) && (param1.x < var_1202.width)))
                {
                    if (((param1.y >= 0) && (param1.y < var_1202.height)))
                    {
                        _loc4_ = true;
                    };
                };
            };
            return (_loc4_);
        }

        public function isCapableOfUsingSharedGraphicContext():Boolean
        {
            return (true);
        }

        public function resolveVerticalScale():Number
        {
            return (var_1202.height / var_1197.height);
        }

        public function resolveHorizontalScale():Number
        {
            return (var_1202.width / var_1197.width);
        }

        public function offset(param1:Number, param2:Number):void
        {
            this.setRectangle((var_1202.x + param1), (var_1202.y + param2), var_1202.width, var_1202.height);
        }

        public function scale(param1:Number, param2:Number):void
        {
            this.setRectangle(var_1202.x, var_1202.y, (var_1202.width + param1), (var_1202.height + param2));
        }

        public function scaleToAccommodateChildren():void
        {
            var _loc1_:IWindow;
            var _loc6_:Rectangle;
            var _loc9_:Array;
            var _loc10_:uint;
            var _loc2_:int;
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:int;
            var _loc7_:Boolean;
            var _loc8_:uint = (param & (WindowParam.WINDOW_PARAM_EXPAND_TO_ACCOMMODATE_CHILDREN | WindowParam.var_723));
            for each (_loc1_ in this._children)
            {
                _loc6_ = _loc1_.rectangle;
                if (_loc6_.x < _loc2_)
                {
                    _loc4_ = (_loc4_ - (_loc6_.x - _loc2_));
                    _loc2_ = _loc6_.x;
                    _loc7_ = true;
                };
                if (_loc6_.right > _loc4_)
                {
                    _loc4_ = (_loc6_.x + _loc6_.width);
                    _loc7_ = true;
                };
                if (_loc6_.y < _loc3_)
                {
                    _loc5_ = (_loc5_ - (_loc6_.y - _loc3_));
                    _loc3_ = _loc6_.y;
                    _loc7_ = true;
                };
                if (_loc6_.bottom > _loc5_)
                {
                    _loc5_ = (_loc6_.y + _loc6_.height);
                    _loc7_ = true;
                };
            };
            if (_loc7_)
            {
                _loc9_ = [];
                for each (_loc1_ in this._children)
                {
                    _loc10_ = (_loc1_.param & (WindowParam.var_717 | WindowParam.var_718));
                    _loc1_.setParamFlag(_loc10_, false);
                    _loc9_.push(_loc10_);
                };
                if (_loc8_)
                {
                    this.setParamFlag(_loc8_, false);
                };
                this.setRectangle((var_1202.x + _loc2_), (var_1202.y + _loc3_), _loc4_, _loc5_);
                for each (_loc1_ in this._children)
                {
                    _loc1_.offset(-(_loc2_), -(_loc3_));
                    _loc1_.setParamFlag(_loc9_.shift(), true);
                };
                if (_loc8_)
                {
                    this.setParamFlag(_loc8_, true);
                };
            };
        }

        public function getStateFlag(param1:uint):Boolean
        {
            return (!((_state & param1) == 0));
        }

        public function setStateFlag(param1:uint, param2:Boolean=true):void
        {
            var _loc3_:uint = _state;
            _state = ((param2) ? _state = (_state | param1) : _state = (_state & (~(param1))));
            if (_state != _loc3_)
            {
                _context.invalidate(this, var_1202, WindowRedrawFlag.var_1205);
            };
        }

        public function getStyleFlag(param1:uint):Boolean
        {
            return (!((var_1206 & param1) == 0));
        }

        public function setStyleFlag(param1:uint, param2:Boolean=true):void
        {
            var _loc4_:Array;
            var _loc5_:uint;
            var _loc6_:WindowController;
            var _loc3_:uint = var_1206;
            var_1206 = ((param2) ? var_1206 = (var_1206 | param1) : var_1206 = (var_1206 & (~(param1))));
            if (var_1206 != _loc3_)
            {
                _loc4_ = new Array();
                this.groupChildrenWithTag(WindowController.TAG_INTERNAL, _loc4_);
                _loc5_ = _loc4_.length;
                while (--_loc5_ > -1)
                {
                    _loc6_ = (_loc4_[_loc5_] as WindowController);
                    if (_loc6_.tags.indexOf(var_1207) == -1)
                    {
                        _loc6_.style = var_1206;
                    };
                };
                _context.invalidate(this, var_1202, WindowRedrawFlag.var_1194);
            };
        }

        public function getParamFlag(param1:uint):Boolean
        {
            return (!((var_1198 & param1) == 0));
        }

        public function setParamFlag(param1:uint, param2:Boolean=true):void
        {
            var _loc3_:uint = var_1198;
            var_1198 = ((param2) ? var_1198 = (var_1198 | param1) : var_1198 = (var_1198 & (~(param1))));
            if (var_1198 != _loc3_)
            {
                if (!(var_1198 & WindowParam.var_713))
                {
                    if (!this.var_1252)
                    {
                        this.setupGraphicsContext();
                        _context.invalidate(this, var_1202, WindowRedrawFlag.var_1194);
                    };
                }
                else
                {
                    if ((var_1198 & WindowParam.var_713))
                    {
                        if (this.var_1252)
                        {
                            _context.invalidate(this, var_1202, WindowRedrawFlag.var_1194);
                        };
                    };
                };
            };
        }

        protected function updateScaleRelativeToParent():void
        {
            var _loc3_:Rectangle;
            var _loc4_:int;
            var _loc5_:uint;
            var _loc6_:uint;
            var _loc7_:Rectangle;
            if (this._parent == null)
            {
                return;
            };
            var _loc1_:* = (!(testParamFlag(WindowParam.var_684, WindowParam.var_717)));
            var _loc2_:* = (!(testParamFlag(WindowParam.var_688, WindowParam.var_718)));
            if (((_loc1_) || (_loc2_)))
            {
                _loc3_ = var_1202.clone();
                if (_loc1_)
                {
                    _loc4_ = (this._parent.width - this.var_2817.width);
                    _loc5_ = (var_1198 & WindowParam.var_717);
                    if (_loc5_ == WindowParam.var_686)
                    {
                        _loc3_.width = (_loc3_.width + _loc4_);
                    }
                    else
                    {
                        if (_loc5_ == WindowParam.var_685)
                        {
                            _loc3_.x = (_loc3_.x + _loc4_);
                        }
                        else
                        {
                            if (_loc5_ == WindowParam.var_687)
                            {
                                if (((this._parent.width < _loc3_.width) && (this.getParamFlag(WindowParam.var_713))))
                                {
                                    _loc3_.x = 0;
                                }
                                else
                                {
                                    _loc3_.x = (Math.floor((this._parent.width / 2)) - Math.floor((_loc3_.width / 2)));
                                };
                            };
                        };
                    };
                };
                if (_loc2_)
                {
                    _loc4_ = (this._parent.height - this.var_2817.height);
                    _loc5_ = (var_1198 & WindowParam.var_718);
                    if (_loc5_ == WindowParam.var_690)
                    {
                        _loc3_.height = (_loc3_.height + _loc4_);
                    }
                    else
                    {
                        if (_loc5_ == WindowParam.var_689)
                        {
                            _loc3_.y = (_loc3_.y + _loc4_);
                        }
                        else
                        {
                            if (_loc5_ == WindowParam.var_691)
                            {
                                if (((this._parent.height < _loc3_.height) && (this.getParamFlag(WindowParam.var_713))))
                                {
                                    _loc3_.y = 0;
                                }
                                else
                                {
                                    _loc3_.y = (Math.floor((this._parent.height / 2)) - Math.floor((_loc3_.height / 2)));
                                };
                            };
                        };
                    };
                };
                _loc6_ = var_1198;
                var_1198 = (var_1198 & (~((WindowParam.var_730 | WindowParam.var_717) | WindowParam.var_718)));
                this.setRectangle(_loc3_.x, _loc3_.y, _loc3_.width, _loc3_.height);
                var_1198 = _loc6_;
            }
            else
            {
                if (testParamFlag(WindowParam.var_711))
                {
                    _loc3_ = var_1202.clone();
                    if (this._parent != null)
                    {
                        _loc7_ = this._parent.rectangle;
                        _loc3_.x = ((_loc3_.x < 0) ? 0 : _loc3_.x);
                        _loc3_.y = ((_loc3_.y < 0) ? 0 : _loc3_.y);
                        _loc3_.x = (_loc3_.x - (((_loc3_.x + _loc3_.width) > _loc7_.width) ? ((_loc3_.x + _loc3_.width) - _loc7_.width) : 0));
                        _loc3_.y = (_loc3_.y - (((_loc3_.y + _loc3_.height) > _loc7_.height) ? ((_loc3_.y + _loc3_.height) - _loc7_.height) : 0));
                        _loc3_.width = (_loc3_.width - (((_loc3_.x + _loc3_.width) > _loc7_.width) ? ((_loc3_.x + _loc3_.width) - _loc7_.width) : 0));
                        _loc3_.height = (_loc3_.height - (((_loc3_.y + _loc3_.height) > _loc7_.height) ? ((_loc3_.y + _loc3_.height) - _loc7_.height) : 0));
                        if (((((!(_loc3_.x == var_1202.x)) || (!(_loc3_.y == var_1202.y))) || (!(_loc3_.width == var_1202.width))) || (!(_loc3_.height == var_1202.height))))
                        {
                            _loc6_ = var_1198;
                            var_1198 = (var_1198 & (~((WindowParam.var_730 | WindowParam.var_717) | WindowParam.var_718)));
                            this.setRectangle(_loc3_.x, _loc3_.y, _loc3_.width, _loc3_.height);
                            var_1198 = _loc6_;
                        };
                    };
                };
            };
        }

        protected function isChildWindow():Boolean
        {
            return (!(this._parent == context.getDesktopWindow()));
        }

        public function destroy():Boolean
        {
            if (_state == WindowState.var_1115)
            {
                return (true);
            };
            _state = WindowState.var_1115;
            var _loc1_:WindowEvent = WindowEvent.allocate(WindowEvent.var_561, this, null);
            this.update(this, _loc1_);
            if (_loc1_.isDefaultPrevented())
            {
                _loc1_.recycle();
                return (false);
            };
            _loc1_.recycle();
            _loc1_ = WindowEvent.allocate(WindowEvent.var_562, this, null);
            this.update(this, _loc1_);
            _loc1_.recycle();
            this.dispose();
            return (true);
        }

        public function minimize():Boolean
        {
            if ((_state & WindowState.var_1183))
            {
                return (false);
            };
            var _loc1_:WindowEvent = WindowEvent.allocate(WindowEvent.var_590, this, null);
            this.update(this, _loc1_);
            if (_loc1_.isDefaultPrevented())
            {
                _loc1_.recycle();
                return (false);
            };
            _loc1_.recycle();
            this.setStateFlag(WindowState.var_1183, true);
            _loc1_ = WindowEvent.allocate(WindowEvent.var_591, this, null);
            this.update(this, _loc1_);
            _loc1_.recycle();
            return (true);
        }

        public function maximize():Boolean
        {
            if ((_state & WindowState.var_1183))
            {
                return (false);
            };
            var _loc1_:WindowEvent = WindowEvent.allocate(WindowEvent.var_592, this, null);
            this.update(this, _loc1_);
            if (_loc1_.isDefaultPrevented())
            {
                _loc1_.recycle();
                return (false);
            };
            _loc1_.recycle();
            this.setStateFlag(WindowState.var_1183, true);
            _loc1_ = WindowEvent.allocate(WindowEvent.var_593, this, null);
            this.update(this, _loc1_);
            _loc1_.recycle();
            return (true);
        }

        public function restore():Boolean
        {
            var _loc1_:WindowEvent = WindowEvent.allocate(WindowEvent.var_594, this, null);
            this.update(this, _loc1_);
            if (_loc1_.isDefaultPrevented())
            {
                _loc1_.recycle();
                return (false);
            };
            _loc1_.recycle();
            this.setStateFlag(WindowState.var_1183, false);
            _loc1_ = WindowEvent.allocate(WindowEvent.var_595, this, null);
            this.update(this, _loc1_);
            _loc1_.recycle();
            return (true);
        }

        public function activate():Boolean
        {
            var _loc1_:WindowEvent = WindowEvent.allocate(WindowEvent.var_571, this, null);
            this.update(this, _loc1_);
            if (_loc1_.isDefaultPrevented())
            {
                _loc1_.recycle();
                return (false);
            };
            _loc1_.recycle();
            this.setStateFlag(WindowState.var_743, true);
            _loc1_ = WindowEvent.allocate(WindowEvent.var_572, this, null);
            this.update(this, _loc1_);
            _loc1_.recycle();
            return (true);
        }

        public function deactivate():Boolean
        {
            if (!this.getStateFlag(WindowState.var_743))
            {
                return (true);
            };
            var _loc1_:WindowEvent = WindowEvent.allocate(WindowEvent.var_573, this, null);
            this.update(this, _loc1_);
            if (_loc1_.isDefaultPrevented())
            {
                _loc1_.recycle();
                return (false);
            };
            _loc1_.recycle();
            this.setStateFlag(WindowState.var_743, false);
            _loc1_ = WindowEvent.allocate(WindowEvent.var_574, this, null);
            this.update(this, _loc1_);
            _loc1_.recycle();
            return (true);
        }

        public function lock():Boolean
        {
            if (this.getStateFlag(WindowState.var_1183))
            {
                return (true);
            };
            var _loc1_:WindowEvent = WindowEvent.allocate(WindowEvent.var_579, this, null);
            this.update(this, _loc1_);
            if (_loc1_.isDefaultPrevented())
            {
                _loc1_.recycle();
                return (false);
            };
            _loc1_.recycle();
            this.setStateFlag(WindowState.var_1183, true);
            _loc1_ = WindowEvent.allocate(WindowEvent.var_580, this, null);
            this.update(this, _loc1_);
            _loc1_.recycle();
            return (true);
        }

        public function unlock():Boolean
        {
            if (!this.getStateFlag(WindowState.var_1183))
            {
                return (true);
            };
            var _loc1_:WindowEvent = WindowEvent.allocate(WindowEvent.var_581, this, null);
            this.update(this, _loc1_);
            if (_loc1_.isDefaultPrevented())
            {
                _loc1_.recycle();
                return (false);
            };
            _loc1_.recycle();
            this.setStateFlag(WindowState.var_1183, false);
            _loc1_ = WindowEvent.allocate(WindowEvent.var_582, this, null);
            this.update(this, _loc1_);
            _loc1_.recycle();
            return (true);
        }

        public function enable():Boolean
        {
            if (!this.getStateFlag(WindowState.var_1184))
            {
                return (true);
            };
            var _loc1_:WindowEvent = WindowEvent.allocate(WindowEvent.var_583, this, null);
            this.update(this, _loc1_);
            if (_loc1_.isDefaultPrevented())
            {
                _loc1_.recycle();
                return (false);
            };
            _loc1_.recycle();
            this.setStateFlag(WindowState.var_1184, false);
            _loc1_ = WindowEvent.allocate(WindowEvent.var_584, this, null);
            this.update(this, _loc1_);
            _loc1_.recycle();
            return (true);
        }

        public function disable():Boolean
        {
            if (this.getStateFlag(WindowState.var_1184))
            {
                return (true);
            };
            var _loc1_:WindowEvent = WindowEvent.allocate(WindowEvent.var_585, this, null);
            this.update(this, _loc1_);
            if (_loc1_.isDefaultPrevented())
            {
                _loc1_.recycle();
                return (false);
            };
            _loc1_.recycle();
            this.setStateFlag(WindowState.var_1184, true);
            _loc1_ = WindowEvent.allocate(WindowEvent.var_586, this, null);
            this.update(this, _loc1_);
            _loc1_.recycle();
            return (true);
        }

        public function focus():Boolean
        {
            if (this.getStateFlag(WindowState.var_1188))
            {
                return (true);
            };
            var _loc1_:WindowEvent = WindowEvent.allocate(WindowEvent.var_567, this, null);
            this.update(this, _loc1_);
            if (_loc1_.isDefaultPrevented())
            {
                _loc1_.recycle();
                return (false);
            };
            _loc1_.recycle();
            this.setStateFlag(WindowState.var_1188, true);
            _loc1_ = WindowEvent.allocate(WindowEvent.var_568, this, null);
            this.update(this, _loc1_);
            _loc1_.recycle();
            return (true);
        }

        public function unfocus():Boolean
        {
            if (!this.getStateFlag(WindowState.var_1188))
            {
                return (true);
            };
            var _loc1_:WindowEvent = WindowEvent.allocate(WindowEvent.var_569, this, null);
            this.update(this, _loc1_);
            if (_loc1_.isDefaultPrevented())
            {
                _loc1_.recycle();
                return (false);
            };
            _loc1_.recycle();
            this.setStateFlag(WindowState.var_1188, false);
            _loc1_ = WindowEvent.allocate(WindowEvent.var_570, this, null);
            this.update(this, _loc1_);
            _loc1_.recycle();
            return (true);
        }

        public function getChildUnderPoint(param1:Point):IWindow
        {
            var _loc2_:Rectangle;
            var _loc3_:Boolean;
            var _loc4_:IWindow;
            var _loc5_:uint;
            if (var_1169)
            {
                _loc2_ = new Rectangle();
                this.getMouseRegion(_loc2_);
                _loc3_ = _loc2_.containsPoint(param1);
                _loc5_ = this.numChildren;
                if (_loc3_)
                {
                    while (_loc5_ > 0)
                    {
                        _loc4_ = WindowController(this._children[(_loc5_ - 1)]).getChildUnderPoint(param1);
                        if (_loc4_ != null)
                        {
                            return (_loc4_);
                        };
                        _loc5_--;
                    };
                };
                if (this.validateGlobalPointIntersection(param1, null))
                {
                    return (this);
                };
            };
            return (null);
        }

        public function groupChildrenUnderPoint(param1:Point, param2:Array):void
        {
            var _loc3_:WindowController;
            if (var_1169)
            {
                if (var_1202.containsPoint(param1))
                {
                    param2.push(this);
                    param1.offset(-(var_1202.x), -(var_1202.y));
                    for each (_loc3_ in this._children)
                    {
                        _loc3_.groupChildrenUnderPoint(param1, param2);
                    };
                    param1.offset(var_1202.x, var_1202.y);
                }
                else
                {
                    if (!var_1208)
                    {
                        param1.offset(-(var_1202.x), -(var_1202.y));
                        for each (_loc3_ in this._children)
                        {
                            _loc3_.groupChildrenUnderPoint(param1, param2);
                        };
                        param1.offset(var_1202.x, var_1202.y);
                    };
                };
            };
        }

        public function groupParameterFilteredChildrenUnderPoint(param1:Point, param2:Array, param3:uint=0):void
        {
            var _loc4_:WindowController;
            if (var_1169)
            {
                if (var_1202.containsPoint(param1))
                {
                    if ((var_1198 & param3) == param3)
                    {
                        param2.push(this);
                    };
                    param1.offset(-(var_1202.x), -(var_1202.y));
                    for each (_loc4_ in this._children)
                    {
                        _loc4_.groupParameterFilteredChildrenUnderPoint(param1, param2, param3);
                    };
                    param1.offset(var_1202.x, var_1202.y);
                }
                else
                {
                    if (!var_1208)
                    {
                        param1.offset(-(var_1202.x), -(var_1202.y));
                        for each (_loc4_ in this._children)
                        {
                            _loc4_.groupParameterFilteredChildrenUnderPoint(param1, param2, param3);
                        };
                        param1.offset(var_1202.x, var_1202.y);
                    };
                };
            };
        }

        public function addEventListener(param1:String, param2:Function, param3:int=0):void
        {
            if (!_disposed)
            {
                if (!this._events)
                {
                    this._events = new WindowEventDispatcher(this);
                };
                this._events.addEventListener(param1, param2, param3);
            };
        }

        public function hasEventListener(param1:String):Boolean
        {
            return (((_disposed) || (!(this._events))) ? false : this._events.hasEventListener(param1));
        }

        public function removeEventListener(param1:String, param2:Function):void
        {
            if (((!(_disposed)) && (this._events)))
            {
                this._events.removeEventListener(param1, param2);
            };
        }

        public function get numChildren():int
        {
            return (this._children.length);
        }

        public function populate(param1:Array):void
        {
            var _loc3_:WindowController;
            var _loc2_:Boolean;
            for each (_loc3_ in param1)
            {
                if (((_loc3_) && (!(_loc3_.parent == this))))
                {
                    this._children.push(_loc3_);
                    _loc3_.parent = this;
                    _loc2_ = ((_loc2_) || (_loc3_.hasGraphicsContext()));
                };
            };
            if (((this.var_2818) || (_loc2_)))
            {
                this.setupGraphicsContext();
            };
        }

        public function addChild(param1:IWindow):IWindow
        {
            var _loc2_:WindowController = WindowController(param1);
            if (_loc2_.parent != null)
            {
                WindowController(_loc2_.parent).removeChild(_loc2_);
            };
            this._children.push(_loc2_);
            _loc2_.parent = this;
            if (((this.var_2818) || (_loc2_.hasGraphicsContext())))
            {
                this.setupGraphicsContext();
                if (_loc2_.getGraphicContext(true).parent != this.var_1252)
                {
                    this.var_1252.addChildContext(_loc2_.getGraphicContext(true));
                };
            };
            var _loc3_:WindowEvent = WindowEvent.allocate(WindowEvent.var_596, this, param1);
            this.update(this, _loc3_);
            _loc3_.recycle();
            return (param1);
        }

        public function addChildAt(param1:IWindow, param2:int):IWindow
        {
            var _loc3_:WindowController = WindowController(param1);
            if (_loc3_.parent != null)
            {
                WindowController(_loc3_.parent).removeChild(_loc3_);
            };
            this._children.splice(param2, 0, _loc3_);
            _loc3_.parent = this;
            if (((this.var_2818) || (_loc3_.hasGraphicsContext())))
            {
                this.setupGraphicsContext();
                if (_loc3_.getGraphicContext(true).parent != this.var_1252)
                {
                    this.var_1252.addChildContextAt(_loc3_.getGraphicContext(true), param2);
                };
            };
            var _loc4_:WindowEvent = WindowEvent.allocate(WindowEvent.var_596, this, param1);
            this.update(this, _loc4_);
            _loc4_.recycle();
            return (param1);
        }

        public function getChildAt(param1:int):IWindow
        {
            return (this._children[param1] as IWindow);
        }

        public function getChildByID(param1:uint):IWindow
        {
            var _loc2_:IWindow;
            for each (_loc2_ in this._children)
            {
                if (_loc2_.id == param1)
                {
                    return (_loc2_);
                };
            };
            return (null);
        }

        public function getChildByName(param1:String):IWindow
        {
            var _loc2_:IWindow;
            for each (_loc2_ in this._children)
            {
                if (_loc2_.name == param1)
                {
                    return (_loc2_);
                };
            };
            return (null);
        }

        public function findChildByName(param1:String):IWindow
        {
            var _loc2_:WindowController;
            for each (_loc2_ in this._children)
            {
                if (_loc2_.name == param1)
                {
                    return (_loc2_);
                };
            };
            for each (_loc2_ in this._children)
            {
                _loc2_ = (_loc2_.findChildByName(param1) as WindowController);
                if (_loc2_)
                {
                    return (_loc2_ as IWindow);
                };
            };
            return (null);
        }

        public function getChildByTag(param1:String):IWindow
        {
            var _loc2_:IWindow;
            for each (_loc2_ in this._children)
            {
                if (_loc2_.tags.indexOf(param1) > -1)
                {
                    return (_loc2_);
                };
            };
            return (null);
        }

        public function findChildByTag(param1:String):IWindow
        {
            if (var_1209.indexOf(param1) > -1)
            {
                return (this);
            };
            var _loc2_:WindowController = WindowController(this.getChildByTag(param1));
            if (_loc2_ == null)
            {
                for each (_loc2_ in this._children)
                {
                    _loc2_ = (_loc2_.findChildByTag(param1) as WindowController);
                    if (_loc2_ != null) break;
                };
            };
            return (_loc2_ as IWindow);
        }

        public function getChildIndex(param1:IWindow):int
        {
            return (this._children.indexOf(param1));
        }

        public function removeChild(param1:IWindow):IWindow
        {
            var _loc2_:int = this._children.indexOf(param1);
            if (_loc2_ < 0)
            {
                return (null);
            };
            this._children.splice(_loc2_, 1);
            var _loc3_:WindowController = WindowController(param1);
            _loc3_.parent = null;
            if (_loc3_.hasGraphicsContext())
            {
                this.var_1252.removeChildContext(_loc3_.getGraphicContext(true));
            };
            var _loc4_:WindowEvent = WindowEvent.allocate(WindowEvent.var_597, this, param1);
            this.update(this, _loc4_);
            _loc4_.recycle();
            return (param1);
        }

        public function removeChildAt(param1:int):IWindow
        {
            return (this.removeChild(this.getChildAt(param1)));
        }

        public function setChildIndex(param1:IWindow, param2:int):void
        {
            var _loc4_:WindowController;
            var _loc3_:int = this._children.indexOf(param1);
            if (((_loc3_ > -1) && (!(param2 == _loc3_))))
            {
                this._children.splice(_loc3_, 1);
                this._children.splice(param2, 0, param1);
                _loc4_ = WindowController(param1);
                if (_loc4_.hasGraphicsContext())
                {
                    this.var_1252.setChildContextIndex(_loc4_.getGraphicContext(true), this.getChildIndex(_loc4_));
                };
            };
        }

        public function swapChildren(param1:IWindow, param2:IWindow):void
        {
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:IWindow;
            var _loc6_:int;
            if ((((!(param1 == null)) && (!(param2 == null))) && (!(param1 == param2))))
            {
                _loc3_ = this._children.indexOf(param1);
                if (_loc3_ < 0)
                {
                    return;
                };
                _loc4_ = this._children.indexOf(param2);
                if (_loc4_ < 0)
                {
                    return;
                };
                if (_loc4_ < _loc3_)
                {
                    _loc5_ = param1;
                    param1 = param2;
                    param2 = _loc5_;
                    _loc6_ = _loc3_;
                    _loc3_ = _loc4_;
                    _loc4_ = _loc6_;
                };
                this._children.splice(_loc4_, 1);
                this._children.splice(_loc3_, 1);
                this._children.splice(_loc3_, 0, param2);
                this._children.splice(_loc4_, 0, param1);
                if (((WindowController(param1).hasGraphicsContext()) || (WindowController(param2).hasGraphicsContext())))
                {
                    this.var_1252.swapChildContexts(WindowController(param1).getGraphicContext(true), WindowController(param2).getGraphicContext(true));
                };
            };
        }

        public function swapChildrenAt(param1:int, param2:int):void
        {
            this.swapChildren(this._children[param1], this._children[param2]);
            this.var_1252.swapChildContextsAt(param1, param2);
        }

        public function groupChildrenWithID(param1:uint, param2:Array, param3:Boolean=false):uint
        {
            var _loc4_:WindowController;
            var _loc5_:uint;
            for each (_loc4_ in this._children)
            {
                if (_loc4_.id == param1)
                {
                    param2.push(_loc4_);
                    _loc5_++;
                };
                if (param3)
                {
                    _loc5_ = (_loc5_ + _loc4_.groupChildrenWithID(param1, param2, param3));
                };
            };
            return (_loc5_);
        }

        public function groupChildrenWithTag(param1:String, param2:Array, param3:Boolean=false):uint
        {
            var _loc4_:WindowController;
            var _loc5_:uint;
            for each (_loc4_ in this._children)
            {
                if (_loc4_.tags.indexOf(param1) > -1)
                {
                    param2.push(_loc4_);
                    _loc5_++;
                };
                if (param3)
                {
                    _loc5_ = (_loc5_ + _loc4_.groupChildrenWithTag(param1, param2, param3));
                };
            };
            return (_loc5_);
        }

        public function findParentByName(param1:String):IWindow
        {
            if (_name == param1)
            {
                return (this);
            };
            if (this._parent != null)
            {
                if (this._parent.name == param1)
                {
                    return (this._parent);
                };
                return (this._parent.findParentByName(param1));
            };
            return (null);
        }

        protected function requiresOwnGraphicContext():Boolean
        {
            var _loc1_:WindowController;
            if (testParamFlag(WindowParam.var_713))
            {
                for each (_loc1_ in this._children)
                {
                    if (_loc1_.requiresOwnGraphicContext())
                    {
                        return (true);
                    };
                };
                return (false);
            };
            return (true);
        }


    }
}