package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.AcceptBuddyFailureData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AcceptBuddyResultMessageParser implements IMessageParser 
    {

        private var var_3655:Array;


        public function flush():Boolean
        {
            this.var_3655 = new Array();
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_3655.push(new AcceptBuddyFailureData(param1));
                _loc3_++;
            };
            return (true);
        }

        public function get failures():Array
        {
            return (this.var_3655);
        }


    }
}