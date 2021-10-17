package com.sulake.habbo.communication.messages.parser.inventory.badges
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class BadgeAndPointLimit 
    {

        private var var_3417:String;
        private var var_3706:int;

        public function BadgeAndPointLimit(param1:String, param2:IMessageDataWrapper)
        {
            this.var_3417 = (("ACH_" + param1) + param2.readInteger());
            this.var_3706 = param2.readInteger();
        }

        public function get badgeId():String
        {
            return (this.var_3417);
        }

        public function get limit():int
        {
            return (this.var_3706);
        }


    }
}