package com.sulake.habbo.ui.widget.chatinput
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import flash.utils.Timer;
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import flash.utils.getTimer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChatMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChatInputContentUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFloodControlEvent;
    import flash.events.IEventDispatcher;
    import flash.events.TimerEvent;
    import com.sulake.core.window.IWindow;

    public class RoomChatInputWidget extends RoomWidgetBase 
    {

        private static const var_1638:int = 5000;

        private var _visualization:RoomChatInputView;
        private var var_5221:String = "";
        private var var_5222:Boolean = false;
        private var var_5223:Timer = null;
        private var var_5224:int;
        private var var_4007:Component = null;
        private var _configuration:IHabboConfigurationManager;

        public function RoomChatInputWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager, param5:IHabboConfigurationManager, param6:Component)
        {
            super(param1, param2, param3, param4);
            this.var_4007 = param6;
            this._configuration = param5;
            this._visualization = new RoomChatInputView(this);
        }

        public function get floodBlocked():Boolean
        {
            return (this.var_5222);
        }

        public function get config():IHabboConfigurationManager
        {
            return (this._configuration);
        }

        override public function dispose():void
        {
            if (this._visualization != null)
            {
                this._visualization.dispose();
                this._visualization = null;
            };
            if (this.var_5223 != null)
            {
                this.var_5223.stop();
                this.var_5223 = null;
            };
            this.var_4007 = null;
            this._configuration = null;
            super.dispose();
        }

        public function get allowPaste():Boolean
        {
            return ((getTimer() - this.var_5224) > var_1638);
        }

        public function setLastPasteTime():void
        {
            this.var_5224 = getTimer();
        }

        public function sendChat(param1:String, param2:int, param3:String=""):void
        {
            if (this.var_5222)
            {
                return;
            };
            var _loc4_:RoomWidgetChatMessage = new RoomWidgetChatMessage(RoomWidgetChatMessage.var_1639, param1, param2, param3);
            if (messageListener != null)
            {
                messageListener.processWidgetMessage(_loc4_);
            };
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1544, this.onRoomObjectDeselected);
            param1.addEventListener(RoomWidgetChatInputContentUpdateEvent.var_1640, this.onChatInputUpdate);
            param1.addEventListener(RoomWidgetUserInfoUpdateEvent.var_1641, this.onUserInfo);
            param1.addEventListener(RoomWidgetFloodControlEvent.var_1642, this.onFloodControl);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1544, this.onRoomObjectDeselected);
            param1.removeEventListener(RoomWidgetChatInputContentUpdateEvent.var_1640, this.onChatInputUpdate);
            param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.var_1641, this.onUserInfo);
            param1.removeEventListener(RoomWidgetFloodControlEvent.var_1642, this.onFloodControl);
        }

        private function onRoomObjectDeselected(param1:RoomWidgetRoomObjectUpdateEvent):void
        {
            this.var_5221 = "";
        }

        private function onUserInfo(param1:RoomWidgetUserInfoUpdateEvent):void
        {
            this.var_5221 = param1.name;
        }

        private function onChatInputUpdate(param1:RoomWidgetChatInputContentUpdateEvent):void
        {
            var _loc2_:String = "";
            switch (param1.messageType)
            {
                case RoomWidgetChatInputContentUpdateEvent.var_1643:
                    _loc2_ = localizations.getKey("widgets.chatinput.mode.whisper", ":tell");
                    this._visualization.displaySpecialChatMessage(_loc2_, param1.userName);
                    return;
                case RoomWidgetChatInputContentUpdateEvent.var_1644:
                    return;
            };
        }

        private function onReleaseTimerComplete(param1:TimerEvent):void
        {
            Logger.log("Releasing flood blocking");
            this.var_5222 = false;
            if (this._visualization != null)
            {
                this._visualization.hideFloodBlocking();
            };
            this.var_5223 = null;
        }

        private function onReleaseTimerTick(param1:TimerEvent):void
        {
            if (this._visualization != null)
            {
                this._visualization.updateBlockText((this.var_5223.repeatCount - this.var_5223.currentCount));
            };
        }

        public function get selectedUserName():String
        {
            return (this.var_5221);
        }

        public function onFloodControl(param1:RoomWidgetFloodControlEvent):void
        {
            this.var_5222 = true;
            Logger.log((("Enabling flood blocking for " + param1.seconds) + " seconds"));
            if (this.var_5223)
            {
                this.var_5223.reset();
            }
            else
            {
                this.var_5223 = new Timer(1000, param1.seconds);
                this.var_5223.addEventListener(TimerEvent.TIMER, this.onReleaseTimerTick);
                this.var_5223.addEventListener(TimerEvent.TIMER_COMPLETE, this.onReleaseTimerComplete);
            };
            this.var_5223.start();
            if (this._visualization != null)
            {
                this._visualization.updateBlockText(param1.seconds);
                this._visualization.showFloodBlocking();
            };
        }

        override public function get mainWindow():IWindow
        {
            return (this._visualization.window);
        }


    }
}