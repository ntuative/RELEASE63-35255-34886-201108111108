package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RespectNotificationMessageParser implements IMessageParser 
    {

        private var _userId:int = 0;
        private var var_3689:int = 0;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._userId = param1.readInteger();
            this.var_3689 = param1.readInteger();
            return (true);
        }

        public function get userId():int
        {
            return (this._userId);
        }

        public function get respectTotal():int
        {
            return (this.var_3689);
        }


    }
}