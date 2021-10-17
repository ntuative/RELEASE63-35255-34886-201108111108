package com.sulake.core.communication.connection
{
    import flash.events.IEventDispatcher;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.communication.encryption.IEncryption;
    import com.sulake.core.communication.messages.IMessageConfiguration;
    import com.sulake.core.communication.protocol.IProtocol;
    import com.sulake.core.communication.messages.IMessageEvent;

    public interface IConnection extends IEventDispatcher 
    {

        function dispose():void;
        function init(param1:String, param2:uint=0):Boolean;
        function set timeout(param1:int):void;
        function send(param1:IMessageComposer, param2:int=-1):Boolean;
        function setEncryption(param1:IEncryption):void;
        function registerMessageClasses(param1:IMessageConfiguration):void;
        function set protocol(param1:IProtocol):void;
        function get protocol():IProtocol;
        function addMessageEvent(param1:IMessageEvent):void;
        function removeMessageEvent(param1:IMessageEvent):void;
        function processReceivedData():void;
        function get connected():Boolean;

    }
}