package com.sulake.core.communication.protocol
{
    import flash.utils.ByteArray;
    import com.sulake.core.communication.util.Short;

    public interface IProtocolDecoder 
    {

        function dispose():void;
        function getID(param1:ByteArray):int;
        function decode(param1:ByteArray):void;
        function readString(param1:ByteArray):String;
        function readInteger(param1:ByteArray):int;
        function readBoolean(param1:ByteArray):Boolean;
        function readShort(param1:ByteArray):Short;

    }
}