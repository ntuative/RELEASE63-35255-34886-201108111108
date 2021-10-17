package com.sulake.habbo.communication.messages.incoming.inventory.badges
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgesParser;

    public class BadgesEvent extends MessageEvent 
    {

        public function BadgesEvent(param1:Function)
        {
            super(param1, BadgesParser);
        }

        public function getParser():BadgesParser
        {
            return (var_334 as BadgesParser);
        }


    }
}