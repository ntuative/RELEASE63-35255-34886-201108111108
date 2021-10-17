package com.sulake.habbo.notifications
{
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.utils.HabboWebTools;

    public class ParkBusDialogManager 
    {

        private var _assets:IAssetLibrary;
        private var _localization:IHabboLocalizationManager;
        private var _windowManager:IHabboWindowManager;
        private var _window:IFrameWindow;

        public function ParkBusDialogManager(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboLocalizationManager)
        {
            this._assets = param2;
            this._localization = param3;
            this._windowManager = param1;
        }

        public function dispose():void
        {
            this.disposeWindow();
            this._windowManager = null;
            this._assets = null;
        }

        private function disposeWindow(param1:WindowEvent=null):void
        {
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
        }

        public function handleParkBusCannotEnter(param1:String):void
        {
            var _loc4_:IWindow;
            this.disposeWindow();
            if (((this._assets == null) || (this._windowManager == null)))
            {
                return;
            };
            var _loc2_:XmlAsset = (this._assets.getAssetByName("layout_parkbus_notification_xml") as XmlAsset);
            var _loc3_:XML = (_loc2_.content as XML);
            this._window = (this._windowManager.buildFromXML(_loc3_) as IFrameWindow);
            this._window.center();
            var _loc5_:ITextWindow = (this._window.findChildByName("hubu_reason") as ITextWindow);
            if (_loc5_ != null)
            {
                _loc5_.text = param1;
            };
            _loc4_ = this._window.findChildByName("hubu_link1");
            if (_loc4_ != null)
            {
                _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onLinkClick);
                _loc4_.mouseThreshold = 0;
            };
            _loc4_ = this._window.findChildByName("hubu_link2");
            if (_loc4_ != null)
            {
                _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onLinkClick);
                _loc4_.mouseThreshold = 0;
            };
            _loc4_ = this._window.findChildByTag("close");
            if (_loc4_ != null)
            {
                _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onLinkClick);
            };
        }

        private function onLinkClick(param1:WindowMouseEvent):void
        {
            switch (param1.target.name)
            {
                case "hubu_link1":
                    if (this._localization.getKey("hubu.info.url1").length > 0)
                    {
                        this.openExternalLink(this._localization.getKey("hubu.info.url1"));
                    };
                    return;
                case "hubu_link2":
                    if (this._localization.getKey("hubu.info.url2").length > 0)
                    {
                        this.openExternalLink(this._localization.getKey("hubu.info.url2"));
                    };
                    return;
                case "header_button_close":
                    this.disposeWindow();
                    return;
            };
        }

        private function openExternalLink(param1:String):void
        {
            HabboWebTools.navigateToURL(param1, "habboMain");
        }


    }
}