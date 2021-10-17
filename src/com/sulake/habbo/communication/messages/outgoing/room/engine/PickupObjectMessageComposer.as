package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;

    public class PickupObjectMessageComposer implements IMessageComposer 
    {

        private var var_1678:int;
        private var var_2823:int;
        private var _roomId:int;
        private var _roomCategory:int;

        public function PickupObjectMessageComposer(param1:int, param2:int, param3:int=0, param4:int=0)
        {
            this.var_1678 = param1;
            this.var_2823 = param2;
            this._roomId = param3;
            this._roomCategory = param4;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            var _loc1_:int;
            switch (this.var_2823)
            {
                case RoomObjectCategoryEnum.var_70:
                    _loc1_ = 2;
                    break;
                case RoomObjectCategoryEnum.var_71:
                    _loc1_ = 1;
                    break;
                default:
                    return ([]);
            };
            return ([_loc1_, this.var_1678]);
        }


    }
}