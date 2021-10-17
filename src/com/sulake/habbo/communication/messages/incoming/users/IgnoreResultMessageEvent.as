package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.IgnoreResultMessageParser;

    public class IgnoreResultMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function IgnoreResultMessageEvent(param1:Function)
        {
            super(param1, IgnoreResultMessageParser);
        }

        public function get result():int
        {
            return ((var_334 as IgnoreResultMessageParser).result);
        }


    }
}