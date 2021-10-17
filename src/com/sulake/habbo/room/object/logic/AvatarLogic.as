package com.sulake.habbo.room.object.logic
{
    import com.sulake.room.utils.Vector3d;
    import flash.utils.getTimer;
    import com.sulake.room.events.RoomObjectMouseEvent;
    import com.sulake.habbo.room.events.RoomObjectMoveEvent;
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.messages.RoomObjectAvatarPostureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarChatUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarTypingUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarGestureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarWaveUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarDanceUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSleepUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarPlayerValueUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarEffectUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarCarryObjectUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarUseObjectUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSignUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarFlatControlUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarFigureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSelectedMessage;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.avatar.enum.AvatarAction;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.utils.IVector3d;

    public class AvatarLogic extends MovingObjectLogic 
    {

        private static const var_1091:Number = 1.5;
        private static const var_1088:int = 28;
        private static const var_1090:int = 29;
        private static const var_1089:int = 500;
        private static const var_1085:int = 999999999;

        private var _selected:Boolean = false;
        private var var_4538:Vector3d = null;
        private var var_4539:int = 0;
        private var var_4540:int = 0;
        private var var_4541:int = 0;
        private var var_4542:int = 0;
        private var var_4543:int = 0;
        private var var_4544:int = 0;
        private var var_4545:int = 0;
        private var var_4546:int = 0;
        private var var_4547:int = 0;
        private var var_4548:Boolean = false;
        private var var_4549:int = 0;
        private var var_4550:int = 0;
        private var var_4551:int = 0;

        public function AvatarLogic()
        {
            this.var_4550 = (getTimer() + this.getBlinkInterval());
        }

        override public function getEventTypes():Array
        {
            var _loc1_:Array = [RoomObjectMouseEvent.var_496, RoomObjectMoveEvent.var_1073, RoomObjectMouseEvent.var_387, RoomObjectMouseEvent.var_388, RoomObjectFurnitureActionEvent.var_455, RoomObjectFurnitureActionEvent.var_1041];
            return (getAllEventTypes(super.getEventTypes(), _loc1_));
        }

        override public function dispose():void
        {
            var _loc1_:RoomObjectEvent;
            if (((this._selected) && (!(object == null))))
            {
                if (eventDispatcher != null)
                {
                    _loc1_ = new RoomObjectMoveEvent(RoomObjectMoveEvent.var_1074, object.getId(), object.getType());
                    eventDispatcher.dispatchEvent(_loc1_);
                };
            };
            super.dispose();
            this.var_4538 = null;
        }

        override public function processUpdateMessage(param1:RoomObjectUpdateMessage):void
        {
            var _loc3_:RoomObjectAvatarPostureUpdateMessage;
            var _loc4_:RoomObjectAvatarChatUpdateMessage;
            var _loc5_:RoomObjectAvatarTypingUpdateMessage;
            var _loc6_:RoomObjectAvatarUpdateMessage;
            var _loc7_:RoomObjectAvatarGestureUpdateMessage;
            var _loc8_:RoomObjectAvatarWaveUpdateMessage;
            var _loc9_:RoomObjectAvatarDanceUpdateMessage;
            var _loc10_:RoomObjectAvatarSleepUpdateMessage;
            var _loc11_:RoomObjectAvatarPlayerValueUpdateMessage;
            var _loc12_:RoomObjectAvatarEffectUpdateMessage;
            var _loc13_:int;
            var _loc14_:int;
            var _loc15_:RoomObjectAvatarCarryObjectUpdateMessage;
            var _loc16_:RoomObjectAvatarUseObjectUpdateMessage;
            var _loc17_:RoomObjectAvatarSignUpdateMessage;
            var _loc18_:RoomObjectAvatarFlatControlUpdateMessage;
            var _loc19_:RoomObjectAvatarFigureUpdateMessage;
            var _loc20_:String;
            var _loc21_:String;
            var _loc22_:String;
            var _loc23_:RoomObjectAvatarSelectedMessage;
            if (((param1 == null) || (object == null)))
            {
                return;
            };
            super.processUpdateMessage(param1);
            var _loc2_:IRoomObjectModelController = object.getModelController();
            if ((param1 is RoomObjectAvatarPostureUpdateMessage))
            {
                _loc3_ = (param1 as RoomObjectAvatarPostureUpdateMessage);
                _loc2_.setString(RoomObjectVariableEnum.var_751, _loc3_.postureType);
                _loc2_.setString(RoomObjectVariableEnum.var_752, _loc3_.parameter);
                return;
            };
            if ((param1 is RoomObjectAvatarChatUpdateMessage))
            {
                _loc4_ = (param1 as RoomObjectAvatarChatUpdateMessage);
                _loc2_.setNumber(RoomObjectVariableEnum.var_511, 1);
                this.var_4541 = (getTimer() + (_loc4_.numberOfWords * 1000));
                return;
            };
            if ((param1 is RoomObjectAvatarTypingUpdateMessage))
            {
                _loc5_ = (param1 as RoomObjectAvatarTypingUpdateMessage);
                _loc2_.setNumber(RoomObjectVariableEnum.var_514, Number(_loc5_.isTyping));
                return;
            };
            if ((param1 is RoomObjectAvatarUpdateMessage))
            {
                _loc6_ = (param1 as RoomObjectAvatarUpdateMessage);
                _loc2_.setNumber(RoomObjectVariableEnum.var_510, _loc6_.dirHead);
                return;
            };
            if ((param1 is RoomObjectAvatarGestureUpdateMessage))
            {
                _loc7_ = (param1 as RoomObjectAvatarGestureUpdateMessage);
                _loc2_.setNumber(RoomObjectVariableEnum.var_750, _loc7_.gesture);
                this.var_4545 = (getTimer() + (3 * 1000));
                return;
            };
            if ((param1 is RoomObjectAvatarWaveUpdateMessage))
            {
                _loc8_ = (param1 as RoomObjectAvatarWaveUpdateMessage);
                if (_loc8_.isWaving)
                {
                    _loc2_.setNumber(RoomObjectVariableEnum.var_512, 1);
                    this.var_4544 = (getTimer() + (AvatarAction.var_1086 * 1000));
                }
                else
                {
                    _loc2_.setNumber(RoomObjectVariableEnum.var_512, 0);
                    this.var_4544 = 0;
                };
                return;
            };
            if ((param1 is RoomObjectAvatarDanceUpdateMessage))
            {
                _loc9_ = (param1 as RoomObjectAvatarDanceUpdateMessage);
                _loc2_.setNumber(RoomObjectVariableEnum.var_517, _loc9_.danceStyle);
                return;
            };
            if ((param1 is RoomObjectAvatarSleepUpdateMessage))
            {
                _loc10_ = (param1 as RoomObjectAvatarSleepUpdateMessage);
                _loc2_.setNumber(RoomObjectVariableEnum.var_513, Number(_loc10_.isSleeping));
                return;
            };
            if ((param1 is RoomObjectAvatarPlayerValueUpdateMessage))
            {
                _loc11_ = (param1 as RoomObjectAvatarPlayerValueUpdateMessage);
                _loc2_.setNumber(RoomObjectVariableEnum.var_519, _loc11_.value);
                this.var_4551 = (getTimer() + 3000);
                return;
            };
            if ((param1 is RoomObjectAvatarEffectUpdateMessage))
            {
                _loc12_ = (param1 as RoomObjectAvatarEffectUpdateMessage);
                _loc13_ = _loc12_.effect;
                _loc14_ = _loc12_.delayMilliSeconds;
                this.updateEffect(_loc13_, _loc14_, _loc2_);
                return;
            };
            if ((param1 is RoomObjectAvatarCarryObjectUpdateMessage))
            {
                _loc15_ = (param1 as RoomObjectAvatarCarryObjectUpdateMessage);
                _loc2_.setNumber(RoomObjectVariableEnum.var_515, _loc15_.itemType);
                if (_loc15_.itemType < var_1085)
                {
                    this.var_4547 = (getTimer() + (100 * 1000));
                    this.var_4548 = true;
                }
                else
                {
                    this.var_4547 = (getTimer() + 1500);
                    this.var_4548 = false;
                };
                return;
            };
            if ((param1 is RoomObjectAvatarUseObjectUpdateMessage))
            {
                _loc16_ = (param1 as RoomObjectAvatarUseObjectUpdateMessage);
                _loc2_.setNumber(RoomObjectVariableEnum.var_516, _loc16_.itemType);
                return;
            };
            if ((param1 is RoomObjectAvatarSignUpdateMessage))
            {
                _loc17_ = (param1 as RoomObjectAvatarSignUpdateMessage);
                _loc2_.setNumber(RoomObjectVariableEnum.var_520, _loc17_.var_1087);
                this.var_4546 = (getTimer() + (5 * 1000));
                return;
            };
            if ((param1 is RoomObjectAvatarFlatControlUpdateMessage))
            {
                _loc18_ = (param1 as RoomObjectAvatarFlatControlUpdateMessage);
                _loc2_.setString(RoomObjectVariableEnum.var_754, _loc18_.rawData);
                _loc2_.setNumber(RoomObjectVariableEnum.var_755, Number(_loc18_.isAdmin));
                return;
            };
            if ((param1 is RoomObjectAvatarFigureUpdateMessage))
            {
                _loc19_ = (param1 as RoomObjectAvatarFigureUpdateMessage);
                _loc20_ = _loc2_.getString(RoomObjectVariableEnum.var_522);
                _loc21_ = _loc19_.figure;
                _loc22_ = _loc19_.gender;
                if (((!(_loc20_ == null)) && (!(_loc20_.indexOf(".bds-") == -1))))
                {
                    _loc21_ = (_loc21_ + _loc20_.substr(_loc20_.indexOf(".bds-")));
                };
                _loc2_.setString(RoomObjectVariableEnum.var_522, _loc21_);
                _loc2_.setString(RoomObjectVariableEnum.AVATAR_GENDER, _loc22_);
                return;
            };
            if ((param1 is RoomObjectAvatarSelectedMessage))
            {
                _loc23_ = (param1 as RoomObjectAvatarSelectedMessage);
                this._selected = _loc23_.selected;
                this.var_4538 = null;
                return;
            };
        }

        private function updateEffect(param1:int, param2:int, param3:IRoomObjectModelController):void
        {
            if (param1 == var_1088)
            {
                this.var_4539 = (getTimer() + var_1089);
                this.var_4540 = var_1090;
            }
            else
            {
                if (param3.getNumber(RoomObjectVariableEnum.var_749) == var_1090)
                {
                    this.var_4539 = (getTimer() + var_1089);
                    this.var_4540 = param1;
                    param1 = var_1088;
                }
                else
                {
                    if (param2 == 0)
                    {
                        this.var_4539 = 0;
                    }
                    else
                    {
                        this.var_4539 = (getTimer() + param2);
                        this.var_4540 = param1;
                        return;
                    };
                };
            };
            param3.setNumber(RoomObjectVariableEnum.var_749, param1);
        }

        override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry):void
        {
            var _loc4_:int;
            var _loc5_:String;
            var _loc6_:RoomObjectEvent;
            if (((object == null) || (param1 == null)))
            {
                return;
            };
            var _loc3_:String;
            switch (param1.type)
            {
                case MouseEvent.CLICK:
                    _loc3_ = RoomObjectMouseEvent.var_496;
                    break;
                case MouseEvent.ROLL_OVER:
                    _loc3_ = RoomObjectMouseEvent.var_387;
                    eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_455, object.getId(), object.getType()));
                    break;
                case MouseEvent.ROLL_OUT:
                    _loc3_ = RoomObjectMouseEvent.var_388;
                    eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1041, object.getId(), object.getType()));
                    break;
            };
            if (_loc3_ != null)
            {
                _loc4_ = object.getId();
                _loc5_ = object.getType();
                if (eventDispatcher != null)
                {
                    _loc6_ = new RoomObjectMouseEvent(_loc3_, param1.eventId, _loc4_, _loc5_, param1.altKey, param1.ctrlKey, param1.shiftKey, param1.buttonDown);
                    eventDispatcher.dispatchEvent(_loc6_);
                };
            };
        }

        override public function update(param1:int):void
        {
            var _loc2_:IVector3d;
            var _loc3_:RoomObjectEvent;
            super.update(param1);
            if (((this._selected) && (!(object == null))))
            {
                if (eventDispatcher != null)
                {
                    _loc2_ = object.getLocation();
                    if (((((this.var_4538 == null) || (!(this.var_4538.x == _loc2_.x))) || (!(this.var_4538.y == _loc2_.y))) || (!(this.var_4538.z == _loc2_.z))))
                    {
                        if (this.var_4538 == null)
                        {
                            this.var_4538 = new Vector3d();
                        };
                        this.var_4538.assign(_loc2_);
                        _loc3_ = new RoomObjectMoveEvent(RoomObjectMoveEvent.var_1073, object.getId(), object.getType());
                        eventDispatcher.dispatchEvent(_loc3_);
                    };
                };
            };
            if (((!(object == null)) && (!(object.getModelController() == null))))
            {
                this.updateActions(param1, object.getModelController());
            };
        }

        private function updateActions(param1:int, param2:IRoomObjectModelController):void
        {
            if (this.var_4541 > 0)
            {
                if (param1 > this.var_4541)
                {
                    param2.setNumber(RoomObjectVariableEnum.var_511, 0);
                    this.var_4541 = 0;
                    this.var_4543 = 0;
                    this.var_4542 = 0;
                }
                else
                {
                    if (((this.var_4542 == 0) && (this.var_4543 == 0)))
                    {
                        this.var_4543 = (param1 + this.getTalkingPauseInterval());
                        this.var_4542 = (this.var_4543 + this.getTalkingPauseLength());
                    }
                    else
                    {
                        if (((this.var_4543 > 0) && (param1 > this.var_4543)))
                        {
                            param2.setNumber(RoomObjectVariableEnum.var_511, 0);
                            this.var_4543 = 0;
                        }
                        else
                        {
                            if (((this.var_4542 > 0) && (param1 > this.var_4542)))
                            {
                                param2.setNumber(RoomObjectVariableEnum.var_511, 1);
                                this.var_4542 = 0;
                            };
                        };
                    };
                };
            };
            if (((this.var_4544 > 0) && (param1 > this.var_4544)))
            {
                param2.setNumber(RoomObjectVariableEnum.var_512, 0);
                this.var_4544 = 0;
            };
            if (((this.var_4545 > 0) && (param1 > this.var_4545)))
            {
                param2.setNumber(RoomObjectVariableEnum.var_750, 0);
                this.var_4545 = 0;
            };
            if (((this.var_4546 > 0) && (param1 > this.var_4546)))
            {
                param2.setNumber(RoomObjectVariableEnum.var_520, 0);
                this.var_4546 = 0;
            };
            if (this.var_4547 > 0)
            {
                if (param1 > this.var_4547)
                {
                    param2.setNumber(RoomObjectVariableEnum.var_515, 0);
                    this.var_4547 = 0;
                }
                else
                {
                    if (((((this.var_4547 - param1) % 10000) < 1000) && (this.var_4548)))
                    {
                        param2.setNumber(RoomObjectVariableEnum.var_516, 1);
                    }
                    else
                    {
                        param2.setNumber(RoomObjectVariableEnum.var_516, 0);
                    };
                };
            };
            if (param1 > this.var_4550)
            {
                param2.setNumber(RoomObjectVariableEnum.var_748, 1);
                this.var_4550 = (param1 + this.getBlinkInterval());
                this.var_4549 = (param1 + this.getBlinkLength());
            };
            if (((this.var_4549 > 0) && (param1 > this.var_4549)))
            {
                param2.setNumber(RoomObjectVariableEnum.var_748, 0);
                this.var_4549 = 0;
            };
            if (((this.var_4539 > 0) && (param1 > this.var_4539)))
            {
                param2.setNumber(RoomObjectVariableEnum.var_749, this.var_4540);
                this.var_4539 = 0;
            };
            if (((this.var_4551 > 0) && (param1 > this.var_4551)))
            {
                param2.setNumber(RoomObjectVariableEnum.var_519, 0);
                this.var_4551 = 0;
            };
        }

        private function getTalkingPauseInterval():int
        {
            return (100 + (Math.random() * 200));
        }

        private function getTalkingPauseLength():int
        {
            return (75 + (Math.random() * 75));
        }

        private function getBlinkInterval():int
        {
            return (4500 + (Math.random() * 1000));
        }

        private function getBlinkLength():int
        {
            return (50 + (Math.random() * 200));
        }

        private function targetIsWarping(param1:IVector3d):Boolean
        {
            var _loc2_:IVector3d = object.getLocation();
            if (param1 == null)
            {
                return (false);
            };
            if (((_loc2_.x == 0) && (_loc2_.y == 0)))
            {
                return (false);
            };
            if (((Math.abs((_loc2_.x - param1.x)) > var_1091) || (Math.abs((_loc2_.y - param1.y)) > var_1091)))
            {
                return (true);
            };
            return (false);
        }


    }
}