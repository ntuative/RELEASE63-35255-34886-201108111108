package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.notifications.IHabboNotifications;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboNotifications;
    import com.sulake.iid.IIDHabboHelp;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;

    public class HabboQuestEngine extends Component implements IHabboQuestEngine, IUpdateReceiver 
    {

        private static const var_290:int = 5;
        private static const var_291:int = 800;
        private static const var_293:int = 15;
        private static const var_292:int = 300;
        private static const QUESTS_WITH_PROMPTS:Array = ["MOVEITEM", "ENTEROTHERSROOM", "CHANGEFIGURE", "FINDLIFEGUARDTOWER", "SCRATCHAPET"];

        private var _windowManager:IHabboWindowManager;
        private var _communication:IHabboCommunicationManager;
        private var _localization:IHabboLocalizationManager;
        private var _configuration:IHabboConfigurationManager;
        private var var_4033:IncomingMessages;
        private var var_4437:QuestController;
        private var var_4438:AchievementController;
        private var var_3317:IHabboToolbar;
        private var _catalog:IHabboCatalog;
        private var _navigator:IHabboNavigator;
        private var var_3890:IHabboNotifications;
        private var var_1354:ISessionDataManager;
        private var var_4439:IHabboHelp;
        private var _twinkleImages:TwinkleImages;
        private var var_4440:Boolean = false;

        public function HabboQuestEngine(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            this.var_4437 = new QuestController(this);
            this.var_4438 = new AchievementController(this);
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationComponentInit);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
            queueInterface(new IIDHabboToolbar(), this.onToolbarReady);
            queueInterface(new IIDHabboCatalog(), this.onCatalogReady);
            queueInterface(new IIDHabboNotifications(), this.onNotificationsReady);
            queueInterface(new IIDHabboHelp(), this.onHabboHelpReady);
            queueInterface(new IIDHabboNavigator(), this.onHabboNavigatorReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataManagerReady);
            registerUpdateReceiver(this, var_290);
        }

        public static function moveChildrenToRow(param1:IWindowContainer, param2:Array, param3:int, param4:int):void
        {
            var _loc5_:String;
            var _loc6_:IWindow;
            for each (_loc5_ in param2)
            {
                _loc6_ = param1.getChildByName(_loc5_);
                if (((!(_loc6_ == null)) && (_loc6_.visible)))
                {
                    _loc6_.x = param3;
                    param3 = (param3 + (_loc6_.width + param4));
                };
            };
        }


        override public function dispose():void
        {
            removeUpdateReceiver(this);
            super.dispose();
            if (this.var_3317)
            {
                this.var_3317.release(new IIDHabboToolbar());
                this.var_3317 = null;
            };
            if (this._catalog != null)
            {
                this._catalog.release(new IIDHabboCatalog());
                this._catalog = null;
            };
            if (this.var_3890 != null)
            {
                this.var_3890.release(new IIDHabboNotifications());
                this.var_3890 = null;
            };
            if (this._windowManager != null)
            {
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this._configuration != null)
            {
                this._configuration.release(new IIDHabboConfigurationManager());
                this._configuration = null;
            };
            if (this._localization != null)
            {
                this._localization.release(new IIDHabboLocalizationManager());
                this._localization = null;
            };
            if (this._communication != null)
            {
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            };
            if (this.var_1354 != null)
            {
                this.var_1354.events.removeEventListener(BadgeImageReadyEvent.var_100, this.var_4438.onBadgeImageReady);
                this.var_1354.release(new IIDSessionDataManager());
                this.var_1354 = null;
            };
            if (this.var_4033)
            {
                this.var_4033.dispose();
            };
            if (this.var_4439 != null)
            {
                this.var_4439.release(new IIDHabboHelp());
                this.var_4439 = null;
            };
            if (this._navigator != null)
            {
                this._navigator.release(new IIDHabboNavigator());
                this._navigator = null;
            };
            if (this._twinkleImages)
            {
                this._twinkleImages.dispose();
                this._twinkleImages = null;
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
                window = this._windowManager.buildFromXML(XML(xmlAsset.content));
            }
            catch(e:Error)
            {
            };
            return (window);
        }

        private function onCommunicationComponentInit(param1:IID=null, param2:IUnknown=null):void
        {
            this._communication = IHabboCommunicationManager(param2);
            this.var_4033 = new IncomingMessages(this);
        }

        private function onWindowManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._windowManager = IHabboWindowManager(param2);
        }

        private function onLocalizationReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._localization = IHabboLocalizationManager(param2);
        }

        private function onConfigurationReady(param1:IID, param2:IUnknown):void
        {
            if (param2 == null)
            {
                return;
            };
            this._configuration = (param2 as IHabboConfigurationManager);
        }

        private function onCatalogReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._catalog = (param2 as IHabboCatalog);
        }

        private function onNotificationsReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_3890 = (param2 as IHabboNotifications);
        }

        private function onSessionDataManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_1354 = (param2 as ISessionDataManager);
            this.var_1354.events.addEventListener(BadgeImageReadyEvent.var_100, this.var_4438.onBadgeImageReady);
        }

        private function onHabboHelpReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_4439 = (param2 as IHabboHelp);
        }

        private function onHabboNavigatorReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._navigator = (param2 as IHabboNavigator);
        }

        public function get communication():IHabboCommunicationManager
        {
            return (this._communication);
        }

        public function get habboHelp():IHabboHelp
        {
            return (this.var_4439);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (this._localization);
        }

        public function get configuration():IHabboConfigurationManager
        {
            return (this._configuration);
        }

        public function get questController():QuestController
        {
            return (this.var_4437);
        }

        public function get achievementController():AchievementController
        {
            return (this.var_4438);
        }

        public function get toolbar():IHabboToolbar
        {
            return (this.var_3317);
        }

        public function openCatalog(param1:QuestMessageData):void
        {
            var _loc2_:String = ("catalog.page.quest." + param1.campaignCode);
            Logger.log(("Questing->Open Catalog: " + _loc2_));
            this._catalog.openCatalogPage(_loc2_, true);
        }

        public function openNavigator(param1:QuestMessageData):void
        {
            var _loc3_:String;
            var _loc2_:Boolean = this._localization.hasKey((param1.getQuestLocalizationKey() + ".searchtag"));
            if (_loc2_)
            {
                _loc3_ = (param1.getQuestLocalizationKey() + ".searchtag");
            }
            else
            {
                _loc3_ = (param1.getCampaignLocalizationKey() + ".searchtag");
            };
            var _loc4_:String = this._localization.getKey(_loc3_);
            Logger.log(("Questing->Open Navigator: " + _loc4_));
            this._navigator.performTagSearch(_loc4_);
        }

        private function onToolbarReady(param1:IID=null, param2:IUnknown=null):void
        {
            this.var_3317 = (IHabboToolbar(param2) as IHabboToolbar);
            this.var_3317.events.addEventListener(HabboToolbarEvent.var_48, this.onHabboToolbarEvent);
        }

        private function onHabboToolbarEvent(param1:HabboToolbarEvent):void
        {
            if (param1.type == HabboToolbarEvent.var_48)
            {
                if (param1.iconId == HabboToolbarIconEnum.QUESTS)
                {
                    this.var_4437.onToolbarClick();
                };
                if (param1.iconId == HabboToolbarIconEnum.ACHIEVEMENTS)
                {
                    this.var_4438.onToolbarClick();
                };
            };
        }

        public function showAchievements():void
        {
            if (this.var_4438 != null)
            {
                this.var_4438.show();
            };
        }

        public function showQuests():void
        {
        }

        public function get notifications():IHabboNotifications
        {
            return (this.var_3890);
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (this.var_1354);
        }

        public function send(param1:IMessageComposer):void
        {
            this.communication.getHabboMainConnection(null).send(param1);
        }

        public function isTrackerVisible():Boolean
        {
            return (this.var_4437.questTracker.isVisible());
        }

        public function getQuestRowTitle(param1:QuestMessageData):String
        {
            var _loc2_:String = ((param1.waitPeriodSeconds < 1) ? (param1.getQuestLocalizationKey() + ".name") : "quests.list.questdelayed");
            return (this._localization.getKey(_loc2_, _loc2_));
        }

        public function getQuestName(param1:QuestMessageData):String
        {
            var _loc2_:* = (param1.getQuestLocalizationKey() + ".name");
            return (this._localization.getKey(_loc2_, _loc2_));
        }

        public function getQuestDesc(param1:QuestMessageData):String
        {
            var _loc2_:* = (param1.getQuestLocalizationKey() + ".desc");
            return (this._localization.getKey(_loc2_, _loc2_));
        }

        public function getQuestHint(param1:QuestMessageData):String
        {
            var _loc2_:* = (param1.getQuestLocalizationKey() + ".hint");
            return (this._localization.getKey(_loc2_, _loc2_));
        }

        public function getActivityPointName(param1:int):String
        {
            var _loc2_:String = ("achievements.activitypoint." + param1);
            return (this._localization.getKey(_loc2_, _loc2_));
        }

        public function getCampaignName(param1:QuestMessageData):String
        {
            var _loc2_:* = (param1.getCampaignLocalizationKey() + ".name");
            return (this._localization.getKey(_loc2_, _loc2_));
        }

        public function getAchievementCategoryName(param1:String):String
        {
            var _loc2_:* = (("quests." + param1) + ".name");
            return (this._localization.getKey(_loc2_, _loc2_));
        }

        public function setupQuestImage(param1:IWindowContainer, param2:QuestMessageData):void
        {
            var _loc3_:IBitmapWrapperWindow = IBitmapWrapperWindow(param1.findChildByName("quest_pic_bitmap"));
            var _loc4_:String = ((this.isQuestWithPrompts(param2)) ? "_a" : "");
            var _loc5_:String = ((param2.waitPeriodSeconds > 0) ? "quest_timer_questionmark" : ((((param2.campaignCode + "_") + param2.localizationCode) + param2.imageVersion) + _loc4_).toLowerCase());
            if (_loc3_.tags[0] == _loc5_)
            {
                return;
            };
            Logger.log(("Refreshing quest image: " + _loc5_));
            _loc3_.tags[0] = _loc5_;
            new PendingImage(this, _loc3_, _loc5_);
        }

        public function setupPromptFrameImage(param1:IWindowContainer, param2:QuestMessageData, param3:String):void
        {
            var _loc4_:IBitmapWrapperWindow = IBitmapWrapperWindow(param1.findChildByName(("prompt_pic_" + param3)));
            if (_loc4_.id == param2.id)
            {
                Logger.log("No need to refresh prompt image...");
                return;
            };
            _loc4_.id = param2.id;
            new PendingImage(this, _loc4_, (((((param2.campaignCode + "_") + param2.localizationCode) + param2.imageVersion) + "_") + param3).toLowerCase());
        }

        public function setupRewardImage(param1:IWindowContainer, param2:int):void
        {
            var _loc4_:String;
            var _loc3_:IBitmapWrapperWindow = IBitmapWrapperWindow(param1.findChildByName("currency_bitmap"));
            if (_loc3_.id == param2)
            {
                Logger.log("No need to refresh reward image...");
                return;
            };
            _loc3_.id = param2;
            switch (param2)
            {
                case 0:
                    _loc4_ = "quest_pixel";
                    break;
                case 1:
                    _loc4_ = "icon_xmas10_pixeltype";
                    break;
                case 2:
                    _loc4_ = "icon_val11_pixeltype";
                    break;
                case 4:
                    _loc4_ = "quest_shells";
                    break;
                default:
                    _loc4_ = "quest_pixel";
            };
            new PendingImage(this, _loc3_, _loc4_);
        }

        public function setupCampaignImage(param1:IWindowContainer, param2:QuestMessageData, param3:Boolean):void
        {
            var _loc4_:IBitmapWrapperWindow = IBitmapWrapperWindow(param1.findChildByName("campaign_pic_bitmap"));
            if (!param3)
            {
                _loc4_.visible = false;
                return;
            };
            _loc4_.visible = true;
            if (_loc4_.tags[0] == param2.campaignCode)
            {
                Logger.log("No need to refresh campaign image...");
                return;
            };
            _loc4_.tags[0] = param2.campaignCode;
            new PendingImage(this, _loc4_, param2.campaignCode);
        }

        public function setupAchievementCategoryImage(param1:IWindowContainer, param2:AchievementCategory, param3:Boolean):void
        {
            var _loc4_:IBitmapWrapperWindow = IBitmapWrapperWindow(param1.findChildByName("category_pic_bitmap"));
            var _loc5_:String = ((param3) ? (("achcategory_" + param2.code) + ((param2.getProgress() > 0) ? "_active" : "_inactive")) : ("achicon_" + param2.code));
            if (_loc4_.tags[0] == _loc5_)
            {
                Logger.log("No need to refresh category image...");
                return;
            };
            _loc4_.tags[0] = _loc5_;
            new PendingImage(this, _loc4_, _loc5_);
        }

        public function isQuestWithPrompts(param1:QuestMessageData):Boolean
        {
            return (QUESTS_WITH_PROMPTS.indexOf(param1.localizationCode) > -1);
        }

        public function refreshReward(param1:Boolean, param2:IWindowContainer, param3:int, param4:int):void
        {
            var _loc5_:IWindow = param2.findChildByName("reward_caption_txt");
            var _loc6_:IWindow = param2.findChildByName("reward_amount_txt");
            var _loc7_:IWindow = param2.findChildByName("currency_bitmap");
            _loc6_.visible = param1;
            _loc5_.visible = param1;
            _loc7_.visible = param1;
            if (!param1)
            {
                return;
            };
            _loc6_.caption = ("" + param4);
            moveChildrenToRow(param2, ["reward_caption_txt", "reward_amount_txt", "currency_bitmap"], _loc5_.x, 3);
            this.setupRewardImage(param2, param3);
        }

        public function update(param1:uint):void
        {
            this.var_4437.update(param1);
            this.var_4438.update(param1);
        }

        public function getTwinkleAnimation(param1:IWindowContainer):Animation
        {
            if (this._twinkleImages == null)
            {
                this._twinkleImages = new TwinkleImages(this);
            };
            var _loc2_:int = var_291;
            var _loc3_:Animation = new Animation(IBitmapWrapperWindow(param1.findChildByName("twinkle_bitmap")));
            var _loc4_:int;
            while (_loc4_ < var_293)
            {
                _loc3_.addObject(new Twinkle(this._twinkleImages, _loc2_));
                _loc2_ = (_loc2_ + var_292);
                _loc4_++;
            };
            return (_loc3_);
        }

        public function get currentlyInRoom():Boolean
        {
            return (this.var_4440);
        }

        public function set currentlyInRoom(param1:Boolean):void
        {
            this.var_4440 = param1;
        }


    }
}