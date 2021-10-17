package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorActionResultMessageParser;

    public class ModeratorActionResultMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ModeratorActionResultMessageEvent(param1:Function)
        {
            super(param1, ModeratorActionResultMessageParser);
        }

        public function getParser():ModeratorActionResultMessageParser
        {
            return (var_334 as ModeratorActionResultMessageParser);
        }


    }
}