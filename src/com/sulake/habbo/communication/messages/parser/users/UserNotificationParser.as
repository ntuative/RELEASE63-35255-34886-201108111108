package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserNotificationParser implements IMessageParser 
    {

        private var _title:String = "";
        private var _message:String = "";
        private var var_2606:Array;


        public function get title():String
        {
            return (this._title);
        }

        public function get message():String
        {
            return (this._message);
        }

        public function get parameters():Array
        {
            return (this.var_2606);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._title = param1.readString();
            this._message = param1.readString();
            this.var_2606 = new Array();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_2606.push(param1.readString());
                this.var_2606.push(param1.readString());
                _loc3_++;
            };
            return (true);
        }


    }
}