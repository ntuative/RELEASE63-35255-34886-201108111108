package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomInviteErrorMessageParser implements IMessageParser 
    {

        private var var_2550:int;
        private var var_3672:Array;


        public function flush():Boolean
        {
            this.var_3672 = new Array();
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc2_:int;
            var _loc3_:int;
            this.var_2550 = param1.readInteger();
            if (this.var_2550 == 1)
            {
                _loc2_ = param1.readInteger();
                _loc3_ = 0;
                while (_loc3_ < _loc2_)
                {
                    this.var_3672.push(param1.readInteger());
                    _loc3_++;
                };
            };
            return (true);
        }

        public function get errorCode():int
        {
            return (this.var_2550);
        }

        public function get failedRecipients():Array
        {
            return (this.var_3672);
        }


    }
}