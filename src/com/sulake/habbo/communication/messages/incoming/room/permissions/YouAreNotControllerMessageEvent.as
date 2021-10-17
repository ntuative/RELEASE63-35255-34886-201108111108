package com.sulake.habbo.communication.messages.incoming.room.permissions
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.permissions.YouAreNotControllerMessageParser;

    public class YouAreNotControllerMessageEvent extends MessageEvent 
    {

        public function YouAreNotControllerMessageEvent(param1:Function)
        {
            super(param1, YouAreNotControllerMessageParser);
        }

        public function getParser():YouAreNotControllerMessageParser
        {
            return (var_334 as YouAreNotControllerMessageParser);
        }


    }
}