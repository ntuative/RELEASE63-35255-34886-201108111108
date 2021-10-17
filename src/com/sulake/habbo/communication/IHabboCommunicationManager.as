package com.sulake.habbo.communication
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.communication.messages.IMessageEvent;

    public interface IHabboCommunicationManager extends IUnknown 
    {

        function initConnection(param1:String):void;
        function getHabboMainConnection(param1:Function):IConnection;
        function addHabboConnectionMessageEvent(param1:IMessageEvent):void;
        function get mode():int;
        function set mode(param1:int):void;
        function get port():int;
        function habboWebLogin(param1:String, param2:String):IHabboWebLogin;

    }
}