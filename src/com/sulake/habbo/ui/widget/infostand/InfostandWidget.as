package com.sulake.habbo.ui.widget.infostand
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import flash.events.TimerEvent;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.handler.InfoStandWidgetHandler;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import flash.display.BitmapData;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserTagsUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserFigureUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserBadgesUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetBadgeImageUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetCommandsUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSongUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetInfostandExtraParamEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;

    public class InfostandWidget extends RoomWidgetBase 
    {

        private const var_5340:String = "infostand_user_view";
        private const var_5339:String = "infostand_furni_view";
        private const var_5341:String = "infostand_pet_view";
        private const var_5342:String = "infostand_bot_view";
        private const var_5343:String = "infostand_jukebox_view";
        private const var_5344:String = "infostand_songdisk_view";
        private const var_5345:int = 3000;

        private var var_5347:InfoStandFurniView;
        private var var_5348:InfoStandUserView;
        private var var_5349:InfoStandPetView;
        private var var_5350:InfoStandBotView;
        private var var_5351:InfoStandJukeboxView;
        private var var_5352:InfoStandSongDiskView;
        private var var_5353:Array;
        private var var_5354:InfostandUserData;
        private var var_3153:InfostandFurniData;
        private var _petData:InfoStandPetData;
        private var _mainContainer:IWindowContainer;
        private var var_5346:Timer;
        private var _config:IHabboConfigurationManager;
        private var _catalog:IHabboCatalog;

        public function InfostandWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager, param5:IHabboConfigurationManager, param6:IHabboCatalog)
        {
            super(param1, param2, param3, param4);
            this._config = param5;
            this._catalog = param6;
            this.var_5347 = new InfoStandFurniView(this, this.var_5339, this._catalog);
            this.var_5348 = new InfoStandUserView(this, this.var_5340);
            this.var_5349 = new InfoStandPetView(this, this.var_5341, this._catalog);
            this.var_5350 = new InfoStandBotView(this, this.var_5342);
            this.var_5351 = new InfoStandJukeboxView(this, this.var_5343, this._catalog);
            this.var_5352 = new InfoStandSongDiskView(this, this.var_5344, this._catalog);
            this.var_5354 = new InfostandUserData();
            this.var_3153 = new InfostandFurniData();
            this._petData = new InfoStandPetData();
            this.var_5346 = new Timer(this.var_5345);
            this.var_5346.addEventListener(TimerEvent.TIMER, this.onUpdateTimer);
            this.mainContainer.visible = false;
            this.handler.widget = this;
        }

        public function get handler():InfoStandWidgetHandler
        {
            return (var_1604 as InfoStandWidgetHandler);
        }

        override public function get mainWindow():IWindow
        {
            return (this.mainContainer);
        }

        public function get config():IHabboConfigurationManager
        {
            return (this._config);
        }

        public function get mainContainer():IWindowContainer
        {
            if (this._mainContainer == null)
            {
                this._mainContainer = (windowManager.createWindow("infostand_main_container", "", HabboWindowType.var_218, HabboWindowStyle.var_157, HabboWindowParam.var_157, new Rectangle(0, 0, 50, 100)) as IWindowContainer);
                this._mainContainer.tags.push("room_widget_infostand");
                this._mainContainer.background = true;
                this._mainContainer.color = 0;
            };
            return (this._mainContainer);
        }

        public function favouriteGroupUpdated(param1:int, param2:int, param3:int):void
        {
            var _loc5_:String;
            var _loc6_:BitmapData;
            if (((!(this.userData)) || (!(this.userData.userRoomId == param1))))
            {
                return;
            };
            if (!this.mainContainer)
            {
                return;
            };
            var _loc4_:IWindow = this.mainContainer.findChildByName(this.var_5340);
            if (((!(_loc4_)) || (!(_loc4_.visible))))
            {
                return;
            };
            this.var_5348.clearGroupBadge();
            if (param2 != -1)
            {
                _loc5_ = this.handler.container.sessionDataManager.getGroupBadgeId(param2);
                this.userData.groupId = param2;
                this.userData.groupBadgeId = _loc5_;
                _loc6_ = this.handler.container.sessionDataManager.getGroupBadgeImage(_loc5_);
                this.var_5348.setGroupBadgeImage(_loc6_);
            };
        }

        public function getXmlWindow(name:String):IWindow
        {
            var asset:IAsset;
            var xmlAsset:XmlAsset;
            var window:IWindow;
            try
            {
                asset = assets.getAssetByName(name);
                xmlAsset = XmlAsset(asset);
                window = windowManager.buildFromXML(XML(xmlAsset.content));
            }
            catch(e:Error)
            {
                Logger.log(("[InfoStandWidget] Missing window XML: " + name));
            };
            return (window);
        }

        override public function dispose():void
        {
            if (this.var_5346)
            {
                this.var_5346.stop();
            };
            this.var_5346 = null;
            if (this.var_5348)
            {
                this.var_5348.dispose();
            };
            this.var_5348 = null;
            if (this.var_5347)
            {
                this.var_5347.dispose();
            };
            this.var_5347 = null;
            if (this.var_5350)
            {
                this.var_5350.dispose();
            };
            this.var_5350 = null;
            if (this.var_5349)
            {
                this.var_5349.dispose();
            };
            this.var_5349 = null;
            if (this.var_5351)
            {
                this.var_5351.dispose();
            };
            this.var_5351 = null;
            if (this.var_5352)
            {
                this.var_5352.dispose();
            };
            this.var_5352 = null;
            super.dispose();
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1539, this.onRoomObjectSelected);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1544, this.onClose);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1543, this.onRoomObjectRemoved);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1542, this.onRoomObjectRemoved);
            param1.addEventListener(RoomWidgetUserInfoUpdateEvent.var_1697, this.onUserInfo);
            param1.addEventListener(RoomWidgetUserInfoUpdateEvent.var_1641, this.onUserInfo);
            param1.addEventListener(RoomWidgetUserInfoUpdateEvent.BOT, this.onBotInfo);
            param1.addEventListener(RoomWidgetFurniInfoUpdateEvent.var_1702, this.onFurniInfo);
            param1.addEventListener(RoomWidgetUserTagsUpdateEvent.var_1703, this.onUserTags);
            param1.addEventListener(RoomWidgetUserFigureUpdateEvent.var_1704, this.onUserFigureUpdate);
            param1.addEventListener(RoomWidgetUserBadgesUpdateEvent.var_342, this.onUserBadges);
            param1.addEventListener(RoomWidgetBadgeImageUpdateEvent.var_1705, this.onBadgeImage);
            param1.addEventListener(RoomWidgetPetInfoUpdateEvent.PET_INFO, this.onPetInfo);
            param1.addEventListener(RoomWidgetPetCommandsUpdateEvent.PET_COMMANDS, this.onPetCommands);
            param1.addEventListener(RoomWidgetSongUpdateEvent.var_1706, this.onSongUpdate);
            param1.addEventListener(RoomWidgetSongUpdateEvent.var_1707, this.onSongUpdate);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1539, this.onRoomObjectSelected);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1544, this.onClose);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1543, this.onRoomObjectRemoved);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1542, this.onRoomObjectRemoved);
            param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.var_1697, this.onUserInfo);
            param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.var_1641, this.onUserInfo);
            param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.BOT, this.onBotInfo);
            param1.removeEventListener(RoomWidgetFurniInfoUpdateEvent.var_1702, this.onFurniInfo);
            param1.removeEventListener(RoomWidgetUserTagsUpdateEvent.var_1703, this.onUserTags);
            param1.removeEventListener(RoomWidgetUserFigureUpdateEvent.var_1704, this.onUserFigureUpdate);
            param1.removeEventListener(RoomWidgetUserBadgesUpdateEvent.var_342, this.onUserBadges);
            param1.removeEventListener(RoomWidgetBadgeImageUpdateEvent.var_1705, this.onBadgeImage);
            param1.removeEventListener(RoomWidgetPetInfoUpdateEvent.PET_INFO, this.onPetInfo);
            param1.removeEventListener(RoomWidgetPetCommandsUpdateEvent.PET_COMMANDS, this.onPetCommands);
            param1.removeEventListener(RoomWidgetSongUpdateEvent.var_1706, this.onSongUpdate);
            param1.removeEventListener(RoomWidgetSongUpdateEvent.var_1707, this.onSongUpdate);
        }

        public function get userData():InfostandUserData
        {
            return (this.var_5354);
        }

        public function get furniData():InfostandFurniData
        {
            return (this.var_3153);
        }

        public function get petData():InfoStandPetData
        {
            return (this._petData);
        }

        private function onUpdateTimer(param1:TimerEvent):void
        {
            if (this.var_5349 == null)
            {
                return;
            };
            messageListener.processWidgetMessage(new RoomWidgetUserActionMessage(RoomWidgetUserActionMessage.var_1708, this.var_5349.getCurrentPetId()));
        }

        private function onUserInfo(param1:RoomWidgetUserInfoUpdateEvent):void
        {
            this.userData.setData(param1);
            this.var_5348.update(param1);
            this.selectView(this.var_5340);
            if (this.var_5346)
            {
                this.var_5346.stop();
            };
        }

        private function onBotInfo(param1:RoomWidgetUserInfoUpdateEvent):void
        {
            this.userData.setData(param1);
            this.var_5350.update(param1);
            this.selectView(this.var_5342);
            if (this.var_5346)
            {
                this.var_5346.stop();
            };
        }

        private function onFurniInfo(param1:RoomWidgetFurniInfoUpdateEvent):void
        {
            this.furniData.setData(param1);
            if (param1.extraParam == RoomWidgetInfostandExtraParamEnum.var_1083)
            {
                this.var_5351.update(param1);
                this.selectView(this.var_5343);
            }
            else
            {
                if (param1.extraParam.indexOf(RoomWidgetInfostandExtraParamEnum.var_1092) != -1)
                {
                    this.var_5352.update(param1);
                    this.selectView(this.var_5344);
                }
                else
                {
                    this.var_5347.update(param1);
                    this.selectView(this.var_5339);
                };
            };
            if (this.var_5346)
            {
                this.var_5346.stop();
            };
        }

        private function onPetInfo(param1:RoomWidgetPetInfoUpdateEvent):void
        {
            this.petData.setData(param1);
            this.userData.petRespectLeft = param1.petRespectLeft;
            this.var_5349.update(this.petData);
            this.selectView(this.var_5341);
            if (this.var_5346)
            {
                this.var_5346.start();
            };
        }

        private function onPetCommands(param1:RoomWidgetPetCommandsUpdateEvent):void
        {
            this.var_5349.updateEnabledTrainingCommands(param1.id, new CommandConfiguration(param1.allCommands, param1.enabledCommands));
        }

        private function onUserTags(param1:RoomWidgetUserTagsUpdateEvent):void
        {
            if (param1.isOwnUser)
            {
                this.var_5353 = param1.tags;
            };
            if (param1.userId != this.userData.userId)
            {
                return;
            };
            if (param1.isOwnUser)
            {
                this.var_5348.setTags(param1.tags);
            }
            else
            {
                this.var_5348.setTags(param1.tags, this.var_5353);
            };
        }

        private function onUserFigureUpdate(param1:RoomWidgetUserFigureUpdateEvent):void
        {
            if (param1.userId != this.userData.userId)
            {
                return;
            };
            if (this.userData.isBot())
            {
                this.var_5350.image = param1.image;
            }
            else
            {
                this.var_5348.image = param1.image;
                this.var_5348.setMotto(param1.customInfo, param1.isOwnUser);
                this.var_5348.achievementScore = param1.achievementScore;
            };
        }

        private function onUserBadges(param1:RoomWidgetUserBadgesUpdateEvent):void
        {
            if (param1.userId != this.userData.userId)
            {
                return;
            };
            this.userData.badges = param1.badges;
            this.var_5348.clearBadges();
        }

        private function onBadgeImage(param1:RoomWidgetBadgeImageUpdateEvent):void
        {
            var _loc2_:int = this.userData.badges.indexOf(param1.badgeID);
            if (_loc2_ >= 0)
            {
                if (this.userData.isBot())
                {
                    this.var_5350.setBadgeImage(_loc2_, param1.badgeImage);
                }
                else
                {
                    this.var_5348.setBadgeImage(_loc2_, param1.badgeImage);
                };
                return;
            };
            if (param1.badgeID == this.userData.groupBadgeId)
            {
                this.var_5348.setGroupBadgeImage(param1.badgeImage);
            };
        }

        private function onRoomObjectSelected(param1:RoomWidgetRoomObjectUpdateEvent):void
        {
            var _loc2_:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.var_1661, param1.id, param1.category);
            messageListener.processWidgetMessage(_loc2_);
        }

        private function onRoomObjectRemoved(param1:RoomWidgetRoomObjectUpdateEvent):void
        {
            var _loc2_:Boolean;
            switch (param1.type)
            {
                case RoomWidgetRoomObjectUpdateEvent.var_1542:
                    _loc2_ = (param1.id == this.var_3153.id);
                    break;
                case RoomWidgetRoomObjectUpdateEvent.var_1543:
                    if ((((!(this.var_5348 == null)) && (!(this.var_5348.window == null))) && (this.var_5348.window.visible)))
                    {
                        _loc2_ = (param1.id == this.var_5354.userRoomId);
                        break;
                    };
                    if ((((!(this.var_5349 == null)) && (!(this.var_5349.window == null))) && (this.var_5349.window.visible)))
                    {
                        _loc2_ = (param1.id == this._petData.roomIndex);
                        break;
                    };
                    if ((((!(this.var_5350 == null)) && (!(this.var_5350.window == null))) && (this.var_5350.window.visible)))
                    {
                        _loc2_ = (param1.id == this.var_5354.userRoomId);
                        break;
                    };
            };
            if (_loc2_)
            {
                this.close();
            };
        }

        private function onSongUpdate(param1:RoomWidgetSongUpdateEvent):void
        {
            this.var_5351.updateSongInfo(param1);
            this.var_5352.updateSongInfo(param1);
        }

        public function close():void
        {
            this.hideChildren();
            if (this.var_5346)
            {
                this.var_5346.stop();
            };
        }

        private function onClose(param1:RoomWidgetRoomObjectUpdateEvent):void
        {
            this.close();
            if (this.var_5346)
            {
                this.var_5346.stop();
            };
        }

        private function hideChildren():void
        {
            var _loc1_:int;
            if (this._mainContainer != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this._mainContainer.numChildren)
                {
                    this._mainContainer.getChildAt(_loc1_).visible = false;
                    _loc1_++;
                };
            };
        }

        private function selectView(param1:String):void
        {
            this.hideChildren();
            var _loc2_:IWindow = (this.mainContainer.getChildByName(param1) as IWindow);
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.visible = true;
            this.mainContainer.visible = true;
            this.mainContainer.width = _loc2_.width;
            this.mainContainer.height = _loc2_.height;
        }

        public function refreshContainer():void
        {
            var _loc1_:IWindow;
            var _loc2_:int;
            while (_loc2_ < this.mainContainer.numChildren)
            {
                _loc1_ = this.mainContainer.getChildAt(_loc2_);
                if (_loc1_.visible)
                {
                    this.mainContainer.width = _loc1_.width;
                    this.mainContainer.height = _loc1_.height;
                };
                _loc2_++;
            };
        }


    }
}