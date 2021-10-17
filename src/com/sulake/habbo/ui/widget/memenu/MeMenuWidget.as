package com.sulake.habbo.ui.widget.memenu
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import flash.geom.Point;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.ui.handler.MeMenuWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.IAsset;
    import flash.events.Event;
    import com.sulake.habbo.ui.widget.memenu.enum.HabboMeMenuTrackingEvent;
    import flash.geom.Rectangle;
    import com.sulake.habbo.ui.widget.events.RoomWidgetWaveUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetDanceUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEffectsUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetToolbarClickedUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetAvatarEditorUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetHabboClubUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSettingsUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetTutorialEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPurseUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomEngineUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMeMenuMessage;
    import com.sulake.habbo.utils.WindowToggle;

    public class MeMenuWidget extends RoomWidgetBase 
    {

        public static const var_1685:String = "me_menu_top_view";
        public static const var_1686:String = "me_menu_my_clothes_view";
        public static const var_1687:String = "me_menu_dance_moves_view";
        public static const var_1688:String = "me_menu_settings_view";
        public static const var_1689:String = "me_menu_sound_settings";
        private static const var_1690:Point = new Point(95, 440);

        private var var_4021:IMeMenuView;
        private var var_3966:IWindowContainer;
        private var _eventDispatcher:IEventDispatcher;
        private var var_5369:int = 0;
        private var var_5370:int = 0;
        private var var_5371:int = 0;
        private var var_5372:Boolean = false;
        private var var_5373:int = 0;
        private var var_5374:Boolean = false;
        private var var_5205:Boolean = false;
        private var var_4064:Boolean = false;
        private var var_5375:Boolean = false;
        private var var_5376:int = 0;
        private var var_5195:Boolean = false;
        private var _config:IHabboConfigurationManager;
        private var var_5198:Boolean;

        public function MeMenuWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager, param5:IEventDispatcher, param6:IHabboConfigurationManager)
        {
            super(param1, param2, param3, param4);
            this._config = param6;
            this._eventDispatcher = param5;
            if (ExternalInterface.available)
            {
                this.var_5375 = param6.getBoolean("client.news.embed.enabled", false);
            };
            this.var_5198 = this._config.getBoolean("menu.own_avatar.enabled", false);
            (param1 as MeMenuWidgetHandler).widget = this;
            this.changeView(var_1685);
            this.hide();
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            this.hide();
            this._eventDispatcher = null;
            if (this.var_4021 != null)
            {
                this.var_4021.dispose();
                this.var_4021 = null;
            };
            this.var_3966 = null;
            this._config = null;
            super.dispose();
        }

        public function get handler():MeMenuWidgetHandler
        {
            return (var_1604 as MeMenuWidgetHandler);
        }

        override public function get mainWindow():IWindow
        {
            return (this.var_3966);
        }

        private function get mainContainer():IWindowContainer
        {
            var _loc1_:IAsset;
            if (this.var_3966 == null)
            {
                _loc1_ = _assets.getAssetByName("memenu");
                if (_loc1_)
                {
                    this.var_3966 = (windowManager.buildFromXML((_loc1_.content as XML)) as IWindowContainer);
                };
            };
            if (this.var_3966)
            {
                return (this.var_3966.findChildByTag("MAIN_CONTENT") as IWindowContainer);
            };
            return (null);
        }

        public function changeView(param1:String):void
        {
            var _loc2_:IMeMenuView;
            switch (param1)
            {
                case var_1685:
                    _loc2_ = new MeMenuMainView();
                    this._eventDispatcher.dispatchEvent(new Event(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_DEFAULT));
                    break;
                case var_1687:
                    _loc2_ = new MeMenuDanceView();
                    this._eventDispatcher.dispatchEvent(new Event(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_DANCE));
                    break;
                case var_1688:
                    _loc2_ = new MeMenuSettingsMenuView();
                    break;
                case var_1689:
                    _loc2_ = new MeMenuSoundSettingsView();
                    break;
                default:
                    Logger.log(("Me Menu Change view: unknown view: " + param1));
            };
            if (_loc2_ != null)
            {
                if (this.var_4021)
                {
                    this.var_4021.dispose();
                    this.var_4021 = null;
                };
                this.var_4021 = _loc2_;
                this.var_4021.init(this, param1);
                this.mainContainer.removeChildAt(0);
                this.mainContainer.addChildAt(this.var_4021.window, 0);
                this.var_3966.visible = true;
                this.var_3966.activate();
            };
            this.updateSize();
        }

        public function updateSize():void
        {
            var _loc1_:int;
            var _loc2_:Rectangle;
            if ((((this.var_4021) && (this.var_4021.window)) && (this.var_3966)))
            {
                _loc1_ = 5;
                this.var_4021.window.position = new Point(_loc1_, _loc1_);
                this.mainContainer.width = (this.var_4021.window.width + (_loc1_ * 2));
                this.mainContainer.height = (this.var_4021.window.height + (_loc1_ * 2));
                if (((((this._config.getBoolean("simple.memenu.enabled", false)) && (this.handler)) && (this.handler.container)) && (this.handler.container.toolbar)))
                {
                    _loc2_ = this.handler.container.toolbar.getRect();
                    this.var_3966.x = (_loc2_.right + _loc1_);
                    this.var_3966.y = (_loc2_.bottom - this.var_3966.height);
                }
                else
                {
                    this.var_3966.x = var_1690.x;
                    this.var_3966.y = (var_1690.y - this.mainContainer.height);
                };
            };
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.addEventListener(RoomWidgetWaveUpdateEvent.var_1691, this.onWaveEvent);
            param1.addEventListener(RoomWidgetDanceUpdateEvent.var_1692, this.onDanceEvent);
            param1.addEventListener(RoomWidgetUpdateEffectsUpdateEvent.var_1693, this.onUpdateEffects);
            param1.addEventListener(RoomWidgetToolbarClickedUpdateEvent.var_1694, this.onToolbarClicked);
            param1.addEventListener(RoomWidgetAvatarEditorUpdateEvent.var_1695, this.onAvatarEditorClosed);
            param1.addEventListener(RoomWidgetAvatarEditorUpdateEvent.var_1696, this.onHideAvatarEditor);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1544, this.onAvatarDeselected);
            param1.addEventListener(RoomWidgetHabboClubUpdateEvent.var_115, this.onHabboClubEvent);
            param1.addEventListener(RoomWidgetUserInfoUpdateEvent.var_1697, this.onUserInfo);
            param1.addEventListener(RoomWidgetSettingsUpdateEvent.var_1698, this.onSettingsUpdate);
            param1.addEventListener(RoomWidgetTutorialEvent.var_1413, this.onTutorialEvent);
            param1.addEventListener(RoomWidgetTutorialEvent.var_1699, this.onTutorialEvent);
            param1.addEventListener(RoomWidgetPurseUpdateEvent.var_140, this.onCreditBalance);
            param1.addEventListener(RoomWidgetRoomEngineUpdateEvent.var_450, this.onNormalMode);
            param1.addEventListener(RoomWidgetRoomEngineUpdateEvent.var_1556, this.onGameMode);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetWaveUpdateEvent.var_1691, this.onWaveEvent);
            param1.removeEventListener(RoomWidgetDanceUpdateEvent.var_1692, this.onDanceEvent);
            param1.removeEventListener(RoomWidgetUpdateEffectsUpdateEvent.var_1693, this.onUpdateEffects);
            param1.removeEventListener(RoomWidgetToolbarClickedUpdateEvent.var_1694, this.onToolbarClicked);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1544, this.onAvatarDeselected);
            param1.removeEventListener(RoomWidgetHabboClubUpdateEvent.var_115, this.onHabboClubEvent);
            param1.removeEventListener(RoomWidgetAvatarEditorUpdateEvent.var_1695, this.onHideAvatarEditor);
            param1.removeEventListener(RoomWidgetAvatarEditorUpdateEvent.var_1696, this.onAvatarEditorClosed);
            param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.var_1697, this.onUserInfo);
            param1.removeEventListener(RoomWidgetSettingsUpdateEvent.var_1698, this.onSettingsUpdate);
            param1.removeEventListener(RoomWidgetTutorialEvent.var_1699, this.onTutorialEvent);
            param1.removeEventListener(RoomWidgetTutorialEvent.var_1413, this.onTutorialEvent);
            param1.removeEventListener(RoomWidgetPurseUpdateEvent.var_140, this.onCreditBalance);
            param1.removeEventListener(RoomWidgetRoomEngineUpdateEvent.var_450, this.onNormalMode);
            param1.removeEventListener(RoomWidgetRoomEngineUpdateEvent.var_450, this.onGameMode);
        }

        public function hide(param1:RoomWidgetRoomObjectUpdateEvent=null):void
        {
            if (this.var_4021 != null)
            {
                this.var_3966.removeChild(this.var_4021.window);
                this.var_4021.dispose();
                this.var_4021 = null;
            };
            this.var_3966.visible = false;
            this.var_4064 = false;
            this._eventDispatcher.dispatchEvent(new Event(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_CLOSE));
        }

        private function onUserInfo(param1:RoomWidgetUserInfoUpdateEvent):void
        {
            var _loc2_:RoomWidgetRequestWidgetMessage;
            if (this.var_5198)
            {
                return;
            };
            if (!((this.var_4064) && (this.var_4021.window.name == var_1686)))
            {
                _loc2_ = new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.var_1700);
                if (messageListener != null)
                {
                    if (!this.var_5195)
                    {
                        messageListener.processWidgetMessage(_loc2_);
                    };
                };
            };
        }

        private function onSettingsUpdate(param1:RoomWidgetSettingsUpdateEvent):void
        {
            if (!this.var_4064)
            {
                return;
            };
            if (this.var_4021.window.name == var_1689)
            {
                (this.var_4021 as MeMenuSoundSettingsView).updateSettings(param1);
            };
        }

        private function onTutorialEvent(param1:RoomWidgetTutorialEvent):void
        {
            switch (param1.type)
            {
                case RoomWidgetTutorialEvent.var_1699:
                    Logger.log(((("* MeMenuWidget: onHighlightClothesIcon " + this.var_4064) + " view: ") + this.var_4021.window.name));
                    if (((!(this.var_4064 == true)) || (!(this.var_4021.window.name == var_1685))))
                    {
                        return;
                    };
                    (this.var_4021 as MeMenuMainView).setIconAssets("clothes_icon", var_1685, "clothes_highlighter_blue");
                    return;
                case RoomWidgetTutorialEvent.var_1413:
                    this.hide();
                    return;
            };
        }

        private function onToolbarClicked(param1:RoomWidgetToolbarClickedUpdateEvent):void
        {
            var _loc2_:RoomWidgetMeMenuMessage;
            if (this.var_4064)
            {
                if (((!(this.var_3966 == null)) && (WindowToggle.isHiddenByOtherWindows(this.var_3966))))
                {
                    this.var_3966.activate();
                    return;
                };
                this.var_4064 = false;
            }
            else
            {
                this.var_4064 = true;
            };
            if (this.var_4064)
            {
                _loc2_ = new RoomWidgetMeMenuMessage(RoomWidgetMeMenuMessage.var_1701);
                if (messageListener != null)
                {
                    messageListener.processWidgetMessage(_loc2_);
                };
                this.changeView(var_1685);
            }
            else
            {
                this.hide();
            };
        }

        private function onUpdateEffects(param1:RoomWidgetUpdateEffectsUpdateEvent):void
        {
            var _loc2_:IWidgetAvatarEffect;
            this.var_5374 = false;
            for each (_loc2_ in param1.effects)
            {
                if (_loc2_.isInUse)
                {
                    this.var_5374 = true;
                };
            };
        }

        private function onAvatarDeselected(param1:Event):void
        {
            if (((!(this.var_4021 == null)) && (!(this.var_4021.window.name == var_1686))))
            {
                this.hide();
            };
        }

        private function onAvatarEditorClosed(param1:RoomWidgetAvatarEditorUpdateEvent):void
        {
            if (((!(this.var_4021 == null)) && (this.var_4021.window.name == var_1686)))
            {
                this.changeView(var_1685);
            };
        }

        private function onHideAvatarEditor(param1:RoomWidgetAvatarEditorUpdateEvent):void
        {
            if (((!(this.var_4021 == null)) && (this.var_4021.window.name == var_1686)))
            {
                this.changeView(var_1685);
            };
        }

        private function onWaveEvent(param1:RoomWidgetWaveUpdateEvent):void
        {
            Logger.log("[MeMenuWidget] Wave Event received");
        }

        private function onDanceEvent(param1:RoomWidgetDanceUpdateEvent):void
        {
            Logger.log(("[MeMenuWidget] Dance Event received, style: " + param1.style));
        }

        private function onHabboClubEvent(param1:RoomWidgetHabboClubUpdateEvent):void
        {
            var _loc2_:* = (!(param1.daysLeft == this.var_5369));
            this.var_5369 = param1.daysLeft;
            this.var_5370 = param1.periodsLeft;
            this.var_5371 = param1.pastPeriods;
            this.var_5372 = param1.allowClubDances;
            _loc2_ = ((_loc2_) || (!(param1.clubLevel == this.var_5373)));
            this.var_5373 = param1.clubLevel;
            if (_loc2_)
            {
                if (this.var_4021 != null)
                {
                    this.changeView(this.var_4021.window.name);
                };
            };
        }

        private function onCreditBalance(param1:RoomWidgetPurseUpdateEvent):void
        {
            if (param1 == null)
            {
                return;
            };
            this.var_5376 = param1.balance;
            localizations.registerParameter("widget.memenu.credits", "credits", this.var_5376.toString());
        }

        private function onNormalMode(param1:RoomWidgetRoomEngineUpdateEvent):void
        {
            this.var_5195 = false;
        }

        private function onGameMode(param1:RoomWidgetRoomEngineUpdateEvent):void
        {
            this.var_5195 = true;
        }

        public function get allowHabboClubDances():Boolean
        {
            return (this.var_5372);
        }

        public function get isHabboClubActive():Boolean
        {
            return (this.var_5369 > 0);
        }

        public function get habboClubDays():int
        {
            return (this.var_5369);
        }

        public function get habboClubPeriods():int
        {
            return (this.var_5370);
        }

        public function get habboClubLevel():int
        {
            return (this.var_5373);
        }

        public function get isNewsEnabled():Boolean
        {
            return (this.var_5375);
        }

        public function get config():IHabboConfigurationManager
        {
            return (this._config);
        }

        public function get hasEffectOn():Boolean
        {
            return (this.var_5374);
        }

        public function get isDancing():Boolean
        {
            return (this.var_5205);
        }

        public function set isDancing(param1:Boolean):void
        {
            this.var_5205 = param1;
        }


    }
}