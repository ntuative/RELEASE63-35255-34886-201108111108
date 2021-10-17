package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IgnoreResultMessageParser implements IMessageParser 
    {

        protected var _result:int;

        public function IgnoreResultMessageParser()
        {
            this._result = -1;
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._result = param1.readInteger();
            return (true);
        }

        public function get result():int
        {
            return (this._result);
        }


    }
}