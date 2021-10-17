package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AvailabilityStatusMessageParser implements IMessageParser 
    {

        private var var_3142:Boolean;
        private var var_3635:Boolean;


        public function get isOpen():Boolean
        {
            return (this.var_3142);
        }

        public function get onShutDown():Boolean
        {
            return (this.var_3635);
        }

        public function flush():Boolean
        {
            this.var_3142 = false;
            this.var_3635 = false;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3142 = (param1.readInteger() > 0);
            this.var_3635 = (param1.readInteger() > 0);
            return (true);
        }


    }
}