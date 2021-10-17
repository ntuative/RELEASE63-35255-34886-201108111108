package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.QuestCancelledMessageParser;

    public class QuestCancelledMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function QuestCancelledMessageEvent(param1:Function)
        {
            super(param1, QuestCancelledMessageParser);
        }

        public function getParser():QuestCancelledMessageParser
        {
            return (var_334 as QuestCancelledMessageParser);
        }


    }
}