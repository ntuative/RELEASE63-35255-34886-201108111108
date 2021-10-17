package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSaveErrorMessageParser;

    public class RoomSettingsSaveErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomSettingsSaveErrorEvent(param1:Function)
        {
            super(param1, RoomSettingsSaveErrorMessageParser);
        }

        public function getParser():RoomSettingsSaveErrorMessageParser
        {
            return (this.var_334 as RoomSettingsSaveErrorMessageParser);
        }


    }
}