package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllerRemovedMessageParser;

    public class FlatControllerRemovedEvent extends MessageEvent implements IMessageEvent 
    {

        public function FlatControllerRemovedEvent(param1:Function)
        {
            super(param1, FlatControllerRemovedMessageParser);
        }

        public function getParser():FlatControllerRemovedMessageParser
        {
            return (this.var_334 as FlatControllerRemovedMessageParser);
        }


    }
}