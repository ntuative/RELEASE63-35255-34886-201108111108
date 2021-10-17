package com.sulake.habbo.toolbar.extensions.purse.indicators
{
    import com.sulake.habbo.toolbar.extensions.purse.CurrencyIndicatorBase;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.core.window.components.IIconWindow;

    public class ClubDaysIndicator extends CurrencyIndicatorBase 
    {

        private static const var_2425:uint = 4286084205;
        private static const var_2426:uint = 4283781966;
        private static const var_623:int = 13;
        private static const var_622:int = 14;

        private var _catalog:IHabboCatalog;
        private var var_3071:IHabboInventory;

        public function ClubDaysIndicator(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboCatalog, param4:IHabboInventory, param5:ICoreLocalizationManager)
        {
            super(param1, param2);
            this._catalog = param3;
            this.var_3071 = param4;
            this.bgColorLight = var_2425;
            this.bgColorDark = var_2426;
            this.textElementName = "days";
            this.textElementShadowName = "days_shadow";
            this.amountZeroText = param5.getKey("purse.clubdays.zero.amount.text", "Get");
            createWindow("purse_indicator_club_xml", "");
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (!param1)
            {
                return;
            };
            param1.addEventListener(HabboInventoryHabboClubEvent.var_1717, this.onClubChanged);
        }

        override protected function onContainerClick(param1:WindowMouseEvent):void
        {
            this._catalog.openCatalogPage(CatalogPageName.var_160, true);
        }

        private function onClubChanged(param1:HabboInventoryHabboClubEvent):void
        {
            var _loc2_:int = ((this.var_3071.clubPeriods * 31) + this.var_3071.clubDays);
            setText(_loc2_.toString());
            switch (this.var_3071.clubLevel)
            {
                case HabboClubLevelEnum.var_255:
                    this.setClubIcon(var_622);
                    setText(this.amountZeroText);
                    setTextUnderline(true);
                    return;
                case HabboClubLevelEnum.var_256:
                    this.setClubIcon(var_623);
                    setTextUnderline(false);
                    return;
                case HabboClubLevelEnum.var_114:
                    this.setClubIcon(var_622);
                    setTextUnderline(false);
                    return;
            };
        }

        private function setClubIcon(param1:int):void
        {
            var _loc2_:IIconWindow = (this.view.findChildByName("club_icon") as IIconWindow);
            if (_loc2_)
            {
                _loc2_.style = param1;
                _loc2_.invalidate();
            };
        }


    }
}