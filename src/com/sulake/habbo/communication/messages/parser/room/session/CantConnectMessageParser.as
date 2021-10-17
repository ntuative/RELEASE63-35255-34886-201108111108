package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CantConnectMessageParser implements IMessageParser 
    {

        public static const var_941:int = 1;
        public static const var_1916:int = 2;
        public static const var_942:int = 3;
        public static const var_943:int = 4;

        private var var_3673:int = 0;
        private var var_3194:String = "";


        public function flush():Boolean
        {
            this.var_3673 = 0;
            this.var_3194 = "";
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3673 = param1.readInteger();
            if (this.var_3673 == 3)
            {
                this.var_3194 = param1.readString();
            }
            else
            {
                this.var_3194 = "";
            };
            return (true);
        }

        public function get reason():int
        {
            return (this.var_3673);
        }

        public function get parameter():String
        {
            return (this.var_3194);
        }


    }
}