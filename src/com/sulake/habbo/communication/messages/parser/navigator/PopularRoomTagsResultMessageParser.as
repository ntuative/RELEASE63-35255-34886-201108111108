﻿package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PopularRoomTagsResultMessageParser implements IMessageParser 
    {

        private var _data:PopularRoomTagsData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._data = new PopularRoomTagsData(param1);
            return (true);
        }

        public function get data():PopularRoomTagsData
        {
            return (this._data);
        }


    }
}