package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CallForHelpResultMessageParser implements IMessageParser 
    {

        private var var_3695:int;


        public function get resultType():int
        {
            return (this.var_3695);
        }

        public function flush():Boolean
        {
            this.var_3695 = -1;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3695 = param1.readInteger();
            return (true);
        }


    }
}