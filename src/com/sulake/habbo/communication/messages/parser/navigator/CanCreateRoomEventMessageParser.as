package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CanCreateRoomEventMessageParser implements IMessageParser 
    {

        private var var_3760:Boolean;
        private var var_2550:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3760 = param1.readBoolean();
            this.var_2550 = param1.readInteger();
            return (true);
        }

        public function get canCreateEvent():Boolean
        {
            return (this.var_3760);
        }

        public function get errorCode():int
        {
            return (this.var_2550);
        }


    }
}