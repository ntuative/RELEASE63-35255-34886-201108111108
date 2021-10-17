package com.sulake.habbo.room
{
    import com.sulake.room.IRoomInstance;
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.habbo.room.utils.TileHeightMap;
    import com.sulake.habbo.room.utils.LegacyWallGeometry;

    public interface IRoomCreator extends IRoomObjectCreator 
    {

        function initializeRoom(param1:int, param2:int, param3:XML):void;
        function getRoom(param1:int, param2:int):IRoomInstance;
        function disposeRoom(param1:int, param2:int):void;
        function isPublicRoom(param1:int, param2:int):Boolean;
        function setOwnUserId(param1:int, param2:int, param3:int):void;
        function setWorldType(param1:int, param2:int, param3:String):void;
        function getObjectRoom(param1:int, param2:int):IRoomObjectController;
        function setTileHeightMap(param1:int, param2:int, param3:TileHeightMap):void;
        function getTileHeightMap(param1:int, param2:int):TileHeightMap;
        function getLegacyGeometry(param1:int, param2:int):LegacyWallGeometry;
        function getRoomNumberValue(param1:int, param2:int, param3:String):Number;
        function getRoomStringValue(param1:int, param2:int, param3:String):String;
        function setIsPlayingGame(param1:int, param2:int, param3:Boolean):void;

    }
}