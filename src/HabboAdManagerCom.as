package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.AdManager;
    import com.sulake.iid.IIDHabboAdManager;

    public class HabboAdManagerCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboAdManagerCom_manifest;
        public static var requiredClasses:Array = new Array(AdManager, IIDHabboAdManager);


    }
}