package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AcceptBuddyFailureData 
    {

        private var var_3389:String;
        private var var_2550:int;

        public function AcceptBuddyFailureData(param1:IMessageDataWrapper)
        {
            this.var_3389 = param1.readString();
            this.var_2550 = param1.readInteger();
        }

        public function get senderName():String
        {
            return (this.var_3389);
        }

        public function get errorCode():int
        {
            return (this.var_2550);
        }


    }
}