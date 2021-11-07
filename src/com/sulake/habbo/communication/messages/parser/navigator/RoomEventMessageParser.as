﻿package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomEventMessageParser implements IMessageParser 
    {

        private var _data:RoomEventData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._data = new RoomEventData(param1);
            return (true);
        }

        public function get data():RoomEventData
        {
            return (this._data);
        }


    }
}