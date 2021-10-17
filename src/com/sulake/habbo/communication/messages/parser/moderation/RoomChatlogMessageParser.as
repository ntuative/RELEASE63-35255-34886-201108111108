package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomChatlogData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomChatlogMessageParser implements IMessageParser 
    {

        private var _data:RoomChatlogData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._data = new RoomChatlogData(param1);
            return (true);
        }

        public function get data():RoomChatlogData
        {
            return (this._data);
        }


    }
}