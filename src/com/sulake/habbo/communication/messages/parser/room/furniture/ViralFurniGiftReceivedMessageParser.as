package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ViralFurniGiftReceivedMessageParser implements IMessageParser 
    {

        private var var_3824:String;
        private var var_3825:Boolean;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3824 = param1.readString();
            this.var_3825 = param1.readBoolean();
            return (true);
        }

        public function get firstClickUserName():String
        {
            return (this.var_3824);
        }

        public function get giftWasReceived():Boolean
        {
            return (this.var_3825);
        }


    }
}