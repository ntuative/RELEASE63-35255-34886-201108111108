package com.sulake.core.communication.encryption
{
    import flash.utils.ByteArray;

    public interface IEncryption 
    {

        function init(param1:ByteArray):void;
        function initFromState(param1:IEncryption):void;
        function encipher(param1:ByteArray, param2:Boolean=false):ByteArray;
        function decipher(param1:ByteArray):ByteArray;

    }
}