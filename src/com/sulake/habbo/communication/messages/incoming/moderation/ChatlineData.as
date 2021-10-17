package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ChatlineData 
    {

        private var var_3449:int;
        private var var_3450:int;
        private var var_3451:int;
        private var var_3452:String;
        private var var_3453:String;

        public function ChatlineData(param1:IMessageDataWrapper)
        {
            this.var_3449 = param1.readInteger();
            this.var_3450 = param1.readInteger();
            this.var_3451 = param1.readInteger();
            this.var_3452 = param1.readString();
            this.var_3453 = param1.readString();
        }

        public function get hour():int
        {
            return (this.var_3449);
        }

        public function get minute():int
        {
            return (this.var_3450);
        }

        public function get chatterId():int
        {
            return (this.var_3451);
        }

        public function get chatterName():String
        {
            return (this.var_3452);
        }

        public function get msg():String
        {
            return (this.var_3453);
        }


    }
}