package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import flash.utils.getTimer;

    public class FurnitureScoreBoardLogic extends FurnitureLogic 
    {

        private static const var_1047:int = 50;
        private static const var_1048:int = 3000;

        private var var_3478:int = 0;
        private var var_4526:int = 0;
        private var var_4527:int = 50;


        override public function processUpdateMessage(param1:RoomObjectUpdateMessage):void
        {
            var _loc2_:RoomObjectDataUpdateMessage = (param1 as RoomObjectDataUpdateMessage);
            if (_loc2_ != null)
            {
                this.updateScore(_loc2_.state);
                return;
            };
            super.processUpdateMessage(param1);
        }

        private function updateScore(param1:int):void
        {
            var _loc3_:int;
            this.var_3478 = param1;
            var _loc2_:int = object.getState(0);
            if (this.var_3478 != _loc2_)
            {
                _loc3_ = (this.var_3478 - _loc2_);
                if (_loc3_ < 0)
                {
                    _loc3_ = -(_loc3_);
                };
                if ((_loc3_ * var_1047) > var_1048)
                {
                    this.var_4527 = (var_1048 / _loc3_);
                }
                else
                {
                    this.var_4527 = var_1047;
                };
                this.var_4526 = getTimer();
            };
        }

        override public function update(param1:int):void
        {
            var _loc2_:int;
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:int;
            super.update(param1);
            if (object != null)
            {
                _loc2_ = object.getState(0);
                if (((!(_loc2_ == this.var_3478)) && (param1 >= (this.var_4526 + this.var_4527))))
                {
                    _loc3_ = (param1 - this.var_4526);
                    _loc4_ = int((_loc3_ / this.var_4527));
                    _loc5_ = 1;
                    if (this.var_3478 < _loc2_)
                    {
                        _loc5_ = -1;
                    };
                    if (_loc4_ > (_loc5_ * (this.var_3478 - _loc2_)))
                    {
                        _loc4_ = (_loc5_ * (this.var_3478 - _loc2_));
                    };
                    object.setState((_loc2_ + (_loc5_ * _loc4_)), 0);
                    this.var_4526 = (param1 - (_loc3_ - (_loc4_ * this.var_4527)));
                };
            };
        }


    }
}