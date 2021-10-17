package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboAchievementShareIdMessageParser implements IMessageParser 
    {

        private var var_3772:String = "";
        private var var_3773:String = "";


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3772 = param1.readString();
            this.var_3773 = param1.readString();
            return (true);
        }

        public function get badgeID():String
        {
            return (this.var_3772);
        }

        public function get shareID():String
        {
            return (this.var_3773);
        }


    }
}