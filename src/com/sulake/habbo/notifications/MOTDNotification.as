package com.sulake.habbo.notifications
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class MOTDNotification 
    {

        private const var_4402:int = 20;

        private var _window:IFrameWindow;
        private var var_1600:IHabboLocalizationManager;
        private var var_3777:Array;

        public function MOTDNotification(param1:Array, param2:IAssetLibrary, param3:IHabboWindowManager)
        {
            var _loc8_:String;
            var _loc9_:IWindowContainer;
            var _loc10_:ITextWindow;
            super();
            if (((!(param3)) || (!(param2))))
            {
                return;
            };
            this.var_3777 = param1;
            var _loc4_:XmlAsset = (param2.getAssetByName("motd_notification_xml") as XmlAsset);
            if (_loc4_ == null)
            {
                return;
            };
            this._window = (param3.buildFromXML((_loc4_.content as XML)) as IFrameWindow);
            if (this._window == null)
            {
                return;
            };
            this._window.procedure = this.eventHandler;
            this._window.center();
            var _loc5_:XmlAsset = (param2.getAssetByName("motd_notification_item_xml") as XmlAsset);
            if (_loc5_ == null)
            {
                return;
            };
            var _loc6_:IWindowContainer = (param3.buildFromXML((_loc5_.content as XML)) as IWindowContainer);
            var _loc7_:IItemListWindow = (this._window.findChildByName("message_list") as IItemListWindow);
            for each (_loc8_ in this.var_3777)
            {
                _loc9_ = (_loc6_.clone() as IWindowContainer);
                _loc10_ = (_loc9_.findChildByName("message_text") as ITextWindow);
                _loc10_.text = _loc8_;
                _loc9_.height = (_loc10_.textHeight + this.var_4402);
                _loc7_.addListItem(_loc9_);
            };
        }

        public function dispose():void
        {
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
            this.var_1600 = null;
        }

        private function eventHandler(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            switch (param2.name)
            {
                case "close":
                case "header_button_close":
                    this.dispose();
                    return;
            };
        }


    }
}