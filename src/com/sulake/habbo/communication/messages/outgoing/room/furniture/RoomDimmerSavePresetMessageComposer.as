package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class RoomDimmerSavePresetMessageComposer implements IMessageComposer 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var var_3610:int;
        private var var_3611:int;
        private var var_3612:String;
        private var var_3613:int;
        private var var_3614:Boolean;

        public function RoomDimmerSavePresetMessageComposer(param1:int, param2:int, param3:String, param4:int, param5:Boolean, param6:int=0, param7:int=0)
        {
            this._roomId = param6;
            this._roomCategory = param7;
            this.var_3610 = param1;
            this.var_3611 = param2;
            this.var_3612 = param3;
            this.var_3613 = param4;
            this.var_3614 = param5;
        }

        public function getMessageArray():Array
        {
            return ([this.var_3610, this.var_3611, this.var_3612, this.var_3613, int(this.var_3614)]);
        }

        public function dispose():void
        {
        }


    }
}