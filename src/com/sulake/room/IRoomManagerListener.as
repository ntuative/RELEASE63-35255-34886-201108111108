package com.sulake.room
{
    public interface IRoomManagerListener 
    {

        function roomManagerInitialized(param1:Boolean=false):void;
        function contentLoaded(param1:String, param2:Boolean=false):void;
        function objectInitialized(param1:String, param2:int, param3:int):void;

    }
}