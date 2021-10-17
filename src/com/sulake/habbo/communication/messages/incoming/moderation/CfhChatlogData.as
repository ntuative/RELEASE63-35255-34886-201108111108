package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CfhChatlogData 
    {

        private var var_3444:int;
        private var var_3445:int;
        private var var_3446:int;
        private var var_3447:int;
        private var var_3448:RoomChatlogData;

        public function CfhChatlogData(param1:IMessageDataWrapper)
        {
            this.var_3444 = param1.readInteger();
            this.var_3445 = param1.readInteger();
            this.var_3446 = param1.readInteger();
            this.var_3447 = param1.readInteger();
            this.var_3448 = new RoomChatlogData(param1);
            Logger.log(("READ CFHCHATLOGDATA: callId: " + this.var_3444));
        }

        public function get callId():int
        {
            return (this.var_3444);
        }

        public function get callerUserId():int
        {
            return (this.var_3445);
        }

        public function get reportedUserId():int
        {
            return (this.var_3446);
        }

        public function get chatRecordId():int
        {
            return (this.var_3447);
        }

        public function get room():RoomChatlogData
        {
            return (this.var_3448);
        }


    }
}