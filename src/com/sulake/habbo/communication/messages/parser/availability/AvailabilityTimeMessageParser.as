package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AvailabilityTimeMessageParser implements IMessageParser 
    {

        private var var_3142:Boolean;
        private var var_3636:int;


        public function get isOpen():Boolean
        {
            return (this.var_3142);
        }

        public function get minutesUntilChange():int
        {
            return (this.var_3636);
        }

        public function flush():Boolean
        {
            this.var_3142 = false;
            this.var_3636 = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3142 = (param1.readInteger() > 0);
            this.var_3636 = param1.readInteger();
            return (true);
        }


    }
}