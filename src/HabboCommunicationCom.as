package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboCommunicationManager;
    import com.sulake.iid.IIDHabboCommunicationManager;

    public class HabboCommunicationCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboCommunicationCom_manifest;
        public static var requiredClasses:Array = new Array(HabboCommunicationManager, IIDHabboCommunicationManager);


    }
}