package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.FavouriteChangedMessageParser;

    public class FavouriteChangedEvent extends MessageEvent implements IMessageEvent 
    {

        public function FavouriteChangedEvent(param1:Function)
        {
            super(param1, FavouriteChangedMessageParser);
        }

        public function getParser():FavouriteChangedMessageParser
        {
            return (this.var_334 as FavouriteChangedMessageParser);
        }


    }
}