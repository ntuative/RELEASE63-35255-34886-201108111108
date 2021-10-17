package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomSettingsErrorMessageParser implements IMessageParser 
    {

        private var _roomId:int;
        private var var_2550:int;


        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._roomId = param1.readInteger();
            this.var_2550 = param1.readInteger();
            return (true);
        }

        public function flush():Boolean
        {
            this._roomId = 0;
            this.var_2550 = 0;
            return (true);
        }

        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get errorCode():int
        {
            return (this.var_2550);
        }


    }
}