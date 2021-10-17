package com.sulake.core.window.components
{
    import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;

    public class DropMenuItemController extends ButtonController implements IDropMenuItemWindow, ITouchAwareWindow 
    {

        public function DropMenuItemController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function, param9:Array=null, param10:Array=null, param11:uint=0)
        {
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
        }

        public function get menu():IDropMenuWindow
        {
            var _loc1_:IWindow = parent;
            while (_loc1_)
            {
                if ((_loc1_ is IDropMenuWindow)) break;
                _loc1_ = _loc1_.parent;
            };
            return (_loc1_ as IDropMenuWindow);
        }


    }
}