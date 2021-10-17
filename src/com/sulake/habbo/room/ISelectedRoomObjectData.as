package com.sulake.habbo.room
{
    public interface ISelectedRoomObjectData 
    {

        function get id():int;
        function get category():int;
        function get operation():String;
        function get typeId():int;
        function get instanceData():String;

    }
}