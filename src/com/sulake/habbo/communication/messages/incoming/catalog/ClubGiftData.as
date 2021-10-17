package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ClubGiftData 
    {

        private var var_3082:int;
        private var var_3383:Boolean;
        private var var_2976:Boolean;
        private var var_3384:int;

        public function ClubGiftData(param1:IMessageDataWrapper)
        {
            this.var_3082 = param1.readInteger();
            this.var_3383 = param1.readBoolean();
            this.var_3384 = param1.readInteger();
            this.var_2976 = param1.readBoolean();
        }

        public function get offerId():int
        {
            return (this.var_3082);
        }

        public function get isVip():Boolean
        {
            return (this.var_3383);
        }

        public function get isSelectable():Boolean
        {
            return (this.var_2976);
        }

        public function get daysRequired():int
        {
            return (this.var_3384);
        }


    }
}