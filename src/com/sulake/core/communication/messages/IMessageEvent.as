package com.sulake.core.communication.messages
{
    import com.sulake.core.communication.connection.IConnection;

    public interface IMessageEvent 
    {

        function get callback():Function;
        function set connection(param1:IConnection):void;
        function get connection():IConnection;
        function get parserClass():Class;
        function set parser(param1:IMessageParser):void;
        function dispose():void;

    }
}