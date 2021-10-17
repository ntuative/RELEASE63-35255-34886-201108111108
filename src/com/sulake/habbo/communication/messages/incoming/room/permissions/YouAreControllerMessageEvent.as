package com.sulake.habbo.communication.messages.incoming.room.permissions
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.permissions.YouAreControllerMessageParser;

    public class YouAreControllerMessageEvent extends MessageEvent 
    {

        public function YouAreControllerMessageEvent(param1:Function)
        {
            super(param1, YouAreControllerMessageParser);
        }

        public function getParser():YouAreControllerMessageParser
        {
            return (var_334 as YouAreControllerMessageParser);
        }


    }
}