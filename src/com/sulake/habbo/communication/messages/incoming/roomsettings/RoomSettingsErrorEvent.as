package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsErrorMessageParser;

    public class RoomSettingsErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomSettingsErrorEvent(param1:Function)
        {
            super(param1, RoomSettingsErrorMessageParser);
        }

        public function getParser():RoomSettingsErrorMessageParser
        {
            return (this.var_334 as RoomSettingsErrorMessageParser);
        }


    }
}