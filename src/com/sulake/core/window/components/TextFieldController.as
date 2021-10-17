package com.sulake.core.window.components
{
    import com.sulake.core.window.enum.WindowParam;
    import flash.text.TextField;
    import flash.events.KeyboardEvent;
    import flash.events.Event;
    import flash.events.FocusEvent;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import flash.text.TextFieldType;
    import com.sulake.core.window.graphics.GraphicContext;
    import com.sulake.core.window.graphics.IGraphicContext;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.WindowController;
    import flash.geom.Point;
    import flash.text.TextFieldAutoSize;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.utils.PropertyDefaults;

    public class TextFieldController extends TextController implements ITextFieldWindow 
    {

        protected var var_2678:uint = 500;
        protected var var_2677:String = "";
        protected var var_2715:Boolean = false;
        protected var var_2709:Boolean = false;

        public function TextFieldController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function, param9:Array=null, param10:Array=null, param11:uint=0)
        {
            param4 = (param4 & (~(WindowParam.var_713)));
            param4 = (param4 | WindowParam.var_609);
            var_1202 = param6;
            _field = TextField(this.getGraphicContext(true).getDisplayObject());
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
            _field.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDownEvent);
            _field.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUpEvent);
            _field.addEventListener(Event.CHANGE, this.onChangeEvent);
            _field.addEventListener(FocusEvent.FOCUS_IN, this.onFocusEvent);
            _field.addEventListener(FocusEvent.FOCUS_OUT, this.onFocusEvent);
            _field.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedEvent);
            var_2666 = false;
            this.var_2709 = true;
        }

        public function get focused():Boolean
        {
            if (_field)
            {
                if (_field.stage)
                {
                    return (_field.stage.focus == _field);
                };
            };
            return (false);
        }

        override public function enable():Boolean
        {
            if (super.enable())
            {
                _field.type = TextFieldType.INPUT;
                return (true);
            };
            _field.type = TextFieldType.DYNAMIC;
            return (false);
        }

        override public function disable():Boolean
        {
            if (super.disable())
            {
                _field.type = TextFieldType.DYNAMIC;
                return (true);
            };
            _field.type = TextFieldType.INPUT;
            return (false);
        }

        public function get editable():Boolean
        {
            return (_field.type == TextFieldType.INPUT);
        }

        public function set editable(param1:Boolean):void
        {
            _field.type = ((param1) ? TextFieldType.INPUT : TextFieldType.DYNAMIC);
        }

        public function get selectable():Boolean
        {
            return (_field.selectable);
        }

        public function set selectable(param1:Boolean):void
        {
            _field.selectable = param1;
        }

        public function set displayAsPassword(param1:Boolean):void
        {
            _field.displayAsPassword = param1;
        }

        public function get displayAsPassword():Boolean
        {
            return (_field.displayAsPassword);
        }

        public function set mouseCursorType(param1:uint):void
        {
        }

        public function get mouseCursorType():uint
        {
            return (0);
        }

        public function set toolTipCaption(param1:String):void
        {
            this.var_2677 = ((param1 == null) ? "" : param1);
        }

        public function get toolTipCaption():String
        {
            return (this.var_2677);
        }

        public function set toolTipDelay(param1:uint):void
        {
            this.var_2678 = param1;
        }

        public function get toolTipDelay():uint
        {
            return (this.var_2678);
        }

        public function setMouseCursorForState(param1:uint, param2:uint):uint
        {
            throw (new Error("Unimplemented method!"));
        }

        public function getMouseCursorByState(param1:uint):uint
        {
            throw (new Error("Unimplemented method!"));
        }

        public function showToolTip(param1:IToolTipWindow):void
        {
            throw (new Error("Unimplemented method!"));
        }

        public function hideToolTip():void
        {
            throw (new Error("Unimplemented method!"));
        }

        override public function set autoSize(param1:String):void
        {
            super.autoSize = param1;
            this.refreshAutoSize();
        }

        override public function set background(param1:Boolean):void
        {
            _field.background = param1;
            var_1200 = param1;
            var_1201 = ((var_1200) ? (var_1201 | var_1203) : (var_1201 & 0xFFFFFF));
        }

        public function setSelection(param1:int, param2:int):void
        {
            _field.setSelection(param1, param2);
        }

        public function get selectionBeginIndex():int
        {
            return (_field.selectionBeginIndex);
        }

        public function get selectionEndIndex():int
        {
            return (_field.selectionEndIndex);
        }

        override public function getGraphicContext(param1:Boolean):IGraphicContext
        {
            if (((param1) && (!(var_1252))))
            {
                var_1252 = new GraphicContext((("GC {" + _name) + "}"), GraphicContext.GC_TYPE_TEXTFIELD, var_1202);
            };
            return (var_1252);
        }

        override public function dispose():void
        {
            _context.getWindowServices().getFocusManagerService().removeFocusWindow(this);
            this.var_2715 = false;
            if (_field)
            {
                if (this.focused)
                {
                    this.unfocus();
                };
                _field.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDownEvent);
                _field.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUpEvent);
                _field.removeEventListener(Event.CHANGE, this.onChangeEvent);
                _field.removeEventListener(FocusEvent.FOCUS_IN, this.onFocusEvent);
                _field.removeEventListener(FocusEvent.FOCUS_OUT, this.onFocusEvent);
                _field.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedEvent);
            };
            super.dispose();
        }

        override public function set text(param1:String):void
        {
            super.text = param1;
            this.refreshAutoSize();
        }

        override public function focus():Boolean
        {
            var _loc1_:Boolean = super.focus();
            if (_loc1_)
            {
                if (_field)
                {
                    if (_field.stage)
                    {
                        if (_field.stage.focus != _field)
                        {
                            _field.stage.focus = _field;
                        };
                    };
                };
            };
            return (_loc1_);
        }

        override public function unfocus():Boolean
        {
            if (_field)
            {
                if (_field.stage)
                {
                    if (_field.stage.focus == _field)
                    {
                        _field.stage.focus = null;
                    };
                };
            };
            return (super.unfocus());
        }

        override public function update(param1:WindowController, param2:WindowEvent):Boolean
        {
            var _loc3_:Boolean = super.update(param1, param2);
            switch (param2.type)
            {
                case WindowEvent.var_571:
                case WindowMouseEvent.var_650:
                    this.focus();
                    break;
                case WindowEvent.var_589:
                    if (param1 == this)
                    {
                        _field.width = this.width;
                        _field.height = this.height;
                    };
                    break;
            };
            if (param1 == this)
            {
                InteractiveController.processInteractiveWindowEvents(this, param2);
            };
            return (_loc3_);
        }

        protected function refreshAutoSize():void
        {
            var _loc1_:Point;
            var _loc2_:Point;
            var _loc3_:Point;
            if (((this.var_2709) && (!(autoSize == TextFieldAutoSize.NONE))))
            {
                if (((!(var_1202.width == _field.width)) || (!(var_1202.height == _field.height))))
                {
                    _loc1_ = _field.localToGlobal(new Point(_field.x, _field.y));
                    _loc2_ = new Point();
                    getGlobalPosition(_loc2_);
                    _loc3_ = new Point((_loc1_.x - _loc2_.x), (_loc1_.y - _loc2_.y));
                    setRectangle((var_1202.x + _loc3_.x), (var_1202.y + _loc3_.y), _field.width, _field.height);
                };
            };
        }

        override protected function refreshTextImage(param1:Boolean=false):void
        {
            var _loc3_:WindowEvent;
            var _loc2_:Boolean;
            if (var_1202.width != _field.width)
            {
                if (autoSize != TextFieldAutoSize.NONE)
                {
                    width = _field.width;
                    _loc2_ = true;
                }
                else
                {
                    _field.width = width;
                };
            };
            if (var_1202.height != _field.height)
            {
                if (autoSize != TextFieldAutoSize.NONE)
                {
                    height = _field.height;
                    _loc2_ = true;
                }
                else
                {
                    _field.height = height;
                };
            };
            if ((((!(_loc2_)) && (!(param1))) && (_events)))
            {
                _loc3_ = WindowEvent.allocate(WindowEvent.var_589, this, null);
                _events.dispatchEvent(_loc3_);
                _loc3_.recycle();
            };
        }

        private function onKeyDownEvent(event:KeyboardEvent):void
        {
            var windowEvent:WindowKeyboardEvent;
            try
            {
                windowEvent = WindowKeyboardEvent.allocate(WindowKeyboardEvent.var_1253, event, this, null);
                this.update(this, windowEvent);
                windowEvent.recycle();
            }
            catch(e:Error)
            {
                _context.handleError(WindowContext.var_1111, e);
            };
        }

        private function onKeyUpEvent(event:KeyboardEvent):void
        {
            var windowEvent:WindowKeyboardEvent;
            try
            {
                var_1214 = _field.text;
                windowEvent = WindowKeyboardEvent.allocate(WindowKeyboardEvent.var_744, event, this, null);
                this.update(this, windowEvent);
                windowEvent.recycle();
            }
            catch(e:Error)
            {
                _context.handleError(WindowContext.var_1111, e);
            };
        }

        private function onChangeEvent(event:Event):void
        {
            var windowEvent:WindowEvent;
            try
            {
                this.refreshAutoSize();
                windowEvent = WindowEvent.allocate(WindowEvent.var_606, this, null);
                this.update(this, windowEvent);
                windowEvent.recycle();
            }
            catch(e:Error)
            {
                _context.handleError(WindowContext.var_1111, e);
            };
        }

        private function onFocusEvent(event:FocusEvent):void
        {
            try
            {
                if (event.type == FocusEvent.FOCUS_IN)
                {
                    if (!getStateFlag(WindowState.var_1188))
                    {
                        this.focus();
                    };
                }
                else
                {
                    if (event.type == FocusEvent.FOCUS_OUT)
                    {
                        if (getStateFlag(WindowState.var_1188))
                        {
                            this.unfocus();
                        };
                    };
                };
            }
            catch(e:Error)
            {
                _context.handleError(WindowContext.var_1111, e);
            };
        }

        private function onRemovedEvent(event:Event):void
        {
            try
            {
                if (getStateFlag(WindowState.var_1188))
                {
                    this.unfocus();
                };
            }
            catch(e:Error)
            {
                _context.handleError(WindowContext.var_1111, e);
            };
        }

        override public function get properties():Array
        {
            var _loc1_:Array = InteractiveController.writeInteractiveWindowProperties(this, super.properties);
            _loc1_.push(((_field.type == TextFieldType.DYNAMIC) ? new PropertyStruct(PropertyDefaults.var_1254, false, PropertyStruct.var_634, true) : PropertyDefaults.var_1255));
            _loc1_.push(((this.var_2715 != PropertyDefaults.var_1256) ? new PropertyStruct(PropertyDefaults.var_1257, this.var_2715, PropertyStruct.var_634, true) : PropertyDefaults.var_1258));
            _loc1_.push(((_field.selectable != PropertyDefaults.var_1259) ? new PropertyStruct(PropertyDefaults.var_1260, _field.selectable, PropertyStruct.var_634, true) : PropertyDefaults.var_1261));
            _loc1_.push(((_field.displayAsPassword != PropertyDefaults.var_1262) ? new PropertyStruct("display_as_password", _field.displayAsPassword, PropertyStruct.var_634, true) : PropertyDefaults.var_1263));
            return (_loc1_);
        }

        override public function set properties(param1:Array):void
        {
            var _loc2_:PropertyStruct;
            InteractiveController.readInteractiveWindowProperties(this, param1);
            for each (_loc2_ in param1)
            {
                switch (_loc2_.key)
                {
                    case PropertyDefaults.var_1257:
                        this.var_2715 = (_loc2_.value as Boolean);
                        if (this.var_2715)
                        {
                            _context.getWindowServices().getFocusManagerService().registerFocusWindow(this);
                        };
                        break;
                    case PropertyDefaults.var_1260:
                        _field.selectable = (_loc2_.value as Boolean);
                        break;
                    case PropertyDefaults.var_1254:
                        _field.type = ((_loc2_.value) ? TextFieldType.INPUT : TextFieldType.DYNAMIC);
                        break;
                    case PropertyDefaults.var_1264:
                        _field.displayAsPassword = (_loc2_.value as Boolean);
                        break;
                };
            };
            super.properties = param1;
        }


    }
}