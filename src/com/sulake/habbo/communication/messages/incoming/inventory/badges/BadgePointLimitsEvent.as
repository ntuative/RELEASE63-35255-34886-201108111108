package com.sulake.habbo.communication.messages.incoming.inventory.badges
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgePointLimitsParser;

    public class BadgePointLimitsEvent extends MessageEvent 
    {

        public function BadgePointLimitsEvent(param1:Function)
        {
            super(param1, BadgePointLimitsParser);
        }

        public function getParser():BadgePointLimitsParser
        {
            return (var_334 as BadgePointLimitsParser);
        }


    }
}