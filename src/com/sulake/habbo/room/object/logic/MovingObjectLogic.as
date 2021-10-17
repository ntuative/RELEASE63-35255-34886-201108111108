package com.sulake.habbo.room.object.logic
{
    import com.sulake.room.object.logic.ObjectLogicBase;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.room.messages.RoomObjectMoveUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;

    public class MovingObjectLogic extends ObjectLogicBase 
    {

        public static const var_1036:int = 500;
        private static var var_1037:Vector3d = new Vector3d();

        private var var_4552:Vector3d = new Vector3d();
        private var var_3543:Vector3d = new Vector3d();
        private var var_4553:Number = 0;
        private var _lastUpdateTime:int = 0;
        private var var_4554:int;
        private var var_4527:int = 500;


        protected function get lastUpdateTime():int
        {
            return (this._lastUpdateTime);
        }

        override public function dispose():void
        {
            super.dispose();
            this.var_3543 = null;
            this.var_4552 = null;
        }

        override public function set object(param1:IRoomObjectController):void
        {
            super.object = param1;
            if (param1 != null)
            {
                this.var_3543.assign(param1.getLocation());
            };
        }

        protected function set moveUpdateInterval(param1:int):void
        {
            if (param1 <= 0)
            {
                param1 = 1;
            };
            this.var_4527 = param1;
        }

        override public function processUpdateMessage(param1:RoomObjectUpdateMessage):void
        {
            var _loc3_:IVector3d;
            if (param1 == null)
            {
                return;
            };
            super.processUpdateMessage(param1);
            if (param1.loc != null)
            {
                this.var_3543.assign(param1.loc);
            };
            var _loc2_:RoomObjectMoveUpdateMessage = (param1 as RoomObjectMoveUpdateMessage);
            if (_loc2_ == null)
            {
                return;
            };
            if (object != null)
            {
                if (param1.loc != null)
                {
                    _loc3_ = _loc2_.targetLoc;
                    this.var_4554 = this._lastUpdateTime;
                    this.var_4552.assign(_loc3_);
                    this.var_4552.sub(this.var_3543);
                };
            };
        }

        protected function getLocationOffset():IVector3d
        {
            return (null);
        }

        override public function update(param1:int):void
        {
            var _loc4_:int;
            var _loc2_:IVector3d = this.getLocationOffset();
            var _loc3_:IRoomObjectModelController = object.getModelController();
            if (_loc3_ != null)
            {
                if (_loc2_ != null)
                {
                    if (this.var_4553 != _loc2_.z)
                    {
                        this.var_4553 = _loc2_.z;
                        _loc3_.setNumber(RoomObjectVariableEnum.var_761, this.var_4553);
                    };
                }
                else
                {
                    if (this.var_4553 != 0)
                    {
                        this.var_4553 = 0;
                        _loc3_.setNumber(RoomObjectVariableEnum.var_761, this.var_4553);
                    };
                };
            };
            if (((this.var_4552.length > 0) || (!(_loc2_ == null))))
            {
                _loc4_ = (param1 - this.var_4554);
                if (_loc4_ == (this.var_4527 >> 1))
                {
                    _loc4_++;
                };
                if (_loc4_ > this.var_4527)
                {
                    _loc4_ = this.var_4527;
                };
                if (this.var_4552.length > 0)
                {
                    var_1037.assign(this.var_4552);
                    var_1037.mul((_loc4_ / Number(this.var_4527)));
                    var_1037.add(this.var_3543);
                }
                else
                {
                    var_1037.assign(this.var_3543);
                };
                if (_loc2_ != null)
                {
                    var_1037.add(_loc2_);
                };
                if (object != null)
                {
                    object.setLocation(var_1037);
                };
                if (_loc4_ == this.var_4527)
                {
                    this.var_4552.x = 0;
                    this.var_4552.y = 0;
                    this.var_4552.z = 0;
                };
            };
            this._lastUpdateTime = param1;
        }


    }
}