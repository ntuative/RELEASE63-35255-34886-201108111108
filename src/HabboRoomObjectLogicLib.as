﻿package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.RoomObjectFactory;
    import com.sulake.iid.IIDRoomObjectFactory;

    public class HabboRoomObjectLogicLib extends SimpleApplication 
    {

        public static var manifest:Class = HabboRoomObjectLogicLib_manifest;
        public static var requiredClasses:Array = new Array(RoomObjectFactory, IIDRoomObjectFactory);


    }
}