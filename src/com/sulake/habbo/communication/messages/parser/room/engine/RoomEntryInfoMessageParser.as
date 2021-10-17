package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.PublicRoomShortData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomEntryInfoMessageParser implements IMessageParser 
    {

        private var var_3811:Boolean;
        private var var_3812:int;
        private var _owner:Boolean;
        private var var_3813:PublicRoomShortData;


        public function get privateRoom():Boolean
        {
            return (this.var_3811);
        }

        public function get guestRoomId():int
        {
            return (this.var_3812);
        }

        public function get publicSpace():PublicRoomShortData
        {
            return (this.var_3813);
        }

        public function get owner():Boolean
        {
            return (this._owner);
        }

        public function flush():Boolean
        {
            if (this.var_3813 != null)
            {
                this.var_3813.dispose();
                this.var_3813 = null;
            };
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3811 = param1.readBoolean();
            if (this.var_3811)
            {
                this.var_3812 = param1.readInteger();
                this._owner = param1.readBoolean();
            }
            else
            {
                this.var_3813 = new PublicRoomShortData(param1);
            };
            return (true);
        }


    }
}