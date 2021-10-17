package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendCategoryData;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MessengerInitMessageParser implements IMessageParser 
    {

        private var var_3665:int;
        private var var_3666:int;
        private var var_3667:int;
        private var var_3668:int;
        private var var_534:Array;
        private var var_3154:Array;


        public function flush():Boolean
        {
            this.var_534 = new Array();
            this.var_3154 = new Array();
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc4_:int;
            this.var_3665 = param1.readInteger();
            this.var_3666 = param1.readInteger();
            this.var_3667 = param1.readInteger();
            this.var_3668 = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc2_)
            {
                this.var_534.push(new FriendCategoryData(param1));
                _loc4_++;
            };
            var _loc3_:int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_)
            {
                this.var_3154.push(new FriendData(param1));
                _loc4_++;
            };
            return (true);
        }

        public function get userFriendLimit():int
        {
            return (this.var_3665);
        }

        public function get normalFriendLimit():int
        {
            return (this.var_3666);
        }

        public function get extendedFriendLimit():int
        {
            return (this.var_3667);
        }

        public function get categories():Array
        {
            return (this.var_534);
        }

        public function get friends():Array
        {
            return (this.var_3154);
        }

        public function get evenMoreExtendedFriendLimit():int
        {
            return (this.var_3668);
        }


    }
}