package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomForwardMessageParser implements IMessageParser 
    {

        private var var_3843:Boolean;
        private var _roomId:int;


        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get publicRoom():Boolean
        {
            return (this.var_3843);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3843 = param1.readBoolean();
            this._roomId = param1.readInteger();
            return (true);
        }


    }
}