package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatAccessDeniedMessageParser implements IMessageParser 
    {

        private var _userName:String = null;


        public function get userName():String
        {
            return (this._userName);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 != null)
            {
                this._userName = param1.readString();
            };
            return (true);
        }

        public function flush():Boolean
        {
            this._userName = null;
            return (true);
        }


    }
}