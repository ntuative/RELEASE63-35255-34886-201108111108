package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ModeratorActionResultMessageParser implements IMessageParser 
    {

        private var _userId:int;
        private var var_3658:Boolean;


        public function get userId():int
        {
            return (this._userId);
        }

        public function get success():Boolean
        {
            return (this.var_3658);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._userId = param1.readInteger();
            this.var_3658 = param1.readBoolean();
            return (true);
        }


    }
}