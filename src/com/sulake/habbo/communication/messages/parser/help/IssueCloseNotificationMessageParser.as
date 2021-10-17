package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IssueCloseNotificationMessageParser implements IMessageParser 
    {

        private var var_3699:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3699 = param1.readInteger();
            return (true);
        }

        public function get closeReason():int
        {
            return (this.var_3699);
        }


    }
}