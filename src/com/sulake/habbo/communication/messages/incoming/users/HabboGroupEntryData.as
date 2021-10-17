package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboGroupEntryData 
    {

        private var var_3581:int;
        private var var_3582:String;
        private var var_3516:String;
        private var var_3584:Boolean;

        public function HabboGroupEntryData(param1:IMessageDataWrapper)
        {
            this.var_3581 = param1.readInteger();
            this.var_3582 = param1.readString();
            this.var_3516 = param1.readString();
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

        public function get badgeCode():String
        {
            return (this.var_3516);
        }

        public function get favourite():Boolean
        {
            return (this.var_3584);
        }


    }
}