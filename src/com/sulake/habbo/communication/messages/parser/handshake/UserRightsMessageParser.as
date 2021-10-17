package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserRightsMessageParser implements IMessageParser 
    {

        private var _clubLevel:int;
        private var var_3693:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._clubLevel = param1.readInteger();
            this.var_3693 = param1.readInteger();
            return (true);
        }

        public function get clubLevel():int
        {
            return (this._clubLevel);
        }

        public function get securityLevel():int
        {
            return (this.var_3693);
        }


    }
}