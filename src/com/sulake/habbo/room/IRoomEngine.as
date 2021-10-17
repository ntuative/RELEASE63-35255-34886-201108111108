package com.sulake.habbo.room
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;
    import flash.display.DisplayObject;
    import com.sulake.room.utils.IRoomGeometry;
    import flash.geom.Point;
    import com.sulake.room.utils.IVector3d;
    import flash.geom.Rectangle;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.core.utils.Map;

    public interface IRoomEngine extends IUnknown 
    {

        function get events():IEventDispatcher;
        function get isInitialized():Boolean;
        function get activeRoomId():int;
        function get activeRoomCategory():int;
        function createRoomCanvas(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int):DisplayObject;
        function modifyRoomCanvas(param1:int, param2:int, param3:int, param4:int, param5:int):Boolean;
        function setRoomCanvasMask(param1:int, param2:int, param3:int, param4:Boolean):void;
        function getRoomCanvasGeometry(param1:int, param2:int, param3:int):IRoomGeometry;
        function getRoomCanvasScreenOffset(param1:int, param2:int, param3:int):Point;
        function setRoomCanvasScreenOffset(param1:int, param2:int, param3:int, param4:Point):Boolean;
        function handleRoomCanvasMouseEvent(param1:int, param2:int, param3:int, param4:String, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean):void;
        function setActiveRoom(param1:int, param2:int):void;
        function getRoomNumberValue(param1:int, param2:int, param3:String):Number;
        function getRoomStringValue(param1:int, param2:int, param3:String):String;
        function getFurnitureIcon(param1:int, param2:IGetImageListener, param3:String=null):ImageResult;
        function getWallItemIcon(param1:int, param2:IGetImageListener, param3:String=null):ImageResult;
        function getFurnitureImage(param1:int, param2:IVector3d, param3:int, param4:IGetImageListener, param5:uint=0, param6:String=null, param7:int=-1, param8:int=-1):ImageResult;
        function getGenericRoomObjectImage(param1:String, param2:String, param3:IVector3d, param4:int, param5:IGetImageListener, param6:uint=0, param7:String=null, param8:int=-1, param9:int=-1):ImageResult;
        function getWallItemImage(param1:int, param2:IVector3d, param3:int, param4:IGetImageListener, param5:uint=0, param6:String=null, param7:int=-1, param8:int=-1):ImageResult;
        function getPetImage(param1:int, param2:int, param3:IVector3d, param4:int, param5:IGetImageListener, param6:uint=0):ImageResult;
        function getRoomImage(param1:String, param2:String, param3:String, param4:int, param5:IGetImageListener, param6:String=null):ImageResult;
        function getRoomObjectImage(param1:int, param2:int, param3:int, param4:int, param5:IVector3d, param6:int, param7:IGetImageListener, param8:uint=0):ImageResult;
        function getRoomObjectBoundingRectangle(param1:int, param2:int, param3:int, param4:int, param5:int):Rectangle;
        function getRoomObjectScreenLocation(param1:int, param2:int, param3:int, param4:int, param5:int):Point;
        function getActiveRoomBoundingRectangle(param1:int):Rectangle;
        function getRoomObjectCount(param1:int, param2:int, param3:int):int;
        function getRoomObject(param1:int, param2:int, param3:int, param4:int):IRoomObject;
        function getRoomObjectWithIndex(param1:int, param2:int, param3:int, param4:int):IRoomObject;
        function modifyRoomObject(param1:int, param2:int, param3:String):Boolean;
        function modifyRoomObjectDataWithMap(param1:int, param2:int, param3:String, param4:Map):Boolean;
        function modifyRoomObjectData(param1:int, param2:int, param3:String):Boolean;
        function deleteRoomObject(param1:int, param2:int):Boolean;
        function initializeRoomObjectInsert(param1:int, param2:int, param3:int, param4:String=null):Boolean;
        function cancelRoomObjectInsert():void;
        function selectAvatar(param1:int, param2:int, param3:int):void;
        function selectRoomObject(param1:int, param2:int, param3:int, param4:int):void;
        function loadRoomResources(param1:String):Array;
        function isPublicRoomWorldType(param1:String):Boolean;
        function getWorldType(param1:int, param2:int):String;
        function getSelectedObjectData(param1:int, param2:int):ISelectedRoomObjectData;
        function getSelectedAvatarId():int;
        function updateObjectRoomColor(param1:int, param2:int, param3:uint, param4:int, param5:Boolean):Boolean;
        function getPetColor(param1:int, param2:int):PetColorResult;
        function addObjectFurniture(param1:int, param2:int, param3:int, param4:int, param5:IVector3d, param6:IVector3d, param7:int, param8:String, param9:Number=NaN, param10:int=-1, param11:Boolean=false):Boolean;
        function changeObjectState(param1:int, param2:int, param3:int, param4:int):void;
        function disposeObjectFurniture(param1:int, param2:int, param3:int):void;
        function addObjectWallItem(param1:int, param2:int, param3:int, param4:int, param5:IVector3d, param6:IVector3d, param7:int, param8:String, param9:Boolean=false):Boolean;
        function updateObjectWallItemLocation(param1:int, param2:int, param3:int, param4:IVector3d):Boolean;
        function disposeObjectWallItem(param1:int, param2:int, param3:int):void;
        function addObjectUser(param1:int, param2:int, param3:int, param4:IVector3d, param5:IVector3d, param6:Number, param7:int, param8:String=null):Boolean;
        function updateObjectUserFigure(param1:int, param2:int, param3:int, param4:String, param5:String=null, param6:String=null):Boolean;
        function updateObjectUserPosture(param1:int, param2:int, param3:int, param4:String, param5:String=""):Boolean;
        function updateObjectUserGesture(param1:int, param2:int, param3:int, param4:int):Boolean;
        function updateObjectUserEffect(param1:int, param2:int, param3:int, param4:int, param5:int=0):Boolean;
        function disposeObjectUser(param1:int, param2:int, param3:int):void;
        function updateObjectRoom(param1:int, param2:int, param3:String=null, param4:String=null, param5:String=null, param6:Boolean=false):Boolean;
        function getFurnitureType(param1:int):String;
        function getWallItemType(param1:int, param2:String=null):String;
        function useRoomObjectInActiveRoom(param1:int, param2:int):Boolean;
        function initializeRoom(param1:int, param2:int, param3:XML):void;
        function disposeRoom(param1:int, param2:int):void;

    }
}