package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.QuestMessageParser;

    public class QuestMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function QuestMessageEvent(param1:Function)
        {
            super(param1, QuestMessageParser);
        }

        public function getParser():QuestMessageParser
        {
            return (var_334 as QuestMessageParser);
        }


    }
}