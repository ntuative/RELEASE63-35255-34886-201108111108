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

    public class ShellsIndicator extends CurrencyIndicatorBase 
    {

        private static const var_2424:Array = ["icon_shell_0_png", "icon_shell_1_png", "icon_shell_2_png", "icon_shell_3_png"];

        private const var_2425:uint = 4283212437;
        private const var_2426:uint = 4282748017;

        private var var_5089:int = 0;
        private var _catalog:IHabboCatalog;

        public function ShellsIndicator(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboCatalog, param4:ICoreLocalizationManager)
        {
            super(param1, param2);
            this._catalog = param3;
            this.bgColorLight = this.var_2425;
            this.bgColorDark = this.var_2426;
            this.textElementName = "amount";
            this.textElementShadowName = "amount_shadow";
            this.iconAnimationSequence = var_2424.concat(var_2424).concat(var_2424);
            this.iconAnimationDelay = 50;
            this.amountZeroText = param4.getKey("purse.shells.zero.amount.text", "Info");
            createWindow("purse_indicator_shells_xml", var_2424[0]);
            this.setAmount(0);
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (!param1)
            {
                return;
            };
            param1.addEventListener(PurseEvent.var_144, this.onShellBalance);
        }

        override protected function onContainerClick(param1:WindowMouseEvent):void
        {
            this._catalog.openCatalogPage(CatalogPageName.var_740, true);
        }

        private function onShellBalance(param1:PurseEvent):void
        {
            this.setAmount(param1.balance);
            if (this.var_5089 != 0)
            {
                if (this.var_5089 > param1.balance)
                {
                    animateIcon(CurrencyIndicatorBase.ANIM_DIRECTION_FORWARD);
                }
                else
                {
                    animateIcon(CurrencyIndicatorBase.ANIM_DIRECTION_BACKWARD);
                };
            };
            this.var_5089 = param1.balance;
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