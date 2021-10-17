package com.sulake.core.window.utils
{
    import com.sulake.core.window.enum.WindowParam;
    import flash.utils.Dictionary;

    public class ParamCodeTable extends WindowParam 
    {


        public static function fillTables(param1:Dictionary, param2:Dictionary=null):void
        {
            var _loc3_:String;
            param1["null"] = var_714;
            param1["bound_to_parent_rect"] = var_711;
            param1["child_window"] = var_732;
            param1["embedded_controller"] = var_733;
            param1["expand_to_accommodate_children"] = WINDOW_PARAM_EXPAND_TO_ACCOMMODATE_CHILDREN;
            param1["input_event_processor"] = var_609;
            param1["internal_event_handling"] = var_716;
            param1["mouse_dragging_target"] = var_137;
            param1["mouse_dragging_trigger"] = var_692;
            param1["mouse_scaling_target"] = var_696;
            param1["mouse_scaling_trigger"] = var_695;
            param1["horizontal_mouse_scaling_trigger"] = var_693;
            param1["vertical_mouse_scaling_trigger"] = var_694;
            param1["observe_parent_input_events"] = var_715;
            param1["parent_window"] = var_731;
            param1["resize_to_accommodate_children"] = var_723;
            param1["relative_horizontal_scale_center"] = var_687;
            param1["relative_horizontal_scale_fixed"] = var_684;
            param1["relative_horizontal_scale_move"] = var_685;
            param1["relative_horizontal_scale_strech"] = var_686;
            param1["relative_scale_center"] = var_722;
            param1["relative_scale_fixed"] = var_719;
            param1["relative_scale_move"] = var_720;
            param1["relative_scale_strech"] = var_721;
            param1["relative_vertical_scale_center"] = var_691;
            param1["relative_vertical_scale_fixed"] = var_688;
            param1["relative_vertical_scale_move"] = var_689;
            param1["relative_vertical_scale_strech"] = var_690;
            param1["on_resize_align_left"] = var_703;
            param1["on_resize_align_right"] = var_705;
            param1["on_resize_align_center"] = var_704;
            param1["on_resize_align_top"] = var_706;
            param1["on_resize_align_bottom"] = var_708;
            param1["on_resize_align_middle"] = var_707;
            param1["on_accommodate_align_left"] = var_701;
            param1["on_accommodate_align_right"] = var_697;
            param1["on_accommodate_align_center"] = var_699;
            param1["on_accommodate_align_top"] = var_702;
            param1["on_accommodate_align_bottom"] = var_698;
            param1["on_accommodate_align_middle"] = var_700;
            param1["route_input_events_to_parent"] = var_712;
            param1["use_parent_graphic_context"] = var_713;
            param1["draggable_with_mouse"] = var_724;
            param1["scalable_with_mouse"] = var_726;
            param1["reflect_horizontal_resize_to_parent"] = var_709;
            param1["reflect_vertical_resize_to_parent"] = var_710;
            param1["reflect_resize_to_parent"] = var_730;
            param1["force_clipping"] = WINDOW_PARAM_FORCE_CLIPPING;
            param1["inherit_caption"] = var_734;
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