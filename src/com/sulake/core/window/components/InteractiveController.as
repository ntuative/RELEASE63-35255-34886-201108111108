package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.utils.PropertyDefaults;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.enum.MouseCursorType;

    public class InteractiveController extends WindowController implements IInteractiveWindow 
    {

        protected var var_2678:uint = 500;
        protected var var_2677:String = "";
        protected var _cursorByState:Map;

        public function InteractiveController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function, param9:Array=null, param10:Array=null, param11:uint=0)
        {
            param4 = (param4 | WindowParam.var_609);
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
        }

        public static function processInteractiveWindowEvents(param1:IInteractiveWindow, param2:WindowEvent):void
        {
            if (param1.toolTipCaption != PropertyDefaults.var_2030)
            {
                if (param2.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
                {
                    param1.context.getWindowServices().getToolTipAgentService().begin(param1);
                }
                else
                {
                    if (param2.type != WindowMouseEvent.var_654)
                    {
                        if (param2.type == WindowMouseEvent.var_624)
                        {
                            param1.context.getWindowServices().getToolTipAgentService().end(param1);
                        };
                    };
                };
            };
        }

        public static function readInteractiveWindowProperties(param1:IInteractiveWindow, param2:Array):void
        {
            var _loc3_:PropertyStruct;
            for each (_loc3_ in param2)
            {
                switch (_loc3_.key)
                {
                    case PropertyDefaults.var_2029:
                        if (_loc3_.value != param1.toolTipCaption)
                        {
                            param1.toolTipCaption = (_loc3_.value as String);
                        };
                        break;
                    case PropertyDefaults.var_2031:
                        if (_loc3_.value != param1.toolTipDelay)
                        {
                            param1.toolTipDelay = (_loc3_.value as uint);
                        };
                        break;
                };
            };
        }

        public static function writeInteractiveWindowProperties(param1:IInteractiveWindow, param2:Array):Array
        {
            if (param1.toolTipCaption != PropertyDefaults.var_2030)
            {
                param2.push(new PropertyStruct(PropertyDefaults.var_2029, param1.toolTipCaption, PropertyStruct.var_636, true));
            }
            else
            {
                param2.push(PropertyDefaults.var_2050);
            };
            if (param1.toolTipDelay != PropertyDefaults.var_2032)
            {
                param2.push(new PropertyStruct(PropertyDefaults.var_2031, param1.toolTipDelay, PropertyStruct.var_631, true));
            }
            else
            {
                param2.push(PropertyDefaults.TOOL_TIP_DELAY);
            };
            return (param2);
        }


        public function set toolTipCaption(param1:String):void
        {
            this.var_2677 = ((param1 == null) ? PropertyDefaults.var_2030 : param1);
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
            if (!this._cursorByState)
            {
                this._cursorByState = new Map();
            };
            var _loc3_:uint = this._cursorByState[param1];
            if (((param2 == MouseCursorType.var_613) || (param2 == -1)))
            {
                this._cursorByState.remove(param1);
            }
            else
            {
                this._cursorByState[param1] = param2;
            };
            return (_loc3_);
        }

        public function getMouseCursorByState(param1:uint):uint
        {
            if (!this._cursorByState)
            {
                return (MouseCursorType.var_613);
            };
            return (this._cursorByState.getValue(param1));
        }

        override public function update(param1:WindowController, param2:WindowEvent):Boolean
        {
            if (param1 == this)
            {
                processInteractiveWindowEvents(this, param2);
            };
            return (super.update(param1, param2));
        }

        public function showToolTip(param1:IToolTipWindow):void
        {
        }

        public function hideToolTip():void
        {
        }

        override public function get properties():Array
        {
            return (writeInteractiveWindowProperties(this, super.properties));
        }

        override public function set properties(param1:Array):void
        {
            readInteractiveWindowProperties(this, param1);
            super.properties = param1;
        }


    }
}