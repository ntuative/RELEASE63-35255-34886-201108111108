﻿package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomVisitsData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomVisitsMessageParser implements IMessageParser 
    {

        private var _data:RoomVisitsData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._data = new RoomVisitsData(param1);
            return (true);
        }

        public function get data():RoomVisitsData
        {
            return (this._data);
        }


    }
}