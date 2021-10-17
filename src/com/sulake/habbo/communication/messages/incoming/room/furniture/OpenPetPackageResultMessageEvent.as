package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.OpenPetPackageResultMessageParser;

    public class OpenPetPackageResultMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function OpenPetPackageResultMessageEvent(param1:Function)
        {
            super(param1, OpenPetPackageResultMessageParser);
        }

        public function getParser():OpenPetPackageResultMessageParser
        {
            return (var_334 as OpenPetPackageResultMessageParser);
        }


    }
}