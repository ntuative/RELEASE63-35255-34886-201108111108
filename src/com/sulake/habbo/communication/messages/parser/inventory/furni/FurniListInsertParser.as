package com.sulake.habbo.communication.messages.parser.inventory.furni
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniData;

    public class FurniListInsertParser implements IMessageParser 
    {

        protected var var_3710:Array;


        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3710 = new Array();
            var _loc2_:int = 1;
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_3710.push(this.parseItem(param1));
                _loc3_++;
            };
            return (true);
        }

        public function parseItem(param1:IMessageDataWrapper):FurniData
        {
            var _loc14_:String;
            var _loc15_:int;
            var _loc2_:int = param1.readInteger();
            var _loc3_:String = param1.readString();
            var _loc4_:int = param1.readInteger();
            var _loc5_:int = param1.readInteger();
            var _loc6_:int = param1.readInteger();
            var _loc7_:String = param1.readString();
            var _loc8_:Boolean = param1.readBoolean();
            var _loc9_:Boolean = param1.readBoolean();
            var _loc10_:Boolean = param1.readBoolean();
            var _loc11_:Boolean = param1.readBoolean();
            var _loc12_:int = param1.readInteger();
            var _loc13_:FurniData = new FurniData(_loc2_, _loc3_, _loc4_, _loc5_, _loc6_, _loc7_, _loc10_, _loc8_, _loc9_, _loc11_, _loc12_);
            if (_loc3_ == "S")
            {
                _loc14_ = param1.readString();
                _loc15_ = param1.readInteger();
                _loc13_.setExtraData(_loc14_, _loc15_);
            };
            return (_loc13_);
        }

        public function flush():Boolean
        {
            this.var_3710 = null;
            return (true);
        }

        public function getFurni():Array
        {
            return (this.var_3710);
        }


    }
}