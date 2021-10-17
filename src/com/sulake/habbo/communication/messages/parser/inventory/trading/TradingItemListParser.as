package com.sulake.habbo.communication.messages.parser.inventory.trading
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.ItemDataStructure;

    public class TradingItemListParser implements IMessageParser 
    {

        private var var_3719:int;
        private var _firstUserItemArray:Array;
        private var var_3720:int;
        private var var_3721:Array;


        public function get firstUserID():int
        {
            return (this.var_3719);
        }

        public function get firstUserItemArray():Array
        {
            return (this._firstUserItemArray);
        }

        public function get secondUserID():int
        {
            return (this.var_3720);
        }

        public function get secondUserItemArray():Array
        {
            return (this.var_3721);
        }

        public function flush():Boolean
        {
            this.var_3719 = -1;
            this._firstUserItemArray = null;
            this.var_3720 = -1;
            this.var_3721 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3719 = param1.readInteger();
            this._firstUserItemArray = new Array();
            if (!this.parseItemData(param1, this._firstUserItemArray))
            {
                return (false);
            };
            this.var_3720 = param1.readInteger();
            this.var_3721 = new Array();
            if (!this.parseItemData(param1, this.var_3721))
            {
                return (false);
            };
            return (true);
        }

        private function parseItemData(param1:IMessageDataWrapper, param2:Array):Boolean
        {
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:String;
            var _loc6_:int;
            var _loc7_:int;
            var _loc8_:int;
            var _loc9_:String;
            var _loc10_:int;
            var _loc11_:int;
            var _loc12_:int;
            var _loc13_:int;
            var _loc14_:Boolean;
            var _loc15_:int;
            _loc3_ = param1.readInteger();
            while (_loc3_ > 0)
            {
                _loc4_ = param1.readInteger();
                _loc5_ = param1.readString().toUpperCase();
                _loc6_ = param1.readInteger();
                _loc7_ = param1.readInteger();
                _loc8_ = param1.readInteger();
                _loc14_ = param1.readBoolean();
                _loc9_ = param1.readString();
                _loc10_ = -1;
                _loc11_ = param1.readInteger();
                _loc12_ = param1.readInteger();
                _loc13_ = param1.readInteger();
                _loc15_ = ((_loc5_ == "S") ? param1.readInteger() : -1);
                param2.push(new ItemDataStructure(_loc4_, _loc5_, _loc6_, _loc7_, _loc8_, _loc9_, _loc15_, _loc10_, _loc11_, _loc12_, _loc13_, _loc14_));
                _loc3_--;
            };
            return (true);
        }


    }
}