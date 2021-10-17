package com.sulake.core.window.utils
{
    import com.sulake.core.window.enum.WindowState;
    import flash.utils.Dictionary;

    public class StateCodeTable 
    {


        public static function fillTables(param1:Dictionary, param2:Dictionary=null):void
        {
            var _loc3_:String;
            param1["default"] = WindowState.var_1189;
            param1["active"] = WindowState.var_743;
            param1["focused"] = WindowState.var_1188;
            param1["hovering"] = WindowState.var_1187;
            param1["selected"] = WindowState.var_1186;
            param1["pressed"] = WindowState.var_1185;
            param1["disabled"] = WindowState.var_1184;
            param1["locked"] = WindowState.var_1183;
            if (param2 != null)
            {
                for (_loc3_ in param1)
                {
                    param2[param1[_loc3_]] = _loc3_;
                };
            };
        }


    }
}