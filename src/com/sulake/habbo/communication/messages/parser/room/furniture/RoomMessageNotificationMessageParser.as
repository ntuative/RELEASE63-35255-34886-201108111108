package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomMessageNotificationMessageParser implements IMessageParser 
    {

        private var _roomId:int;
        private var var_3463:String;
        private var var_3823:int;


        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomName():String
        {
            return (this.var_3463);
        }

        public function get messageCount():int
        {
            return (this.var_3823);
        }

        public function flush():Boolean
        {
            this._roomId = -1;
            this.var_3463 = "";
            this.var_3823 = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._roomId = param1.readInteger();
            this.var_3463 = param1.readString();
            this.var_3823 = param1.readInteger();
            return (true);
        }


    }
}