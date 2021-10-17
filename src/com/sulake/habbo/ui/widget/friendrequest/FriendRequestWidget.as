package com.sulake.habbo.ui.widget.friendrequest
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.runtime.Component;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFriendRequestUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserLocationUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetUserLocationMessage;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFriendRequestMessage;

    public class FriendRequestWidget extends RoomWidgetBase implements IUpdateReceiver 
    {

        private var var_4007:Component;
        private var _requests:Map;

        public function FriendRequestWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager, param5:Component)
        {
            super(param1, param2, param3, param4);
            this.var_4007 = param5;
            this._requests = new Map();
        }

        override public function dispose():void
        {
            var _loc1_:FriendRequestDialog;
            if (disposed)
            {
                return;
            };
            if (this.var_4007)
            {
                this.var_4007.removeUpdateReceiver(this);
                this.var_4007 = null;
            };
            if (this._requests)
            {
                for each (_loc1_ in this._requests)
                {
                    _loc1_.dispose();
                    _loc1_ = null;
                };
                this._requests.dispose();
                this._requests = null;
            };
            super.dispose();
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (!param1)
            {
                return;
            };
            param1.addEventListener(RoomWidgetFriendRequestUpdateEvent.var_1593, this.eventHandler);
            param1.addEventListener(RoomWidgetFriendRequestUpdateEvent.var_1594, this.eventHandler);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetFriendRequestUpdateEvent.var_1593, this.eventHandler);
            param1.removeEventListener(RoomWidgetFriendRequestUpdateEvent.var_1594, this.eventHandler);
        }

        private function eventHandler(param1:RoomWidgetFriendRequestUpdateEvent):void
        {
            if (!param1)
            {
                return;
            };
            switch (param1.type)
            {
                case RoomWidgetFriendRequestUpdateEvent.var_1593:
                    this.addRequest(param1.requestId, new FriendRequestDialog(this, param1.requestId, param1.userId, param1.userName));
                    break;
                case RoomWidgetFriendRequestUpdateEvent.var_1594:
                    this.removeRequest(param1.requestId);
                    break;
            };
            this.checkUpdateNeed();
        }

        public function checkUpdateNeed():void
        {
            if (!this.var_4007)
            {
                return;
            };
            if (((this._requests) && (this._requests.length > 0)))
            {
                this.var_4007.registerUpdateReceiver(this, 10);
            }
            else
            {
                this.var_4007.removeUpdateReceiver(this);
            };
        }

        public function update(param1:uint):void
        {
            var _loc2_:FriendRequestDialog;
            var _loc3_:RoomWidgetUserLocationUpdateEvent;
            if (!this._requests)
            {
                return;
            };
            for each (_loc2_ in this._requests)
            {
                if (_loc2_)
                {
                    _loc3_ = (messageListener.processWidgetMessage(new RoomWidgetGetUserLocationMessage(_loc2_.userId, RoomObjectTypeEnum.var_1406)) as RoomWidgetUserLocationUpdateEvent);
                    if (_loc3_)
                    {
                        _loc2_.targetRect = _loc3_.rectangle;
                    };
                };
            };
        }

        public function acceptRequest(param1:int):void
        {
            if (!messageListener)
            {
                return;
            };
            messageListener.processWidgetMessage(new RoomWidgetFriendRequestMessage(RoomWidgetFriendRequestMessage.var_1595, param1));
            this.removeRequest(param1);
        }

        public function declineRequest(param1:int):void
        {
            if (!messageListener)
            {
                return;
            };
            messageListener.processWidgetMessage(new RoomWidgetFriendRequestMessage(RoomWidgetFriendRequestMessage.var_1596, param1));
            this.removeRequest(param1);
        }

        public function ignoreRequest(param1:int):void
        {
            this.removeRequest(param1);
        }

        private function addRequest(param1:int, param2:FriendRequestDialog):void
        {
            if (((!(this._requests)) || (!(param2))))
            {
                return;
            };
            this._requests.add(param1, param2);
        }

        private function removeRequest(param1:int):void
        {
            if (!this._requests)
            {
                return;
            };
            var _loc2_:FriendRequestDialog = (this._requests.getValue(param1) as FriendRequestDialog);
            if (!_loc2_)
            {
                return;
            };
            this._requests.remove(param1);
            _loc2_.dispose();
            this.checkUpdateNeed();
        }


    }
}