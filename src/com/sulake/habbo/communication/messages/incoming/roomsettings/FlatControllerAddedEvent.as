﻿package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllerAddedMessageParser;

    public class FlatControllerAddedEvent extends MessageEvent implements IMessageEvent 
    {

        public function FlatControllerAddedEvent(param1:Function)
        {
            super(param1, FlatControllerAddedMessageParser);
        }

        public function getParser():FlatControllerAddedMessageParser
        {
            return (this.var_334 as FlatControllerAddedMessageParser);
        }


    }
}