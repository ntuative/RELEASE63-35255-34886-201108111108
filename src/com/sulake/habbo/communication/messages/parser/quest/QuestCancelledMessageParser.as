package com.sulake.habbo.communication.messages.parser.quest
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class QuestCancelledMessageParser implements IMessageParser 
    {


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            return (true);
        }


    }
}