package com.sulake.habbo.toolbar.extensions.purse.indicators
{
    import com.sulake.habbo.toolbar.extensions.purse.CurrencyIndicatorBase;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.catalog.purse.PurseEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class PixelsIndicator extends CurrencyIndicatorBase 
    {

        private static const var_2425:uint = 4285767869;
        private static const var_2426:uint = 4283664040;
        private static const var_2424:Array = ["icon_pixel_0_png", "icon_pixel_1_png", "icon_pixel_2_png", "icon_pixel_3_png"];

        private var var_5088:int = 0;
        private var _catalog:IHabboCatalog;

        public function PixelsIndicator(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboCatalog, param4:ICoreLocalizationManager)
        {
            super(param1, param2);
            this._catalog = param3;
            this.bgColorLight = var_2425;
            this.bgColorDark = var_2426;
            this.textElementName = "pixels";
            this.textElementShadowName = "pixels_shadow";
            this.iconAnimationSequence = var_2424.concat(var_2424);
            this.iconAnimationDelay = 50;
            this.amountZeroText = param4.getKey("purse.pixels.zero.amount.text", "Get");
            createWindow("purse_indicator_pixels_xml", var_2424[0]);
            this.setAmount(0);
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (!param1)
            {
                return;
            };
            param1.addEventListener(PurseEvent.var_142, this.onPixelBalance);
        }

        override protected function onContainerClick(param1:WindowMouseEvent):void
        {
            this._catalog.openCatalogPage(CatalogPageName.var_735);
        }

        private function onPixelBalance(param1:PurseEvent):void
        {
            this.setAmount(param1.balance);
            if (this.var_5088 != 0)
            {
                if (this.var_5088 > param1.balance)
                {
                    animateIcon(CurrencyIndicatorBase.ANIM_DIRECTION_FORWARD);
                }
                else
                {
                    animateIcon(CurrencyIndicatorBase.ANIM_DIRECTION_BACKWARD);
                };
            };
            this.var_5088 = param1.balance;
        }

        private function setAmount(param1:int):void
        {
            var _loc2_:String = param1.toString();
            if (param1 == 0)
            {
                _loc2_ = this.amountZeroText;
                setTextUnderline(true);
            }
            else
            {
                setTextUnderline(false);
            };
            setText(_loc2_);
        }


    }
}