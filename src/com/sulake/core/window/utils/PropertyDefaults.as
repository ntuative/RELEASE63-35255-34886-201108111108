package com.sulake.core.window.utils
{
    import flash.text.AntiAliasType;
    import flash.text.TextFieldAutoSize;
    import com.sulake.core.window.enum.Direction;
    import flash.text.GridFitType;
    import com.sulake.core.window.enum.LinkTarget;

    public class PropertyDefaults 
    {

        public static const var_1220:String = "antialias_type";
        public static const var_2004:String = "auto_arrange_items";
        public static const var_1221:String = "auto_size";
        public static const var_2006:String = "bitmap_asset_name";
        public static const var_2008:String = "direction";
        public static const var_1264:String = "display_as_password";
        public static const var_1254:String = "editable";
        public static const var_1257:String = "focus_capturer";
        public static const var_1235:String = "grid_fit_type";
        public static const var_2012:String = "handle_bitmap_disposing";
        public static const var_1270:String = "link_target";
        public static const var_2014:String = "spacing";
        public static const var_1225:String = "margin_left";
        public static const var_1226:String = "margin_top";
        public static const var_1227:String = "margin_right";
        public static const var_1228:String = "margin_bottom";
        public static const var_2016:String = "item_array";
        public static const var_1222:String = "mouse_wheel_enabled";
        public static const var_2020:String = "pointer_offset";
        public static const var_2018:String = "resize_on_item_update";
        public static const var_2022:String = "scale_to_fit_items";
        public static const var_2024:String = "scroll_step_h";
        public static const var_2026:String = "scroll_step_v";
        public static const var_1260:String = "selectable";
        public static const var_1223:String = "text_color";
        public static const var_1224:String = "text_style";
        public static const var_2029:String = "tool_tip_caption";
        public static const var_2031:String = "tool_tip_delay";
        public static const var_2033:String = "test_id_key";
        public static const var_2003:String = AntiAliasType.NORMAL;//"normal"
        public static const var_1230:Array = [AntiAliasType.NORMAL, AntiAliasType.ADVANCED];
        public static const var_2005:Boolean = true;
        public static const var_1231:String = TextFieldAutoSize.NONE;//"none"
        public static const var_1232:Array = [TextFieldAutoSize.NONE, TextFieldAutoSize.LEFT, TextFieldAutoSize.CENTER, TextFieldAutoSize.RIGHT];
        public static const var_2007:String = null;
        public static const var_2009:String = Direction.DOWN;
        public static const var_2010:Array = [Direction.UP, Direction.DOWN, Direction.LEFT, Direction.RIGHT];
        public static const var_1262:Boolean = false;
        public static const var_2011:Boolean = true;
        public static const var_1256:Boolean = false;
        public static const var_1234:String = GridFitType.PIXEL;//"pixel"
        public static const var_1236:Array = [GridFitType.PIXEL, GridFitType.NONE, GridFitType.SUBPIXEL];
        public static const var_2013:Boolean = true;
        public static const HTML_LINK_TARGET_VALUE:String = LinkTarget.var_613;
        public static const var_1266:Array = [LinkTarget.var_613, LinkTarget.var_2034, LinkTarget.var_2035, LinkTarget.var_2036, LinkTarget.var_2037, LinkTarget.var_1269];
        public static const var_2015:int = 0;
        public static const var_1242:int = 0;
        public static const var_1244:int = 0;
        public static const var_1246:int = 0;
        public static const var_1248:int = 0;
        public static const var_2017:Array = [];
        public static const var_1250:Boolean = true;
        public static const var_2021:int = 0;
        public static const var_2019:Boolean = false;
        public static const var_2023:Boolean = false;
        public static const var_2025:Number = -1;
        public static const var_2027:Number = -1;
        public static const var_1259:Boolean = true;
        public static const var_1238:uint = 0;
        public static const var_2028:String = TextStyleManager.var_1219;//"regular"
        public static const var_1240:Array = TextStyleManager.getStyleNameArrayRef();
        public static const var_2030:String = "";
        public static const var_2032:int = 500;
        public static const var_2038:PropertyStruct = new PropertyStruct(var_1220, var_2003, PropertyStruct.var_636, false, var_1230);
        public static const var_2039:PropertyStruct = new PropertyStruct(var_2004, var_2005, PropertyStruct.var_634, false);
        public static const var_1233:PropertyStruct = new PropertyStruct(var_1221, var_1231, PropertyStruct.var_636, false, var_1232);
        public static const var_2040:PropertyStruct = new PropertyStruct(var_2006, var_2007, PropertyStruct.var_636, false);
        public static const var_2041:PropertyStruct = new PropertyStruct(var_2008, var_2009, PropertyStruct.var_636, false, var_2010);
        public static const var_1263:PropertyStruct = new PropertyStruct(var_1264, var_1262, PropertyStruct.var_634, false);
        public static const var_1255:PropertyStruct = new PropertyStruct(var_1254, var_2011, PropertyStruct.var_634, false);
        public static const var_1258:PropertyStruct = new PropertyStruct(var_1257, var_1256, PropertyStruct.var_634, false);
        public static const var_1237:PropertyStruct = new PropertyStruct(var_1235, var_1234, PropertyStruct.var_636, false, var_1236);
        public static const var_2042:PropertyStruct = new PropertyStruct(var_2012, var_2013, PropertyStruct.var_634, false);
        public static const var_1271:PropertyStruct = new PropertyStruct(var_1270, HTML_LINK_TARGET_VALUE, PropertyStruct.var_636, false, var_1266);
        public static const var_2043:PropertyStruct = new PropertyStruct(var_2014, var_2015, PropertyStruct.var_630, false);
        public static const var_1243:PropertyStruct = new PropertyStruct(var_1225, var_1242, PropertyStruct.var_630, false);
        public static const var_1245:PropertyStruct = new PropertyStruct(var_1226, var_1244, PropertyStruct.var_630, false);
        public static const var_1247:PropertyStruct = new PropertyStruct(var_1227, var_1246, PropertyStruct.var_630, false);
        public static const var_1249:PropertyStruct = new PropertyStruct(var_1228, var_1248, PropertyStruct.var_630, false);
        public static const var_2044:PropertyStruct = new PropertyStruct(var_2016, var_2017, PropertyStruct.var_639, false);
        public static const var_1251:PropertyStruct = new PropertyStruct(var_1222, var_1250, PropertyStruct.var_634, false);
        public static const var_2045:PropertyStruct = new PropertyStruct(var_2018, var_2019, PropertyStruct.var_634, false);
        public static const var_2046:PropertyStruct = new PropertyStruct(var_2020, var_2021, PropertyStruct.var_630, false);
        public static const var_2047:PropertyStruct = new PropertyStruct(var_2022, var_2023, PropertyStruct.var_634, false);
        public static const var_2048:PropertyStruct = new PropertyStruct(var_2024, var_2025, PropertyStruct.var_632, false);
        public static const var_2049:PropertyStruct = new PropertyStruct(var_2026, var_2027, PropertyStruct.var_632, false);
        public static const var_1261:PropertyStruct = new PropertyStruct(var_1260, var_1259, PropertyStruct.var_634, false);
        public static const var_1239:PropertyStruct = new PropertyStruct(var_1223, var_1238, PropertyStruct.var_629, false);
        public static const var_1241:PropertyStruct = new PropertyStruct(var_1224, var_2028, PropertyStruct.var_636, false, var_1240);
        public static const var_2050:PropertyStruct = new PropertyStruct(var_2029, var_2030, PropertyStruct.var_636, false);
        public static const TOOL_TIP_DELAY:PropertyStruct = new PropertyStruct(var_2031, var_2032, PropertyStruct.var_631, false);


    }
}