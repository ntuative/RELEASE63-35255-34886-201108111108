package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.avatar.IPetImageListener;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.connection.IConnection;
    import flash.geom.Point;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import flash.display.BitmapData;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChatMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChatSelectAvatarMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.session.SecurityLevelEnum;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionChatEvent;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import flash.events.Event;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChatUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomViewUpdateEvent;
    import com.sulake.room.utils.RoomGeometry;
    import com.sulake.room.utils.PointMath;
    import com.sulake.habbo.room.ImageResult;

    public class ChatWidgetHandler implements IRoomWidgetHandler, IPetImageListener, IAvatarImageListener, IGetImageListener 
    {

        private var var_1023:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var var_5166:Map = null;
        private var var_5167:Map = null;
        private var var_5168:Map = null;
        private var var_5169:Map = null;
        private var var_5170:Array = [];
        private var _connection:IConnection = null;
        private var var_5171:Number = 0;
        private var var_5172:Point = null;
        private var var_5173:Vector3d = new Vector3d();

        public function ChatWidgetHandler()
        {
            this.var_5166 = new Map();
            this.var_5167 = new Map();
            this.var_5168 = new Map();
            this.var_5169 = new Map();
        }

        public function get disposed():Boolean
        {
            return (this.var_1023);
        }

        public function get type():String
        {
            return (RoomWidgetEnum.var_405);
        }

        public function set container(param1:IRoomWidgetHandlerContainer):void
        {
            this._container = param1;
        }

        public function set connection(param1:IConnection):void
        {
            this._connection = param1;
        }

        public function dispose():void
        {
            var _loc1_:int;
            var _loc2_:BitmapData;
            var _loc3_:BitmapData;
            this.var_1023 = true;
            this._container = null;
            this.var_5172 = null;
            if (this.var_5166 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_5166.length)
                {
                    _loc2_ = (this.var_5166.getWithIndex(_loc1_) as BitmapData);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    };
                    _loc1_++;
                };
                this.var_5166.dispose();
                this.var_5166 = null;
            };
            if (this.var_5167 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_5167.length)
                {
                    _loc2_ = (this.var_5167.getWithIndex(_loc1_) as BitmapData);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    };
                    _loc1_++;
                };
                this.var_5167.dispose();
                this.var_5167 = null;
            };
            for each (_loc3_ in this.var_5170)
            {
                if (_loc3_ != null)
                {
                    _loc3_.dispose();
                };
            };
            this.var_5170 = [];
            if (this.var_5168 != null)
            {
                this.var_5168.dispose();
                this.var_5168 = null;
            };
        }

        public function getWidgetMessages():Array
        {
            return ([RoomWidgetChatMessage.var_1639, RoomWidgetChatSelectAvatarMessage.var_1662]);
        }

        public function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _loc2_:RoomWidgetChatSelectAvatarMessage;
            var _loc3_:RoomWidgetChatMessage;
            var _loc4_:RoomWidgetRequestWidgetMessage;
            var _loc5_:Array;
            var _loc6_:String;
            var _loc7_:String;
            var _loc8_:int;
            var _loc9_:IUserData;
            var _loc10_:IUserData;
            switch (param1.type)
            {
                case RoomWidgetChatMessage.var_1639:
                    if (((!(this._container == null)) && (!(this._container.roomSession == null))))
                    {
                        _loc3_ = (param1 as RoomWidgetChatMessage);
                        if (_loc3_ != null)
                        {
                            if (_loc3_.text == "")
                            {
                                return (null);
                            };
                            _loc4_ = null;
                            _loc5_ = _loc3_.text.split(" ");
                            if (_loc5_.length > 0)
                            {
                                _loc6_ = _loc5_[0];
                                _loc7_ = "";
                                if (_loc5_.length > 1)
                                {
                                    _loc7_ = _loc5_[1];
                                };
                                if (((_loc6_.charAt(0) == ":") && (_loc7_ == "x")))
                                {
                                    _loc8_ = this._container.roomEngine.getSelectedAvatarId();
                                    if (_loc8_ > -1)
                                    {
                                        _loc9_ = this._container.roomSession.userDataManager.getUserDataByIndex(_loc8_);
                                        if (_loc9_ != null)
                                        {
                                            this._container.roomSession.sendChatMessage(_loc3_.text.replace(" x", (" " + _loc9_.name)));
                                            return (null);
                                        };
                                    };
                                };
                                switch (_loc6_.toLowerCase())
                                {
                                    case "o/":
                                        this._container.roomSession.sendWaveMessage();
                                        return (null);
                                    case ":sign":
                                        this._container.roomSession.sendSignMessage(int(_loc7_));
                                        return (null);
                                    case ":chooser":
                                        if (((this._container.sessionDataManager.hasUserRight("fuse_habbo_chooser", HabboClubLevelEnum.var_256)) || (this._container.sessionDataManager.hasSecurity(SecurityLevelEnum.var_1755))))
                                        {
                                            _loc4_ = new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.var_1574);
                                            this._container.processWidgetMessage(_loc4_);
                                        };
                                        return (null);
                                    case ":furni":
                                        if (((this._container.sessionDataManager.hasUserRight("fuse_furni_chooser", HabboClubLevelEnum.var_256)) || (this._container.sessionDataManager.hasSecurity(SecurityLevelEnum.var_1755))))
                                        {
                                            _loc4_ = new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.var_1573);
                                            this._container.processWidgetMessage(_loc4_);
                                        };
                                        return (null);
                                    case ":pickall":
                                        this._container.sessionDataManager.pickAllFurniture(this._container.roomSession.roomId, this._container.roomSession.roomCategory);
                                        return (null);
                                    case ":news":
                                        if (ExternalInterface.available)
                                        {
                                            ExternalInterface.call("FlashExternalInterface.openHabblet", "news");
                                        };
                                        return (null);
                                };
                            };
                            switch (_loc3_.chatType)
                            {
                                case RoomWidgetChatMessage.var_542:
                                    this._container.roomSession.sendChatMessage(_loc3_.text);
                                    break;
                                case RoomWidgetChatMessage.var_546:
                                    this._container.roomSession.sendShoutMessage(_loc3_.text);
                                    break;
                                case RoomWidgetChatMessage.var_545:
                                    this._container.roomSession.sendWhisperMessage(_loc3_.recipientName, _loc3_.text);
                                    break;
                            };
                        };
                    };
                    break;
                case RoomWidgetChatSelectAvatarMessage.var_1662:
                    _loc2_ = (param1 as RoomWidgetChatSelectAvatarMessage);
                    if (_loc2_ != null)
                    {
                        this._container.roomEngine.selectAvatar(_loc2_.roomId, _loc2_.roomCategory, _loc2_.objectId);
                        _loc10_ = this._container.roomSession.userDataManager.getUserDataByIndex(_loc2_.objectId);
                        if (_loc10_ != null)
                        {
                            this._container.moderation.userSelected(_loc10_.webID, _loc2_.userName);
                        };
                    };
                    break;
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return ([RoomSessionChatEvent.var_340]);
        }

        public function processEvent(param1:Event):void
        {
            var _loc3_:RoomSessionChatEvent;
            var _loc4_:IRoomObject;
            var _loc5_:IRoomGeometry;
            var _loc6_:Number;
            var _loc7_:Number;
            var _loc8_:IVector3d;
            var _loc9_:Point;
            var _loc10_:IUserData;
            var _loc11_:String;
            var _loc12_:uint;
            var _loc13_:BitmapData;
            var _loc14_:String;
            var _loc15_:Point;
            var _loc16_:String;
            var _loc17_:IAvatarImage;
            var _loc18_:IPartColor;
            var _loc2_:Event;
            switch (param1.type)
            {
                case RoomSessionChatEvent.var_340:
                    _loc3_ = (param1 as RoomSessionChatEvent);
                    if (_loc3_ != null)
                    {
                        _loc4_ = this._container.roomEngine.getRoomObject(_loc3_.session.roomId, _loc3_.session.roomCategory, _loc3_.userId, RoomObjectCategoryEnum.OBJECT_CATEGORY_USER);
                        if (_loc4_ != null)
                        {
                            _loc5_ = this._container.roomEngine.getRoomCanvasGeometry(_loc3_.session.roomId, _loc3_.session.roomCategory, this._container.getFirstCanvasId());
                            if (_loc5_ != null)
                            {
                                this.updateWidgetPosition();
                                _loc6_ = 0;
                                _loc7_ = 0;
                                _loc8_ = _loc4_.getLocation();
                                _loc9_ = _loc5_.getScreenPoint(_loc8_);
                                if (_loc9_ != null)
                                {
                                    _loc6_ = _loc9_.x;
                                    _loc7_ = _loc9_.y;
                                    _loc15_ = this._container.roomEngine.getRoomCanvasScreenOffset(_loc3_.session.roomId, _loc3_.session.roomCategory, this._container.getFirstCanvasId());
                                    if (_loc15_ != null)
                                    {
                                        _loc6_ = (_loc6_ + _loc15_.x);
                                        _loc7_ = (_loc7_ + _loc15_.y);
                                    };
                                };
                                _loc10_ = this._container.roomSession.userDataManager.getUserDataByIndex(_loc3_.userId);
                                _loc11_ = "";
                                _loc12_ = 0;
                                _loc13_ = null;
                                if (_loc10_ != null)
                                {
                                    _loc16_ = _loc10_.figure;
                                    if (_loc10_.type == RoomObjectTypeEnum.var_1300)
                                    {
                                        _loc13_ = (this.var_5167.getValue(this.getPetFigureString(_loc16_)) as BitmapData);
                                    }
                                    else
                                    {
                                        _loc13_ = (this.var_5166.getValue(_loc16_) as BitmapData);
                                    };
                                    _loc12_ = this.var_5168.getValue(_loc16_);
                                    if (_loc13_ == null)
                                    {
                                        if (this._container.avatarRenderManager != null)
                                        {
                                            switch (_loc10_.type)
                                            {
                                                case RoomObjectTypeEnum.var_1300:
                                                    _loc13_ = this.getPetImage(_loc16_);
                                                    _loc12_ = this.var_5168.getValue(_loc16_);
                                                    break;
                                                default:
                                                    _loc17_ = this._container.avatarRenderManager.createAvatarImage(_loc16_, AvatarScaleType.var_275, null, this);
                                                    if (_loc17_ != null)
                                                    {
                                                        _loc13_ = _loc17_.getCroppedImage(AvatarSetType.var_130);
                                                        _loc18_ = _loc17_.getPartColor("ch");
                                                        _loc17_.dispose();
                                                        if (_loc18_ != null)
                                                        {
                                                            _loc12_ = _loc18_.rgb;
                                                            this.var_5168.add(_loc16_, _loc12_);
                                                        };
                                                    };
                                            };
                                            if (_loc13_ != null)
                                            {
                                                if (_loc10_.type == RoomObjectTypeEnum.var_1300)
                                                {
                                                    this.var_5167.add(this.getPetFigureString(_loc16_), _loc13_);
                                                }
                                                else
                                                {
                                                    this.var_5166.add(_loc16_, _loc13_);
                                                };
                                            };
                                        };
                                    };
                                    _loc11_ = _loc10_.name;
                                };
                                _loc14_ = RoomWidgetChatUpdateEvent.var_1652;
                                _loc2_ = new RoomWidgetChatUpdateEvent(_loc14_, _loc3_.userId, _loc3_.text, _loc11_, RoomObjectCategoryEnum.OBJECT_CATEGORY_USER, _loc6_, _loc7_, _loc13_, _loc12_, _loc3_.session.roomId, _loc3_.session.roomCategory, _loc3_.chatType, _loc3_.links);
                            };
                        };
                    };
                    break;
            };
            if ((((!(this._container == null)) && (!(this._container.events == null))) && (!(_loc2_ == null))))
            {
                this._container.events.dispatchEvent(_loc2_);
            };
        }

        public function update():void
        {
            this.updateWidgetPosition();
        }

        private function updateWidgetPosition():void
        {
            var _loc5_:Number;
            var _loc6_:String;
            var _loc7_:RoomWidgetRoomViewUpdateEvent;
            var _loc8_:Point;
            var _loc9_:Point;
            var _loc10_:Point;
            if (((((this._container == null) || (this._container.roomSession == null)) || (this._container.roomEngine == null)) || (this._container.events == null)))
            {
                return;
            };
            var _loc1_:int = this._container.getFirstCanvasId();
            var _loc2_:int = this._container.roomSession.roomId;
            var _loc3_:int = this._container.roomSession.roomCategory;
            var _loc4_:RoomGeometry = (this._container.roomEngine.getRoomCanvasGeometry(_loc2_, _loc3_, _loc1_) as RoomGeometry);
            if (_loc4_ != null)
            {
                _loc5_ = 1;
                if (this.var_5171 > 0)
                {
                    _loc5_ = (_loc4_.scale / this.var_5171);
                };
                if (this.var_5172 == null)
                {
                    this.var_5173.x = 0;
                    this.var_5173.y = 0;
                    this.var_5173.z = 0;
                    this.var_5172 = _loc4_.getScreenPoint(this.var_5173);
                    this.var_5171 = (_loc4_.scale - 10);
                };
                _loc6_ = "";
                _loc7_ = null;
                this.var_5173.x = 0;
                this.var_5173.y = 0;
                this.var_5173.z = 0;
                _loc8_ = _loc4_.getScreenPoint(this.var_5173);
                if (_loc8_ != null)
                {
                    _loc9_ = this._container.roomEngine.getRoomCanvasScreenOffset(_loc2_, _loc3_, _loc1_);
                    if (_loc9_ != null)
                    {
                        _loc8_.offset(_loc9_.x, _loc9_.y);
                    };
                    if (((!(_loc8_.x == this.var_5172.x)) || (!(_loc8_.y == this.var_5172.y))))
                    {
                        _loc10_ = PointMath.sub(_loc8_, PointMath.mul(this.var_5172, _loc5_));
                        if (((!(_loc10_.x == 0)) || (!(_loc10_.y == 0))))
                        {
                            _loc6_ = RoomWidgetRoomViewUpdateEvent.var_1653;
                            _loc7_ = new RoomWidgetRoomViewUpdateEvent(_loc6_, null, _loc10_);
                            this._container.events.dispatchEvent(_loc7_);
                        };
                        this.var_5172 = _loc8_;
                    };
                };
                if (_loc4_.scale != this.var_5171)
                {
                    _loc6_ = RoomWidgetRoomViewUpdateEvent.var_1654;
                    _loc7_ = new RoomWidgetRoomViewUpdateEvent(_loc6_, null, null, _loc4_.scale);
                    this._container.events.dispatchEvent(_loc7_);
                    this.var_5171 = _loc4_.scale;
                };
            };
        }

        public function petImageReady(param1:String):void
        {
            var _loc2_:BitmapData;
            if (this.var_5167)
            {
                _loc2_ = (this.var_5167.remove(param1) as BitmapData);
                if (_loc2_ != null)
                {
                    this.var_5170.push(_loc2_);
                };
            };
        }

        public function avatarImageReady(param1:String):void
        {
            var _loc2_:BitmapData;
            if (this.var_5166)
            {
                _loc2_ = (this.var_5166.remove(param1) as BitmapData);
                if (_loc2_ != null)
                {
                    this.var_5170.push(_loc2_);
                };
            };
        }

        private function getPetFigureString(param1:String):String
        {
            var _loc2_:int = this.getPetType(param1);
            if (_loc2_ < 0)
            {
                return (param1);
            };
            if (_loc2_ < 8)
            {
                return (this._container.avatarRenderManager.getPetFigureString(param1));
            };
            return (param1);
        }

        private function getPetImage(param1:String):BitmapData
        {
            var _loc5_:IAvatarImage;
            var _loc6_:IPartColor;
            var _loc7_:uint;
            var _loc8_:uint;
            var _loc9_:ImageResult;
            var _loc2_:BitmapData;
            var _loc3_:int = this.getPetType(param1);
            var _loc4_:int = this.getPetRace(param1);
            if (((_loc3_ < 0) || (_loc4_ < 0)))
            {
                return (_loc2_);
            };
            if (_loc3_ < 8)
            {
                _loc5_ = this._container.avatarRenderManager.createPetImageFromFigure(param1, AvatarScaleType.var_275, this);
                if (_loc5_ != null)
                {
                    _loc2_ = _loc5_.getCroppedImage(AvatarSetType.var_129);
                    _loc6_ = _loc5_.getPartColor("pbd");
                    _loc5_.dispose();
                    if (_loc6_ != null)
                    {
                        _loc7_ = _loc6_.rgb;
                        if (_loc7_ != 0)
                        {
                            this.var_5168.add(param1, _loc7_);
                        };
                    };
                };
            }
            else
            {
                _loc8_ = 0;
                _loc9_ = this._container.roomEngine.getPetImage(_loc3_, _loc4_, new Vector3d(90), 32, this, _loc8_);
                if (_loc9_ != null)
                {
                    _loc2_ = _loc9_.data;
                    if (_loc9_.id > 0)
                    {
                        this.var_5169.add(_loc9_.id, param1);
                    };
                };
            };
            return (_loc2_);
        }

        private function getPetType(param1:String):int
        {
            var _loc3_:Array;
            var _loc2_:int = -1;
            if (param1 != null)
            {
                _loc3_ = param1.split(" ");
                if (_loc3_.length >= 2)
                {
                    _loc2_ = int(_loc3_[0]);
                };
            };
            return (_loc2_);
        }

        private function getPetRace(param1:String):int
        {
            var _loc3_:Array;
            var _loc2_:int = -1;
            if (param1 != null)
            {
                _loc3_ = param1.split(" ");
                if (_loc3_.length >= 2)
                {
                    _loc2_ = int(_loc3_[1]);
                };
            };
            return (_loc2_);
        }

        public function imageReady(param1:int, param2:BitmapData):void
        {
            var _loc3_:String = this.var_5169.remove(param1);
            if (_loc3_ != null)
            {
                this.petImageReady(_loc3_);
                if (this.var_5167)
                {
                    this.var_5167.add(_loc3_, param2);
                };
            };
        }


    }
}