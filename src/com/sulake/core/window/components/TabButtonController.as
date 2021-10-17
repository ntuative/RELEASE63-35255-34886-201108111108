package com.sulake.core.window.components
{
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.WindowController;

    public class TabButtonController extends SelectableController implements ITabButtonWindow 
    {

        private static const var_2705:String = "TAB_BUTTON_CONTENT";
        private static const var_2066:String = "TAB_BUTTON_TITLE";
        private static const var_2706:String = "TAB_BUTTON_ICON";

        public function TabButtonController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function=null, param9:Array=null, param10:Array=null, param11:uint=0)
        {
            param4 = (param4 | WindowParam.var_609);
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
        }

        override public function set caption(param1:String):void
        {
            super.caption = param1;
            var _loc2_:IWindow = findChildByTag(var_2066);
            if (_loc2_ != null)
            {
                _loc2_.caption = param1;
            };
        }

        override public function update(param1:WindowController, param2:WindowEvent):Boolean
        {
            if (param2.type == WindowEvent.var_599)
            {
                WindowController.resizeToAccommodateChildren(this);
            };
            return (super.update(param1, param2));
        }


    }
}