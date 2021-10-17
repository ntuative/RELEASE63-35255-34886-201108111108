package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.WelcomeGiftStatusParser;

    public class WelcomeGiftStatusEvent extends MessageEvent 
    {

        public function WelcomeGiftStatusEvent(param1:Function)
        {
            super(param1, WelcomeGiftStatusParser);
        }

        public function getParser():WelcomeGiftStatusParser
        {
            return (var_334 as WelcomeGiftStatusParser);
        }


    }
}