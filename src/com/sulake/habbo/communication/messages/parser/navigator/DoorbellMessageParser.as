package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class DoorbellMessageParser implements IMessageParser 
    {

        private var _userName:String;


        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._userName = param1.readString();
            return (true);
        }

        public function flush():Boolean
        {
            this._userName = null;
            return (true);
        }

        public function get userName():String
        {
            return (this._userName);
        }


    }
}