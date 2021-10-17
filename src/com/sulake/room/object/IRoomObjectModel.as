package com.sulake.room.object
{
    public interface IRoomObjectModel 
    {

        function getNumber(param1:String):Number;
        function getString(param1:String):String;
        function getNumberArray(param1:String):Array;
        function getStringArray(param1:String):Array;
        function getUpdateID():int;

    }
}