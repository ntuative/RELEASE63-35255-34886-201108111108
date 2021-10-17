package com.sulake.core.communication.protocol
{
    import flash.utils.ByteArray;

    public interface IProtocolEncoder 
    {

        function dispose():void;
        function encode(param1:int, param2:Array, param3:int=-1):ByteArray;

    }
}