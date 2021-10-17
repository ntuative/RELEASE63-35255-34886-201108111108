package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.object.logic.MovingObjectLogic;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
    import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
    import com.sulake.room.events.RoomObjectMouseEvent;
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.room.utils.XMLValidator;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.room.events.RoomObjectEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectItemDataUpdateMessage;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.room.messages.RoomObjectMoveUpdateMessage;

    public class FurnitureLogic extends MovingObjectLogic 
    {

        private static const var_1039:int = 8;
        private static const var_1040:Number = (1 / 16);//0.0625

        private var var_4511:Boolean = false;
        private var var_3540:Number = 0;
        private var var_3541:Number = 0;
        private var var_4512:Number = 0;
        private var var_4513:Number = 0;
        private var var_4514:Number = 0;
        private var var_4515:Number = 0;
        private var var_4516:Boolean = false;
        private var var_4517:int = 0;
        private var var_4518:RoomObjectUpdateMessage;
        private var var_4519:Vector3d = new Vector3d();
        private var var_4520:Array = [];


        override public function getEventTypes():Array
        {
            var _loc1_:Array = [RoomObjectRoomAdEvent.var_321, RoomObjectRoomAdEvent.var_322, RoomObjectRoomAdEvent.var_320, RoomObjectStateChangeEvent.var_1038, RoomObjectMouseEvent.var_496, RoomObjectRoomAdEvent.var_49, RoomObjectMouseEvent.var_498];
            return (getAllEventTypes(super.getEventTypes(), _loc1_));
        }

        override public function dispose():void
        {
            super.dispose();
            this.var_4518 = null;
            this.var_4520 = null;
        }

        override public function set object(param1:IRoomObjectController):void
        {
            super.object = param1;
            if (((!(param1 == null)) && (param1.getLocation().length > 0)))
            {
                this.var_4516 = true;
            };
        }

        override public function initialize(param1:XML):void
        {
            var _loc7_:XML;
            var _loc8_:int;
            if (param1 == null)
            {
                return;
            };
            this.var_3540 = 0;
            this.var_3541 = 0;
            this.var_4512 = 0;
            this.var_4520 = [];
            var _loc2_:XMLList = param1.model.dimensions;
            if (_loc2_.length() == 0)
            {
                return;
            };
            var _loc3_:XMLList = _loc2_.@x;
            if (_loc3_.length() == 1)
            {
                this.var_3540 = Number(_loc3_);
            };
            _loc3_ = _loc2_.@y;
            if (_loc3_.length() == 1)
            {
                this.var_3541 = Number(_loc3_);
            };
            _loc3_ = _loc2_.@z;
            if (_loc3_.length() == 1)
            {
                this.var_4512 = Number(_loc3_);
            };
            this.var_4513 = (this.var_3540 / 2);
            this.var_4514 = (this.var_3541 / 2);
            _loc3_ = _loc2_.@centerZ;
            if (_loc3_.length() == 1)
            {
                this.var_4515 = Number(_loc3_);
            }
            else
            {
                this.var_4515 = (this.var_4512 / 2);
            };
            var _loc4_:XMLList = param1.model.directions.direction;
            var _loc5_:Array = ["id"];
            var _loc6_:int;
            while (_loc6_ < _loc4_.length())
            {
                _loc7_ = _loc4_[_loc6_];
                if (XMLValidator.checkRequiredAttributes(_loc7_, _loc5_))
                {
                    _loc8_ = parseInt(_loc7_.@id);
                    this.var_4520.push(_loc8_);
                };
                _loc6_++;
            };
            this.var_4520.sort(Array.NUMERIC);
            if (((object == null) || (object.getModelController() == null)))
            {
                return;
            };
            object.getModelController().setNumber(RoomObjectVariableEnum.var_457, this.var_3540, true);
            object.getModelController().setNumber(RoomObjectVariableEnum.var_458, this.var_3541, true);
            object.getModelController().setNumber(RoomObjectVariableEnum.var_757, this.var_4512, true);
            object.getModelController().setNumber(RoomObjectVariableEnum.var_758, this.var_4513, true);
            object.getModelController().setNumber(RoomObjectVariableEnum.var_759, this.var_4514, true);
            object.getModelController().setNumber(RoomObjectVariableEnum.var_760, this.var_4515, true);
            object.getModelController().setNumberArray(RoomObjectVariableEnum.var_762, this.var_4520, true);
            object.getModelController().setNumber(RoomObjectVariableEnum.var_150, 1);
        }

        protected function getAdClickUrl(param1:IRoomObjectModelController):String
        {
            return (param1.getString(RoomObjectVariableEnum.var_501));
        }

        protected function handleAdClick(param1:int, param2:String, param3:String):void
        {
            if (eventDispatcher != null)
            {
                eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.var_49, param1, param2));
            };
        }

        override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry):void
        {
            var _loc4_:int;
            var _loc5_:String;
            var _loc6_:RoomObjectEvent;
            if (((param1 == null) || (param2 == null)))
            {
                return;
            };
            if (param1.type == MouseEvent.MOUSE_MOVE)
            {
                return;
            };
            if (object == null)
            {
                return;
            };
            var _loc3_:IRoomObjectModelController = (object.getModel() as IRoomObjectModelController);
            if (_loc3_ == null)
            {
                return;
            };
            var _loc7_:String = this.getAdClickUrl(_loc3_);
            switch (param1.type)
            {
                case MouseEvent.ROLL_OVER:
                    if (!this.var_4511)
                    {
                        if ((((!(eventDispatcher == null)) && (!(_loc7_ == null))) && (_loc7_.indexOf("http") == 0)))
                        {
                            _loc4_ = object.getId();
                            _loc5_ = object.getType();
                            eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.var_321, _loc4_, _loc5_));
                        };
                        this.var_4511 = true;
                    };
                    return;
                case MouseEvent.ROLL_OUT:
                    if (this.var_4511)
                    {
                        if ((((!(eventDispatcher == null)) && (!(_loc7_ == null))) && (_loc7_.indexOf("http") == 0)))
                        {
                            _loc4_ = object.getId();
                            _loc5_ = object.getType();
                            eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.var_322, _loc4_, _loc5_));
                        };
                        this.var_4511 = false;
                    };
                    return;
                case MouseEvent.DOUBLE_CLICK:
                    this.useObject();
                    return;
                case MouseEvent.CLICK:
                    _loc4_ = object.getId();
                    _loc5_ = object.getType();
                    if (eventDispatcher != null)
                    {
                        _loc6_ = new RoomObjectMouseEvent(RoomObjectMouseEvent.var_496, param1.eventId, _loc4_, _loc5_, param1.altKey, param1.ctrlKey, param1.shiftKey, param1.buttonDown);
                        eventDispatcher.dispatchEvent(_loc6_);
                    };
                    if ((((!(eventDispatcher == null)) && (!(_loc7_ == null))) && (_loc7_.indexOf("http") == 0)))
                    {
                        this.handleAdClick(_loc4_, _loc5_, _loc7_);
                    };
                    return;
                case MouseEvent.MOUSE_DOWN:
                    if (eventDispatcher != null)
                    {
                        _loc4_ = object.getId();
                        _loc5_ = object.getType();
                        _loc6_ = new RoomObjectMouseEvent(RoomObjectMouseEvent.var_498, param1.eventId, _loc4_, _loc5_, param1.altKey, param1.ctrlKey, param1.shiftKey, param1.buttonDown);
                        eventDispatcher.dispatchEvent(_loc6_);
                    };
                    return;
            };
        }

        override public function useObject():void
        {
            var _loc1_:int;
            var _loc2_:String;
            var _loc3_:IRoomObjectModelController;
            var _loc4_:String;
            if (object != null)
            {
                _loc1_ = object.getId();
                _loc2_ = object.getType();
                _loc3_ = (object.getModel() as IRoomObjectModelController);
                if (_loc3_ != null)
                {
                    _loc4_ = this.getAdClickUrl(_loc3_);
                    if ((((!(eventDispatcher == null)) && (!(_loc4_ == null))) && (_loc4_.indexOf("http") == 0)))
                    {
                        eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.var_320, _loc1_, _loc2_));
                    };
                };
                if (eventDispatcher != null)
                {
                    eventDispatcher.dispatchEvent(new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.var_1038, _loc1_, _loc2_));
                };
            };
        }

        private function handleDataUpdateMessage(param1:RoomObjectDataUpdateMessage):void
        {
            var _loc2_:IRoomObjectModelController = object.getModelController();
            object.setState(param1.state, 0);
            if (_loc2_ != null)
            {
                _loc2_.setString(RoomObjectVariableEnum.var_525, param1.data);
                if (!isNaN(param1.extra))
                {
                    _loc2_.setString(RoomObjectVariableEnum.var_521, String(param1.extra));
                };
                _loc2_.setNumber(RoomObjectVariableEnum.var_764, lastUpdateTime);
            };
        }

        private function handleItemDataUpdateMessage(param1:RoomObjectItemDataUpdateMessage):void
        {
            var _loc2_:IRoomObjectModelController = object.getModelController();
            if (_loc2_ != null)
            {
                _loc2_.setString(RoomObjectVariableEnum.var_763, param1.itemData);
            };
        }

        override public function processUpdateMessage(param1:RoomObjectUpdateMessage):void
        {
            var _loc4_:IVector3d;
            var _loc5_:IVector3d;
            var _loc2_:RoomObjectDataUpdateMessage = (param1 as RoomObjectDataUpdateMessage);
            if (_loc2_ != null)
            {
                this.handleDataUpdateMessage(_loc2_);
                return;
            };
            var _loc3_:RoomObjectItemDataUpdateMessage = (param1 as RoomObjectItemDataUpdateMessage);
            if (_loc3_ != null)
            {
                this.handleItemDataUpdateMessage(_loc3_);
                return;
            };
            this.var_4511 = false;
            if (((!(param1.dir == null)) && (!(param1.loc == null))))
            {
                if (!(param1 is RoomObjectMoveUpdateMessage))
                {
                    _loc4_ = object.getDirection();
                    _loc5_ = object.getLocation();
                    if ((((((((!(_loc4_ == null)) && (!(_loc4_.x == param1.dir.x))) && (this.var_4516)) && (!(_loc5_ == null))) && (_loc5_.x == param1.loc.x)) && (_loc5_.y == param1.loc.y)) && (_loc5_.z == param1.loc.z)))
                    {
                        this.var_4517 = 1;
                        this.var_4518 = new RoomObjectUpdateMessage(param1.loc, param1.dir);
                        param1 = null;
                    };
                };
                this.var_4516 = true;
            };
            super.processUpdateMessage(param1);
        }

        override protected function getLocationOffset():IVector3d
        {
            if (this.var_4517 > 0)
            {
                this.var_4519.x = 0;
                this.var_4519.y = 0;
                if (this.var_4517 <= (var_1039 / 2))
                {
                    this.var_4519.z = (var_1040 * this.var_4517);
                }
                else
                {
                    if (this.var_4517 <= var_1039)
                    {
                        if (this.var_4518)
                        {
                            super.processUpdateMessage(this.var_4518);
                            this.var_4518 = null;
                        };
                        this.var_4519.z = (var_1040 * (var_1039 - this.var_4517));
                    };
                };
                return (this.var_4519);
            };
            return (null);
        }

        override public function update(param1:int):void
        {
            super.update(param1);
            if (this.var_4517 > 0)
            {
                this.var_4517++;
                if (this.var_4517 > var_1039)
                {
                    this.var_4517 = 0;
                };
            };
        }


    }
}