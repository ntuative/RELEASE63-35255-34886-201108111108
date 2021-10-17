package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboGroupDetailsMessageParser implements IMessageParser 
    {

        private var _data:HabboGroupDetailsData;


        public function flush():Boolean
        {
            this._data = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._data = new HabboGroupDetailsData(param1);
            return (true);
        }

        public function get data():HabboGroupDetailsData
        {
            return (this._data);
        }


    }
}