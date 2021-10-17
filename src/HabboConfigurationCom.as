package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboConfigurationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.habbo.configuration.HabboConfigurationManager;

    public class HabboConfigurationCom extends SimpleApplication 
    {

        public static var requiredClasses:Array = new Array(com.sulake.bootstrap.HabboConfigurationManager, com.sulake.iid.IIDHabboConfigurationManager);
        public static var manifest:Class = HabboConfigurationCom_manifest;
        public static var default_configuration:Class = HabboConfigurationCom_default_configuration;
        public static var IIDHabboConfigurationManager:Class = com.sulake.iid.IIDHabboConfigurationManager;
        public static var HabboConfigurationManager:Class = com.sulake.habbo.configuration.HabboConfigurationManager;


    }
}