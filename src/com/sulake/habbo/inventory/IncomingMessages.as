package com.sulake.habbo.inventory
{
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListInsertEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListRemoveEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListUpdateEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.PostItPlacedEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectActivatedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectAddedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectExpiredMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgesEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboUserBadgesMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgePointLimitsEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementsScoreEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAcceptEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingAcceptParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingConfirmationEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingConfirmationParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAlreadyOpenEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingAlreadyOpenParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCloseEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingCloseParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCompletedEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingCompletedParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingItemListEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingItemListParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingNotOpenEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingNotOpenParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOpenEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingOpenParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOtherNotAllowedEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingOtherNotAllowedParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingYouAreNotAllowedEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingYouAreNotAllowedParser;
    import com.sulake.habbo.communication.messages.incoming.room.session.OpenConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatAccessDeniedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetInventoryEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetAddedToInventoryEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetRemovedFromInventoryEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetInventoryUpdatedEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceConfigurationEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCanMakeOfferResult;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceMakeOfferResult;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceItemStatsEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.NotEnoughBalanceMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.UnseenItemsEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListParser;
    import com.sulake.habbo.inventory.furni.FurniModel;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListInsertParser;
    import com.sulake.habbo.inventory.items.IItem;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniData;
    import com.sulake.habbo.inventory.items.FloorItem;
    import com.sulake.habbo.inventory.items.WallItem;
    import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListRemoveParser;
    import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestFurniInventoryComposer;
    import com.sulake.habbo.inventory.enum.InventoryCategory;
    import com.sulake.habbo.communication.messages.parser.inventory.furni.PostItPlacedParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffect;
    import com.sulake.habbo.inventory.effects.Effect;
    import com.sulake.habbo.inventory.effects.EffectsModel;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectsMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectAddedMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectActivatedMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectExpiredMessageParser;
    import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoMessageParser;
    import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgesParser;
    import com.sulake.habbo.inventory.badges.BadgesModel;
    import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgeAndPointLimit;
    import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgePointLimitsParser;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsScoreMessageParser;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.inventory.enum.InventorySubCategory;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.inventory.trading.TradingModel;
    import com.sulake.habbo.inventory.items.GroupItem;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.ItemDataStructure;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.inventory.enum.FurniCategory;
    import com.sulake.habbo.inventory.enum.FurniModelCategory;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
    import com.sulake.habbo.inventory.pets.PetsModel;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetInventoryMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetAddedToInventoryParser;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetRemovedFromInventoryParser;
    import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceConfigurationParser;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceCanMakeOfferResultParser;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceMakeOfferResultParser;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceItemStatsParser;
    import com.sulake.habbo.communication.messages.parser.notifications.UnseenItemsParser;
    import com.sulake.habbo.communication.messages.outgoing.notifications.UnseenItemCategoryEnum;

    public class IncomingMessages 
    {

        private var var_3071:HabboInventory;
        private var var_4124:IHabboCommunicationManager;

        public function IncomingMessages(param1:HabboInventory)
        {
            this.var_3071 = param1;
            this.var_4124 = this.var_3071.communication;
            this.var_4124.addHabboConnectionMessageEvent(new FurniListEvent(this.onFurniList));
            this.var_4124.addHabboConnectionMessageEvent(new FurniListInsertEvent(this.onFurniListInsert));
            this.var_4124.addHabboConnectionMessageEvent(new FurniListRemoveEvent(this.onFurniListRemove));
            this.var_4124.addHabboConnectionMessageEvent(new FurniListUpdateEvent(this.onFurniListUpdate));
            this.var_4124.addHabboConnectionMessageEvent(new PostItPlacedEvent(this.onPostItPlaced));
            this.var_4124.addHabboConnectionMessageEvent(new AvatarEffectsMessageEvent(this.onAvatarEffects));
            this.var_4124.addHabboConnectionMessageEvent(new AvatarEffectActivatedMessageEvent(this.onAvatarEffectActivated));
            this.var_4124.addHabboConnectionMessageEvent(new AvatarEffectAddedMessageEvent(this.onAvatarEffectAdded));
            this.var_4124.addHabboConnectionMessageEvent(new AvatarEffectExpiredMessageEvent(this.onAvatarEffectExpired));
            this.var_4124.addHabboConnectionMessageEvent(new ScrSendUserInfoEvent(this.onClubStatus));
            this.var_4124.addHabboConnectionMessageEvent(new BadgesEvent(this.onBadges));
            this.var_4124.addHabboConnectionMessageEvent(new HabboUserBadgesMessageEvent(this.onUserBadges));
            this.var_4124.addHabboConnectionMessageEvent(new HabboAchievementNotificationMessageEvent(this.onAchievementReceived));
            this.var_4124.addHabboConnectionMessageEvent(new BadgePointLimitsEvent(this.var_1276));
            this.var_4124.addHabboConnectionMessageEvent(new AchievementsScoreEvent(this.onAchievementsScore));
            this.var_4124.addHabboConnectionMessageEvent(new TradingAcceptEvent(this.onTradingAccepted, TradingAcceptParser));
            this.var_4124.addHabboConnectionMessageEvent(new TradingConfirmationEvent(this.onTradingConfirmation, TradingConfirmationParser));
            this.var_4124.addHabboConnectionMessageEvent(new TradingAlreadyOpenEvent(this.onTradingAlreadyOpen, TradingAlreadyOpenParser));
            this.var_4124.addHabboConnectionMessageEvent(new TradingCloseEvent(this.onTradingClose, TradingCloseParser));
            this.var_4124.addHabboConnectionMessageEvent(new TradingCompletedEvent(this.onTradingCompleted, TradingCompletedParser));
            this.var_4124.addHabboConnectionMessageEvent(new TradingItemListEvent(this.onTradingItemList, TradingItemListParser));
            this.var_4124.addHabboConnectionMessageEvent(new TradingNotOpenEvent(this.onTradingNotOpen, TradingNotOpenParser));
            this.var_4124.addHabboConnectionMessageEvent(new TradingOpenEvent(this.onTradingOpen, TradingOpenParser));
            this.var_4124.addHabboConnectionMessageEvent(new TradingOtherNotAllowedEvent(this.onTradingOtherNotAllowed, TradingOtherNotAllowedParser));
            this.var_4124.addHabboConnectionMessageEvent(new TradingYouAreNotAllowedEvent(this.onTradingYouAreNotAllowed, TradingYouAreNotAllowedParser));
            this.var_4124.addHabboConnectionMessageEvent(new OpenConnectionMessageEvent(this.onRoomClosed));
            this.var_4124.addHabboConnectionMessageEvent(new CloseConnectionMessageEvent(this.onRoomClosed));
            this.var_4124.addHabboConnectionMessageEvent(new FlatAccessDeniedMessageEvent(this.onRoomClosed));
            this.var_4124.addHabboConnectionMessageEvent(new PetInventoryEvent(this.onPets));
            this.var_4124.addHabboConnectionMessageEvent(new PetAddedToInventoryEvent(this.onPetAdded));
            this.var_4124.addHabboConnectionMessageEvent(new PetRemovedFromInventoryEvent(this.onPetRemoved));
            this.var_4124.addHabboConnectionMessageEvent(new PetInventoryUpdatedEvent(this.onPetInventoryUpdated));
            this.var_4124.addHabboConnectionMessageEvent(new MarketplaceConfigurationEvent(this.onMarketplaceConfiguration));
            this.var_4124.addHabboConnectionMessageEvent(new MarketplaceCanMakeOfferResult(this.onMarketplaceCanMakeOfferResult));
            this.var_4124.addHabboConnectionMessageEvent(new MarketplaceMakeOfferResult(this.onMarketplaceMakeOfferResult));
            this.var_4124.addHabboConnectionMessageEvent(new MarketplaceItemStatsEvent(this.onMarketplaceItemStats));
            this.var_4124.addHabboConnectionMessageEvent(new NotEnoughBalanceMessageEvent(this.onNotEnoughCredits));
            this.var_4124.addHabboConnectionMessageEvent(new UserRightsMessageEvent(this.onUserRights));
            this.var_4124.addHabboConnectionMessageEvent(new UnseenItemsEvent(this.onUnseenItems));
        }

        public function dispose():void
        {
            this.var_3071 = null;
            this.var_4124 = null;
        }

        private function getConnection():IConnection
        {
            if (this.var_4124 == null)
            {
                return (null);
            };
            return (this.var_4124.getHabboMainConnection(null));
        }

        public function onFurniList(param1:IMessageEvent):void
        {
            var _loc2_:FurniListParser = (param1 as FurniListEvent).getParser();
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:FurniModel = this.var_3071.furniModel;
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.insertFurniList(_loc2_.categoryType, _loc2_.getFurni(), _loc2_.totalFragments, _loc2_.fragmentNo);
        }

        public function onFurniListInsert(param1:IMessageEvent):void
        {
            var _loc2_:FurniListInsertParser = (param1 as FurniListInsertEvent).getParser();
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:FurniModel = this.var_3071.furniModel;
            if (((_loc3_ == null) || (!(_loc3_.isListInited()))))
            {
                return;
            };
            var _loc4_:IItem;
            var _loc5_:FurniData;
            var _loc6_:Array = _loc2_.getFurni();
            var _loc7_:int;
            while (_loc7_ < _loc6_.length)
            {
                _loc5_ = FurniData(_loc6_[_loc7_]);
                if (_loc5_.itemType == "S")
                {
                    _loc4_ = new FloorItem(_loc5_.stripId, _loc5_.classId, _loc5_.objId, _loc5_.category, _loc5_.isGroupable, _loc5_.isTradeable, _loc5_.isRecyclable, _loc5_.isSellable, _loc5_.stuffData, _loc5_.extra, _loc5_.expiryTime, 0, 0, 0, _loc5_.slotId, _loc5_.songId);
                }
                else
                {
                    if (_loc5_.itemType == "I")
                    {
                        _loc4_ = new WallItem(_loc5_.stripId, _loc5_.classId, _loc5_.objId, _loc5_.category, _loc5_.isGroupable, _loc5_.isTradeable, _loc5_.isRecyclable, _loc5_.isSellable, _loc5_.stuffData, _loc5_.extra);
                    }
                    else
                    {
                        throw (new Error((('Unknown inventory item category: "' + _loc5_.itemType) + '"')));
                    };
                };
                _loc3_.addFurniAsLast(_loc4_);
                _loc7_++;
            };
        }

        public function onFurniListRemove(param1:IMessageEvent):void
        {
            var _loc2_:FurniListRemoveParser = (param1 as FurniListRemoveEvent).getParser();
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:FurniModel = this.var_3071.furniModel;
            if (_loc3_ == null)
            {
                return;
            };
            var _loc4_:int = _loc2_.stripId;
            _loc3_.removeFurni(_loc4_);
        }

        public function onFurniListUpdate(param1:IMessageEvent):void
        {
            var _loc2_:IConnection = this.getConnection();
            if (_loc2_ != null)
            {
                _loc2_.send(new RequestFurniInventoryComposer());
            };
            this.var_3071.setInventoryCategoryInit(InventoryCategory.var_125, false);
        }

        public function onPostItPlaced(param1:IMessageEvent):void
        {
            var _loc2_:PostItPlacedParser = (param1 as PostItPlacedEvent).getParser();
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:FurniModel = this.var_3071.furniModel;
            if (_loc3_ == null)
            {
                return;
            };
            var _loc4_:int = _loc2_.id;
            var _loc5_:int = _loc2_.itemsLeft;
            _loc3_.updatePostItCount(_loc4_, _loc5_);
        }

        public function onAvatarEffects(param1:IMessageEvent):void
        {
            var _loc6_:AvatarEffect;
            var _loc7_:Effect;
            if (this.var_3071 == null)
            {
                return;
            };
            var _loc2_:EffectsModel = this.var_3071.effectsModel;
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:AvatarEffectsMessageParser = (param1 as AvatarEffectsMessageEvent).getParser();
            if (_loc3_ == null)
            {
                return;
            };
            var _loc4_:Array = _loc3_.effects;
            var _loc5_:int;
            while (_loc5_ < _loc4_.length)
            {
                _loc6_ = (_loc4_[_loc5_] as AvatarEffect);
                _loc7_ = new Effect();
                _loc7_.type = _loc6_.type;
                _loc7_.duration = _loc6_.duration;
                _loc7_.effectsInInventory = _loc6_.inactiveEffectsInInventory;
                if (_loc6_.secondsLeftIfActive >= 0)
                {
                    _loc7_.isActive = true;
                    _loc7_.secondsLeft = _loc6_.secondsLeftIfActive;
                    _loc7_.effectsInInventory++;
                }
                else
                {
                    if (_loc6_.secondsLeftIfActive == -1)
                    {
                        _loc7_.isActive = false;
                        _loc7_.secondsLeft = _loc6_.duration;
                    };
                };
                _loc2_.addEffect(_loc7_, false);
                _loc5_++;
            };
            this.var_3071.setInventoryCategoryInit(InventoryCategory.var_252);
            _loc2_.refreshViews();
            this.var_3071.notifyChangedEffects();
        }

        public function onAvatarEffectAdded(param1:IMessageEvent):void
        {
            var _loc2_:EffectsModel = this.var_3071.effectsModel;
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:AvatarEffectAddedMessageParser = (param1 as AvatarEffectAddedMessageEvent).getParser();
            if (_loc3_ == null)
            {
                return;
            };
            var _loc4_:int = _loc3_.type;
            var _loc5_:int = _loc3_.duration;
            var _loc6_:Effect = new Effect();
            _loc6_.type = _loc4_;
            _loc6_.duration = _loc5_;
            _loc6_.secondsLeft = _loc5_;
            _loc2_.addEffect(_loc6_);
            this.var_3071.notifyChangedEffects();
        }

        public function onAvatarEffectActivated(param1:IMessageEvent):void
        {
            var _loc2_:EffectsModel = this.var_3071.effectsModel;
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:AvatarEffectActivatedMessageParser = (param1 as AvatarEffectActivatedMessageEvent).getParser();
            if (_loc3_ == null)
            {
                return;
            };
            var _loc4_:int = _loc3_.type;
            _loc2_.setEffectActivated(_loc4_);
            this.var_3071.notifyChangedEffects();
        }

        public function onAvatarEffectExpired(param1:IMessageEvent):void
        {
            var _loc2_:EffectsModel = this.var_3071.effectsModel;
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:AvatarEffectExpiredMessageParser = (param1 as AvatarEffectExpiredMessageEvent).getParser();
            if (_loc3_ == null)
            {
                return;
            };
            var _loc4_:int = _loc3_.type;
            _loc2_.setEffectExpired(_loc4_);
            this.var_3071.notifyChangedEffects();
        }

        public function onClubStatus(param1:IMessageEvent):void
        {
            var _loc2_:ScrSendUserInfoMessageParser = (param1 as ScrSendUserInfoEvent).getParser();
            if (((_loc2_.productName == "habbo_club") || (_loc2_.productName == "club_habbo")))
            {
                this.var_3071.setClubStatus(_loc2_.periodsSubscribedAhead, _loc2_.daysToPeriodEnd, _loc2_.hasEverBeenMember, _loc2_.isVIP, (_loc2_.responseType == ScrSendUserInfoMessageParser.var_145));
                this.var_3071.events.dispatchEvent(new HabboInventoryHabboClubEvent());
            };
        }

        public function onBadges(param1:IMessageEvent):void
        {
            var _loc4_:int;
            var _loc5_:String;
            var _loc8_:Boolean;
            var _loc9_:int;
            var _loc2_:BadgesParser = (param1 as BadgesEvent).getParser();
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:BadgesModel = this.var_3071.badgesModel;
            if (_loc3_ == null)
            {
                return;
            };
            var _loc6_:Array = _loc2_.getAllBadgeCodes();
            var _loc7_:Array = _loc2_.getActiveBadgeCodes();
            for each (_loc5_ in _loc6_)
            {
                _loc8_ = (_loc7_.indexOf(_loc5_) > -1);
                _loc9_ = _loc2_.getBadgeId(_loc5_);
                _loc3_.updateBadge(_loc5_, _loc8_, _loc9_);
            };
            _loc3_.forceSelection();
            _loc3_.updateView();
            this.var_3071.setInventoryCategoryInit(InventoryCategory.var_124);
        }

        public function var_1276(param1:IMessageEvent):void
        {
            var _loc3_:BadgeAndPointLimit;
            var _loc2_:BadgePointLimitsParser = (param1 as BadgePointLimitsEvent).getParser();
            for each (_loc3_ in _loc2_.data)
            {
                this.var_3071.localization.setBadgePointLimit(_loc3_.badgeId, _loc3_.limit);
            };
        }

        public function onUserBadges(param1:IMessageEvent):void
        {
            var _loc4_:String;
            var _loc2_:HabboUserBadgesMessageEvent = (param1 as HabboUserBadgesMessageEvent);
            if (_loc2_.userId != this.var_3071.sessionData.userId)
            {
                return;
            };
            var _loc3_:BadgesModel = this.var_3071.badgesModel;
            if (_loc3_ == null)
            {
                return;
            };
            for each (_loc4_ in _loc2_.badges)
            {
                _loc3_.updateBadge(_loc4_, true);
            };
            _loc3_.updateView();
        }

        public function onAchievementReceived(param1:IMessageEvent):void
        {
            var _loc2_:HabboAchievementNotificationMessageEvent = (param1 as HabboAchievementNotificationMessageEvent);
            var _loc3_:HabboAchievementNotificationMessageParser = _loc2_.getParser();
            var _loc4_:BadgesModel = this.var_3071.badgesModel;
            if (_loc4_ != null)
            {
                _loc4_.updateBadge(_loc3_.data.badgeCode, false, _loc3_.data.badgeId);
                _loc4_.removeBadge(_loc3_.data.removedBadgeCode);
                _loc4_.updateView();
            };
        }

        public function onAchievementsScore(param1:IMessageEvent):void
        {
            var _loc2_:AchievementsScoreEvent = (param1 as AchievementsScoreEvent);
            var _loc3_:AchievementsScoreMessageParser = (_loc2_.getParser() as AchievementsScoreMessageParser);
            if (_loc3_ == null)
            {
                return;
            };
            this.var_3071.localization.registerParameter("achievements_score_description", "score", _loc3_.score.toString());
        }

        private function onTradingOpen(param1:IMessageEvent):void
        {
            var _loc14_:int;
            var _loc15_:String;
            var _loc16_:Boolean;
            if (!this.var_3071)
            {
                ErrorReportStorage.addDebugData("IncomingEvent", "Trading open - inventory is null!");
                return;
            };
            var _loc2_:ISessionDataManager = this.var_3071.sessionData;
            var _loc3_:IRoomSession = this.var_3071.roomSession;
            if (!_loc2_)
            {
                ErrorReportStorage.addDebugData("IncomingEvent", "Trading open - sessionData not available!");
                return;
            };
            if (!_loc3_)
            {
                ErrorReportStorage.addDebugData("IncomingEvent", "Trading open - roomSession not available!");
                return;
            };
            this.var_3071.toggleInventorySubPage(InventorySubCategory.var_251);
            var _loc4_:TradingOpenEvent = (param1 as TradingOpenEvent);
            if (!_loc4_)
            {
                ErrorReportStorage.addDebugData("IncomingEvent", (("event is of unknown type:" + param1) + "!"));
                return;
            };
            var _loc5_:int = _loc4_.userID;
            var _loc6_:IUserData = _loc3_.userDataManager.getUserData(_loc5_);
            if (!_loc6_)
            {
                ErrorReportStorage.addDebugData("IncomingEvent", "Trading open - failed to retrieve own user data!");
                return;
            };
            var _loc7_:String = _loc6_.name;
            var _loc8_:* = (_loc4_.userCanTrade > 0);
            var _loc9_:int = _loc4_.otherUserID;
            var _loc10_:IUserData = _loc3_.userDataManager.getUserData(_loc9_);
            if (!_loc10_)
            {
                ErrorReportStorage.addDebugData("IncomingEvent", "Trading open - failed to retrieve other user data!");
                return;
            };
            var _loc11_:String = _loc10_.name;
            var _loc12_:* = (_loc4_.otherUserCanTrade > 0);
            if (_loc9_ == _loc2_.userId)
            {
                _loc14_ = _loc5_;
                _loc15_ = _loc7_;
                _loc16_ = _loc8_;
                _loc5_ = _loc9_;
                _loc7_ = _loc11_;
                _loc8_ = _loc12_;
                _loc9_ = _loc14_;
                _loc11_ = _loc15_;
                _loc12_ = _loc16_;
            };
            var _loc13_:TradingModel = this.var_3071.tradingModel;
            if (_loc13_ != null)
            {
                _loc13_.startTrading(_loc5_, _loc7_, _loc8_, _loc9_, _loc11_, _loc12_);
            };
        }

        private function onTradingAlreadyOpen(param1:IMessageEvent):void
        {
            var _loc2_:TradingModel = this.var_3071.tradingModel;
            if (_loc2_ != null)
            {
                _loc2_.handleMessageEvent(param1);
            };
        }

        private function onTradingClose(param1:IMessageEvent):void
        {
            var _loc2_:TradingModel = this.var_3071.tradingModel;
            if (_loc2_ != null)
            {
                _loc2_.handleMessageEvent(param1);
            };
        }

        private function onTradingCompleted(param1:IMessageEvent):void
        {
            var _loc2_:TradingModel = this.var_3071.tradingModel;
            if (_loc2_ != null)
            {
                _loc2_.handleMessageEvent(param1);
            };
        }

        private function onTradingAccepted(param1:IMessageEvent):void
        {
            var _loc2_:TradingModel = this.var_3071.tradingModel;
            if (_loc2_ != null)
            {
                _loc2_.handleMessageEvent(param1);
            };
        }

        private function onTradingConfirmation(param1:IMessageEvent):void
        {
            var _loc2_:TradingModel = this.var_3071.tradingModel;
            if (_loc2_ != null)
            {
                _loc2_.handleMessageEvent(param1);
            };
        }

        private function onTradingItemList(param1:IMessageEvent):void
        {
            var _loc5_:uint;
            var _loc6_:GroupItem;
            var _loc7_:int;
            var _loc8_:String;
            var _loc9_:ItemDataStructure;
            var _loc10_:int;
            var _loc2_:TradingItemListEvent = (param1 as TradingItemListEvent);
            var _loc3_:Map = new Map();
            var _loc4_:Map = new Map();
            var _loc11_:FurniModel = this.var_3071.furniModel;
            if (_loc11_ == null)
            {
                return;
            };
            _loc5_ = _loc2_.firstUserItemArray.length;
            _loc10_ = 0;
            while (_loc10_ < _loc5_)
            {
                _loc9_ = (_loc2_.firstUserItemArray[_loc10_] as ItemDataStructure);
                _loc7_ = _loc9_.itemTypeID;
                _loc8_ = (_loc9_.itemType + String(_loc7_));
                if (!_loc9_.groupable)
                {
                    _loc8_ = ("itemid" + _loc9_.itemID);
                };
                if (_loc9_.category == FurniCategory.var_615)
                {
                    _loc8_ = ((String(_loc7_) + "poster") + _loc9_.stuffData);
                };
                _loc6_ = ((_loc9_.groupable) ? (_loc3_.getValue(_loc8_) as GroupItem) : null);
                if (_loc9_.itemType == "S")
                {
                    if (_loc6_ == null)
                    {
                        _loc6_ = _loc11_.createNewGroupItemTemplate(_loc7_, FurniModelCategory.var_1277, _loc9_.category, _loc9_.stuffData);
                        _loc3_.add(_loc8_, _loc6_);
                    };
                    _loc6_.push(new FloorItem(_loc9_.itemID, _loc9_.itemTypeID, _loc9_.roomItemID, _loc9_.category, true, true, true, true, _loc9_.stuffData, _loc9_.extra, _loc9_.timeToExpiration, _loc9_.creationDay, _loc9_.creationMonth, _loc9_.creationYear, null, _loc9_.songID));
                }
                else
                {
                    if (_loc9_.itemType == "I")
                    {
                        if (_loc6_ == null)
                        {
                            _loc6_ = _loc11_.createNewGroupItemTemplate(_loc7_, FurniModelCategory.var_1278, _loc9_.category, _loc9_.stuffData);
                            _loc3_.add(_loc8_, _loc6_);
                        };
                        _loc6_.push(new WallItem(_loc9_.itemID, _loc9_.itemTypeID, _loc9_.roomItemID, _loc9_.category, true, true, true, true, _loc9_.stuffData, _loc9_.extra));
                    }
                    else
                    {
                        throw (new Error((('Unsupported item category: "' + _loc9_.itemType) + '"')));
                    };
                };
                _loc10_++;
            };
            _loc5_ = _loc2_.secondUserItemArray.length;
            _loc10_ = 0;
            while (_loc10_ < _loc5_)
            {
                _loc9_ = (_loc2_.secondUserItemArray[_loc10_] as ItemDataStructure);
                _loc7_ = _loc9_.itemTypeID;
                _loc8_ = (_loc9_.itemType + String(_loc7_));
                if (!_loc9_.groupable)
                {
                    _loc8_ = ("itemid" + _loc9_.itemID);
                };
                if (_loc9_.category == FurniCategory.var_615)
                {
                    _loc8_ = ((String(_loc7_) + "poster") + _loc9_.stuffData);
                };
                _loc6_ = ((_loc9_.groupable) ? (_loc4_.getValue(_loc8_) as GroupItem) : null);
                if (_loc9_.itemType == "S")
                {
                    if (_loc6_ == null)
                    {
                        _loc6_ = _loc11_.createNewGroupItemTemplate(_loc7_, FurniModelCategory.var_1277, _loc9_.category, _loc9_.stuffData);
                        _loc4_.add(_loc8_, _loc6_);
                    };
                    _loc6_.push(new FloorItem(_loc9_.itemID, _loc9_.itemTypeID, _loc9_.roomItemID, _loc9_.category, true, true, true, true, _loc9_.stuffData, _loc9_.extra, _loc9_.timeToExpiration, _loc9_.creationDay, _loc9_.creationMonth, _loc9_.creationYear, null, _loc9_.songID));
                }
                else
                {
                    if (_loc9_.itemType == "I")
                    {
                        if (_loc6_ == null)
                        {
                            _loc6_ = _loc11_.createNewGroupItemTemplate(_loc7_, FurniModelCategory.var_1278, _loc9_.category, _loc9_.stuffData);
                            _loc4_.add(_loc8_, _loc6_);
                        };
                        _loc6_.push(new WallItem(_loc9_.itemID, _loc9_.itemTypeID, _loc9_.roomItemID, _loc9_.category, true, true, true, true, _loc9_.stuffData, _loc9_.extra));
                    }
                    else
                    {
                        throw (new Error((('Unsupported item category: "' + _loc9_.itemType) + '"')));
                    };
                };
                _loc10_++;
            };
            var _loc12_:TradingModel = this.var_3071.tradingModel;
            if (_loc12_ != null)
            {
                _loc12_.updateItemGroupMaps(_loc2_.firstUserID, _loc3_, _loc2_.secondUserID, _loc4_);
            };
        }

        private function onTradingNotOpen(param1:IMessageEvent):void
        {
            var _loc2_:TradingModel = this.var_3071.tradingModel;
            if (_loc2_ != null)
            {
                _loc2_.handleMessageEvent(param1);
            };
        }

        private function onTradingOtherNotAllowed(param1:IMessageEvent):void
        {
            var _loc2_:TradingModel = this.var_3071.tradingModel;
            if (_loc2_ != null)
            {
                _loc2_.handleMessageEvent(param1);
            };
        }

        private function onTradingYouAreNotAllowed(param1:IMessageEvent):void
        {
            var _loc2_:TradingModel = this.var_3071.tradingModel;
            if (_loc2_ != null)
            {
                _loc2_.handleMessageEvent(param1);
            };
        }

        private function onRoomClosed(param1:IMessageEvent):void
        {
            this.var_3071.closeView();
        }

        private function onPets(param1:PetInventoryEvent):void
        {
            var _loc4_:PetData;
            if (((param1 == null) || (this.var_3071 == null)))
            {
                return;
            };
            var _loc2_:PetsModel = this.var_3071.petsModel;
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:PetInventoryMessageParser = param1.getParser();
            for each (_loc4_ in _loc3_.pets)
            {
                _loc2_.addPet(_loc4_);
            };
            this.var_3071.setInventoryCategoryInit(InventoryCategory.var_126);
            this.var_3071.petsModel.setListInitialized();
        }

        private function onPetAdded(param1:PetAddedToInventoryEvent):void
        {
            if (((param1 == null) || (this.var_3071 == null)))
            {
                return;
            };
            var _loc2_:PetsModel = this.var_3071.petsModel;
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:PetAddedToInventoryParser = param1.getParser();
            _loc2_.addPet(_loc3_.pet);
            this.var_3071.furniModel.automaticSwitchToPetCategory();
        }

        private function onPetRemoved(param1:PetRemovedFromInventoryEvent):void
        {
            if (((param1 == null) || (this.var_3071 == null)))
            {
                return;
            };
            var _loc2_:PetsModel = this.var_3071.petsModel;
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:PetRemovedFromInventoryParser = param1.getParser();
            _loc2_.removePet(_loc3_.petId);
        }

        private function onPetInventoryUpdated(param1:PetInventoryUpdatedEvent):void
        {
            var _loc2_:PetsModel = this.var_3071.petsModel;
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.requestPetInventory();
        }

        private function onMarketplaceConfiguration(param1:MarketplaceConfigurationEvent):void
        {
            if (((param1 == null) || (this.var_3071 == null)))
            {
                return;
            };
            var _loc2_:MarketplaceModel = this.var_3071.marketplaceModel;
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:MarketplaceConfigurationParser = param1.getParser();
            _loc2_.isEnabled = _loc3_.isEnabled;
            _loc2_.commission = _loc3_.commission;
            _loc2_.tokenBatchPrice = _loc3_.tokenBatchPrice;
            _loc2_.tokenBatchSize = _loc3_.tokenBatchSize;
            _loc2_.offerMinPrice = _loc3_.offerMinPrice;
            _loc2_.offerMaxPrice = _loc3_.offerMaxPrice;
            _loc2_.expirationHours = _loc3_.expirationHours;
            _loc2_.averagePricePeriod = _loc3_.averagePricePeriod;
            this.var_3071.setInventoryCategoryInit(InventoryCategory.var_254);
            var _loc4_:FurniModel = this.var_3071.furniModel;
            if (_loc4_ != null)
            {
                _loc4_.updateView();
            };
        }

        private function onMarketplaceCanMakeOfferResult(param1:MarketplaceCanMakeOfferResult):void
        {
            if (((param1 == null) || (this.var_3071 == null)))
            {
                return;
            };
            var _loc2_:MarketplaceModel = this.var_3071.marketplaceModel;
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:MarketplaceCanMakeOfferResultParser = param1.getParser();
            _loc2_.proceedOfferMaking(_loc3_.resultCode, _loc3_.tokenCount);
        }

        private function onMarketplaceMakeOfferResult(param1:MarketplaceMakeOfferResult):void
        {
            if (((param1 == null) || (this.var_3071 == null)))
            {
                return;
            };
            var _loc2_:MarketplaceModel = this.var_3071.marketplaceModel;
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:MarketplaceMakeOfferResultParser = param1.getParser();
            _loc2_.var_1279(_loc3_.result);
        }

        private function onMarketplaceItemStats(param1:MarketplaceItemStatsEvent):void
        {
            if (((param1 == null) || (this.var_3071 == null)))
            {
                return;
            };
            var _loc2_:MarketplaceModel = this.var_3071.marketplaceModel;
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:MarketplaceItemStatsParser = param1.getParser();
            _loc2_.setAveragePrice(_loc3_.furniCategoryId, _loc3_.furniTypeId, _loc3_.averagePrice);
        }

        private function onNotEnoughCredits(param1:NotEnoughBalanceMessageEvent):void
        {
            if (((!(param1)) || (!(this.var_3071))))
            {
                return;
            };
            var _loc2_:MarketplaceModel = this.var_3071.marketplaceModel;
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.onNotEnoughCredits();
        }

        private function onUserRights(param1:IMessageEvent):void
        {
            var _loc2_:MarketplaceModel;
            if (this.var_3071.isInventoryCategoryInit(InventoryCategory.var_254))
            {
                _loc2_ = this.var_3071.marketplaceModel;
                if (_loc2_ == null)
                {
                    return;
                };
                _loc2_.requestInitialization();
            };
        }

        private function onUnseenItems(param1:UnseenItemsEvent):void
        {
            var _loc2_:UnseenItemsParser = param1.getParser();
            this.var_3071.furniModel.addUnseenFloorItems(_loc2_.getItemsByCategory(UnseenItemCategoryEnum.var_1280));
            this.var_3071.furniModel.addUnseenWallItems(_loc2_.getItemsByCategory(UnseenItemCategoryEnum.var_1281));
            this.var_3071.petsModel.addUnseenPets(_loc2_.getItemsByCategory(UnseenItemCategoryEnum.var_179));
            this.var_3071.badgesModel.addUnseenBadges(_loc2_.getItemsByCategory(UnseenItemCategoryEnum.var_1282));
            this.var_3071.updateUnseenItemCounts();
        }


    }
}