package com.sulake.habbo.room.object.logic.room
{
    import com.sulake.room.object.logic.ObjectLogicBase;
    import com.sulake.habbo.room.object.RoomPlaneParser;
    import com.sulake.habbo.room.object.RoomPlaneBitmapMaskParser;
    import com.sulake.room.events.RoomObjectMouseEvent;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.utils.ColorConverter;
    import com.sulake.habbo.room.messages.RoomObjectRoomUpdateMessage;
    import com.sulake.habbo.room.object.RoomPlaneBitmapMaskData;
    import com.sulake.habbo.room.messages.RoomObjectRoomMaskUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectRoomPlaneVisibilityUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectRoomPlanePropertyUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectRoomFloorHoleUpdateMessage;
    import flash.utils.getTimer;
    import com.sulake.habbo.room.messages.RoomObjectRoomColorUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.object.RoomPlaneData;
    import com.sulake.habbo.room.events.RoomObjectTileMouseEvent;
    import com.sulake.habbo.room.events.RoomObjectWallMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class RoomLogic extends ObjectLogicBase 
    {

        protected var _planeParser:RoomPlaneParser = null;
        private var var_4530:RoomPlaneBitmapMaskParser = null;
        private var _color:uint = 0xFFFFFF;
        private var var_3560:int = 0xFF;
        private var var_4531:uint = 0xFFFFFF;
        private var var_4532:int = 0xFF;
        private var var_4533:uint = 0xFFFFFF;
        private var var_4534:int = 0xFF;
        private var var_4535:int = 0;
        private var var_4536:int = 1500;
        private var var_4537:Boolean;

        public function RoomLogic()
        {
            this._planeParser = new RoomPlaneParser();
            this.var_4530 = new RoomPlaneBitmapMaskParser();
        }

        override public function getEventTypes():Array
        {
            var _loc1_:Array = [RoomObjectMouseEvent.var_497, RoomObjectMouseEvent.var_496];
            return (getAllEventTypes(super.getEventTypes(), _loc1_));
        }

        override public function dispose():void
        {
            super.dispose();
            if (this._planeParser != null)
            {
                this._planeParser.dispose();
                this._planeParser = null;
            };
            if (this.var_4530 != null)
            {
                this.var_4530.dispose();
                this.var_4530 = null;
            };
        }

        override public function initialize(param1:XML):void
        {
            if (((param1 == null) || (object == null)))
            {
                return;
            };
            if (!this._planeParser.initializeFromXML(param1))
            {
                return;
            };
            var _loc2_:IRoomObjectModelController = (object.getModel() as IRoomObjectModelController);
            if (_loc2_ != null)
            {
                _loc2_.setString(RoomObjectVariableEnum.var_777, param1.toString());
                _loc2_.setNumber(RoomObjectVariableEnum.var_785, 0xFFFFFF);
                _loc2_.setNumber(RoomObjectVariableEnum.var_782, 1);
                _loc2_.setNumber(RoomObjectVariableEnum.var_783, 1);
                _loc2_.setNumber(RoomObjectVariableEnum.var_784, 1);
            };
        }

        override public function update(param1:int):void
        {
            var _loc2_:IRoomObjectModelController;
            var _loc3_:XML;
            super.update(param1);
            this.updateBackgroundColor(param1);
            if (this.var_4537)
            {
                if (object != null)
                {
                    _loc2_ = (object.getModel() as IRoomObjectModelController);
                    if (_loc2_ != null)
                    {
                        _loc3_ = this._planeParser.getXML();
                        _loc2_.setString(RoomObjectVariableEnum.var_777, _loc3_.toString());
                        _loc2_.setNumber(RoomObjectVariableEnum.var_781, param1);
                        this._planeParser.initializeFromXML(_loc3_);
                    };
                };
                this.var_4537 = false;
            };
        }

        private function updateBackgroundColor(param1:int):void
        {
            var _loc2_:int;
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:int;
            var _loc6_:IRoomObjectModelController;
            var _loc7_:int;
            var _loc8_:int;
            var _loc9_:int;
            var _loc10_:int;
            var _loc11_:int;
            var _loc12_:int;
            var _loc13_:Number;
            if (object == null)
            {
                return;
            };
            if (this.var_4535)
            {
                _loc2_ = param1;
                _loc3_ = this._color;
                _loc4_ = this.var_3560;
                if ((_loc2_ - this.var_4535) >= this.var_4536)
                {
                    _loc3_ = this.var_4533;
                    _loc4_ = this.var_4534;
                    this.var_4535 = 0;
                }
                else
                {
                    _loc7_ = ((this.var_4531 >> 16) & 0xFF);
                    _loc8_ = ((this.var_4531 >> 8) & 0xFF);
                    _loc9_ = (this.var_4531 & 0xFF);
                    _loc10_ = ((this.var_4533 >> 16) & 0xFF);
                    _loc11_ = ((this.var_4533 >> 8) & 0xFF);
                    _loc12_ = (this.var_4533 & 0xFF);
                    _loc13_ = ((_loc2_ - this.var_4535) / this.var_4536);
                    _loc7_ = (_loc7_ + ((_loc10_ - _loc7_) * _loc13_));
                    _loc8_ = (_loc8_ + ((_loc11_ - _loc8_) * _loc13_));
                    _loc9_ = (_loc9_ + ((_loc12_ - _loc9_) * _loc13_));
                    _loc3_ = (((_loc7_ << 16) + (_loc8_ << 8)) + _loc9_);
                    _loc4_ = (this.var_4532 + ((this.var_4534 - this.var_4532) * _loc13_));
                    this._color = _loc3_;
                    this.var_3560 = _loc4_;
                };
                _loc5_ = ColorConverter.rgbToHSL(_loc3_);
                _loc5_ = ((_loc5_ & 0xFFFF00) + _loc4_);
                _loc3_ = ColorConverter.hslToRGB(_loc5_);
                _loc6_ = (object.getModel() as IRoomObjectModelController);
                if (_loc6_ == null)
                {
                    return;
                };
                _loc6_.setNumber(RoomObjectVariableEnum.var_785, _loc3_);
            };
        }

        private function updatePlaneTypes(param1:RoomObjectRoomUpdateMessage, param2:IRoomObjectModelController):void
        {
            switch (param1.type)
            {
                case RoomObjectRoomUpdateMessage.var_478:
                    param2.setString(RoomObjectVariableEnum.var_148, param1.value);
                    return;
                case RoomObjectRoomUpdateMessage.var_479:
                    param2.setString(RoomObjectVariableEnum.var_147, param1.value);
                    return;
                case RoomObjectRoomUpdateMessage.var_480:
                    param2.setString(RoomObjectVariableEnum.var_149, param1.value);
                    return;
            };
        }

        private function updatePlaneMasks(param1:RoomObjectRoomMaskUpdateMessage, param2:IRoomObjectModelController):void
        {
            var _loc5_:String;
            var _loc6_:XML;
            var _loc7_:String;
            var _loc3_:RoomPlaneBitmapMaskData;
            var _loc4_:Boolean;
            switch (param1.type)
            {
                case RoomObjectRoomMaskUpdateMessage.var_482:
                    _loc5_ = RoomPlaneBitmapMaskData.var_1064;
                    if (param1.maskCategory == RoomObjectRoomMaskUpdateMessage.var_483)
                    {
                        _loc5_ = RoomPlaneBitmapMaskData.var_483;
                    };
                    this.var_4530.addMask(param1.maskId, param1.maskType, param1.maskLocation, _loc5_);
                    _loc4_ = true;
                    break;
                case RoomObjectRoomMaskUpdateMessage.var_509:
                    _loc4_ = this.var_4530.removeMask(param1.maskId);
                    break;
            };
            if (_loc4_)
            {
                _loc6_ = this.var_4530.getXML();
                _loc7_ = _loc6_.toXMLString();
                param2.setString(RoomObjectVariableEnum.var_778, _loc7_);
            };
        }

        private function updatePlaneVisibilities(param1:RoomObjectRoomPlaneVisibilityUpdateMessage, param2:IRoomObjectModelController):void
        {
            var _loc3_:int;
            if (param1.visible)
            {
                _loc3_ = 1;
            };
            switch (param1.type)
            {
                case RoomObjectRoomPlaneVisibilityUpdateMessage.var_490:
                    param2.setNumber(RoomObjectVariableEnum.var_782, _loc3_);
                    return;
                case RoomObjectRoomPlaneVisibilityUpdateMessage.var_489:
                    param2.setNumber(RoomObjectVariableEnum.var_783, _loc3_);
                    param2.setNumber(RoomObjectVariableEnum.var_784, _loc3_);
                    return;
            };
        }

        private function updatePlaneProperties(param1:RoomObjectRoomPlanePropertyUpdateMessage, param2:IRoomObjectModelController):void
        {
            switch (param1.type)
            {
                case RoomObjectRoomPlanePropertyUpdateMessage.var_492:
                    param2.setNumber(RoomObjectVariableEnum.var_780, param1.value);
                    return;
                case RoomObjectRoomPlanePropertyUpdateMessage.var_491:
                    param2.setNumber(RoomObjectVariableEnum.var_779, param1.value);
                    return;
            };
        }

        private function updateFloorHoles(param1:RoomObjectRoomFloorHoleUpdateMessage, param2:IRoomObjectModelController):void
        {
            switch (param1.type)
            {
                case RoomObjectRoomFloorHoleUpdateMessage.var_456:
                    this._planeParser.addFloorHole(param1.id, param1.x, param1.y, param1.width, param1.height);
                    this.var_4537 = true;
                    return;
                case RoomObjectRoomFloorHoleUpdateMessage.var_459:
                    this._planeParser.removeFloorHole(param1.id);
                    this.var_4537 = true;
                    return;
            };
        }

        private function updateColors(param1:RoomObjectRoomColorUpdateMessage, param2:IRoomObjectModelController):void
        {
            var _loc3_:int = param1.color;
            var _loc4_:int = param1.light;
            param2.setNumber(RoomObjectVariableEnum.var_786, int(param1.bgOnly));
            this.var_4531 = this._color;
            this.var_4532 = this.var_3560;
            this.var_4533 = _loc3_;
            this.var_4534 = _loc4_;
            this.var_4535 = getTimer();
            this.var_4536 = 1500;
        }

        override public function processUpdateMessage(param1:RoomObjectUpdateMessage):void
        {
            if (((param1 == null) || (object == null)))
            {
                return;
            };
            var _loc2_:IRoomObjectModelController = (object.getModel() as IRoomObjectModelController);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:RoomObjectRoomUpdateMessage = (param1 as RoomObjectRoomUpdateMessage);
            if (_loc3_ != null)
            {
                this.updatePlaneTypes(_loc3_, _loc2_);
                return;
            };
            var _loc4_:RoomObjectRoomMaskUpdateMessage = (param1 as RoomObjectRoomMaskUpdateMessage);
            if (_loc4_ != null)
            {
                this.updatePlaneMasks(_loc4_, _loc2_);
                return;
            };
            var _loc5_:RoomObjectRoomPlaneVisibilityUpdateMessage = (param1 as RoomObjectRoomPlaneVisibilityUpdateMessage);
            if (_loc5_ != null)
            {
                this.updatePlaneVisibilities(_loc5_, _loc2_);
                return;
            };
            var _loc6_:RoomObjectRoomPlanePropertyUpdateMessage = (param1 as RoomObjectRoomPlanePropertyUpdateMessage);
            if (_loc6_ != null)
            {
                this.updatePlaneProperties(_loc6_, _loc2_);
                return;
            };
            var _loc7_:RoomObjectRoomFloorHoleUpdateMessage = (param1 as RoomObjectRoomFloorHoleUpdateMessage);
            if (_loc7_ != null)
            {
                this.updateFloorHoles(_loc7_, _loc2_);
            };
            var _loc8_:RoomObjectRoomColorUpdateMessage = (param1 as RoomObjectRoomColorUpdateMessage);
            if (_loc8_ != null)
            {
                this.updateColors(_loc8_, _loc2_);
                return;
            };
        }

        override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry):void
        {
            var _loc25_:String;
            var _loc26_:Number;
            var _loc27_:Number;
            var _loc28_:Number;
            if (param2 == null)
            {
                return;
            };
            var _loc3_:RoomSpriteMouseEvent = param1;
            if (_loc3_ == null)
            {
                return;
            };
            if (((object == null) || (param1 == null)))
            {
                return;
            };
            var _loc4_:IRoomObjectModelController = (object.getModel() as IRoomObjectModelController);
            if (_loc4_ == null)
            {
                return;
            };
            var _loc5_:int;
            var _loc6_:String = _loc3_.spriteTag;
            if (_loc6_.indexOf("@") >= 0)
            {
                _loc5_ = parseInt(_loc6_.substr((_loc6_.indexOf("@") + 1)));
            };
            if (((_loc5_ < 1) || (_loc5_ > this._planeParser.planeCount)))
            {
                if (param1.type == MouseEvent.ROLL_OUT)
                {
                    _loc4_.setNumber(RoomObjectVariableEnum.var_793, 0);
                };
                return;
            };
            _loc5_--;
            var _loc7_:Point;
            var _loc8_:IVector3d = this._planeParser.getPlaneLocation(_loc5_);
            var _loc9_:IVector3d = this._planeParser.getPlaneLeftSide(_loc5_);
            var _loc10_:IVector3d = this._planeParser.getPlaneRightSide(_loc5_);
            var _loc11_:IVector3d = this._planeParser.getPlaneNormalDirection(_loc5_);
            var _loc12_:int = this._planeParser.getPlaneType(_loc5_);
            if (((((_loc8_ == null) || (_loc9_ == null)) || (_loc10_ == null)) || (_loc11_ == null)))
            {
                return;
            };
            var _loc13_:Number = _loc9_.length;
            var _loc14_:Number = _loc10_.length;
            if (((_loc13_ == 0) || (_loc14_ == 0)))
            {
                return;
            };
            var _loc15_:Number = _loc3_.screenX;
            var _loc16_:Number = _loc3_.screenY;
            var _loc17_:Point = new Point(_loc15_, _loc16_);
            _loc7_ = param2.getPlanePosition(_loc17_, _loc8_, _loc9_, _loc10_);
            if (_loc7_ == null)
            {
                _loc4_.setNumber(RoomObjectVariableEnum.var_793, 0);
                return;
            };
            var _loc18_:Vector3d = Vector3d.product(_loc9_, (_loc7_.x / _loc13_));
            _loc18_.add(Vector3d.product(_loc10_, (_loc7_.y / _loc14_)));
            _loc18_.add(_loc8_);
            var _loc19_:Number = _loc18_.x;
            var _loc20_:Number = _loc18_.y;
            var _loc21_:Number = _loc18_.z;
            if (((((_loc7_.x >= 0) && (_loc7_.x < _loc13_)) && (_loc7_.y >= 0)) && (_loc7_.y < _loc14_)))
            {
                _loc4_.setNumber(RoomObjectVariableEnum.var_790, _loc19_);
                _loc4_.setNumber(RoomObjectVariableEnum.var_791, _loc20_);
                _loc4_.setNumber(RoomObjectVariableEnum.var_792, _loc21_);
                _loc4_.setNumber(RoomObjectVariableEnum.var_793, (_loc5_ + 1));
            }
            else
            {
                _loc4_.setNumber(RoomObjectVariableEnum.var_793, 0);
                return;
            };
            var _loc22_:String = "";
            var _loc23_:int;
            var _loc24_:RoomObjectEvent;
            switch (param1.type)
            {
                case MouseEvent.MOUSE_MOVE:
                case MouseEvent.ROLL_OVER:
                case MouseEvent.CLICK:
                    _loc25_ = "";
                    if (((param1.type == MouseEvent.MOUSE_MOVE) || (param1.type == MouseEvent.ROLL_OVER)))
                    {
                        _loc25_ = RoomObjectMouseEvent.var_497;
                    }
                    else
                    {
                        if (param1.type == MouseEvent.CLICK)
                        {
                            _loc25_ = RoomObjectMouseEvent.var_496;
                        };
                    };
                    _loc23_ = object.getId();
                    _loc22_ = object.getType();
                    if (eventDispatcher != null)
                    {
                        if (_loc12_ == RoomPlaneData.var_1065)
                        {
                            _loc24_ = new RoomObjectTileMouseEvent(_loc25_, param1.eventId, _loc23_, _loc22_, _loc19_, _loc20_, _loc21_);
                        }
                        else
                        {
                            if (((_loc12_ == RoomPlaneData.var_1066) || (_loc12_ == RoomPlaneData.var_1067)))
                            {
                                _loc26_ = 90;
                                if (_loc11_ != null)
                                {
                                    _loc26_ = (_loc11_.x + 90);
                                    if (_loc26_ > 360)
                                    {
                                        _loc26_ = (_loc26_ - 360);
                                    };
                                };
                                _loc27_ = ((_loc9_.length * _loc7_.x) / _loc13_);
                                _loc28_ = ((_loc10_.length * _loc7_.y) / _loc14_);
                                _loc24_ = new RoomObjectWallMouseEvent(_loc25_, param1.eventId, _loc23_, _loc22_, _loc8_, _loc9_, _loc10_, _loc27_, _loc28_, _loc26_);
                            };
                        };
                        if (_loc24_ != null)
                        {
                            eventDispatcher.dispatchEvent(_loc24_);
                        };
                    };
                    return;
            };
        }


    }
}