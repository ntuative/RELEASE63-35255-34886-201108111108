package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.RoomEngine;
    import com.sulake.iid.IIDRoomEngine;

    public class HabboRoomEngineCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboRoomEngineCom_manifest;
        public static var requiredClasses:Array = new Array(RoomEngine, IIDRoomEngine);


    }
}