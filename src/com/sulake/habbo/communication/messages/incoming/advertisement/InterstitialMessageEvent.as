﻿package com.sulake.habbo.communication.messages.incoming.advertisement
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.advertisement.InterstitialMessageParser;

    public class InterstitialMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function InterstitialMessageEvent(param1:Function)
        {
            super(param1, InterstitialMessageParser);
        }

        public function getParser():InterstitialMessageParser
        {
            return (this.var_334 as InterstitialMessageParser);
        }


    }
}