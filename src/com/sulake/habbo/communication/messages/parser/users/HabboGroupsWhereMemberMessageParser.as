package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupEntryData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboGroupsWhereMemberMessageParser implements IMessageParser 
    {

        private var var_3203:Array;


        public function flush():Boolean
        {
            this.var_3203 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3203 = new Array();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_3203.push(new HabboGroupEntryData(param1));
                _loc3_++;
            };
            return (true);
        }

        public function get groups():Array
        {
            return (this.var_3203);
        }


    }
}