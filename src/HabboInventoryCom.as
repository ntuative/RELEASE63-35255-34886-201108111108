package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboInventory;
    import com.sulake.iid.IIDHabboInventory;

    public class HabboInventoryCom extends SimpleApplication 
    {

        public static var requiredClasses:Array = new Array(HabboInventory, IIDHabboInventory);
        public static var manifest:Class = HabboInventoryCom_manifest;
        public static var inventory_icon_png:Class = HabboInventoryCom_inventory_icon_png;
        public static var inventory_empty_png:Class = HabboInventoryCom_inventory_empty_png;
        public static var download_icon_png:Class = HabboInventoryCom_download_icon_png;
        public static var thumb_bg_png:Class = HabboInventoryCom_thumb_bg_png;
        public static var thumb_bg_selected_png:Class = HabboInventoryCom_thumb_bg_selected_png;
        public static var thumb_icon_recycle_png:Class = HabboInventoryCom_thumb_icon_recycle_png;
        public static var no_recycle_icon_png:Class = HabboInventoryCom_no_recycle_icon_png;
        public static var recycle_icon_png:Class = HabboInventoryCom_recycle_icon_png;
        public static var no_trade_icon_png:Class = HabboInventoryCom_no_trade_icon_png;
        public static var trade_icon_png:Class = HabboInventoryCom_trade_icon_png;
        public static var trading_locked_icon_png:Class = HabboInventoryCom_trading_locked_icon_png;
        public static var trading_unlocked_icon_png:Class = HabboInventoryCom_trading_unlocked_icon_png;
        public static var thumb_selected_outline_png:Class = HabboInventoryCom_thumb_selected_outline_png;
        public static var inventory_xml:Class = HabboInventoryCom_inventory_xml;
        public static var inventory_furni_base_xml:Class = HabboInventoryCom_inventory_furni_base_xml;
        public static var inventory_furni_grid_xml:Class = HabboInventoryCom_inventory_furni_grid_xml;
        public static var inventory_furni_preview_xml:Class = HabboInventoryCom_inventory_furni_preview_xml;
        public static var inventory_badges_xml:Class = HabboInventoryCom_inventory_badges_xml;
        public static var inventory_effects_xml:Class = HabboInventoryCom_inventory_effects_xml;
        public static var inventory_trading_xml:Class = HabboInventoryCom_inventory_trading_xml;
        public static var inventory_trading_minimized_xml:Class = HabboInventoryCom_inventory_trading_minimized_xml;
        public static var inventory_thumb_xml:Class = HabboInventoryCom_inventory_thumb_xml;
        public static var inventory_pets_view_xml:Class = HabboInventoryCom_inventory_pets_view_xml;
        public static var buy_marketplace_tokens_xml:Class = HabboInventoryCom_buy_marketplace_tokens_xml;
        public static var make_marketplace_offer_xml:Class = HabboInventoryCom_make_marketplace_offer_xml;
        public static var marketplace_no_credits_xml:Class = HabboInventoryCom_marketplace_no_credits_xml;
        public static var unseen_items_counter_xml:Class = HabboInventoryCom_unseen_items_counter_xml;
        public static var unseen_item_symbol_xml:Class = HabboInventoryCom_unseen_item_symbol_xml;
        public static var fx_icon_1_png:Class = HabboInventoryCom_fx_icon_1_png;
        public static var fx_icon_2_png:Class = HabboInventoryCom_fx_icon_2_png;
        public static var fx_icon_3_png:Class = HabboInventoryCom_fx_icon_3_png;
        public static var fx_icon_4_png:Class = HabboInventoryCom_fx_icon_4_png;
        public static var fx_icon_5_png:Class = HabboInventoryCom_fx_icon_5_png;
        public static var fx_icon_6_png:Class = HabboInventoryCom_fx_icon_6_png;
        public static var fx_icon_7_png:Class = HabboInventoryCom_fx_icon_7_png;
        public static var fx_icon_8_png:Class = HabboInventoryCom_fx_icon_8_png;
        public static var fx_icon_9_png:Class = HabboInventoryCom_fx_icon_9_png;
        public static var fx_icon_10_png:Class = HabboInventoryCom_fx_icon_10_png;
        public static var fx_icon_11_png:Class = HabboInventoryCom_fx_icon_11_png;
        public static var fx_icon_12_png:Class = HabboInventoryCom_fx_icon_12_png;
        public static var fx_icon_13_png:Class = HabboInventoryCom_fx_icon_13_png;
        public static var fx_icon_14_png:Class = HabboInventoryCom_fx_icon_14_png;
        public static var fx_icon_15_png:Class = HabboInventoryCom_fx_icon_15_png;
        public static var fx_icon_16_png:Class = HabboInventoryCom_fx_icon_16_png;
        public static var fx_icon_17_png:Class = HabboInventoryCom_fx_icon_17_png;
        public static var fx_icon_18_png:Class = HabboInventoryCom_fx_icon_18_png;
        public static var fx_icon_19_png:Class = HabboInventoryCom_fx_icon_19_png;
        public static var fx_icon_20_png:Class = HabboInventoryCom_fx_icon_20_png;
        public static var fx_icon_21_png:Class = HabboInventoryCom_fx_icon_21_png;
        public static var fx_icon_22_png:Class = HabboInventoryCom_fx_icon_22_png;
        public static var fx_icon_23_png:Class = HabboInventoryCom_fx_icon_23_png;
        public static var fx_icon_24_png:Class = HabboInventoryCom_fx_icon_24_png;
        public static var fx_icon_25_png:Class = HabboInventoryCom_fx_icon_25_png;
        public static var fx_icon_26_png:Class = HabboInventoryCom_fx_icon_26_png;
        public static var fx_icon_27_png:Class = HabboInventoryCom_fx_icon_27_png;
        public static var fx_icon_31_png:Class = HabboInventoryCom_fx_icon_31_png;
        public static var fx_icon_32_png:Class = HabboInventoryCom_fx_icon_32_png;
        public static var fx_icon_44_png:Class = HabboInventoryCom_fx_icon_44_png;
        public static var fx_icon_47_png:Class = HabboInventoryCom_fx_icon_47_png;
        public static var fx_icon_53_png:Class = HabboInventoryCom_fx_icon_53_png;
        public static var fx_icon_54_png:Class = HabboInventoryCom_fx_icon_54_png;
        public static var fx_icon_59_png:Class = HabboInventoryCom_fx_icon_59_png;
        public static var fx_icon_60_png:Class = HabboInventoryCom_fx_icon_60_png;
        public static var fx_icon_61_png:Class = HabboInventoryCom_fx_icon_61_png;
        public static var fx_icon_62_png:Class = HabboInventoryCom_fx_icon_62_png;
        public static var fx_icon_63_png:Class = HabboInventoryCom_fx_icon_63_png;
        public static var fx_icon_64_png:Class = HabboInventoryCom_fx_icon_64_png;
        public static var fx_icon_65_png:Class = HabboInventoryCom_fx_icon_65_png;
        public static var fx_icon_66_png:Class = HabboInventoryCom_fx_icon_66_png;
        public static var fx_icon_67_png:Class = HabboInventoryCom_fx_icon_67_png;
        public static var fx_icon_69_png:Class = HabboInventoryCom_fx_icon_69_png;
        public static var fx_icon_70_png:Class = HabboInventoryCom_fx_icon_70_png;
        public static var fx_icon_71_png:Class = HabboInventoryCom_fx_icon_71_png;
        public static var fx_icon_72_png:Class = HabboInventoryCom_fx_icon_72_png;
        public static var fx_icon_73_png:Class = HabboInventoryCom_fx_icon_73_png;
        public static var fx_icon_74_png:Class = HabboInventoryCom_fx_icon_74_png;
        public static var fx_icon_75_png:Class = HabboInventoryCom_fx_icon_75_png;
        public static var fx_icon_76_png:Class = HabboInventoryCom_fx_icon_76_png;
        public static var icon_wallpaper_png:Class = HabboInventoryCom_icon_wallpaper_png;
        public static var icon_floor_png:Class = HabboInventoryCom_icon_floor_png;
        public static var icon_landscape_png:Class = HabboInventoryCom_icon_landscape_png;
        public static var item_popup_xml:Class = HabboInventoryCom_item_popup_xml;
        public static var popup_arrow_left_png:Class = HabboInventoryCom_popup_arrow_left_png;
        public static var popup_arrow_right_png:Class = HabboInventoryCom_popup_arrow_right_png;


    }
}