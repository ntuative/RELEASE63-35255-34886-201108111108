package com.sulake.habbo.communication.messages.parser.quest
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class QuestCompletedMessageParser implements IMessageParser 
    {

        private var var_3787:QuestMessageData;


        public function flush():Boolean
        {
            this.var_3787 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3787 = new QuestMessageData(param1);
            return (true);
        }

        public function get questData():QuestMessageData
        {
            return (this.var_3787);
        }


    }
}