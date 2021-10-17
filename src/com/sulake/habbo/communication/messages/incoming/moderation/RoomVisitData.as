package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomVisitData 
    {

        private var var_3462:Boolean;
        private var _roomId:int;
        private var var_3463:String;
        private var var_3469:int;
        private var var_3470:int;

        public function RoomVisitData(param1:IMessageDataWrapper)
        {
            this.var_3462 = param1.readBoolean();
            this._roomId = param1.readInteger();
            this.var_3463 = param1.readString();
            this.var_3469 = param1.readInteger();
            this.var_3470 = param1.readInteger();
        }

        public function get isPublic():Boolean
        {
            return (this.var_3462);
        }

        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomName():String
        {
            return (this.var_3463);
        }

        public function get enterHour():int
        {
            return (this.var_3469);
        }

        public function get enterMinute():int
        {
            return (this.var_3470);
        }


    }
}