package com.sulake.habbo.communication.messages.parser.inventory.trading
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class TradingOpenParser implements IMessageParser 
    {

        private var _userID:int;
        private var var_3722:Boolean;
        private var var_3723:int;
        private var var_3724:Boolean;


        public function get userID():int
        {
            return (this._userID);
        }

        public function get userCanTrade():Boolean
        {
            return (this.var_3722);
        }

        public function get otherUserID():int
        {
            return (this.var_3723);
        }

        public function get otherUserCanTrade():Boolean
        {
            return (this.var_3724);
        }

        public function flush():Boolean
        {
            this._userID = -1;
            this.var_3722 = false;
            this.var_3723 = -1;
            this.var_3724 = false;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._userID = param1.readInteger();
            this.var_3722 = (param1.readInteger() == 1);
            this.var_3723 = param1.readInteger();
            this.var_3724 = (param1.readInteger() == 1);
            return (true);
        }


    }
}