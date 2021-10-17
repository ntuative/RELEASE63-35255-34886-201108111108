package com.sulake.habbo.catalog.club
{
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;

    public class ClubGiftConfirmationDialog 
    {

        private var var_3078:Offer;
        private var var_2438:ClubGiftController;
        private var _view:IFrameWindow;

        public function ClubGiftConfirmationDialog(param1:ClubGiftController, param2:Offer)
        {
            this.var_3078 = param2;
            this.var_2438 = param1;
            this.showConfirmation();
        }

        public function dispose():void
        {
            this.var_2438 = null;
            this.var_3078 = null;
            if (this._view)
            {
                this._view.dispose();
                this._view = null;
            };
        }

        public function showConfirmation():void
        {
            if (((!(this.var_3078)) || (!(this.var_2438))))
            {
                return;
            };
            this._view = (this.createWindow("club_gift_confirmation") as IFrameWindow);
            if (!this._view)
            {
                return;
            };
            this._view.procedure = this.windowEventHandler;
            this._view.center();
            var _loc1_:ITextWindow = (this._view.findChildByName("item_name") as ITextWindow);
            if (_loc1_)
            {
                _loc1_.text = this.getProductName();
            };
            var _loc2_:IWindowContainer = (this._view.findChildByName("image_border") as IWindowContainer);
            if (!_loc2_)
            {
                return;
            };
            if (!this.var_3078.productContainer)
            {
                return;
            };
            this.var_3078.productContainer.view = _loc2_;
            this.var_3078.productContainer.initProductIcon(this.var_2438.roomEngine);
        }

        private function getProductName():String
        {
            var _loc1_:IProductData;
            if ((((this.var_3078) && (this.var_3078.productContainer)) && (this.var_3078.productContainer.firstProduct)))
            {
                _loc1_ = this.var_3078.productContainer.firstProduct.productData;
                if (_loc1_)
                {
                    return (_loc1_.name);
                };
            };
            return ("");
        }

        private function windowEventHandler(param1:WindowEvent, param2:IWindow):void
        {
            if (((((!(param1)) || (!(param2))) || (!(this.var_2438))) || (!(this.var_3078))))
            {
                return;
            };
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            switch (param2.name)
            {
                case "select_button":
                    this.var_2438.confirmSelection(this.var_3078.localizationId);
                    return;
                case "header_button_close":
                case "cancel_button":
                    this.var_2438.closeConfirmation();
                    return;
            };
        }

        private function createWindow(param1:String):IWindow
        {
            if ((((!(this.var_2438)) || (!(this.var_2438.assets))) || (!(this.var_2438.windowManager))))
            {
                return (null);
            };
            var _loc2_:XmlAsset = (this.var_2438.assets.getAssetByName(param1) as XmlAsset);
            if (((!(_loc2_)) || (!(_loc2_.content))))
            {
                return (null);
            };
            var _loc3_:XML = (_loc2_.content as XML);
            if (!_loc3_)
            {
                return (null);
            };
            return (this.var_2438.windowManager.buildFromXML(_loc3_));
        }


    }
}