package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.PlaceObjectErrorMessageParser;

    public class PlaceObjectErrorMessageEvent extends MessageEvent 
    {

        public function PlaceObjectErrorMessageEvent(param1:Function)
        {
            super(param1, PlaceObjectErrorMessageParser);
        }

        public function getParser():PlaceObjectErrorMessageParser
        {
            return (var_334 as PlaceObjectErrorMessageParser);
        }


    }
}