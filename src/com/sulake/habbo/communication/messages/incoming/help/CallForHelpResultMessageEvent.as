﻿package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.CallForHelpResultMessageParser;

    public class CallForHelpResultMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CallForHelpResultMessageEvent(param1:Function)
        {
            super(param1, CallForHelpResultMessageParser);
        }

        public function getParser():CallForHelpResultMessageParser
        {
            return (var_334 as CallForHelpResultMessageParser);
        }


    }
}