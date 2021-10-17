package com.sulake.core.communication.messages
{
    public interface IMessageParser 
    {

        function flush():Boolean;
        function parse(param1:IMessageDataWrapper):Boolean;

    }
}