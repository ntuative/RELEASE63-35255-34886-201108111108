package com.sulake.habbo.window.utils
{
    import com.sulake.core.window.utils.INotify;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.window.enum.HabboAlertDialogFlag;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IInteractiveWindow;
    import com.sulake.core.window.components.ITextWindow;

    public class AlertDialog implements IAlertDialog, INotify 
    {

        protected static const var_1095:String = "_alert_button_list";
        protected static const var_1096:String = "_alert_button_ok";
        protected static const var_1097:String = "_alert_button_cancel";
        protected static const var_1098:String = "_alert_button_custom";
        protected static const var_1101:String = "header_button_close";
        protected static const var_1100:String = "_alert_text_summary";
        private static var var_1094:uint = 0;

        protected var _title:String = "";
        protected var var_3782:String = "";
        protected var _disposed:Boolean = false;
        protected var var_1166:Function = null;
        protected var _window:IFrameWindow;

        public function AlertDialog(param1:IHabboWindowManager, param2:XML, param3:String, param4:String, param5:uint, param6:Function)
        {
            var _loc8_:IWindow;
            super();
            var_1094++;
            this._window = (param1.buildFromXML(param2, 2) as IFrameWindow);
            if (param5 == HabboAlertDialogFlag.var_157)
            {
                param5 = ((HabboAlertDialogFlag.var_1096 | HabboAlertDialogFlag.var_1099) | HabboAlertDialogFlag.var_1100);
            };
            var _loc7_:IItemListWindow = (this._window.findChildByName(var_1095) as IItemListWindow);
            if (_loc7_)
            {
                if (!(param5 & HabboAlertDialogFlag.var_1096))
                {
                    _loc8_ = _loc7_.getListItemByName(var_1096);
                    _loc8_.dispose();
                };
                if (!(param5 & HabboAlertDialogFlag.var_1097))
                {
                    _loc8_ = _loc7_.getListItemByName(var_1097);
                    _loc8_.dispose();
                };
                if (!(param5 & HabboAlertDialogFlag.var_1098))
                {
                    _loc8_ = _loc7_.getListItemByName(var_1098);
                    _loc8_.dispose();
                };
            };
            this._window.procedure = this.dialogEventProc;
            this._window.center();
            this.title = param3;
            this.summary = param4;
            this.callback = param6;
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                if (((this._window) && (!(this._window.disposed))))
                {
                    this._window.dispose();
                    this._window = null;
                };
                this.var_1166 = null;
                this._disposed = true;
            };
        }

        protected function dialogEventProc(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:WindowEvent;
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                switch (param2.name)
                {
                    case var_1096:
                        if (this.var_1166 != null)
                        {
                            _loc3_ = WindowEvent.allocate(WindowEvent.var_131, null, null);
                            this.var_1166(this, _loc3_);
                            _loc3_.recycle();
                        }
                        else
                        {
                            this.dispose();
                        };
                        return;
                    case var_1101:
                        if (this.var_1166 != null)
                        {
                            _loc3_ = WindowEvent.allocate(WindowEvent.var_132, null, null);
                            this.var_1166(this, _loc3_);
                            _loc3_.recycle();
                        }
                        else
                        {
                            this.dispose();
                        };
                        return;
                };
            };
        }

        public function getButtonCaption(param1:int):ICaption
        {
            var _loc2_:IInteractiveWindow;
            if (!this._disposed)
            {
                switch (param1)
                {
                    case HabboAlertDialogFlag.var_1096:
                        _loc2_ = (this._window.findChildByName(var_1096) as IInteractiveWindow);
                        break;
                    case HabboAlertDialogFlag.var_1097:
                        _loc2_ = (this._window.findChildByName(var_1097) as IInteractiveWindow);
                        break;
                    case HabboAlertDialogFlag.var_1098:
                        _loc2_ = (this._window.findChildByName(var_1098) as IInteractiveWindow);
                        break;
                };
            };
            return ((_loc2_) ? new AlertDialogCaption(_loc2_.caption, _loc2_.toolTipCaption, _loc2_.visible) : null);
        }

        public function setButtonCaption(param1:int, param2:ICaption):void
        {
        }

        public function set title(param1:String):void
        {
            this._title = param1;
            if (this._window)
            {
                this._window.caption = this._title;
            };
        }

        public function get title():String
        {
            return (this._title);
        }

        public function set summary(param1:String):void
        {
            this.var_3782 = param1;
            if (this._window)
            {
                ITextWindow(this._window.findChildByTag("DESCRIPTION")).text = this.var_3782;
            };
        }

        public function get summary():String
        {
            return (this.var_3782);
        }

        public function set callback(param1:Function):void
        {
            this.var_1166 = param1;
        }

        public function get callback():Function
        {
            return (this.var_1166);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }


    }
}