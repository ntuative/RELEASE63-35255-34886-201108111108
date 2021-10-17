package com.sulake.core.window.services
{
    import com.sulake.core.window.utils.ChildEntityArrayReader;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.FocusEvent;
    import flash.display.DisplayObject;
    import com.sulake.core.window.components.IFocusWindow;
    import com.sulake.core.window.utils.*;

    public class FocusManager extends ChildEntityArrayReader implements IFocusManagerService 
    {

        private var _disposed:Boolean = false;
        private var var_1168:Stage;

        public function FocusManager(param1:DisplayObject)
        {
            this.var_1168 = param1.stage;
            this.var_1168.addEventListener(Event.ACTIVATE, this.onActivateEvent);
            this.var_1168.addEventListener(FocusEvent.FOCUS_OUT, this.onFocusEvent);
            this.var_1168.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, this.onFocusEvent);
            this.var_1168.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, this.onFocusEvent);
            super();
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this.var_1168.removeEventListener(Event.ACTIVATE, this.onActivateEvent);
                this.var_1168.removeEventListener(FocusEvent.FOCUS_OUT, this.onFocusEvent);
                this.var_1168.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE, this.onFocusEvent);
                this.var_1168.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, this.onFocusEvent);
                this.var_1168 = null;
                this._disposed = true;
                var_2493 = null;
            };
        }

        public function registerFocusWindow(param1:IFocusWindow):void
        {
            if (param1 != null)
            {
                if (var_2493.indexOf(param1) == -1)
                {
                    var_2493.push(param1);
                    if (this.var_1168.focus == null)
                    {
                        param1.focus();
                    };
                };
            };
        }

        public function removeFocusWindow(param1:IFocusWindow):void
        {
            var _loc2_:int;
            if (param1 != null)
            {
                _loc2_ = var_2493.indexOf(param1);
                if (_loc2_ > -1)
                {
                    var_2493.splice(_loc2_, 1);
                };
            };
            if (this.var_1168.focus == null)
            {
                this.resolveNextFocusTarget();
            };
        }

        private function resolveNextFocusTarget():IFocusWindow
        {
            var _loc2_:IFocusWindow;
            var _loc1_:uint = var_2493.length;
            while (_loc1_-- != 0)
            {
                _loc2_ = (var_2493[_loc1_] as IFocusWindow);
                if (_loc2_.disposed)
                {
                    var_2493.splice(_loc1_, 1);
                }
                else
                {
                    _loc2_.focus();
                    break;
                };
            };
            return (_loc2_);
        }

        private function onActivateEvent(param1:Event):void
        {
            if (this.var_1168.focus == null)
            {
                this.resolveNextFocusTarget();
            };
        }

        private function onFocusEvent(param1:FocusEvent):void
        {
            if (this.var_1168.focus == null)
            {
                this.resolveNextFocusTarget();
            };
        }


    }
}