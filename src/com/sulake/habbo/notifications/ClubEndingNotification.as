package com.sulake.habbo.notifications
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.habbo.window.enum.HabboIconType;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class ClubEndingNotification 
    {

        private var _window:IFrameWindow;
        private var _catalog:IHabboCatalog;

        public function ClubEndingNotification(param1:int, param2:Boolean, param3:IAssetLibrary, param4:IHabboWindowManager, param5:IHabboCatalog, param6:IHabboLocalizationManager)
        {
            if (((((!(param3)) || (!(param4))) || (!(param5))) || (!(param6))))
            {
                return;
            };
            this._catalog = param5;
            param6.registerParameter("notifications.text.club_ending", "days", param1.toString());
            var _loc7_:XmlAsset = (param3.getAssetByName("club_ending_notification_xml") as XmlAsset);
            if (_loc7_ == null)
            {
                return;
            };
            this._window = (param4.buildFromXML((_loc7_.content as XML)) as IFrameWindow);
            if (this._window == null)
            {
                return;
            };
            var _loc8_:IIconWindow = (this._window.findChildByName("club_icon") as IIconWindow);
            if (_loc8_)
            {
                if (param2)
                {
                    _loc8_.style = HabboIconType.var_548;
                }
                else
                {
                    _loc8_.style = HabboIconType.var_549;
                };
            };
            this._window.procedure = this.eventHandler;
            this._window.center();
        }

        public function get visible():Boolean
        {
            return ((this._window) && (this._window.visible));
        }

        public function dispose():void
        {
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
            this._catalog = null;
        }

        private function eventHandler(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            switch (param2.name)
            {
                case "open_catalog_button":
                    if (this._catalog)
                    {
                        this._catalog.openCatalogPage(CatalogPageName.var_160, true);
                    };
                    this.dispose();
                    return;
                case "header_button_close":
                case "cancel_button":
                    this.dispose();
                    return;
            };
        }


    }
}