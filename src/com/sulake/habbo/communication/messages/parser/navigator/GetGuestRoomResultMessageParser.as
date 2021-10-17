package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GetGuestRoomResultMessageParser implements IMessageParser 
    {

        private var var_3765:Boolean;
        private var var_3766:Boolean;
        private var var_3767:Boolean;
        private var _data:GuestRoomData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3765 = param1.readBoolean();
            this._data = new GuestRoomData(param1);
            this.var_3766 = param1.readBoolean();
            this.var_3767 = param1.readBoolean();
            return (true);
        }

        public function get enterRoom():Boolean
        {
            return (this.var_3765);
        }

        public function get data():GuestRoomData
        {
            return (this._data);
        }

        public function get roomForward():Boolean
        {
            return (this.var_3766);
        }

        public function get staffPick():Boolean
        {
            return (this.var_3767);
        }


    }
}