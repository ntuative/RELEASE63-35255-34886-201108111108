package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FriendRequestData 
    {

        private var var_3405:int;
        private var var_3406:String;
        private var var_3407:int;
        private var var_3066:String;

        public function FriendRequestData(param1:IMessageDataWrapper)
        {
            this.var_3405 = param1.readInteger();
            this.var_3406 = param1.readString();
            this.var_3066 = param1.readString();
            this.var_3407 = this.var_3405;
        }

        public function get requestId():int
        {
            return (this.var_3405);
        }

        public function get requesterName():String
        {
            return (this.var_3406);
        }

        public function get requesterUserId():int
        {
            return (this.var_3407);
        }

        public function get figureString():String
        {
            return (this.var_3066);
        }


    }
}