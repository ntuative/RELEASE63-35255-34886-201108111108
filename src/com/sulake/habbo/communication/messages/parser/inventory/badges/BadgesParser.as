package com.sulake.habbo.communication.messages.parser.inventory.badges
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class BadgesParser implements IMessageParser 
    {

        private var var_3707:Array;
        private var var_3708:Array;
        private var var_3709:Map;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc2_:int;
            var _loc3_:String;
            var _loc8_:int;
            this.var_3707 = new Array();
            this.var_3709 = new Map();
            var _loc4_:int = param1.readInteger();
            var _loc5_:int;
            while (_loc5_ < _loc4_)
            {
                _loc2_ = param1.readInteger();
                _loc3_ = param1.readString();
                this.var_3709.add(_loc3_, _loc2_);
                this.var_3707.push(_loc3_);
                _loc5_++;
            };
            this.var_3708 = new Array();
            var _loc6_:int = param1.readInteger();
            var _loc7_:int;
            while (_loc7_ < _loc6_)
            {
                _loc8_ = param1.readInteger();
                _loc3_ = param1.readString();
                this.var_3708.push(_loc3_);
                _loc7_++;
            };
            return (true);
        }

        public function getBadgeId(param1:String):int
        {
            return (this.var_3709.getValue(param1));
        }

        public function getAllBadgeCodes():Array
        {
            return (this.var_3707);
        }

        public function getActiveBadgeCodes():Array
        {
            return (this.var_3708);
        }


    }
}