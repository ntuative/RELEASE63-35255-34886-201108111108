package com.sulake.core.communication.handshake
{
    public interface IKeyExchange 
    {

        function init(param1:String, param2:uint=16):Boolean;
        function generateSharedKey(param1:String, param2:uint=16):String;
        function getSharedKey(param1:uint=16):String;
        function getPublicKey(param1:uint=16):String;

    }
}