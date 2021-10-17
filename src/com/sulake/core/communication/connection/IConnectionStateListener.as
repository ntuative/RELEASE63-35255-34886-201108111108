package com.sulake.core.communication.connection
{
    public interface IConnectionStateListener 
    {

        function connectionInit(param1:String, param2:int):void;
        function messageReceived(param1:String, param2:String):void;
        function messageSent(param1:String, param2:String):void;

    }
}