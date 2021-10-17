package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.RoomSessionManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;

    public class HabboRoomSessionManagerLib extends SimpleApplication 
    {

        public static var manifest:Class = HabboRoomSessionManagerLib_manifest;
        public static var requiredClasses:Array = new Array(RoomSessionManager, IIDHabboRoomSessionManager);


    }
}