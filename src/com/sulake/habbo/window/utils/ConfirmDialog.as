package com.sulake.habbo.window.utils
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindow;

    public class ConfirmDialog extends AlertDialog implements IConfirmDialog 
    {

        public function ConfirmDialog(param1:IHabboWindowManager, param2:XML, param3:String, param4:String, param5:uint, param6:Function)
        {
            super(param1, param2, param3, param4, param5, param6);
        }

        override protected function dialogEventProc(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:WindowEvent;
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                switch (param2.name)
                {
                    case var_1096:
                        if (var_1166 != null)
                        {
                            _loc3_ = WindowEvent.allocate(WindowEvent.var_131, null, null);
                            var_1166(this, _loc3_);
                            _loc3_.recycle();
                        };
                        return;
                    case var_1097:
                    case var_1101:
                        if (var_1166 != null)
                        {
                            _loc3_ = WindowEvent.allocate(WindowEvent.var_132, null, null);
                            var_1166(this, _loc3_);
                            _loc3_.recycle();
                        };
                        return;
                };
            };
        }


    }
}