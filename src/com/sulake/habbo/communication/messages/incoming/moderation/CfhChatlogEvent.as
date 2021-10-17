package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.CfhChatlogMessageParser;

    public class CfhChatlogEvent extends MessageEvent implements IMessageEvent 
    {

        public function CfhChatlogEvent(param1:Function)
        {
            super(param1, CfhChatlogMessageParser);
        }

        public function getParser():CfhChatlogMessageParser
        {
            return (var_334 as CfhChatlogMessageParser);
        }


    }
}