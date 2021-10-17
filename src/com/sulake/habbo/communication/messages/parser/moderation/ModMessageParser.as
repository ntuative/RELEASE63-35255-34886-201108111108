package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ModMessageParser implements IMessageParser 
    {

        private var _message:String;
        private var var_2552:String;


        public function get message():String
        {
            return (this._message);
        }

        public function get url():String
        {
            return (this.var_2552);
        }

        public function flush():Boolean
        {
            this._message = "";
            this.var_2552 = "";
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._message = param1.readString();
            this.var_2552 = param1.readString();
            return (true);
        }


    }
}