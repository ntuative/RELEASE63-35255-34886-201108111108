package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FavouriteMembershipUpdateMessageParser implements IMessageParser 
    {

        private var var_3804:int;
        private var var_3805:int;
        private var var_2549:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3804 = param1.readInteger();
            this.var_3805 = param1.readInteger();
            this.var_2549 = param1.readInteger();
            return (true);
        }

        public function get roomIndex():int
        {
            return (this.var_3804);
        }

        public function get habboGroupId():int
        {
            return (this.var_3805);
        }

        public function get status():int
        {
            return (this.var_2549);
        }


    }
}