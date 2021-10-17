package com.sulake.habbo.notifications
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.toolbar.events.ExtensionViewEvent;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import flash.events.Event;

    public class HabboNotificationViewManager implements IUpdateReceiver 
    {

        private static const var_560:int = 4;

        private var _assetLibrary:IAssetLibrary;
        private var _windowManager:IHabboWindowManager;
        private var var_3317:IHabboToolbar;
        private var var_4382:Map;
        private var var_4383:Map;
        private var _disposed:Boolean = false;
        private var var_4401:Array;

        public function HabboNotificationViewManager(param1:IAssetLibrary, param2:IHabboWindowManager, param3:IHabboConfigurationManager, param4:IHabboToolbar, param5:Map, param6:Map)
        {
            this._assetLibrary = param1;
            this._windowManager = param2;
            this.var_3317 = param4;
            this.var_4382 = param5;
            this.var_4383 = param6;
            this.var_4401 = new Array();
            this.var_3317.events.addEventListener(ExtensionViewEvent.var_558, this.refreshTopMargin);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function replaceIcon(param1:BadgeImageReadyEvent):void
        {
            var _loc2_:HabboNotificationItemView;
            for each (_loc2_ in this.var_4401)
            {
                _loc2_.replaceIcon(param1);
            };
        }

        public function dispose():void
        {
            var _loc1_:int = this.var_4401.length;
            var _loc2_:int;
            while (_loc2_ < _loc1_)
            {
                (this.var_4401.pop() as HabboNotificationItemView).dispose();
                _loc2_++;
            };
            this._assetLibrary = null;
            this._windowManager = null;
            if (this.var_4382)
            {
                this.var_4382.dispose();
                this.var_4382 = null;
            };
            if (this.var_4383)
            {
                this.var_4383.dispose();
                this.var_4383 = null;
            };
            this._disposed = true;
        }

        public function showItem(param1:HabboNotificationItem):Boolean
        {
            if (!this.isSpaceAvailable())
            {
                return (false);
            };
            var _loc2_:HabboNotificationItemView = new HabboNotificationItemView(this._assetLibrary.getAssetByName("layout_notification_xml"), this._windowManager, this.var_4382, this.var_4383, param1);
            _loc2_.reposition(this.getNextAvailableVerticalPosition());
            this.var_4401.push(_loc2_);
            this.var_4401.sortOn("verticalPosition", Array.NUMERIC);
            return (true);
        }

        public function isSpaceAvailable():Boolean
        {
            return ((this.getNextAvailableVerticalPosition() + HabboNotificationItemView.var_559) < this._windowManager.getDesktop(0).height);
        }

        public function update(param1:uint):void
        {
            var _loc3_:HabboNotificationItemView;
            var _loc2_:int;
            _loc2_ = 0;
            while (_loc2_ < this.var_4401.length)
            {
                (this.var_4401[_loc2_] as HabboNotificationItemView).update(param1);
                _loc2_++;
            };
            _loc2_ = 0;
            while (_loc2_ < this.var_4401.length)
            {
                _loc3_ = (this.var_4401[_loc2_] as HabboNotificationItemView);
                if (_loc3_.ready)
                {
                    _loc3_.dispose();
                    this.var_4401.splice(_loc2_, 1);
                    _loc2_--;
                };
                _loc2_++;
            };
        }

        private function getNextAvailableVerticalPosition():int
        {
            var _loc4_:HabboNotificationItemView;
            var _loc1_:int = (this.var_3317.extensionView.screenHeight + var_560);
            if (this.var_4401.length == 0)
            {
                return (_loc1_);
            };
            var _loc2_:int = _loc1_;
            var _loc3_:int;
            while (_loc3_ < this.var_4401.length)
            {
                _loc4_ = (this.var_4401[_loc3_] as HabboNotificationItemView);
                if ((_loc2_ + HabboNotificationItemView.var_559) < _loc4_.verticalPosition)
                {
                    return (_loc2_);
                };
                _loc2_ = ((_loc4_.verticalPosition + HabboNotificationItemView.var_559) + var_560);
                _loc3_++;
            };
            return (_loc2_);
        }

        public function refreshTopMargin(param1:Event):void
        {
            var _loc4_:HabboNotificationItemView;
            var _loc2_:int = (this.var_3317.extensionView.screenHeight + var_560);
            var _loc3_:int;
            while (_loc3_ < this.var_4401.length)
            {
                _loc4_ = (this.var_4401[_loc3_] as HabboNotificationItemView);
                _loc4_.reposition(_loc2_);
                _loc2_ = ((_loc4_.verticalPosition + HabboNotificationItemView.var_559) + var_560);
                _loc3_++;
            };
        }


    }
}