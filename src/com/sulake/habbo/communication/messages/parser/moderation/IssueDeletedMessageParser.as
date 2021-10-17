package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IssueDeletedMessageParser implements IMessageParser 
    {

        private var var_3735:int;


        public function get issueId():int
        {
            return (this.var_3735);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3735 = parseInt(param1.readString());
            return (true);
        }


    }
}