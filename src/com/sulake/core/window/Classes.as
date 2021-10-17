package com.sulake.core.window
{
    import flash.utils.Dictionary;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.components.ActivatorController;
    import com.sulake.core.window.components.BackgroundController;
    import com.sulake.core.window.components.BadgeController;
    import com.sulake.core.window.components.BorderController;
    import com.sulake.core.window.components.BubbleController;
    import com.sulake.core.window.components.ButtonController;
    import com.sulake.core.window.components.SelectableButtonController;
    import com.sulake.core.window.components.BitmapWrapperController;
    import com.sulake.core.window.components.CanvasController;
    import com.sulake.core.window.components.CheckBoxController;
    import com.sulake.core.window.components.ContainerController;
    import com.sulake.core.window.components.ContainerButtonController;
    import com.sulake.core.window.components.CloseButtonController;
    import com.sulake.core.window.components.DisplayObjectWrapperController;
    import com.sulake.core.window.components.ScrollbarLiftController;
    import com.sulake.core.window.components.DropMenuController;
    import com.sulake.core.window.components.DropMenuItemController;
    import com.sulake.core.window.components.FrameController;
    import com.sulake.core.window.components.HeaderController;
    import com.sulake.core.window.components.HTMLTextController;
    import com.sulake.core.window.components.IconController;
    import com.sulake.core.window.components.ItemListController;
    import com.sulake.core.window.components.ItemGridController;
    import com.sulake.core.window.components.TextLabelController;
    import com.sulake.core.window.components.PasswordFieldController;
    import com.sulake.core.window.components.RadioButtonController;
    import com.sulake.core.window.components.RegionController;
    import com.sulake.core.window.components.ScalerController;
    import com.sulake.core.window.components.ScrollbarController;
    import com.sulake.core.window.components.ScrollableItemListWindow;
    import com.sulake.core.window.components.SelectorController;
    import com.sulake.core.window.components.TabSelectorController;
    import com.sulake.core.window.components.TabButtonController;
    import com.sulake.core.window.components.TabContainerButtonController;
    import com.sulake.core.window.components.TabContextController;
    import com.sulake.core.window.components.TextController;
    import com.sulake.core.window.components.TextFieldController;
    import com.sulake.core.window.components.ToolTipController;
    import com.sulake.core.window.components.*;

    public class Classes 
    {

        protected static var var_1272:Dictionary;


        public static function init():void
        {
            if (!var_1272)
            {
                var_1272 = new Dictionary();
                var_1272[WindowType.var_887] = WindowController;
                var_1272[WindowType.var_1131] = ActivatorController;
                var_1272[WindowType.var_927] = BackgroundController;
                var_1272[WindowType.var_239] = BadgeController;
                var_1272[WindowType.var_934] = BorderController;
                var_1272[WindowType.var_907] = BubbleController;
                var_1272[WindowType.var_1132] = WindowController;
                var_1272[WindowType.var_1133] = WindowController;
                var_1272[WindowType.var_1134] = WindowController;
                var_1272[WindowType.var_1135] = WindowController;
                var_1272[WindowType.var_905] = ButtonController;
                var_1272[WindowType.var_906] = ButtonController;
                var_1272[WindowType.var_935] = SelectableButtonController;
                var_1272[WindowType.var_936] = SelectableButtonController;
                var_1272[WindowType.var_937] = SelectableButtonController;
                var_1272[WindowType.var_928] = BitmapWrapperController;
                var_1272[WindowType.var_916] = CanvasController;
                var_1272[WindowType.var_922] = CheckBoxController;
                var_1272[WindowType.var_910] = ContainerController;
                var_1272[WindowType.var_912] = ContainerButtonController;
                var_1272[WindowType.var_1143] = CloseButtonController;
                var_1272[WindowType.var_930] = DisplayObjectWrapperController;
                var_1272[WindowType.var_1147] = ScrollbarLiftController;
                var_1272[WindowType.var_913] = DropMenuController;
                var_1272[WindowType.var_914] = DropMenuItemController;
                var_1272[WindowType.var_888] = FrameController;
                var_1272[WindowType.var_908] = HeaderController;
                var_1272[WindowType.var_1123] = HTMLTextController;
                var_1272[WindowType.var_1119] = IconController;
                var_1272[WindowType.WINDOW_TYPE_ITEMLIST] = ItemListController;
                var_1272[WindowType.var_891] = ItemListController;
                var_1272[WindowType.var_892] = ItemListController;
                var_1272[WindowType.var_1136] = ItemGridController;
                var_1272[WindowType.var_894] = ItemGridController;
                var_1272[WindowType.var_896] = ItemGridController;
                var_1272[WindowType.var_890] = TextLabelController;
                var_1272[WindowType.var_932] = PasswordFieldController;
                var_1272[WindowType.var_920] = RadioButtonController;
                var_1272[WindowType.var_1120] = RegionController;
                var_1272[WindowType.var_242] = ScalerController;
                var_1272[WindowType.var_897] = ScrollbarController;
                var_1272[WindowType.var_898] = ScrollbarController;
                var_1272[WindowType.var_1165] = ButtonController;
                var_1272[WindowType.var_1163] = ButtonController;
                var_1272[WindowType.var_1164] = ButtonController;
                var_1272[WindowType.var_1162] = ButtonController;
                var_1272[WindowType.var_1158] = ScrollbarLiftController;
                var_1272[WindowType.var_1159] = ScrollbarLiftController;
                var_1272[WindowType.var_1160] = WindowController;
                var_1272[WindowType.var_1161] = WindowController;
                var_1272[WindowType.WINDOW_TYPE_SCROLLABLE_ITEMLIST_VERTICAL] = ScrollableItemListWindow;
                var_1272[WindowType.var_917] = SelectorController;
                var_1272[WindowType.var_919] = TabSelectorController;
                var_1272[WindowType.var_923] = TabButtonController;
                var_1272[WindowType.var_1149] = TabContainerButtonController;
                var_1272[WindowType.var_1148] = ContainerController;
                var_1272[WindowType.var_240] = TabContextController;
                var_1272[WindowType.var_925] = TabSelectorController;
                var_1272[WindowType.var_915] = TextController;
                var_1272[WindowType.var_909] = TextFieldController;
                var_1272[WindowType.var_241] = ToolTipController;
            };
        }

        public static function getWindowClassByType(param1:uint):Class
        {
            return (var_1272[param1]);
        }


    }
}