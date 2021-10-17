package com.sulake.habbo.ui.widget.doorbell
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.ui.widget.events.RoomWidgetDoorbellEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetLetUserInMessage;

    public class DoorbellWidget extends RoomWidgetBase 
    {

        private static const var_1637:int = 50;

        private var _users:Array;
        private var _view:DoorbellView;

        public function DoorbellWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager)
        {
            super(param1, param2, param3, param4);
            this._view = new DoorbellView(this);
            this._users = [];
        }

        override public function get mainWindow():IWindow
        {
            return (this._view.mainWindow);
        }

        public function get users():Array
        {
            return (this._users);
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (this._view)
            {
                this._view.dispose();
                this._view = null;
            };
            this._users = null;
            super.dispose();
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.addEventListener(RoomWidgetDoorbellEvent.var_1636, this.onDoorbellRinging);
            param1.addEventListener(RoomWidgetDoorbellEvent.var_344, this.onDoorbellHandled);
            param1.addEventListener(RoomWidgetDoorbellEvent.var_345, this.onDoorbellHandled);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetDoorbellEvent.var_1636, this.onDoorbellRinging);
            param1.removeEventListener(RoomWidgetDoorbellEvent.var_344, this.onDoorbellHandled);
            param1.removeEventListener(RoomWidgetDoorbellEvent.var_345, this.onDoorbellHandled);
        }

        private function onDoorbellRinging(param1:RoomWidgetDoorbellEvent):void
        {
            this.addUser(param1.userName);
        }

        private function onDoorbellHandled(param1:RoomWidgetDoorbellEvent):void
        {
            this.removeUser(param1.userName);
        }

        public function addUser(param1:String):void
        {
            if (this._users.indexOf(param1) != -1)
            {
                return;
            };
            if (this._users.length >= var_1637)
            {
                this.deny(param1);
                return;
            };
            this._users.push(param1);
            this._view.update();
        }

        public function removeUser(param1:String):void
        {
            var _loc2_:int = this._users.indexOf(param1);
            if (_loc2_ == -1)
            {
                return;
            };
            this._users.splice(_loc2_, 1);
            this._view.update();
        }

        public function accept(param1:String):void
        {
            var _loc2_:RoomWidgetLetUserInMessage = new RoomWidgetLetUserInMessage(param1, true);
            messageListener.processWidgetMessage(_loc2_);
            this.removeUser(param1);
        }

        public function deny(param1:String):void
        {
            var _loc2_:RoomWidgetLetUserInMessage = new RoomWidgetLetUserInMessage(param1, false);
            messageListener.processWidgetMessage(_loc2_);
            this.removeUser(param1);
        }

        public function denyAll():void
        {
            while (this._users.length > 0)
            {
                this.deny(this._users[0]);
            };
        }


    }
}