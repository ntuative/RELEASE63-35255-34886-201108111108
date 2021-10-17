package com.sulake.habbo.notifications
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class ClubPromoNotification 
    {

        private var _window:IFrameWindow;
        private var _catalog:IHabboCatalog;

        public function ClubPromoNotification(param1:int, param2:int, param3:IAssetLibrary, param4:IHabboWindowManager, param5:IHabboCatalog, param6:IHabboLocalizationManager)
        {
            if (((((!(param3)) || (!(param4))) || (!(param5))) || (!(param6))))
            {
                return;
            };
            this._catalog = param5;
            var _loc7_:XmlAsset = (param3.getAssetByName("club_promo_notification_xml") as XmlAsset);
            if (_loc7_ == null)
            {
                return;
            };
            this._window = (param4.buildFromXML((_loc7_.content as XML)) as IFrameWindow);
            if (this._window == null)
            {
                return;
            };
            this.setText("regular_price_text", param1);
            this.setText("discount_text", (param2 - param1));
            this.setText("your_price_text", param2);
            this._window.findChildByName("benefits_text").setParamFlag(WindowParam.var_609);
            this._window.procedure = this.eventHandler;
            this._window.x = 74;
            this._window.y = ((this._window.context.getDesktopWindow().height / 2) - (this._window.height / 2));
        }

        private function setText(param1:String, param2:int):void
        {
            this._window.findChildByName(param1).caption = ("" + param2);
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
                case "benefits_text":
                    this.onBenefitsLink();
                    return;
                case "header_button_close":
                case "cancel_button":
                    this.dispose();
                    return;
            };
        }

        private function onBenefitsLink():void
        {
            var _loc1_:IHabboConfigurationManager = this._catalog.configuration;
            var _loc2_:String = _loc1_.getKey("link.format.club", "credits/habboclub");
            if (_loc2_ != "")
            {
                this._catalog.windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, this.onExternalLinkAlertClose);
                HabboWebTools.navigateToURL(_loc2_, "habboMain");
            };
        }

        private function onExternalLinkAlertClose(param1:IAlertDialog, param2:WindowEvent):void
        {
            param1.dispose();
        }


    }
}