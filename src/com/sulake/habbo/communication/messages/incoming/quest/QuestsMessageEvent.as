package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.QuestsMessageParser;

    public class QuestsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function QuestsMessageEvent(param1:Function)
        {
            super(param1, QuestsMessageParser);
        }

        public function getParser():QuestsMessageParser
        {
            return (var_334 as QuestsMessageParser);
        }


    }
}