package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.room.IRoomEngine;
    import flash.geom.Rectangle;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import com.sulake.habbo.room.object.RoomPlaneParser;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.room.utils.Vector3d;
    import flash.utils.getTimer;
    import com.sulake.room.utils.IVector3d;
    import flash.display.DisplayObject;
    import com.sulake.room.utils.IRoomGeometry;
    import flash.geom.Point;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;

    public class RoomPreviewer 
    {

        private static const var_820:int = -100;
        private static const var_819:int = 1;
        private static const var_825:int = 1;
        private static const var_821:int = 1;
        private static const var_822:int = 2;
        private static const var_823:int = 2;
        private static const var_826:Number = 0.25;
        private static const var_828:int = 64;
        private static const var_827:int = 32;
        private static const var_824:int = 2500;

        private var _roomEngine:IRoomEngine;
        private var var_3307:int = 0;
        private var var_3308:int = 0;
        private var var_3309:String = "";
        private var var_3310:Rectangle = null;
        private var var_3311:int = 0;
        private var var_3312:int = 0;
        private var var_3313:int = 64;
        private var var_3314:Boolean;
        private var var_3315:Boolean;
        private var var_3316:int;

        public function RoomPreviewer(param1:IRoomEngine)
        {
            this._roomEngine = param1;
            if (this._roomEngine != null)
            {
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_384, this.onRoomObjectAdded);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_527, this.onRoomObjectAdded);
                this._roomEngine.events.addEventListener(RoomEngineEvent.var_50, this.onRoomInitialized);
            };
            this.createRoomForPreviews();
        }

        public function dispose():void
        {
            this.reset();
            if (((!(this._roomEngine == null)) && (!(this._roomEngine.events == null))))
            {
                this._roomEngine.events.removeEventListener(RoomEngineObjectEvent.var_384, this.onRoomObjectAdded);
                this._roomEngine.events.removeEventListener(RoomEngineObjectEvent.var_527, this.onRoomObjectAdded);
                this._roomEngine.events.removeEventListener(RoomEngineEvent.var_50, this.onRoomInitialized);
            };
        }

        private function createRoomForPreviews():void
        {
            var _loc1_:int;
            var _loc2_:RoomPlaneParser;
            var _loc3_:int;
            var _loc4_:int;
            if (this._roomEngine != null)
            {
                _loc1_ = 7;
                _loc2_ = new RoomPlaneParser();
                _loc2_.initializeTileMap((_loc1_ + 2), (_loc1_ + 2));
                _loc3_ = 1;
                while (_loc3_ < (1 + _loc1_))
                {
                    _loc4_ = 1;
                    while (_loc4_ < (1 + _loc1_))
                    {
                        _loc2_.setTileHeight(_loc4_, _loc3_, 0);
                        _loc4_++;
                    };
                    _loc3_++;
                };
                _loc2_.initializeFromTileData();
                this._roomEngine.initializeRoom(var_819, var_820, _loc2_.getXML());
                _loc2_.dispose();
            };
        }

        public function reset():void
        {
            var _loc1_:int;
            var _loc2_:int;
            if (this._roomEngine != null)
            {
                _loc1_ = this._roomEngine.activeRoomId;
                _loc2_ = this._roomEngine.activeRoomCategory;
                this._roomEngine.setActiveRoom(var_819, var_820);
                this._roomEngine.disposeObjectFurniture(var_819, var_820, var_821);
                this._roomEngine.disposeObjectWallItem(var_819, var_820, var_821);
                this._roomEngine.disposeObjectUser(var_819, var_820, var_821);
                this.updatePreviewRoomView();
                this._roomEngine.setActiveRoom(_loc1_, _loc2_);
            };
            this.var_3308 = RoomObjectCategoryEnum.var_326;
        }

        public function addFurnitureIntoRoom(param1:int, param2:IVector3d):int
        {
            var _loc4_:int;
            var _loc5_:int;
            var _loc3_:int = -1;
            if (this._roomEngine != null)
            {
                if (((this.var_3308 == RoomObjectCategoryEnum.var_70) && (this.var_3307 == param1)))
                {
                    return (var_821);
                };
                this.reset();
                this.var_3307 = param1;
                this.var_3308 = RoomObjectCategoryEnum.var_70;
                this.var_3309 = "";
                _loc4_ = this._roomEngine.activeRoomId;
                _loc5_ = this._roomEngine.activeRoomCategory;
                this._roomEngine.setActiveRoom(var_819, var_820);
                if (this._roomEngine.addObjectFurniture(var_819, var_820, var_821, param1, new Vector3d(var_822, var_823, 0), param2, 0, ""))
                {
                    this.var_3316 = getTimer();
                    this.var_3315 = true;
                    _loc3_ = var_821;
                    this.updatePreviewRoomView();
                };
                this._roomEngine.setActiveRoom(_loc4_, _loc5_);
            };
            return (_loc3_);
        }

        public function addWallItemIntoRoom(param1:int, param2:IVector3d, param3:String):int
        {
            var _loc4_:int = -1;
            if (this._roomEngine != null)
            {
                if ((((this.var_3308 == RoomObjectCategoryEnum.var_71) && (this.var_3307 == param1)) && (this.var_3309 == param3)))
                {
                    return (var_821);
                };
                this.reset();
                this.var_3307 = param1;
                this.var_3308 = RoomObjectCategoryEnum.var_71;
                this.var_3309 = param3;
                if (this._roomEngine.addObjectWallItem(var_819, var_820, var_821, param1, new Vector3d(0.5, 2.3, 1.8), param2, 0, param3))
                {
                    this.var_3316 = getTimer();
                    this.var_3315 = true;
                    return (var_821);
                };
            };
            return (_loc4_);
        }

        public function addAvatarIntoRoom(param1:String, param2:int):int
        {
            if (this._roomEngine != null)
            {
                this.reset();
                this.var_3307 = 1;
                this.var_3308 = RoomObjectCategoryEnum.OBJECT_CATEGORY_USER;
                this.var_3309 = param1;
                if (this._roomEngine.addObjectUser(var_819, var_820, var_821, new Vector3d(var_822, var_823, 0), new Vector3d(90, 0, 0), 135, 1, param1))
                {
                    this.var_3316 = getTimer();
                    this.var_3315 = true;
                    this._roomEngine.updateObjectUserGesture(var_819, var_820, var_821, 1);
                    this._roomEngine.updateObjectUserEffect(var_819, var_820, var_821, param2);
                    this._roomEngine.updateObjectUserPosture(var_819, var_820, var_821, "std");
                };
                return (var_821);
            };
            return (-1);
        }

        public function changeRoomObjectState():void
        {
            if (this._roomEngine != null)
            {
                this.var_3315 = false;
                if (this.var_3308 != RoomObjectCategoryEnum.OBJECT_CATEGORY_USER)
                {
                    this._roomEngine.changeObjectState(var_819, var_820, var_821, this.var_3308);
                };
            };
        }

        private function checkAutomaticRoomObjectStateChange():void
        {
            var _loc1_:int;
            if (this.var_3315)
            {
                _loc1_ = getTimer();
                if (_loc1_ > (this.var_3316 + var_824))
                {
                    this.var_3316 = _loc1_;
                    if (this._roomEngine != null)
                    {
                        this._roomEngine.changeObjectState(var_819, var_820, var_821, this.var_3308);
                    };
                };
            };
        }

        public function getRoomCanvas(param1:int, param2:int):DisplayObject
        {
            var _loc3_:DisplayObject;
            var _loc4_:IRoomGeometry;
            if (this._roomEngine != null)
            {
                _loc3_ = this._roomEngine.createRoomCanvas(var_819, var_820, var_825, param1, param2, this.var_3313);
                this._roomEngine.setRoomCanvasMask(var_819, var_820, var_825, true);
                _loc4_ = this._roomEngine.getRoomCanvasGeometry(var_819, var_820, var_825);
                if (_loc4_ != null)
                {
                    _loc4_.adjustLocation(new Vector3d(var_822, var_823, 0), 30);
                };
                this.var_3311 = param1;
                this.var_3312 = param2;
                return (_loc3_);
            };
            return (null);
        }

        private function updatePreviewObjectBoundingRectangle(param1:Point):void
        {
            var _loc3_:Rectangle;
            var _loc2_:Rectangle = this._roomEngine.getRoomObjectBoundingRectangle(var_819, var_820, var_821, this.var_3308, var_825);
            if (((!(_loc2_ == null)) && (!(param1 == null))))
            {
                _loc2_.offset(-(this.var_3311 >> 1), -(this.var_3312 >> 1));
                _loc2_.offset(-(param1.x), -(param1.y));
                if (this.var_3310 == null)
                {
                    this.var_3310 = _loc2_;
                }
                else
                {
                    _loc3_ = this.var_3310.union(_loc2_);
                    if ((((((_loc3_.width - this.var_3310.width) > ((this.var_3311 - this.var_3310.width) >> 1)) || ((_loc3_.height - this.var_3310.height) > ((this.var_3312 - this.var_3310.height) >> 1))) || (this.var_3310.width < 1)) || (this.var_3310.height < 1)))
                    {
                        this.var_3310 = _loc3_;
                    };
                };
            };
        }

        private function validatePreviewSize(param1:Point):Point
        {
            if (((this.var_3310.width < 1) || (this.var_3310.height < 1)))
            {
                return (param1);
            };
            var _loc2_:IRoomGeometry = this._roomEngine.getRoomCanvasGeometry(var_819, var_820, var_825);
            if (((this.var_3310.width > (this.var_3311 * (1 + var_826))) || (this.var_3310.height > (this.var_3312 * (1 + var_826)))))
            {
                if (_loc2_.isZoomedIn())
                {
                    _loc2_.performZoomOut();
                    this.var_3313 = var_827;
                    this.var_3314 = true;
                    param1.x = (param1.x >> 1);
                    param1.y = (param1.y >> 1);
                    this.var_3310.left = (this.var_3310.left >> 2);
                    this.var_3310.right = (this.var_3310.right >> 2);
                    this.var_3310.top = (this.var_3310.top >> 2);
                    this.var_3310.bottom = (this.var_3310.bottom >> 2);
                };
            }
            else
            {
                if ((((this.var_3310.width << 1) < ((this.var_3311 * (1 + var_826)) - 5)) && ((this.var_3310.height << 1) < ((this.var_3312 * (1 + var_826)) - 5))))
                {
                    if (((!(_loc2_.isZoomedIn())) && (!(this.var_3314))))
                    {
                        _loc2_.performZoomIn();
                        this.var_3313 = var_828;
                        param1.x = (param1.x << 1);
                        param1.y = (param1.y << 1);
                    };
                };
            };
            return (param1);
        }

        private function getCanvasOffset(param1:Point):Point
        {
            var _loc7_:Number;
            if (((this.var_3310.width < 1) || (this.var_3310.height < 1)))
            {
                return (param1);
            };
            var _loc2_:* = (-(this.var_3310.left + this.var_3310.right) >> 1);
            var _loc3_:* = (-(this.var_3310.top + this.var_3310.bottom) >> 1);
            var _loc4_:* = ((this.var_3312 - this.var_3310.height) >> 1);
            if (_loc4_ > 10)
            {
                _loc3_ = (_loc3_ + Math.min(15, (_loc4_ - 10)));
            }
            else
            {
                if (this.var_3308 != RoomObjectCategoryEnum.OBJECT_CATEGORY_USER)
                {
                    _loc3_ = int((_loc3_ + (5 - Math.max(0, (_loc4_ / 2)))));
                }
                else
                {
                    _loc3_ = int((_loc3_ - (5 - Math.min(0, (_loc4_ / 2)))));
                };
            };
            var _loc5_:int = (_loc2_ - param1.x);
            var _loc6_:int = (_loc3_ - param1.y);
            if (((!(_loc5_ == 0)) || (!(_loc6_ == 0))))
            {
                _loc7_ = Math.sqrt(((_loc5_ * _loc5_) + (_loc6_ * _loc6_)));
                if (_loc7_ > 10)
                {
                    _loc2_ = int((param1.x + ((_loc5_ * 10) / _loc7_)));
                    _loc3_ = int((param1.y + ((_loc6_ * 10) / _loc7_)));
                };
                return (new Point(_loc2_, _loc3_));
            };
            return (null);
        }

        public function updatePreviewRoomView():void
        {
            var _loc1_:Point;
            var _loc2_:int;
            var _loc3_:Point;
            this.checkAutomaticRoomObjectStateChange();
            if (this._roomEngine != null)
            {
                _loc1_ = this._roomEngine.getRoomCanvasScreenOffset(var_819, var_820, var_825);
                if (_loc1_ != null)
                {
                    this.updatePreviewObjectBoundingRectangle(_loc1_);
                    if (this.var_3310 != null)
                    {
                        _loc2_ = this.var_3313;
                        _loc1_ = this.validatePreviewSize(_loc1_);
                        _loc3_ = this.getCanvasOffset(_loc1_);
                        if (_loc3_ != null)
                        {
                            this._roomEngine.setRoomCanvasScreenOffset(var_819, var_820, var_825, _loc3_);
                        };
                        if (this.var_3313 != _loc2_)
                        {
                            this.var_3310 = null;
                        };
                    };
                };
            };
        }

        private function onRoomInitialized(param1:RoomEngineEvent):void
        {
            if (param1 == null)
            {
                return;
            };
            switch (param1.type)
            {
                case RoomEngineEvent.var_50:
                    if (((param1.roomCategory == var_820) && (param1.roomId == var_819)))
                    {
                        this._roomEngine.updateObjectRoomColor(var_819, var_820, 0xFFFFFF, 176, true);
                        this._roomEngine.updateObjectRoom(var_819, var_820, "306", "1401");
                    };
                    return;
            };
        }

        private function onRoomObjectAdded(param1:RoomEngineObjectEvent):void
        {
            var _loc2_:IRoomObject;
            var _loc3_:Number;
            var _loc4_:Number;
            if (((((param1.roomId == var_819) && (param1.roomCategory == var_820)) && (param1.objectId == var_821)) && (param1.category == this.var_3308)))
            {
                this.var_3310 = null;
                this.var_3314 = false;
                _loc2_ = this._roomEngine.getRoomObject(param1.roomId, param1.roomCategory, param1.objectId, param1.category);
                if ((((!(_loc2_ == null)) && (!(_loc2_.getModel() == null))) && (param1.category == RoomObjectCategoryEnum.var_71)))
                {
                    _loc3_ = _loc2_.getModel().getNumber(RoomObjectVariableEnum.var_757);
                    _loc4_ = _loc2_.getModel().getNumber(RoomObjectVariableEnum.var_760);
                    if (((!(isNaN(_loc3_))) && (!(isNaN(_loc4_)))))
                    {
                        this._roomEngine.updateObjectWallItemLocation(param1.roomId, param1.roomCategory, param1.objectId, new Vector3d(0.5, 2.3, (((3.6 - _loc3_) / 2) + _loc4_)));
                    };
                };
            };
        }


    }
}