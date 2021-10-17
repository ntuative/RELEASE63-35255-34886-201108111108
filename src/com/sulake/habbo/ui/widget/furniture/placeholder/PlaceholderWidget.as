package com.sulake.habbo.ui.widget.furniture.placeholder
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.widget.events.RoomWidgetShowPlaceholderEvent;
    import flash.events.IEventDispatcher;

    public class PlaceholderWidget extends RoomWidgetBase 
    {

        private var _view:PlaceholderView;

        public function PlaceholderWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary=null, param4:IHabboLocalizationManager=null)
        {
            super(param1, param2, param3, param4);
        }

        override public function dispose():void
        {
            if (this._view != null)
            {
                this._view.dispose();
                this._view = null;
            };
            super.dispose();
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.addEventListener(RoomWidgetShowPlaceholderEvent.var_1666, this.onShowEvent);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetShowPlaceholderEvent.var_1666, this.onShowEvent);
        }

        private function onShowEvent(param1:RoomWidgetShowPlaceholderEvent):void
        {
            this.showInterface();
        }

        private function showInterface():void
        {
            if (this._view == null)
            {
                this._view = new PlaceholderView(assets, windowManager);
            };
            this._view.showWindow();
        }

        private function hideInterface():void
        {
            if (this._view != null)
            {
                this._view.dispose();
                this._view = null;
            };
        }


    }
}