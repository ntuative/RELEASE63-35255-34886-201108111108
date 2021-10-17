package com.sulake.habbo.communication.messages.parser.quest
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class QuestMessageParser implements IMessageParser 
    {

        private var var_3788:QuestMessageData;


        public function flush():Boolean
        {
            this.var_3788 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3788 = new QuestMessageData(param1);
            return (true);
        }

        public function get quest():QuestMessageData
        {
            return (this.var_3788);
        }


    }
}