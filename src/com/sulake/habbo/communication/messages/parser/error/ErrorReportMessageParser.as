package com.sulake.habbo.communication.messages.parser.error
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ErrorReportMessageParser implements IMessageParser 
    {

        private var var_2550:int;
        private var var_3650:int;
        private var var_3651:String;


        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3650 = param1.readInteger();
            this.var_2550 = param1.readInteger();
            this.var_3651 = param1.readString();
            return (true);
        }

        public function flush():Boolean
        {
            this.var_2550 = 0;
            this.var_3650 = 0;
            this.var_3651 = null;
            return (true);
        }

        public function get errorCode():int
        {
            return (this.var_2550);
        }

        public function get messageId():int
        {
            return (this.var_3650);
        }

        public function get timestamp():String
        {
            return (this.var_3651);
        }


    }
}