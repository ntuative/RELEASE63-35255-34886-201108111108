package com.sulake.habbo.room
{
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.room.object.RoomPlaneParser;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomPropertyMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.FloorHeightMapMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.HeightMapMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.HeightMapUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomVisualizationSettingsEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.FurnitureAliasesMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.PublicRoomObjectsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectAddMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ViralTeaserActiveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectDataUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectsDataUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectRemoveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemAddMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemRemoveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemDataUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UsersMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserRemoveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.action.WaveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.action.DanceMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.action.AvatarEffectMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.action.SleepMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.action.CarryObjectMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.action.UseObjectMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.SlideObjectBundleMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.chat.ChatMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.chat.WhisperMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.chat.ShoutMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.chat.UserTypingMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.DiceValueMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.OneWayDoorStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.publicroom.ParkBusDoorMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetExperienceEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.YouArePlayingGameMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.GamePlayerValueMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.GetFurnitureAliasesMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.GetRoomEntryDataMessageComposer;
    import com.sulake.habbo.communication.messages.parser.room.engine.FurnitureAliasesMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.HeightMapMessageParser;
    import com.sulake.habbo.room.utils.TileHeightMap;
    import com.sulake.habbo.communication.messages.parser.room.engine.HeightMapUpdateMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomVisualizationSettingsParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomPropertyMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.FloorHeightMapMessageParser;
    import com.sulake.habbo.room.utils.LegacyWallGeometry;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectMessageData;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectsMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.PublicRoomObjectMessageData;
    import com.sulake.habbo.communication.messages.parser.room.engine.PublicRoomObjectsMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectAddMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ViralTeaserActiveMessageParser;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectUpdateMessageParser;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectDataUpdateMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectData;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectsDataUpdateMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectRemoveMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemMessageData;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemsMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemAddMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemRemoveMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemUpdateMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemDataUpdateMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserMessageData;
    import com.sulake.habbo.communication.messages.parser.room.engine.UsersMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserUpdateMessageData;
    import com.sulake.habbo.communication.messages.incoming.room.engine.AvatarActionMessageData;
    import com.sulake.habbo.communication.messages.parser.room.engine.UserUpdateMessageParser;
    import com.sulake.room.IRoomInstance;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.communication.messages.parser.room.engine.UserRemoveMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.action.WaveMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.action.DanceMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.action.AvatarEffectMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.action.SleepMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.action.CarryObjectMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.action.UseObjectMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.SlideObjectBundleMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.SlideObjectMessageData;
    import com.sulake.habbo.communication.messages.parser.room.chat.ChatMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.chat.UserTypingMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetExperienceParser;
    import com.sulake.habbo.communication.messages.parser.room.furniture.DiceValueMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.furniture.OneWayDoorStatusMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.publicroom.ParkBusDoorMessageParser;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.communication.messages.parser.room.session.YouArePlayingGameMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.session.GamePlayerValueMessageParser;

    public class RoomMessageHandler 
    {

        private var _connection:IConnection = null;
        private var var_4931:IRoomCreator = null;
        private var _planeParser:RoomPlaneParser = null;
        private var var_4932:int = -1;
        private var var_4933:Boolean = true;
        private var var_4934:int = -1000000000;
        private var var_4935:int = 0;
        private var var_4936:int = 0;
        private var var_4937:Object = new Object();

        public function RoomMessageHandler(param1:IRoomCreator)
        {
            this.var_4931 = param1;
            this._planeParser = new RoomPlaneParser();
            this.var_4933 = true;
        }

        public function dispose():void
        {
            this._connection = null;
            this.var_4931 = null;
            if (this._planeParser != null)
            {
                this._planeParser.dispose();
                this._planeParser = null;
            };
        }

        public function setCurrentRoom(param1:int, param2:int):void
        {
            if (((!(this.var_4935 == 0)) || (!(this.var_4936 == 0))))
            {
                if (this.var_4931 != null)
                {
                    this.var_4931.disposeRoom(this.var_4935, this.var_4936);
                };
            };
            this.var_4935 = param1;
            this.var_4936 = param2;
        }

        public function resetCurrentRoom():void
        {
            this.var_4935 = 0;
            this.var_4936 = 0;
        }

        private function getRoomId(param1:int):int
        {
            return (this.var_4935);
        }

        private function getRoomCategory(param1:int):int
        {
            return (this.var_4936);
        }

        private function isPublicRoom(param1:int, param2:int):Boolean
        {
            if (this.var_4931)
            {
                return (this.var_4931.isPublicRoom(param1, param2));
            };
            return (false);
        }

        public function set connection(param1:IConnection):void
        {
            if (this._connection != null)
            {
                return;
            };
            if (param1 != null)
            {
                this._connection = param1;
                param1.addMessageEvent(new UserObjectEvent(this.onOwnUserEvent));
                param1.addMessageEvent(new RoomReadyMessageEvent(this.onRoomReady));
                param1.addMessageEvent(new RoomPropertyMessageEvent(this.onRoomProperty));
                param1.addMessageEvent(new FloorHeightMapMessageEvent(this.onFloorHeightMap));
                param1.addMessageEvent(new HeightMapMessageEvent(this.onHeightMap));
                param1.addMessageEvent(new HeightMapUpdateMessageEvent(this.onHeightMapUpdate));
                param1.addMessageEvent(new RoomVisualizationSettingsEvent(this.onRoomVisualizationSettings));
                param1.addMessageEvent(new FurnitureAliasesMessageEvent(this.onFurnitureAliases));
                param1.addMessageEvent(new ObjectsMessageEvent(this.onObjects));
                param1.addMessageEvent(new PublicRoomObjectsMessageEvent(this.onPublicRoomObjects));
                param1.addMessageEvent(new ObjectAddMessageEvent(this.onObjectAdd));
                param1.addMessageEvent(new ViralTeaserActiveMessageEvent(this.onObjectInject));
                param1.addMessageEvent(new ObjectUpdateMessageEvent(this.onObjectUpdate));
                param1.addMessageEvent(new ObjectDataUpdateMessageEvent(this.onObjectDataUpdate));
                param1.addMessageEvent(new ObjectsDataUpdateMessageEvent(this.onObjectsDataUpdate));
                param1.addMessageEvent(new ObjectRemoveMessageEvent(this.onObjectRemove));
                param1.addMessageEvent(new ItemsMessageEvent(this.onItems));
                param1.addMessageEvent(new ItemAddMessageEvent(this.onItemAdd));
                param1.addMessageEvent(new ItemRemoveMessageEvent(this.onItemRemove));
                param1.addMessageEvent(new ItemUpdateMessageEvent(this.onItemUpdate));
                param1.addMessageEvent(new ItemDataUpdateMessageEvent(this.onItemDataUpdate));
                param1.addMessageEvent(new UsersMessageEvent(this.onUsers));
                param1.addMessageEvent(new UserUpdateMessageEvent(this.onUserUpdate));
                param1.addMessageEvent(new UserRemoveMessageEvent(this.onUserRemove));
                param1.addMessageEvent(new UserChangeMessageEvent(this.onUserChange));
                param1.addMessageEvent(new WaveMessageEvent(this.onWave));
                param1.addMessageEvent(new DanceMessageEvent(this.onDance));
                param1.addMessageEvent(new AvatarEffectMessageEvent(this.onAvatarEffect));
                param1.addMessageEvent(new SleepMessageEvent(this.onAvatarSleep));
                param1.addMessageEvent(new CarryObjectMessageEvent(this.onCarryObject));
                param1.addMessageEvent(new UseObjectMessageEvent(this.onUseObject));
                param1.addMessageEvent(new SlideObjectBundleMessageEvent(this.onSlideUpdate));
                param1.addMessageEvent(new ChatMessageEvent(this.onChat));
                param1.addMessageEvent(new WhisperMessageEvent(this.onChat));
                param1.addMessageEvent(new ShoutMessageEvent(this.onChat));
                param1.addMessageEvent(new UserTypingMessageEvent(this.onTypingStatus));
                param1.addMessageEvent(new DiceValueMessageEvent(this.onDiceValue));
                param1.addMessageEvent(new OneWayDoorStatusMessageEvent(this.onOneWayDoorStatus));
                param1.addMessageEvent(new ParkBusDoorMessageEvent(this.onParkBusDoor));
                param1.addMessageEvent(new PetExperienceEvent(this.onPetExperience));
                param1.addMessageEvent(new YouArePlayingGameMessageEvent(this.onPlayingGame));
                param1.addMessageEvent(new GamePlayerValueMessageEvent(this.onGamePlayerNumberValue));
            };
        }

        private function onOwnUserEvent(param1:IMessageEvent):void
        {
            var _loc2_:UserObjectEvent = (param1 as UserObjectEvent);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:UserObjectMessageParser = _loc2_.getParser();
            if (_loc3_ != null)
            {
                this.var_4932 = _loc3_.id;
            };
        }

        private function onRoomReady(param1:IMessageEvent):void
        {
            var _loc2_:RoomReadyMessageEvent = (param1 as RoomReadyMessageEvent);
            if ((((_loc2_ == null) || (_loc2_.getParser() == null)) || (param1.connection == null)))
            {
                return;
            };
            var _loc3_:RoomReadyMessageParser = _loc2_.getParser();
            if (((!(this.var_4935 == _loc3_.roomId)) || (!(this.var_4936 == _loc3_.roomCategory))))
            {
                this.setCurrentRoom(_loc3_.roomId, _loc3_.roomCategory);
            };
            var _loc4_:String = _loc3_.roomType;
            if (this.var_4931 != null)
            {
                this.var_4931.setWorldType(_loc3_.roomId, _loc3_.roomCategory, _loc4_);
            };
            if (this.var_4933)
            {
                param1.connection.send(new GetFurnitureAliasesMessageComposer());
                this.var_4933 = false;
            }
            else
            {
                param1.connection.send(new GetRoomEntryDataMessageComposer());
            };
        }

        private function onFurnitureAliases(param1:IMessageEvent):void
        {
            var _loc2_:FurnitureAliasesMessageEvent;
            var _loc3_:FurnitureAliasesMessageParser;
            var _loc4_:int;
            var _loc5_:int;
            var _loc6_:String;
            var _loc7_:String;
            if (this.var_4931 != null)
            {
                _loc2_ = (param1 as FurnitureAliasesMessageEvent);
                if (((_loc2_ == null) || (_loc2_.getParser() == null)))
                {
                    return;
                };
                _loc3_ = _loc2_.getParser();
                if (_loc3_ != null)
                {
                    _loc4_ = _loc3_.aliasCount;
                    _loc5_ = 0;
                    while (_loc5_ < _loc4_)
                    {
                        _loc6_ = _loc3_.getName(_loc5_);
                        _loc7_ = _loc3_.getAlias(_loc5_);
                        this.var_4931.setRoomObjectAlias(_loc6_, _loc7_);
                        _loc5_++;
                    };
                };
            };
            param1.connection.send(new GetRoomEntryDataMessageComposer());
        }

        private function onHeightMap(param1:IMessageEvent):void
        {
            var _loc10_:int;
            var _loc11_:Number;
            var _loc12_:Boolean;
            var _loc13_:Boolean;
            var _loc2_:HeightMapMessageEvent = (param1 as HeightMapMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            if (this.var_4931 == null)
            {
                return;
            };
            var _loc3_:HeightMapMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:int = _loc3_.width;
            var _loc7_:int = _loc3_.height;
            var _loc8_:TileHeightMap = new TileHeightMap(_loc6_, _loc7_);
            var _loc9_:int;
            while (_loc9_ < _loc7_)
            {
                _loc10_ = 0;
                while (_loc10_ < _loc6_)
                {
                    _loc11_ = _loc3_.getTileHeight(_loc10_, _loc9_);
                    _loc12_ = _loc3_.getTileBlocking(_loc10_, _loc9_);
                    _loc13_ = _loc3_.isRoomTile(_loc10_, _loc9_);
                    _loc8_.setTileHeight(_loc10_, _loc9_, _loc11_);
                    _loc8_.setTileBlocking(_loc10_, _loc9_, _loc12_);
                    _loc8_.setIsRoomTile(_loc10_, _loc9_, _loc13_);
                    _loc10_++;
                };
                _loc9_++;
            };
            this.var_4931.setTileHeightMap(_loc4_, _loc5_, _loc8_);
        }

        private function onHeightMapUpdate(param1:IMessageEvent):void
        {
            var _loc10_:int;
            var _loc11_:Number;
            var _loc12_:Boolean;
            var _loc2_:HeightMapUpdateMessageEvent = (param1 as HeightMapUpdateMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            if (this.var_4931 == null)
            {
                return;
            };
            var _loc3_:HeightMapUpdateMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:TileHeightMap = this.var_4931.getTileHeightMap(_loc4_, _loc5_);
            if (_loc6_ == null)
            {
                return;
            };
            var _loc7_:int = _loc6_.mapWidth;
            var _loc8_:int = _loc6_.mapHeight;
            var _loc9_:int;
            while (_loc9_ < _loc8_)
            {
                _loc10_ = 0;
                while (_loc10_ < _loc7_)
                {
                    _loc11_ = _loc6_.getTileHeight(_loc10_, _loc9_);
                    _loc11_ = _loc3_.getTileHeight(_loc10_, _loc9_, _loc11_, _loc7_, _loc8_);
                    _loc12_ = _loc6_.getTileBlocking(_loc10_, _loc9_);
                    _loc12_ = _loc3_.getTileBlocking(_loc10_, _loc9_, _loc12_, _loc7_, _loc8_);
                    _loc6_.setTileHeight(_loc10_, _loc9_, _loc11_);
                    _loc6_.setTileBlocking(_loc10_, _loc9_, _loc12_);
                    _loc10_++;
                };
                _loc9_++;
            };
        }

        private function onRoomVisualizationSettings(param1:IMessageEvent):void
        {
            var _loc2_:RoomVisualizationSettingsEvent = (param1 as RoomVisualizationSettingsEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            var _loc3_:RoomVisualizationSettingsParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:* = (!(_loc3_.wallsHidden));
            var _loc7_:Boolean = true;
            var _loc8_:Number = _loc3_.wallThicknessMultiplier;
            var _loc9_:Number = _loc3_.floorThicknessMultiplier;
            if (this.var_4931 != null)
            {
                this.var_4931.updateObjectRoomVisibilities(_loc4_, _loc5_, _loc6_, _loc7_);
                this.var_4931.updateObjectRoomPlaneThicknesses(_loc4_, _loc5_, _loc8_, _loc9_);
            };
        }

        private function onRoomProperty(param1:IMessageEvent):void
        {
            var _loc2_:RoomPropertyMessageEvent = (param1 as RoomPropertyMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            var _loc3_:RoomPropertyMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:String = _loc3_.floorType;
            var _loc7_:String = _loc3_.wallType;
            var _loc8_:String = _loc3_.landscapeType;
            if (this.var_4931 != null)
            {
                this.var_4931.updateObjectRoom(_loc4_, _loc5_, _loc6_, _loc7_, _loc8_);
            };
        }

        private function onFloorHeightMap(param1:IMessageEvent):void
        {
            var _loc19_:int;
            var _loc20_:int;
            var _loc21_:Boolean;
            var _loc22_:int;
            var _loc23_:XML;
            var _loc2_:FloorHeightMapMessageEvent = (param1 as FloorHeightMapMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            var _loc3_:FloorHeightMapMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            if (this.var_4931 == null)
            {
                return;
            };
            var _loc6_:LegacyWallGeometry = this.var_4931.getLegacyGeometry(_loc4_, _loc5_);
            if (_loc6_ == null)
            {
                return;
            };
            this._planeParser.reset();
            var _loc7_:int = _loc3_.width;
            var _loc8_:int = _loc3_.height;
            this._planeParser.initializeTileMap(_loc7_, _loc8_);
            var _loc9_:Number = -1;
            var _loc10_:Number = -1;
            var _loc11_:Number = 0;
            var _loc12_:Number = 0;
            var _loc13_:Boolean = this.isPublicRoom(_loc4_, _loc5_);
            var _loc14_:TileHeightMap = this.var_4931.getTileHeightMap(_loc4_, _loc5_);
            if (_loc14_ == null)
            {
                return;
            };
            var _loc15_:int;
            while (_loc15_ < _loc8_)
            {
                _loc19_ = 0;
                while (_loc19_ < _loc7_)
                {
                    _loc20_ = _loc3_.getTileHeight(_loc19_, _loc15_);
                    if (!_loc13_)
                    {
                        if (((((_loc15_ > 0) && (_loc15_ < (_loc8_ - 1))) || ((_loc19_ > 0) && (_loc19_ < (_loc7_ - 1)))) && (!(_loc20_ == RoomPlaneParser.var_1825))))
                        {
                            if ((((_loc3_.getTileHeight(_loc19_, (_loc15_ - 1)) == RoomPlaneParser.var_1825) && (_loc3_.getTileHeight((_loc19_ - 1), _loc15_) == RoomPlaneParser.var_1825)) && (_loc3_.getTileHeight(_loc19_, (_loc15_ + 1)) == RoomPlaneParser.var_1825)))
                            {
                                _loc9_ = (_loc19_ + 0.5);
                                _loc10_ = _loc15_;
                                _loc11_ = _loc20_;
                                _loc12_ = 90;
                                if (!_loc14_.isRoomTile((_loc19_ + 1), _loc15_))
                                {
                                    _loc9_ = (_loc9_ + 1);
                                };
                            };
                            if ((((_loc3_.getTileHeight(_loc19_, (_loc15_ - 1)) == RoomPlaneParser.var_1825) && (_loc3_.getTileHeight((_loc19_ - 1), _loc15_) == RoomPlaneParser.var_1825)) && (_loc3_.getTileHeight((_loc19_ + 1), _loc15_) == RoomPlaneParser.var_1825)))
                            {
                                _loc9_ = _loc19_;
                                _loc10_ = (_loc15_ + 0.5);
                                _loc11_ = _loc20_;
                                _loc12_ = 180;
                                if (!_loc14_.isRoomTile(_loc19_, (_loc15_ + 1)))
                                {
                                    _loc10_ = (_loc10_ + 1);
                                };
                            };
                        };
                    };
                    _loc21_ = _loc14_.isRoomTile(_loc19_, _loc15_);
                    if (!_loc21_)
                    {
                        _loc20_ = RoomPlaneParser.var_1825;
                    };
                    this._planeParser.setTileHeight(_loc19_, _loc15_, _loc20_);
                    _loc19_++;
                };
                _loc15_++;
            };
            if (!_loc13_)
            {
                this._planeParser.setTileHeight(Math.floor(_loc9_), Math.floor(_loc10_), _loc11_);
            };
            var _loc16_:* = (_loc5_ == 1);
            if (_loc13_)
            {
                _loc16_ = true;
            };
            this._planeParser.initializeFromTileData(_loc16_);
            if (!_loc13_)
            {
                this._planeParser.setTileHeight(Math.floor(_loc9_), Math.floor(_loc10_), (_loc11_ + this._planeParser.wallHeight));
            };
            _loc6_.scale = _loc3_.scale;
            _loc6_.initialize(_loc7_, _loc8_, this._planeParser.floorHeight);
            var _loc17_:int = (_loc3_.height - 1);
            while (_loc17_ >= 0)
            {
                _loc22_ = (_loc3_.width - 1);
                while (_loc22_ >= 0)
                {
                    _loc6_.setTileHeight(_loc22_, _loc17_, this._planeParser.getTileHeight(_loc22_, _loc17_));
                    _loc22_--;
                };
                _loc17_--;
            };
            var _loc18_:XML = this._planeParser.getXML();
            if (!_loc13_)
            {
                _loc23_ = new (XML)((("<doors>" + (((((((('<door x="' + _loc9_) + '" y="') + _loc10_) + '" z="') + _loc11_) + '" dir="') + _loc12_) + '"/>')) + "</doors>"));
                _loc18_.appendChild(_loc23_);
            };
            this.var_4931.initializeRoom(_loc4_, _loc5_, _loc18_);
            if (this.var_4937.objectData)
            {
                this.addActiveObject(_loc4_, _loc5_, this.var_4937.objectData);
                this.var_4937.objectData = null;
            }
            else
            {
                this.var_4937.floorReady = true;
            };
        }

        private function onObjects(param1:IMessageEvent):void
        {
            var _loc8_:ObjectMessageData;
            var _loc2_:ObjectsMessageEvent = (param1 as ObjectsMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            var _loc3_:ObjectsMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:int = _loc3_.getObjectCount();
            var _loc7_:int;
            while (_loc7_ < _loc6_)
            {
                _loc8_ = _loc3_.getObject(_loc7_);
                this.addActiveObject(_loc4_, _loc5_, _loc8_);
                _loc7_++;
            };
        }

        private function onPublicRoomObjects(param1:IMessageEvent):void
        {
            var _loc8_:PublicRoomObjectMessageData;
            var _loc2_:PublicRoomObjectsMessageEvent = (param1 as PublicRoomObjectsMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            var _loc3_:PublicRoomObjectsMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:int = _loc3_.getObjectCount();
            var _loc7_:int;
            while (_loc7_ < _loc6_)
            {
                _loc8_ = _loc3_.getObject(_loc7_);
                this.addPassiveObject(_loc4_, _loc5_, _loc8_);
                _loc7_++;
            };
        }

        private function onObjectAdd(param1:IMessageEvent):void
        {
            var _loc2_:ObjectAddMessageEvent = (param1 as ObjectAddMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            var _loc3_:ObjectAddMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:ObjectMessageData = _loc3_.data;
            this.addActiveObject(_loc4_, _loc5_, _loc6_);
        }

        private function onObjectInject(param1:IMessageEvent):void
        {
            var _loc2_:ViralTeaserActiveMessageEvent = (param1 as ViralTeaserActiveMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            var _loc3_:ViralTeaserActiveMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:ObjectMessageData = _loc3_.data;
            if (this.var_4937.floorReady)
            {
                this.addActiveObject(_loc4_, _loc5_, _loc6_);
            }
            else
            {
                this.var_4937.objectData = _loc6_;
            };
        }

        private function onObjectUpdate(param1:IMessageEvent):void
        {
            var _loc7_:IVector3d;
            var _loc8_:IVector3d;
            var _loc2_:ObjectUpdateMessageEvent = (param1 as ObjectUpdateMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            if (this.var_4931 == null)
            {
                return;
            };
            var _loc3_:ObjectUpdateMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:ObjectMessageData = _loc3_.data;
            if (_loc6_ != null)
            {
                _loc7_ = new Vector3d(_loc6_.x, _loc6_.y, _loc6_.z);
                _loc8_ = new Vector3d(_loc6_.dir);
                this.var_4931.updateObjectFurniture(_loc4_, _loc5_, _loc6_.id, _loc7_, _loc8_, _loc6_.state, _loc6_.data, _loc6_.extra);
            };
        }

        private function onObjectDataUpdate(param1:IMessageEvent):void
        {
            var _loc2_:ObjectDataUpdateMessageEvent = (param1 as ObjectDataUpdateMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            if (this.var_4931 == null)
            {
                return;
            };
            var _loc3_:ObjectDataUpdateMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:int = _loc3_.id;
            var _loc7_:int = _loc3_.state;
            var _loc8_:String = _loc3_.data;
            this.var_4931.updateObjectFurniture(_loc4_, _loc5_, _loc6_, null, null, _loc7_, _loc8_);
        }

        private function onObjectsDataUpdate(param1:IMessageEvent):void
        {
            var _loc7_:ObjectData;
            var _loc8_:int;
            var _loc9_:int;
            var _loc10_:String;
            var _loc2_:ObjectsDataUpdateMessageEvent = (param1 as ObjectsDataUpdateMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            if (this.var_4931 == null)
            {
                return;
            };
            var _loc3_:ObjectsDataUpdateMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:int;
            while (_loc6_ < _loc3_.objectCount)
            {
                _loc7_ = _loc3_.getObjectData(_loc6_);
                if (_loc7_ != null)
                {
                    _loc8_ = _loc7_.id;
                    _loc9_ = _loc7_.state;
                    _loc10_ = _loc7_.data;
                    this.var_4931.updateObjectFurniture(_loc4_, _loc5_, _loc8_, null, null, _loc9_, _loc10_);
                };
                _loc6_++;
            };
        }

        private function onObjectRemove(param1:IMessageEvent):void
        {
            var _loc2_:ObjectRemoveMessageEvent = (param1 as ObjectRemoveMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            if (this.var_4931 == null)
            {
                return;
            };
            var _loc3_:ObjectRemoveMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:int = _loc3_.id;
            this.var_4931.disposeObjectFurniture(_loc4_, _loc5_, _loc6_);
        }

        private function addActiveObject(param1:int, param2:int, param3:ObjectMessageData):void
        {
            if (((param3 == null) || (this.var_4931 == null)))
            {
                return;
            };
            var _loc4_:IVector3d = new Vector3d(param3.x, param3.y, param3.z);
            var _loc5_:IVector3d = new Vector3d(param3.dir);
            if (param3.staticClass != null)
            {
                this.var_4931.addObjectFurnitureByName(param1, param2, param3.id, param3.staticClass, _loc4_, _loc5_, param3.state, param3.data, param3.extra);
            }
            else
            {
                this.var_4931.addObjectFurniture(param1, param2, param3.id, param3.type, _loc4_, _loc5_, param3.state, param3.data, param3.extra, param3.expiryTime, param3.knownAsUsable);
            };
        }

        private function addPassiveObject(param1:int, param2:int, param3:PublicRoomObjectMessageData):void
        {
            if (((param3 == null) || (this.var_4931 == null)))
            {
                return;
            };
            var _loc4_:IVector3d = new Vector3d(param3.x, param3.y, param3.z);
            var _loc5_:IVector3d = new Vector3d(param3.dir);
            var _loc6_:int = this.getNextPassiveObjectId();
            this.var_4931.addObjectFurnitureByName(param1, param2, _loc6_, param3.type, _loc4_, _loc5_, 0, "");
        }

        private function getNextPassiveObjectId():int
        {
            if (this.var_4934 > 0)
            {
                this.var_4934 = -1000000000;
            };
            return (--this.var_4934);
        }

        private function onItems(param1:IMessageEvent):void
        {
            var _loc8_:ItemMessageData;
            var _loc2_:ItemsMessageEvent = (param1 as ItemsMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            var _loc3_:ItemsMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:int = _loc3_.getItemCount();
            var _loc7_:int;
            while (_loc7_ < _loc6_)
            {
                _loc8_ = _loc3_.getItem(_loc7_);
                this.addWallItem(_loc4_, _loc5_, _loc8_);
                _loc7_++;
            };
        }

        private function onItemAdd(param1:IMessageEvent):void
        {
            var _loc2_:ItemAddMessageEvent = (param1 as ItemAddMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            var _loc3_:ItemAddMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:ItemMessageData = _loc3_.data;
            if (_loc6_ != null)
            {
                this.addWallItem(_loc4_, _loc5_, _loc6_);
            };
        }

        private function onItemRemove(param1:IMessageEvent):void
        {
            var _loc2_:ItemRemoveMessageEvent = (param1 as ItemRemoveMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            if (this.var_4931 == null)
            {
                return;
            };
            var _loc3_:ItemRemoveMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            this.var_4931.disposeObjectWallItem(_loc4_, _loc5_, _loc3_.itemId);
        }

        private function onItemUpdate(param1:IMessageEvent):void
        {
            var _loc8_:IVector3d;
            var _loc9_:IVector3d;
            var _loc2_:ItemUpdateMessageEvent = (param1 as ItemUpdateMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            var _loc3_:ItemUpdateMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:LegacyWallGeometry = this.var_4931.getLegacyGeometry(_loc4_, _loc5_);
            if (((this.var_4931 == null) || (_loc6_ == null)))
            {
                return;
            };
            var _loc7_:ItemMessageData = _loc3_.data;
            if (_loc7_ != null)
            {
                _loc8_ = _loc6_.getLocation(_loc7_.wallX, _loc7_.wallY, _loc7_.localX, _loc7_.localY, _loc7_.dir);
                _loc9_ = new Vector3d(_loc6_.getDirection(_loc7_.dir));
                this.var_4931.updateObjectWallItem(_loc4_, _loc5_, _loc7_.id, _loc8_, _loc9_, _loc7_.state, _loc7_.data);
            };
        }

        private function onItemDataUpdate(param1:IMessageEvent):void
        {
            var _loc2_:ItemDataUpdateMessageEvent = (param1 as ItemDataUpdateMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            var _loc3_:ItemDataUpdateMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            this.var_4931.updateObjectWallItemData(_loc4_, _loc5_, _loc3_.id, _loc3_.itemData);
        }

        private function addWallItem(param1:int, param2:int, param3:ItemMessageData):void
        {
            if (((param3 == null) || (this.var_4931 == null)))
            {
                return;
            };
            var _loc4_:LegacyWallGeometry = this.var_4931.getLegacyGeometry(param1, param2);
            if (_loc4_ == null)
            {
                return;
            };
            var _loc5_:IVector3d;
            if (!param3.isOldFormat)
            {
                _loc5_ = _loc4_.getLocation(param3.wallX, param3.wallY, param3.localX, param3.localY, param3.dir);
            }
            else
            {
                _loc5_ = _loc4_.getLocationOldFormat(param3.y, param3.z, param3.dir);
            };
            var _loc6_:IVector3d = new Vector3d(_loc4_.getDirection(param3.dir));
            this.var_4931.addObjectWallItem(param1, param2, param3.id, param3.type, _loc5_, _loc6_, param3.state, param3.data, param3.knownAsUsable);
        }

        private function onUsers(param1:IMessageEvent):void
        {
            var _loc7_:UserMessageData;
            var _loc8_:IVector3d;
            var _loc9_:IVector3d;
            var _loc10_:int;
            var _loc2_:UsersMessageEvent = (param1 as UsersMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            if (this.var_4931 == null)
            {
                return;
            };
            var _loc3_:UsersMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:int;
            while (_loc6_ < _loc3_.getUserCount())
            {
                _loc7_ = _loc3_.getUser(_loc6_);
                if (_loc7_ != null)
                {
                    _loc8_ = new Vector3d(_loc7_.x, _loc7_.y, _loc7_.z);
                    _loc9_ = new Vector3d(_loc7_.dir);
                    _loc10_ = _loc7_.userType;
                    this.var_4931.addObjectUser(_loc4_, _loc5_, _loc7_.id, _loc8_, _loc9_, _loc7_.dir, _loc10_, _loc7_.figure);
                    if (_loc7_.webID == this.var_4932)
                    {
                        this.var_4931.setOwnUserId(_loc4_, _loc5_, _loc7_.id);
                    };
                    this.var_4931.updateObjectUserFigure(_loc4_, _loc5_, _loc7_.id, _loc7_.figure, _loc7_.sex, _loc7_.subType);
                };
                _loc6_++;
            };
        }

        private function onUserUpdate(param1:IMessageEvent):void
        {
            var _loc9_:UserUpdateMessageData;
            var _loc10_:Number;
            var _loc11_:IVector3d;
            var _loc12_:IVector3d;
            var _loc13_:IVector3d;
            var _loc14_:String;
            var _loc15_:String;
            var _loc16_:Boolean;
            var _loc17_:Boolean;
            var _loc18_:AvatarActionMessageData;
            var _loc2_:UserUpdateMessageEvent = (param1 as UserUpdateMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            if (this.var_4931 == null)
            {
                return;
            };
            var _loc3_:UserUpdateMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:IRoomInstance = this.var_4931.getRoom(_loc4_, _loc5_);
            if (_loc6_ == null)
            {
                return;
            };
            var _loc7_:Number = _loc6_.getNumber(RoomVariableEnum.var_476);
            var _loc8_:int;
            while (_loc8_ < _loc3_.userUpdateCount)
            {
                _loc9_ = _loc3_.getUserUpdateData(_loc8_);
                if (_loc9_ != null)
                {
                    _loc10_ = _loc9_.localZ;
                    if (_loc7_ != 0)
                    {
                        _loc10_ = (_loc10_ / _loc7_);
                    };
                    _loc11_ = new Vector3d(_loc9_.x, _loc9_.y, (_loc9_.z + _loc10_));
                    _loc12_ = new Vector3d(_loc9_.dir);
                    _loc13_ = null;
                    if (_loc9_.isMoving)
                    {
                        _loc13_ = new Vector3d(_loc9_.targetX, _loc9_.targetY, _loc9_.targetZ);
                    };
                    this.var_4931.updateObjectUser(_loc4_, _loc5_, _loc9_.id, _loc11_, _loc13_, _loc12_, _loc9_.dirHead);
                    _loc14_ = RoomObjectVariableEnum.var_753;
                    _loc15_ = "";
                    this.var_4931.updateObjectUserFlatControl(_loc4_, _loc5_, _loc9_.id, null);
                    _loc16_ = false;
                    _loc17_ = false;
                    for each (_loc18_ in _loc9_.actions)
                    {
                        switch (_loc18_.actionType)
                        {
                            case "flatctrl":
                                this.var_4931.updateObjectUserFlatControl(_loc4_, _loc5_, _loc9_.id, _loc18_.actionParameter);
                                break;
                            case "sign":
                                this.var_4931.updateObjectUserAction(_loc4_, _loc5_, _loc9_.id, RoomObjectVariableEnum.var_520, int(_loc18_.actionParameter));
                                break;
                            case "gst":
                                this.var_4931.updateObjectPetGesture(_loc4_, _loc5_, _loc9_.id, _loc18_.actionParameter);
                                break;
                            case "wav":
                            case "mv":
                                _loc17_ = true;
                                _loc14_ = _loc18_.actionType;
                                _loc15_ = _loc18_.actionParameter;
                                break;
                            case "swim":
                                _loc16_ = true;
                                _loc14_ = _loc18_.actionType;
                                _loc15_ = _loc18_.actionParameter;
                                break;
                            case "trd":
                                break;
                            default:
                                _loc14_ = _loc18_.actionType;
                                _loc15_ = _loc18_.actionParameter;
                        };
                    };
                    if (((!(_loc17_)) && (_loc16_)))
                    {
                        _loc14_ = "float";
                    };
                    this.var_4931.updateObjectUserPosture(_loc4_, _loc5_, _loc9_.id, _loc14_, _loc15_);
                };
                _loc8_++;
            };
        }

        private function onUserRemove(param1:IMessageEvent):void
        {
            var _loc2_:UserRemoveMessageEvent = (param1 as UserRemoveMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            if (this.var_4931 == null)
            {
                return;
            };
            var _loc3_:UserRemoveMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            this.var_4931.disposeObjectUser(_loc4_, _loc5_, _loc3_.id);
        }

        private function onUserChange(param1:IMessageEvent):void
        {
            var _loc2_:UserChangeMessageEvent = (param1 as UserChangeMessageEvent);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:int = this.getRoomId(_loc2_.roomId);
            var _loc4_:int = this.getRoomCategory(_loc2_.roomCategory);
            this.var_4931.updateObjectUserFigure(_loc3_, _loc4_, _loc2_.id, _loc2_.figure, _loc2_.sex);
        }

        private function onWave(param1:IMessageEvent):void
        {
            var _loc2_:WaveMessageEvent = (param1 as WaveMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            if (this.var_4931 == null)
            {
                return;
            };
            var _loc3_:WaveMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:int = 1;
            if (!_loc3_.isWaving)
            {
                _loc6_ = 0;
            };
            this.var_4931.updateObjectUserAction(_loc4_, _loc5_, _loc3_.userId, RoomObjectVariableEnum.var_512, _loc6_);
        }

        private function onDance(param1:IMessageEvent):void
        {
            var _loc2_:DanceMessageEvent = (param1 as DanceMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            if (this.var_4931 == null)
            {
                return;
            };
            var _loc3_:DanceMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            this.var_4931.updateObjectUserAction(_loc4_, _loc5_, _loc3_.userId, RoomObjectVariableEnum.var_517, _loc3_.danceStyle);
        }

        private function onAvatarEffect(param1:IMessageEvent):void
        {
            var _loc2_:AvatarEffectMessageEvent = (param1 as AvatarEffectMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            if (this.var_4931 == null)
            {
                return;
            };
            var _loc3_:AvatarEffectMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            this.var_4931.updateObjectUserEffect(_loc4_, _loc5_, _loc3_.userId, _loc3_.effectId, _loc3_.delayMilliSeconds);
        }

        private function onAvatarSleep(param1:IMessageEvent):void
        {
            var _loc2_:SleepMessageEvent = (param1 as SleepMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            if (this.var_4931 == null)
            {
                return;
            };
            var _loc3_:SleepMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:int = 1;
            if (!_loc3_.sleeping)
            {
                _loc6_ = 0;
            };
            this.var_4931.updateObjectUserAction(_loc4_, _loc5_, _loc3_.userId, RoomObjectVariableEnum.var_513, _loc6_);
        }

        private function onCarryObject(param1:IMessageEvent):void
        {
            var _loc2_:CarryObjectMessageParser;
            var _loc3_:int;
            var _loc4_:int;
            if (this.var_4931 == null)
            {
                return;
            };
            if ((param1 is CarryObjectMessageEvent))
            {
                _loc2_ = (param1 as CarryObjectMessageEvent).getParser();
                _loc3_ = this.getRoomId(_loc2_.roomId);
                _loc4_ = this.getRoomCategory(_loc2_.roomCategory);
                this.var_4931.updateObjectUserAction(_loc3_, _loc4_, _loc2_.userId, RoomObjectVariableEnum.var_515, _loc2_.itemType, _loc2_.itemName);
            };
        }

        private function onUseObject(param1:IMessageEvent):void
        {
            var _loc2_:UseObjectMessageParser;
            var _loc3_:int;
            var _loc4_:int;
            if (this.var_4931 == null)
            {
                return;
            };
            if ((param1 is UseObjectMessageEvent))
            {
                _loc2_ = (param1 as UseObjectMessageEvent).getParser();
                _loc3_ = this.getRoomId(_loc2_.roomId);
                _loc4_ = this.getRoomCategory(_loc2_.roomCategory);
                this.var_4931.updateObjectUserAction(_loc3_, _loc4_, _loc2_.userId, RoomObjectVariableEnum.var_516, _loc2_.itemType);
            };
        }

        private function onSlideUpdate(param1:IMessageEvent):void
        {
            var _loc2_:SlideObjectBundleMessageParser;
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:Array;
            var _loc6_:int;
            var _loc7_:SlideObjectMessageData;
            var _loc8_:SlideObjectMessageData;
            var _loc9_:String;
            if (this.var_4931 == null)
            {
                return;
            };
            if ((param1 is SlideObjectBundleMessageEvent))
            {
                _loc2_ = (param1 as SlideObjectBundleMessageEvent).getParser();
                _loc3_ = this.getRoomId(_loc2_.roomId);
                _loc4_ = this.getRoomCategory(_loc2_.roomCategory);
                this.var_4931.updateObjectFurniture(_loc3_, _loc4_, _loc2_.id, null, null, 1, null);
                this.var_4931.updateObjectFurniture(_loc3_, _loc4_, _loc2_.id, null, null, 2, null);
                _loc5_ = _loc2_.objectList;
                _loc6_ = 0;
                while (_loc6_ < _loc5_.length)
                {
                    _loc7_ = _loc5_[_loc6_];
                    if (_loc7_ != null)
                    {
                        this.var_4931.updateObjectFurnitureLocation(_loc3_, _loc4_, _loc7_.id, _loc7_.loc, _loc7_.target);
                    };
                    _loc6_++;
                };
                if (_loc2_.avatar != null)
                {
                    _loc8_ = _loc2_.avatar;
                    this.var_4931.updateObjectUser(_loc3_, _loc4_, _loc8_.id, _loc8_.loc, _loc8_.target);
                    switch (_loc8_.moveType)
                    {
                        case SlideObjectMessageData.var_1826:
                            _loc9_ = "mv";
                            break;
                        case SlideObjectMessageData.var_1827:
                            _loc9_ = "std";
                            break;
                    };
                    this.var_4931.updateObjectUserPosture(_loc3_, _loc4_, _loc8_.id, _loc9_);
                };
            };
        }

        private function onChat(param1:IMessageEvent):void
        {
            var _loc2_:ChatMessageParser;
            if (this.var_4931 == null)
            {
                return;
            };
            if ((param1 is ChatMessageEvent))
            {
                _loc2_ = (param1 as ChatMessageEvent).getParser();
            }
            else
            {
                if ((param1 is WhisperMessageEvent))
                {
                    _loc2_ = (param1 as WhisperMessageEvent).getParser();
                }
                else
                {
                    if ((param1 is ShoutMessageEvent))
                    {
                        _loc2_ = (param1 as ShoutMessageEvent).getParser();
                    };
                };
            };
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:int = this.getRoomId(_loc2_.roomId);
            var _loc4_:int = this.getRoomCategory(_loc2_.roomCategory);
            this.var_4931.updateObjectUserGesture(_loc3_, _loc4_, _loc2_.userId, _loc2_.gesture);
            this.var_4931.updateObjectUserAction(_loc3_, _loc4_, _loc2_.userId, RoomObjectVariableEnum.var_511, Math.ceil((_loc2_.text.length / 10)));
        }

        private function onTypingStatus(param1:IMessageEvent):void
        {
            var _loc2_:UserTypingMessageEvent = (param1 as UserTypingMessageEvent);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:UserTypingMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:int = 1;
            if (!_loc3_.isTyping)
            {
                _loc6_ = 0;
            };
            this.var_4931.updateObjectUserAction(_loc4_, _loc5_, _loc3_.userId, RoomObjectVariableEnum.var_514, _loc6_);
        }

        private function onPetExperience(param1:PetExperienceEvent):void
        {
            if (param1 == null)
            {
                return;
            };
            var _loc2_:PetExperienceParser = param1.getParser();
            var _loc3_:int = this.getRoomId(_loc2_.roomId);
            var _loc4_:int = this.getRoomCategory(_loc2_.roomCategory);
            this.var_4931.updateObjectUserAction(_loc3_, _loc4_, _loc2_.petRoomIndex, RoomObjectVariableEnum.var_518, _loc2_.gainedExperience);
        }

        private function onDiceValue(param1:IMessageEvent):void
        {
            var _loc2_:DiceValueMessageEvent = (param1 as DiceValueMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            if (this.var_4931 == null)
            {
                return;
            };
            var _loc3_:DiceValueMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:int = _loc3_.id;
            var _loc7_:int = _loc3_.value;
            var _loc8_:String = "";
            this.var_4931.updateObjectFurniture(_loc4_, _loc5_, _loc6_, null, null, _loc7_, _loc8_);
        }

        private function onOneWayDoorStatus(param1:IMessageEvent):void
        {
            var _loc2_:OneWayDoorStatusMessageEvent = (param1 as OneWayDoorStatusMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            if (this.var_4931 == null)
            {
                return;
            };
            var _loc3_:OneWayDoorStatusMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:int = _loc3_.id;
            var _loc7_:int = _loc3_.status;
            var _loc8_:String = "";
            this.var_4931.updateObjectFurniture(_loc4_, _loc5_, _loc6_, null, null, _loc7_, _loc8_);
        }

        private function onParkBusDoor(param1:IMessageEvent):void
        {
            var _loc2_:ParkBusDoorMessageEvent = (param1 as ParkBusDoorMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            if (this.var_4931 == null)
            {
                return;
            };
            var _loc3_:ParkBusDoorMessageParser = _loc2_.getParser();
            var _loc4_:int = this.getRoomId(_loc3_.roomId);
            var _loc5_:int = this.getRoomCategory(_loc3_.roomCategory);
            var _loc6_:IRoomObject = this.var_4931.getObjectRoom(_loc4_, _loc5_);
            if (_loc6_ == null)
            {
                return;
            };
            var _loc7_:IRoomObjectModelController = (_loc6_.getModel() as IRoomObjectModelController);
            if (_loc7_ != null)
            {
                _loc7_.setNumber(RoomObjectVariableEnum.var_794, _loc3_.status);
            };
        }

        private function onPlayingGame(param1:YouArePlayingGameMessageEvent):void
        {
            if (param1 == null)
            {
                return;
            };
            var _loc2_:YouArePlayingGameMessageParser = param1.getParser();
            var _loc3_:int = this.getRoomId(_loc2_.roomId);
            var _loc4_:int = this.getRoomCategory(_loc2_.roomCategory);
            var _loc5_:Boolean = _loc2_.isPlaying;
            this.var_4931.setIsPlayingGame(_loc3_, _loc4_, _loc5_);
        }

        private function onGamePlayerNumberValue(param1:IMessageEvent):void
        {
            var _loc2_:GamePlayerValueMessageParser;
            var _loc3_:int;
            var _loc4_:int;
            if (this.var_4931 == null)
            {
                return;
            };
            if ((param1 is GamePlayerValueMessageEvent))
            {
                _loc2_ = (param1 as GamePlayerValueMessageEvent).getParser();
                _loc3_ = this.getRoomId(_loc2_.roomId);
                _loc4_ = this.getRoomCategory(_loc2_.roomCategory);
                this.var_4931.updateObjectUserAction(_loc3_, _loc4_, _loc2_.userId, RoomObjectVariableEnum.var_519, _loc2_.value);
            };
        }


    }
}