package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomVisualizationSettingsParser;

    public class RoomVisualizationSettingsEvent extends MessageEvent 
    {

        public function RoomVisualizationSettingsEvent(param1:Function)
        {
            super(param1, RoomVisualizationSettingsParser);
        }

        public function getParser():RoomVisualizationSettingsParser
        {
            return (var_334 as RoomVisualizationSettingsParser);
        }


    }
}