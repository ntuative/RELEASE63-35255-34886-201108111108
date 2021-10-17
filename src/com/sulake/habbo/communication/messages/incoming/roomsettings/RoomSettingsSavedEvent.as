package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSavedMessageParser;

    public class RoomSettingsSavedEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomSettingsSavedEvent(param1:Function)
        {
            super(param1, RoomSettingsSavedMessageParser);
        }

        public function getParser():RoomSettingsSavedMessageParser
        {
            return (this.var_334 as RoomSettingsSavedMessageParser);
        }


    }
}