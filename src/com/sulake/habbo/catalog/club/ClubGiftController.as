package com.sulake.habbo.catalog.club
{
    import com.sulake.habbo.catalog.viewer.widgets.ClubGiftWidget;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetClubGiftInfo;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.SelectClubGiftComposer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.catalog.purse.IPurse;

    public class ClubGiftController 
    {

        private var _widget:ClubGiftWidget;
        private var var_3100:int;
        private var var_3101:int;
        private var _offers:Array;
        private var var_3102:Map;
        private var _catalog:HabboCatalog;
        private var var_3080:ClubGiftConfirmationDialog;

        public function ClubGiftController(param1:HabboCatalog)
        {
            this._catalog = param1;
        }

        public function dispose():void
        {
            this._catalog = null;
            if (this.var_3080)
            {
                this.var_3080.dispose();
                this.var_3080 = null;
            };
        }

        public function set widget(param1:ClubGiftWidget):void
        {
            this._widget = param1;
            this._catalog.connection.send(new GetClubGiftInfo());
        }

        public function get daysUntilNextGift():int
        {
            return (this.var_3100);
        }

        public function get giftsAvailable():int
        {
            return (this.var_3101);
        }

        public function setInfo(param1:int, param2:int, param3:Array, param4:Map):void
        {
            this.var_3100 = param1;
            this.var_3101 = param2;
            this._offers = param3;
            this.var_3102 = param4;
            this._widget.update();
        }

        public function selectGift(param1:Offer):void
        {
            this.closeConfirmation();
            this.var_3080 = new ClubGiftConfirmationDialog(this, param1);
        }

        public function confirmSelection(param1:String):void
        {
            if ((((!(param1)) || (!(this._catalog))) || (!(this._catalog.connection))))
            {
                return;
            };
            this._catalog.connection.send(new SelectClubGiftComposer(param1));
            this.var_3101--;
            this._widget.update();
            this.closeConfirmation();
        }

        public function closeConfirmation():void
        {
            if (this.var_3080)
            {
                this.var_3080.dispose();
                this.var_3080 = null;
            };
        }

        public function getOffers():Array
        {
            return (this._offers);
        }

        public function getGiftData():Map
        {
            return (this.var_3102);
        }

        public function get hasClub():Boolean
        {
            if (((!(this._catalog)) || (!(this._catalog.getPurse()))))
            {
                return (false);
            };
            return (this._catalog.getPurse().clubDays > 0);
        }

        public function get windowManager():IHabboWindowManager
        {
            if (!this._catalog)
            {
                return (null);
            };
            return (this._catalog.windowManager);
        }

        public function get localization():ICoreLocalizationManager
        {
            if (!this._catalog)
            {
                return (null);
            };
            return (this._catalog.localization);
        }

        public function get assets():IAssetLibrary
        {
            if (!this._catalog)
            {
                return (null);
            };
            return (this._catalog.assets);
        }

        public function get roomEngine():IRoomEngine
        {
            if (!this._catalog)
            {
                return (null);
            };
            return (this._catalog.roomEngine);
        }

        public function getProductData(param1:String):IProductData
        {
            if (!this._catalog)
            {
                return (null);
            };
            return (this._catalog.getProductData(param1));
        }

        public function get purse():IPurse
        {
            if (!this._catalog)
            {
                return (null);
            };
            return (this._catalog.getPurse());
        }

        public function get catalog():HabboCatalog
        {
            return (this._catalog);
        }


    }
}