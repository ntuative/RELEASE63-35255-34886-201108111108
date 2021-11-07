﻿package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.MessengerInitMessageParser;

    public class MessengerInitEvent extends MessageEvent implements IMessageEvent 
    {

        public function MessengerInitEvent(param1:Function)
        {
            super(param1, MessengerInitMessageParser);
        }

        public function getParser():MessengerInitMessageParser
        {
            return (this.var_334 as MessengerInitMessageParser);
        }


    }
}