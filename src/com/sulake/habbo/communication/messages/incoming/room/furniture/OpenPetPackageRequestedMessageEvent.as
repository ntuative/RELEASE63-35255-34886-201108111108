package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.OpenPetPackageRequestedMessageParser;

    public class OpenPetPackageRequestedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function OpenPetPackageRequestedMessageEvent(param1:Function)
        {
            super(param1, OpenPetPackageRequestedMessageParser);
        }

        public function getParser():OpenPetPackageRequestedMessageParser
        {
            return (var_334 as OpenPetPackageRequestedMessageParser);
        }


    }
}