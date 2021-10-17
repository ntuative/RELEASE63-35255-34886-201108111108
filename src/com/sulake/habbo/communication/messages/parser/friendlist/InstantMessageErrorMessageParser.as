package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class InstantMessageErrorMessageParser implements IMessageParser 
    {

        private var var_2550:int;
        private var _userId:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_2550 = param1.readInteger();
            this._userId = param1.readInteger();
            return (true);
        }

        public function get errorCode():int
        {
            return (this.var_2550);
        }

        public function get userId():int
        {
            return (this._userId);
        }


    }
}