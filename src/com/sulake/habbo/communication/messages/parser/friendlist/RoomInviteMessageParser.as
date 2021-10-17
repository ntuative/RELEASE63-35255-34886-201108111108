package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomInviteMessageParser implements IMessageParser 
    {

        private var var_3670:int;
        private var var_3671:String;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3670 = param1.readInteger();
            this.var_3671 = param1.readString();
            return (true);
        }

        public function get senderId():int
        {
            return (this.var_3670);
        }

        public function get messageText():String
        {
            return (this.var_3671);
        }


    }
}