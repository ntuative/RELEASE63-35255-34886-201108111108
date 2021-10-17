package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;

    public class PlaceObjectMessageComposer implements IMessageComposer 
    {

        private var var_1678:int;
        private var var_2823:int;
        private var var_3150:String;
        private var _x:int = 0;
        private var var_2960:int = 0;
        private var var_3536:int = 0;
        private var _roomId:int;
        private var _roomCategory:int;

        public function PlaceObjectMessageComposer(param1:int, param2:int, param3:String, param4:int, param5:int, param6:int, param7:int=0, param8:int=0)
        {
            this.var_1678 = param1;
            this.var_2823 = param2;
            this.var_3150 = param3;
            this._x = param4;
            this.var_2960 = param5;
            this.var_3536 = param6;
            this._roomId = param7;
            this._roomCategory = param8;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            switch (this.var_2823)
            {
                case RoomObjectCategoryEnum.var_70:
                    return ([((((((this.var_1678 + " ") + this._x) + " ") + this.var_2960) + " ") + this.var_3536)]);
                case RoomObjectCategoryEnum.var_71:
                    return ([((this.var_1678 + " ") + this.var_3150)]);
                default:
                    return ([]);
            };
        }


    }
}