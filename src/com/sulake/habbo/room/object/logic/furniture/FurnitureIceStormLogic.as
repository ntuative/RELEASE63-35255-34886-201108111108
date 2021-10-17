package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class FurnitureIceStormLogic extends FurnitureMultiStateLogic 
    {

        private var var_4507:int = 0;
        private var var_4508:Number = 0;
        private var var_4509:int = 0;


        override public function processUpdateMessage(param1:RoomObjectUpdateMessage):void
        {
            if (param1 == null)
            {
                return;
            };
            var _loc2_:RoomObjectDataUpdateMessage = (param1 as RoomObjectDataUpdateMessage);
            if (_loc2_ != null)
            {
                this.handleDataUpdateMessage(_loc2_);
                return;
            };
            super.processUpdateMessage(param1);
        }

        private function handleDataUpdateMessage(param1:RoomObjectDataUpdateMessage):void
        {
            var _loc2_:int = int((param1.state / 1000));
            var _loc3_:int = (param1.state % 1000);
            if (_loc3_ == 0)
            {
                this.var_4509 = 0;
                param1 = new RoomObjectDataUpdateMessage(_loc2_, String(_loc2_), param1.extra);
                super.processUpdateMessage(param1);
            }
            else
            {
                this.var_4507 = _loc2_;
                this.var_4508 = param1.extra;
                this.var_4509 = (lastUpdateTime + _loc3_);
            };
        }

        override public function update(param1:int):void
        {
            var _loc2_:RoomObjectDataUpdateMessage;
            if (((this.var_4509 > 0) && (param1 >= this.var_4509)))
            {
                this.var_4509 = 0;
                _loc2_ = new RoomObjectDataUpdateMessage(this.var_4507, String(this.var_4507), this.var_4508);
                super.processUpdateMessage(_loc2_);
            };
            super.update(param1);
        }


    }
}