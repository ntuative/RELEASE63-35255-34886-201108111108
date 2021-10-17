package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboGroupDetailsData 
    {

        public static const var_1751:int = 0;
        public static const var_2427:int = 1;
        public static const var_1752:int = 2;

        private var var_3581:int;
        private var var_3582:String;
        private var var_2867:String;
        private var var_3516:String;
        private var _roomId:int = -1;
        private var var_3463:String = "";
        private var var_2549:int;
        private var var_3583:int;
        private var var_3584:Boolean;

        public function HabboGroupDetailsData(param1:IMessageDataWrapper)
        {
            this.var_3581 = param1.readInteger();
            this.var_3582 = param1.readString();
            this.var_2867 = param1.readString();
            this.var_3516 = param1.readString();
            this._roomId = param1.readInteger();
            this.var_3463 = param1.readString();
            this.var_2549 = param1.readInteger();
            this.var_3583 = param1.readInteger();
            this.var_3584 = param1.readBoolean();
        }

        public function get groupId():int
        {
            return (this.var_3581);
        }

        public function get groupName():String
        {
            return (this.var_3582);
        }

        public function get description():String
        {
            return (this.var_2867);
        }

        public function get badgeCode():String
        {
            return (this.var_3516);
        }

        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomName():String
        {
            return (this.var_3463);
        }

        public function get status():int
        {
            return (this.var_2549);
        }

        public function get totalMembers():int
        {
            return (this.var_3583);
        }

        public function get favourite():Boolean
        {
            return (this.var_3584);
        }


    }
}