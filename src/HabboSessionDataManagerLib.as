package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.SessionDataManager;
    import com.sulake.iid.IIDSessionDataManager;

    public class HabboSessionDataManagerLib extends SimpleApplication 
    {

        public static var manifest:Class = HabboSessionDataManagerLib_manifest;
        public static var requiredClasses:Array = new Array(SessionDataManager, IIDSessionDataManager);
        public static var loading_icon:Class = HabboSessionDataManagerLib_loading_icon;
        public static var make_favourite:Class = HabboSessionDataManagerLib_make_favourite;
        public static var clear_favourite:Class = HabboSessionDataManagerLib_clear_favourite;
        public static var group_info:Class = HabboSessionDataManagerLib_group_info;
        public static var group_entry:Class = HabboSessionDataManagerLib_group_entry;


    }
}