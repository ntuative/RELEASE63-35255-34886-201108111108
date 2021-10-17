package com.sulake.room.object.logic
{
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import flash.events.IEventDispatcher;

    public interface IRoomObjectEventHandler extends IRoomObjectMouseHandler 
    {

        function set object(param1:IRoomObjectController):void;
        function get object():IRoomObjectController;
        function dispose():void;
        function initialize(param1:XML):void;
        function update(param1:int):void;
        function processUpdateMessage(param1:RoomObjectUpdateMessage):void;
        function useObject():void;
        function set eventDispatcher(param1:IEventDispatcher):void;
        function get eventDispatcher():IEventDispatcher;
        function getEventTypes():Array;

    }
}