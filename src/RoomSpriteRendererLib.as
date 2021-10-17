package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.RoomRendererFactory;
    import com.sulake.iid.IIDRoomRendererFactory;

    public class RoomSpriteRendererLib extends SimpleApplication 
    {

        public static var manifest:Class = RoomSpriteRendererLib_manifest;
        public static var requiredClasses:Array = new Array(RoomRendererFactory, IIDRoomRendererFactory);


    }
}