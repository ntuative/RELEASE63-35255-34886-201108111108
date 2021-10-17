package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FriendNotificationMessageParser implements IMessageParser 
    {

        private var var_3662:int = -1;
        private var var_3408:String;
        private var _message:String;


        public function get typeCode():int
        {
            return (this.var_3662);
        }

        public function get avatarId():String
        {
            return (this.var_3408);
        }

        public function get message():String
        {
            return (this._message);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3408 = param1.readString();
            this.var_3662 = param1.readInteger();
            this._message = param1.readString();
            return (true);
        }


    }
}