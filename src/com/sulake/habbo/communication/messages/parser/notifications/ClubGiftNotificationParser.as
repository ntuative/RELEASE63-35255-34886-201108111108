package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ClubGiftNotificationParser implements IMessageParser 
    {

        private var var_3771:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3771 = param1.readInteger();
            return (true);
        }

        public function get numGifts():int
        {
            return (this.var_3771);
        }


    }
}