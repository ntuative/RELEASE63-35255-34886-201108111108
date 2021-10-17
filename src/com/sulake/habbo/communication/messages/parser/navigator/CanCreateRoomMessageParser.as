package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CanCreateRoomMessageParser implements IMessageParser 
    {

        public static const var_1912:int = 0;
        public static const var_1913:int = 1;

        private var var_3640:int;
        private var var_3761:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3640 = param1.readInteger();
            this.var_3761 = param1.readInteger();
            return (true);
        }

        public function get resultCode():int
        {
            return (this.var_3640);
        }

        public function get roomLimit():int
        {
            return (this.var_3761);
        }


    }
}