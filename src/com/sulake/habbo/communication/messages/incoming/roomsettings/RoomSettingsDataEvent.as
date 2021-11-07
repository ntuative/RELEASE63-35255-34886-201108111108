﻿package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsDataMessageParser;

    public class RoomSettingsDataEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomSettingsDataEvent(param1:Function)
        {
            super(param1, RoomSettingsDataMessageParser);
        }

        public function getParser():RoomSettingsDataMessageParser
        {
            return (this.var_334 as RoomSettingsDataMessageParser);
        }


    }
}