package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OpenPetPackageResultMessageParser implements IMessageParser 
    {

        private var var_1678:int = 0;
        private var var_3822:int = 0;
        private var var_3186:String = null;


        public function get objectId():int
        {
            return (this.var_1678);
        }

        public function get nameValidationStatus():int
        {
            return (this.var_3822);
        }

        public function get nameValidationInfo():String
        {
            return (this.var_3186);
        }

        public function flush():Boolean
        {
            this.var_1678 = 0;
            this.var_3822 = 0;
            this.var_3186 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            this.var_1678 = param1.readInteger();
            this.var_3822 = param1.readInteger();
            this.var_3186 = param1.readString();
            return (true);
        }


    }
}