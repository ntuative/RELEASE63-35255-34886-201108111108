package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.ApproveNameMessageParser;

    public class ApproveNameMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ApproveNameMessageEvent(param1:Function)
        {
            super(param1, ApproveNameMessageParser);
        }

        public function getParser():ApproveNameMessageParser
        {
            return (var_334 as ApproveNameMessageParser);
        }


    }
}