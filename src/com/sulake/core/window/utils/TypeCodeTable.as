package com.sulake.core.window.utils
{
    import com.sulake.core.window.enum.WindowType;
    import flash.utils.Dictionary;

    public class TypeCodeTable extends WindowType 
    {


        public static function fillTables(param1:Dictionary, param2:Dictionary=null):void
        {
            var _loc3_:String;
            param1["background"] = var_927;
            param1["badge"] = var_239;
            param1["bitmap"] = var_928;
            param1["border"] = var_934;
            param1["border_notify"] = var_1127;
            param1["bubble"] = var_907;
            param1["bubble_pointer_up"] = var_1132;
            param1["bubble_pointer_right"] = var_1133;
            param1["bubble_pointer_down"] = var_1134;
            param1["bubble_pointer_left"] = var_1135;
            param1["button"] = var_905;
            param1["button_thick"] = var_906;
            param1["button_icon"] = var_1138;
            param1["button_group_left"] = var_935;
            param1["button_group_center"] = var_936;
            param1["button_group_right"] = var_937;
            param1["canvas"] = var_916;
            param1["checkbox"] = var_922;
            param1["closebutton"] = var_1143;
            param1["container"] = var_910;
            param1["container_button"] = var_912;
            param1["display_object_wrapper"] = var_930;
            param1["dropmenu"] = var_913;
            param1["dropmenu_item"] = var_914;
            param1["frame"] = var_888;
            param1["frame_notify"] = var_1130;
            param1["header"] = var_908;
            param1["html"] = var_1123;
            param1["icon"] = var_1119;
            param1["itemgrid"] = var_1136;
            param1["itemgrid_horizontal"] = var_894;
            param1["itemgrid_vertical"] = var_896;
            param1["itemlist"] = WINDOW_TYPE_ITEMLIST;
            param1["itemlist_horizontal"] = var_891;
            param1["itemlist_vertical"] = var_892;
            param1["label"] = var_890;
            param1["maximizebox"] = var_1145;
            param1["menu"] = var_1150;
            param1["menu_item"] = var_1151;
            param1["submenu"] = var_1152;
            param1["minimizebox"] = var_1144;
            param1["notify"] = var_1122;
            param1["null"] = var_887;
            param1["password"] = var_932;
            param1["radiobutton"] = var_920;
            param1["region"] = var_1120;
            param1["restorebox"] = var_1146;
            param1["scaler"] = var_242;
            param1["scaler_horizontal"] = var_1157;
            param1["scaler_vertical"] = var_1156;
            param1["scrollbar_horizontal"] = var_897;
            param1["scrollbar_vertical"] = var_898;
            param1["scrollbar_slider_button_up"] = var_1165;
            param1["scrollbar_slider_button_down"] = var_1163;
            param1["scrollbar_slider_button_left"] = var_1164;
            param1["scrollbar_slider_button_right"] = var_1162;
            param1["scrollbar_slider_bar_horizontal"] = var_1158;
            param1["scrollbar_slider_bar_vertical"] = var_1159;
            param1["scrollbar_slider_track_horizontal"] = var_1160;
            param1["scrollbar_slider_track_vertical"] = var_1161;
            param1["scrollable_itemlist"] = var_1137;
            param1["scrollable_itemlist_vertical"] = WINDOW_TYPE_SCROLLABLE_ITEMLIST_VERTICAL;
            param1["scrollable_itemlist_horizontal"] = var_902;
            param1["selector"] = var_917;
            param1["selector_list"] = var_919;
            param1["submenu"] = var_1152;
            param1["tab_button"] = var_923;
            param1["tab_container_button"] = var_1149;
            param1["tab_context"] = var_240;
            param1["tab_content"] = var_1148;
            param1["tab_selector"] = var_925;
            param1["text"] = var_915;
            param1["input"] = var_909;
            param1["toolbar"] = var_1121;
            param1["tooltip"] = var_241;
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