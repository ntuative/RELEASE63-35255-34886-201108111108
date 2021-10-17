package com.sulake.habbo.communication.messages.parser.poll
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PollErrorParser implements IMessageParser 
    {


        public function flush():Boolean
        {
            return (false);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            return (false);
        }


    }
}