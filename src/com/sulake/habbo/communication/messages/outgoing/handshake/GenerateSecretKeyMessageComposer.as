package com.sulake.habbo.communication.messages.outgoing.handshake
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import flash.utils.ByteArray;
    import com.sulake.core.communication.encryption.CryptoTools;

    public class GenerateSecretKeyMessageComposer implements IMessageComposer 
    {

        private var var_3371:String;

        public function GenerateSecretKeyMessageComposer(param1:String)
        {
            var _loc2_:ByteArray = new ByteArray();
            _loc2_.writeMultiByte(param1, "iso-8859-1");
            var _loc3_:ByteArray = new ByteArray();
            var _loc4_:RSAKey = RSAKey.parsePublicKey(((("90e0d43db75b5b8ffc8a77e31cc9758fa43fe69f14184bef64e61574beb18fac" + "32520566f6483b246ddc3c991cb366bae975a6f6b733fd9570e8e72efc1e511f") + "f6e2bcac49bf9237222d7c2bf306300d4dfc37113bcc84fa4401c9e4f2b4c41a") + "de9654ef00bd592944838fae21a05ea59fecc961766740c82d84f4299dfb33dd"), "3");
            _loc4_.encrypt(_loc2_, _loc3_, _loc2_.length);
            _loc4_.dispose();
            this.var_3371 = CryptoTools.byteArrayToHexString(_loc3_);
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this.var_3371]);
        }


    }
}