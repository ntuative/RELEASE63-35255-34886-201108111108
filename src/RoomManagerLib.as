package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.RoomManager;
    import com.sulake.iid.IIDRoomManager;

    public class RoomManagerLib extends SimpleApplication 
    {

        public static var manifest:Class = RoomManagerLib_manifest;
        public static var requiredClasses:Array = new Array(RoomManager, IIDRoomManager);


    }
}