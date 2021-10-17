package com.sulake.habbo.room
{
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.room.utils.SelectedRoomObjectData;
    import com.sulake.core.communication.connection.IConnection;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.room.utils.LegacyWallGeometry;
    import com.sulake.habbo.room.utils.TileHeightMap;
    import com.sulake.room.object.IRoomObjectController;

    public interface IRoomEngineServices extends IRoomObjectCreator 
    {

        function get activeRoomId():int;
        function get activeRoomCategory():int;
        function getRoomObjectCategory(param1:String):int;
        function getRoomObject(param1:int, param2:int, param3:int, param4:int):IRoomObject;
        function updateObjectRoomWindow(param1:int, param2:int, param3:int, param4:Boolean=true):void;
        function setObjectMoverIconSprite(param1:int, param2:int, param3:Boolean, param4:String=null):void;
        function setObjectMoverIconSpriteVisible(param1:Boolean):void;
        function removeObjectMoverIconSprite():void;
        function getSelectedObjectData(param1:int, param2:int):ISelectedRoomObjectData;
        function setSelectedObjectData(param1:int, param2:int, param3:SelectedRoomObjectData):void;
        function setPlacedObjectData(param1:int, param2:int, param3:SelectedRoomObjectData):void;
        function getPlacedObjectData(param1:int, param2:int):ISelectedRoomObjectData;
        function get connection():IConnection;
        function get events():IEventDispatcher;
        function getLegacyGeometry(param1:int, param2:int):LegacyWallGeometry;
        function getTileHeightMap(param1:int, param2:int):TileHeightMap;
        function getSelectionArrow(param1:int, param2:int):IRoomObjectController;
        function getTileCursor(param1:int, param2:int):IRoomObjectController;
        function getIsPlayingGame(param1:int, param2:int):Boolean;
        function requestRoomAdImage(param1:int, param2:int, param3:int, param4:int, param5:String, param6:String):void;
        function requestMouseCursor(param1:String, param2:int, param3:String):void;
        function addFloorHole(param1:int, param2:int, param3:int):void;
        function removeFloorHole(param1:int, param2:int, param3:int):void;

    }
}