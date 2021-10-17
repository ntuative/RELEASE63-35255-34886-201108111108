package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomsData;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomEntryData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OfficialRoomsMessageParser implements IMessageParser 
    {

        private var _data:OfficialRoomsData;
        private var var_3769:OfficialRoomEntryData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._data = new OfficialRoomsData(param1);
            var _loc2_:int = param1.readInteger();
            if (_loc2_ > 0)
            {
                this.var_3769 = new OfficialRoomEntryData(param1);
            };
            return (true);
        }

        public function get data():OfficialRoomsData
        {
            return (this._data);
        }

        public function get adRoom():OfficialRoomEntryData
        {
            return (this.var_3769);
        }


    }
}