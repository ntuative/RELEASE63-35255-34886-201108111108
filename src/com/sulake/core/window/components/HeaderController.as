package com.sulake.core.window.components
{
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;

    public class HeaderController extends ContainerController implements IHeaderWindow 
    {

        private static const var_2063:String = "_TITLE";
        private static const var_2064:String = "_CONTROLS";

        public function HeaderController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function=null, param9:Array=null, param10:Array=null, param11:uint=0)
        {
            param4 = (param4 | WindowParam.var_609);
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
        }

        public function get title():ILabelWindow
        {
            return (findChildByTag(var_2063) as ILabelWindow);
        }

        public function get controls():IItemListWindow
        {
            return (findChildByTag(var_2064) as IItemListWindow);
        }

        override public function set caption(value:String):void
        {
            super.caption = value;
            try
            {
                this.title.text = value;
            }
            catch(e:Error)
            {
                Logger.log("Header contains no title element!");
            };
        }

        override public function set color(param1:uint):void
        {
            var _loc3_:IWindow;
            super.color = param1;
            var _loc2_:Array = new Array();
            groupChildrenWithTag(var_2065, _loc2_, true);
            for each (_loc3_ in _loc2_)
            {
                _loc3_.color = param1;
            };
        }


    }
}