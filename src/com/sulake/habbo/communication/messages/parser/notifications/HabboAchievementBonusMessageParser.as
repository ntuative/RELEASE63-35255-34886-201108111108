package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboAchievementBonusMessageParser implements IMessageParser 
    {

        private var var_3515:int;
        private var _realName:String;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3515 = param1.readInteger();
            this._realName = param1.readString();
            return (true);
        }

        public function get bonusPoints():int
        {
            return (this.var_3515);
        }

        public function get realName():String
        {
            return (this._realName);
        }


    }
}