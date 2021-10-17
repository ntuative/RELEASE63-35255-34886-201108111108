package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboLocalizationManager;
    import com.sulake.iid.IIDCoreLocalizationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.localization.HabboLocalizationManager;

    public class HabboLocalizationCom extends SimpleApplication 
    {

        public static var requiredClasses:Array = new Array(com.sulake.bootstrap.HabboLocalizationManager, com.sulake.iid.IIDCoreLocalizationManager, com.sulake.iid.IIDHabboLocalizationManager);
        public static var manifest:Class = HabboLocalizationCom_manifest;
        public static var default_localization:Class = HabboLocalizationCom_default_localization;
        public static var keys_in_use:Class = HabboLocalizationCom_keys_in_use;
        public static var IIDCoreLocalizationManager:Class = com.sulake.iid.IIDCoreLocalizationManager;
        public static var IIDHabboLocalizationManager:Class = com.sulake.iid.IIDHabboLocalizationManager;
        public static var ICoreLocalizationManager:Class = com.sulake.core.localization.ICoreLocalizationManager;
        public static var IHabboLocalizationManager:Class = com.sulake.habbo.localization.IHabboLocalizationManager;
        public static var HabboLocalizationManager:Class = com.sulake.habbo.localization.HabboLocalizationManager;


    }
}