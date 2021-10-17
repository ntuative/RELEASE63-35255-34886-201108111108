package com.sulake.habbo.toolbar.extensions.purse
{
    import com.sulake.core.window.components.IItemGridWindow;
    import __AS3__.vec.Vector;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.toolbar.extensions.purse.indicators.CreditsIndicator;
    import com.sulake.habbo.toolbar.extensions.purse.indicators.ClubDaysIndicator;
    import com.sulake.habbo.toolbar.extensions.purse.indicators.ShellsIndicator;
    import com.sulake.habbo.toolbar.extensions.purse.indicators.PixelsIndicator;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.window.IWindow;
    import flash.events.IEventDispatcher;
    import __AS3__.vec.*;

    public class PurseExtension 
    {

        private var _window:IItemGridWindow;
        private var var_5101:Vector.<ICurrencyIndicator> = new Vector.<ICurrencyIndicator>();
        private var _disposed:Boolean = false;

        public function PurseExtension(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboConfigurationManager, param4:IHabboCatalog, param5:IHabboInventory, param6:ICoreLocalizationManager)
        {
            var _loc7_:XmlAsset = (param2.getAssetByName("purse_xml") as XmlAsset);
            if (_loc7_)
            {
                this._window = (param1.buildFromXML((_loc7_.content as XML), 1) as IItemGridWindow);
                if (this._window)
                {
                    this.addIndicator(this._window, (new CreditsIndicator(param1, param2, param4, param6) as ICurrencyIndicator), param4.events);
                    this.addIndicator(this._window, (new ClubDaysIndicator(param1, param2, param4, param5, param6) as ICurrencyIndicator), param5.events);
                    if (param3.getKey("purse.widget.currency.shells.enabled", "0") == "1")
                    {
                        this.addIndicator(this._window, (new ShellsIndicator(param1, param2, param4, param6) as ICurrencyIndicator), param4.events);
                    };
                    this.addIndicator(this._window, (new PixelsIndicator(param1, param2, param4, param6) as ICurrencyIndicator), param4.events);
                };
                this._window.x = 0;
                this._window.y = 0;
                this._window.visible = true;
            };
        }

        public function get window():IWindow
        {
            return (this._window);
        }

        public function dispose():void
        {
            var _loc1_:ICurrencyIndicator;
            if (!this._disposed)
            {
                if (this.var_5101)
                {
                    for each (_loc1_ in this.var_5101)
                    {
                        _loc1_.dispose();
                    };
                    this.var_5101 = null;
                };
                this._disposed = true;
            };
        }

        private function addIndicator(param1:IItemGridWindow, param2:ICurrencyIndicator, param3:IEventDispatcher):void
        {
            if (param2.view)
            {
                param1.addGridItem(param2.view);
                param2.registerUpdateEvents(param3);
                this.var_5101.push(param2);
            }
            else
            {
                Logger.log("ERROR: currency indicator view was null!");
            };
        }


    }
}