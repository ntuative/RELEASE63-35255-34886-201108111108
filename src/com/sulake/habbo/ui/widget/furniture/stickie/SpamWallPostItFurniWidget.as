package com.sulake.habbo.ui.widget.furniture.stickie
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSpamWallPostItEditEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetStickieDataUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetSpamWallPostItFinishEditingMessage;

    public class SpamWallPostItFurniWidget extends StickieFurniWidget 
    {

        private var var_2957:String = "";

        public function SpamWallPostItFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary=null)
        {
            var_5298 = "spamwall_postit_container";
            super(param1, param2, param3);
        }

        override public function dispose():void
        {
            var_1678 = -1;
            this.var_2957 = "";
            super.dispose();
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            param1.addEventListener(RoomWidgetSpamWallPostItEditEvent.var_1677, this.onEditPostItRequest);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetSpamWallPostItEditEvent.var_1677, this.onEditPostItRequest);
        }

        override protected function onObjectUpdate(param1:RoomWidgetStickieDataUpdateEvent):void
        {
        }

        private function onEditPostItRequest(param1:RoomWidgetSpamWallPostItEditEvent):void
        {
            hideInterface(false);
            var_1678 = param1.objectId;
            this.var_2957 = param1.location;
            var_5260 = param1.objectType;
            _text = "";
            var_1679 = "FFFF33";
            var_2438 = true;
            showInterface();
        }

        override protected function sendUpdate():void
        {
            var _loc1_:RoomWidgetSpamWallPostItFinishEditingMessage;
            if (var_1678 != -1)
            {
                storeTextFromField();
                Logger.log("Spamwall Post-It Widget Send Update");
                if (messageListener != null)
                {
                    _loc1_ = new RoomWidgetSpamWallPostItFinishEditingMessage(RoomWidgetSpamWallPostItFinishEditingMessage.var_1680, var_1678, this.var_2957, _text, var_1679);
                    messageListener.processWidgetMessage(_loc1_);
                };
                hideInterface(false);
            };
        }

        override protected function sendSetColor(param1:uint):void
        {
            storeTextFromField();
            var _loc2_:String = param1.toString(16).toUpperCase();
            if (_loc2_.length > 6)
            {
                _loc2_ = _loc2_.slice((_loc2_.length - 6), _loc2_.length);
            };
            if (_loc2_ == var_1679)
            {
                return;
            };
            var_1679 = _loc2_;
            showInterface();
        }

        override protected function sendDelete():void
        {
            hideInterface(false);
        }


    }
}