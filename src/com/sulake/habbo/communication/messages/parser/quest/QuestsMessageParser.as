package com.sulake.habbo.communication.messages.parser.quest
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class QuestsMessageParser implements IMessageParser 
    {

        private var var_3789:Array;
        private var var_3790:Boolean;


        public function flush():Boolean
        {
            this.var_3789 = [];
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_3789.push(new QuestMessageData(param1));
                _loc3_++;
            };
            this.var_3790 = param1.readBoolean();
            return (true);
        }

        public function get quests():Array
        {
            return (this.var_3789);
        }

        public function get openWindow():Boolean
        {
            return (this.var_3790);
        }


    }
}