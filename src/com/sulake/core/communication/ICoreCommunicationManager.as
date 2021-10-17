package com.sulake.core.communication
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.communication.protocol.IProtocol;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.connection.IConnectionStateListener;

    public interface ICoreCommunicationManager extends IUnknown 
    {

        function queueConnection(param1:String, param2:Function):IConnection;
        function createConnection(param1:String, param2:uint=0):IConnection;
        function registerProtocolType(param1:String, param2:Class):Boolean;
        function getProtocolInstanceOfType(param1:String):IProtocol;
        function addConnectionMessageEvent(param1:String, param2:IMessageEvent):void;
        function removeConnectionMessageEvent(param1:String, param2:IMessageEvent):void;
        function getMessageEvents(param1:IConnection, param2:Class):Array;
        function getMessageParser(param1:Class):IMessageParser;
        function set connectionStateListener(param1:IConnectionStateListener):void;

    }
}