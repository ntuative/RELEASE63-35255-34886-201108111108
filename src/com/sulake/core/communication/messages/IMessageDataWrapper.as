package com.sulake.core.communication.messages
{
    import com.sulake.core.communication.util.Short;

    public interface IMessageDataWrapper 
    {

        function readString():String;
        function readInteger():int;
        function readBoolean():Boolean;
        function readShort():Short;

    }
}