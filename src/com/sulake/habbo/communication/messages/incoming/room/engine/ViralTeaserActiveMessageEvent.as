package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ViralTeaserActiveMessageParser;

    public class ViralTeaserActiveMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ViralTeaserActiveMessageEvent(param1:Function)
        {
            super(param1, ViralTeaserActiveMessageParser);
        }

        public function getParser():ViralTeaserActiveMessageParser
        {
            return (var_334 as ViralTeaserActiveMessageParser);
        }


    }
}