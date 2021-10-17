package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.QuestCompletedMessageParser;

    public class QuestCompletedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function QuestCompletedMessageEvent(param1:Function)
        {
            super(param1, QuestCompletedMessageParser);
        }

        public function getParser():QuestCompletedMessageParser
        {
            return (var_334 as QuestCompletedMessageParser);
        }


    }
}