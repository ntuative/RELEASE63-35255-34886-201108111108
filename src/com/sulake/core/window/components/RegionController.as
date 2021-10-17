package com.sulake.core.window.components
{
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.MouseCursorType;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.events.WindowEvent;

    public class RegionController extends ContainerController implements IRegionWindow 
    {

        protected static const var_2693:String = "tool_tip_caption";
        protected static const var_2694:String = "";
        protected static const KEY_TOOLTIP_DELAY:String = "tool_tip_delay";
        protected static const var_2695:uint = 500;

        protected var var_2678:uint = 500;
        protected var var_2677:String = "";
        protected var _cursorByState:Map;

        public function RegionController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function=null, param9:Array=null, param10:Array=null, param11:uint=0)
        {
            param4 = (param4 | WindowParam.var_609);
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
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

        public function showToolTip(param1:IToolTipWindow):void
        {
        }

        public function hideToolTip():void
        {
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
            var _loc3_:Boolean = super.update(param1, param2);
            if (param1 == this)
            {
                InteractiveController.processInteractiveWindowEvents(this, param2);
            };
            return (_loc3_);
        }

        override public function get properties():Array
        {
            return (InteractiveController.writeInteractiveWindowProperties(this, super.properties));
        }

        override public function set properties(param1:Array):void
        {
            InteractiveController.readInteractiveWindowProperties(this, param1);
            super.properties = param1;
        }


    }
}