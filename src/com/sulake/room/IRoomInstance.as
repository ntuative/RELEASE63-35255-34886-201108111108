package com.sulake.room
{
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.renderer.IRoomRendererBase;

    public interface IRoomInstance 
    {

        function getNumber(param1:String):Number;
        function setNumber(param1:String, param2:Number, param3:Boolean=false):void;
        function getString(param1:String):String;
        function setString(param1:String, param2:String, param3:Boolean=false):void;
        function dispose():void;
        function update():void;
        function createRoomObject(param1:int, param2:String, param3:int):IRoomObject;
        function getObject(param1:int, param2:int):IRoomObject;
        function disposeObject(param1:int, param2:int):Boolean;
        function getObjectCount(param1:int):int;
        function getObjectWithIndexAndType(param1:int, param2:String, param3:int):IRoomObject;
        function getObjectCountForType(param1:String, param2:int):int;
        function getObjectWithIndex(param1:int, param2:int):IRoomObject;
        function disposeObjects(param1:int):int;
        function setRenderer(param1:IRoomRendererBase):void;
        function getRenderer():IRoomRendererBase;

    }
}