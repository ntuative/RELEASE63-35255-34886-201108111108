package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class NavigatorSettingsMessageParser implements IMessageParser 
    {

        private var var_3768:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3768 = param1.readInteger();
            return (true);
        }

        public function get homeRoomId():int
        {
            return (this.var_3768);
        }


    }
}