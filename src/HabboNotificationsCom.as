package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboNotifications;
    import com.sulake.iid.IIDHabboNotifications;

    public class HabboNotificationsCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboNotificationsCom_manifest;
        public static var habbo_notifications_config_xml:Class = HabboNotificationsCom_habbo_notifications_config_xml;
        public static var achievement_bg_001_png:Class = HabboNotificationsCom_achievement_bg_001_png;
        public static var if_icon_temp_png:Class = HabboNotificationsCom_if_icon_temp_png;
        public static var if_icon_hc_png:Class = HabboNotificationsCom_if_icon_hc_png;
        public static var if_icon_vip_png:Class = HabboNotificationsCom_if_icon_vip_png;
        public static var if_icon_recycler_png:Class = HabboNotificationsCom_if_icon_recycler_png;
        public static var if_icon_friend_bg_blue_png:Class = HabboNotificationsCom_if_icon_friend_bg_blue_png;
        public static var motd_notification_xml:Class = HabboNotificationsCom_motd_notification_xml;
        public static var motd_notification_item_xml:Class = HabboNotificationsCom_motd_notification_item_xml;
        public static var layout_notification_xml:Class = HabboNotificationsCom_layout_notification_xml;
        public static var layout_notifications_browser_xml:Class = HabboNotificationsCom_layout_notifications_browser_xml;
        public static var layout_parkbus_notification_xml:Class = HabboNotificationsCom_layout_parkbus_notification_xml;
        public static var achievement_notification_bonus_xml:Class = HabboNotificationsCom_achievement_notification_bonus_xml;
        public static var club_gift_notification_xml:Class = HabboNotificationsCom_club_gift_notification_xml;
        public static var club_ending_notification_xml:Class = HabboNotificationsCom_club_ending_notification_xml;
        public static var club_promo_notification_xml:Class = HabboNotificationsCom_club_promo_notification_xml;
        public static var requiredClasses:Array = new Array(HabboNotifications, IIDHabboNotifications);


    }
}