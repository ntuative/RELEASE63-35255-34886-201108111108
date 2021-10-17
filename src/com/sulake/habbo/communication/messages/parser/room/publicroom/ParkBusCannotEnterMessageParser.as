package com.sulake.habbo.communication.messages.parser.room.publicroom
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ParkBusCannotEnterMessageParser implements IMessageParser 
    {

        private var var_3673:String = "";


        public function get reason():String
        {
            return (this.var_3673);
        }

        public function flush():Boolean
        {
            this.var_3673 = "";
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3673 = param1.readString();
            return (true);
        }


    }
}