package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetPurchaseOverrideEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetsInitializedEvent;
    import com.sulake.habbo.room.PetColorResult;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetMultiColoursEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetApproveNameResultEvent;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSellablePetBreedsEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.SellablePetBreedData;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Matrix;

    public class NewPetsCatalogWidget extends CatalogWidget implements ICatalogWidget, IGetImageListener 
    {

        private static const var_2479:int = 18;

        private var _offers:Map;
        private var _name:String;
        private var var_3218:int = -1;
        private var var_3219:int = -1;
        private var var_3220:String;
        private var var_3221:Boolean = false;
        private var var_1023:Boolean = false;
        private var var_3222:Array = null;

        public function NewPetsCatalogWidget(param1:IWindowContainer)
        {
            super(param1);
        }

        override public function dispose():void
        {
            if (this.var_1023)
            {
                return;
            };
            this.var_3221 = false;
            if (this._offers != null)
            {
                this._offers.dispose();
                this._offers = null;
            };
            this.var_3222 = null;
            super.dispose();
            this.var_1023 = true;
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            this.var_3221 = false;
            var _loc1_:ITextFieldWindow = (window.findChildByName("name_input_text") as ITextFieldWindow);
            if (_loc1_ == null)
            {
                return (false);
            };
            _loc1_.addEventListener(WindowEvent.var_606, this.onTextWindowEvent);
            this._offers = new Map();
            if (page.offers.length == 0)
            {
                return (false);
            };
            var _loc2_:Offer = page.offers[0];
            this.var_3218 = this.getPetTypeIndexFromProduct(_loc2_.localizationId);
            if (this.var_3218 < 8)
            {
                return (false);
            };
            this.var_3220 = _loc2_.localizationId;
            this.updateAvailableBreeds(_loc2_.localizationId);
            if (((!(this.var_3222 == null)) && (this.var_3222.length > 0)))
            {
                this.var_3219 = this.var_3222[0];
            }
            else
            {
                this.var_3219 = -1;
            };
            this._offers.add(this.var_3218, _loc2_);
            events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT, this.onSelectProduct);
            events.addEventListener(WidgetEvent.CWE_COLOUR_INDEX, this.onColourIndex);
            events.addEventListener(WidgetEvent.var_683, this.onApproveNameResult);
            events.addEventListener(WidgetEvent.CWE_WIDGETS_INITIALIZED, this.onWidgetsInitialized);
            events.addEventListener(WidgetEvent.CWE_SELLABLE_PET_BREEDS, this.onSellablePetBreeds);
            return (true);
        }

        private function onWidgetsInitialized(param1:CatalogWidgetsInitializedEvent=null):void
        {
            if (this.var_1023)
            {
                return;
            };
            events.dispatchEvent(new CatalogWidgetPurchaseOverrideEvent(this.onPurchase));
            var _loc2_:Offer = this._offers.getWithIndex(0);
            if (_loc2_ != null)
            {
                events.dispatchEvent(new SelectProductEvent(_loc2_));
            };
            this.initializeBreedSelection();
        }

        private function initializeBreedSelection():void
        {
            var _loc1_:Array;
            var _loc2_:int;
            var _loc3_:PetColorResult;
            if (this.var_3222 != null)
            {
                _loc1_ = [];
                _loc2_ = 0;
                while (((_loc2_ < var_2479) && (_loc2_ < this.var_3222.length)))
                {
                    _loc3_ = (page.viewer.catalog as HabboCatalog).roomEngine.getPetColor(this.var_3218, this.var_3222[_loc2_]);
                    if (_loc3_ != null)
                    {
                        if (_loc3_.primaryColor == _loc3_.secondaryColor)
                        {
                            _loc1_.push([_loc3_.primaryColor]);
                        }
                        else
                        {
                            _loc1_.push([_loc3_.primaryColor, _loc3_.secondaryColor]);
                        };
                    };
                    _loc2_++;
                };
                events.dispatchEvent(new CatalogWidgetMultiColoursEvent(_loc1_, "ctlg_clr_27x22_1", "ctlg_clr_27x22_2", "ctlg_clr_27x22_3"));
            };
        }

        private function onColourIndex(param1:CatalogWidgetColourIndexEvent):void
        {
            if (param1 == null)
            {
                return;
            };
            var _loc2_:int = param1.index;
            this.selectedBreed(_loc2_);
        }

        private function selectedBreed(param1:int):void
        {
            if (((!(this.var_3222 == null)) && (this.var_3222.length > 0)))
            {
                if (((param1 < 0) || (param1 > this.var_3222.length)))
                {
                    param1 = 0;
                };
                this.var_3219 = this.var_3222[param1];
                this.updateImage();
            };
        }

        private function getPetLocalization():String
        {
            var _loc1_:IHabboCatalog;
            if (this.var_3219 < 0)
            {
                return ("");
            };
            if (((!(page == null)) && (!(page.viewer == null))))
            {
                _loc1_ = page.viewer.catalog;
                if (((!(_loc1_ == null)) && (!(_loc1_.localization == null))))
                {
                    return (_loc1_.localization.getKey(this.getRaceLocalizationKey(this.var_3218, this.var_3219), this.getRaceLocalizationKey(this.var_3218, this.var_3219)));
                };
            };
            return (this.getRaceLocalizationKey(this.var_3218, this.var_3219));
        }

        private function onPurchase(param1:WindowEvent):void
        {
            if (this.var_3221)
            {
                Logger.log("* Cannot buy a pet, pending previous name approval.");
            };
            if (this.getPurchaseParameters() == "")
            {
                return;
            };
            this.var_3221 = true;
            (page.viewer.catalog as HabboCatalog).approveName(this._name, 1);
        }

        private function onTextWindowEvent(param1:WindowEvent):void
        {
            var _loc2_:ITextFieldWindow = (param1.target as ITextFieldWindow);
            if (_loc2_ == null)
            {
                return;
            };
            this._name = _loc2_.text;
        }

        private function onSelectProduct(param1:SelectProductEvent):void
        {
            if (param1 == null)
            {
                return;
            };
            this.updateImage();
        }

        private function onApproveNameResult(event:CatalogWidgetApproveNameResultEvent):void
        {
            if (((event == null) || (!(this.var_3221))))
            {
                return;
            };
            this.var_3221 = false;
            var nameValidationInfo:String = event.nameValidationInfo;
            switch (event.result)
            {
                case 1:
                    page.viewer.catalog.windowManager.alert("${catalog.alert.purchaseerror.title}", this.constructErrorMessage("long", nameValidationInfo), 0, function (param1:IAlertDialog, param2:WindowEvent):void
                    {
                        param1.dispose();
                    });
                    return;
                case 2:
                    page.viewer.catalog.windowManager.alert("${catalog.alert.purchaseerror.title}", this.constructErrorMessage("short", nameValidationInfo), 0, function (param1:IAlertDialog, param2:WindowEvent):void
                    {
                        param1.dispose();
                    });
                    return;
                case 3:
                    page.viewer.catalog.windowManager.alert("${catalog.alert.purchaseerror.title}", this.constructErrorMessage("chars", nameValidationInfo), 0, function (param1:IAlertDialog, param2:WindowEvent):void
                    {
                        param1.dispose();
                    });
                    return;
                case 4:
                    page.viewer.catalog.windowManager.alert("${catalog.alert.purchaseerror.title}", this.constructErrorMessage("bobba", nameValidationInfo), 0, function (param1:IAlertDialog, param2:WindowEvent):void
                    {
                        param1.dispose();
                    });
                    return;
            };
            var p:String = this.getPurchaseParameters();
            if (p == "")
            {
                Logger.log("* Not enough information to buy a pet!");
                return;
            };
            Logger.log(("* Will buy pet as " + p));
            (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(this._offers.getWithIndex(0), page.pageId, p);
        }

        private function constructErrorMessage(param1:String, param2:String):String
        {
            var _loc3_:ICoreLocalizationManager = (page.viewer.catalog as HabboCatalog).localization;
            var _loc4_:String = ("catalog.alert.petname." + param1);
            var _loc5_:* = (_loc4_ + ".additionalInfo");
            _loc3_.registerParameter(_loc5_, "additional_info", param2);
            var _loc6_:String = _loc3_.getKey(_loc4_);
            var _loc7_:String = _loc3_.getKey(_loc5_);
            if (((((!(param2 == null)) && (param2.length > 0)) && (!(_loc7_ == null))) && (_loc7_.length > 0)))
            {
                _loc6_ = _loc7_;
            };
            return (_loc6_);
        }

        private function onSellablePetBreeds(param1:CatalogWidgetSellablePetBreedsEvent):void
        {
            if (param1.productCode == this.var_3220)
            {
                this.var_3222 = this.parseSellableBreeds(param1.sellableBreeds);
                this.initializeBreedSelection();
                this.selectedBreed(0);
                this.updateImage();
            };
        }

        private function parseSellableBreeds(param1:Array):Array
        {
            var _loc3_:SellablePetBreedData;
            if (!param1)
            {
                return (null);
            };
            var _loc2_:Array = new Array();
            for each (_loc3_ in param1)
            {
                if (((_loc3_.type == this.var_3218) && (_loc3_.sellable)))
                {
                    _loc2_.push(_loc3_.breed);
                };
            };
            return (_loc2_);
        }

        private function updateImage():void
        {
            var _loc1_:Offer = this._offers.getWithIndex(0);
            if (((_loc1_ == null) || (this.var_3219 < 0)))
            {
                return;
            };
            var _loc2_:int = this.var_3218;
            var _loc3_:int = this.var_3219;
            var _loc4_:ImageResult = (page.viewer.catalog as HabboCatalog).roomEngine.getPetImage(_loc2_, _loc3_, new Vector3d(135, 0, 0), 64, this);
            if (_loc4_ != null)
            {
                this.setPreviewImage(_loc4_.data, true);
            };
            var _loc5_:ICoreLocalizationManager = (page.viewer.catalog as HabboCatalog).localization;
            var _loc6_:ITextWindow = (_window.findChildByName("ctlg_price_credits") as ITextWindow);
            if (_loc6_ != null)
            {
                _loc5_.registerParameter("catalog.purchase.price.credits", "credits", String(_loc1_.priceInCredits));
                _loc6_.caption = "${catalog.purchase.price.credits}";
            };
            var _loc7_:ITextWindow = (_window.findChildByName("pet_breed_text") as ITextWindow);
            if (_loc7_)
            {
                _loc7_.caption = this.getPetLocalization();
            };
        }

        private function getPurchaseParameters():String
        {
            if (((this._name == null) || (this._name.length == 0)))
            {
                page.viewer.catalog.windowManager.alert("${catalog.alert.purchaseerror.title}", "${catalog.alert.petname.empty}", 0, function (param1:IAlertDialog, param2:WindowEvent):void
                {
                    param1.dispose();
                });
                return ("");
            };
            if (this.var_3219 < 0)
            {
                return ("");
            };
            var color:uint = 0xFFFFFF;
            var p:String = ((((this._name + String.fromCharCode(10)) + this.var_3219) + String.fromCharCode(10)) + this.addZeroPadding(color.toString(16).toUpperCase(), 6));
            return (p);
        }

        private function setPreviewImage(param1:BitmapData, param2:Boolean):void
        {
            var _loc3_:IBitmapWrapperWindow;
            var _loc4_:int;
            var _loc5_:BitmapData;
            var _loc6_:Point;
            if (!window.disposed)
            {
                if (param1 == null)
                {
                    param1 = new BitmapData(1, 1);
                    param2 = true;
                };
                _loc3_ = (window.findChildByName("ctlg_teaserimg_1") as IBitmapWrapperWindow);
                if (_loc3_ != null)
                {
                    if (_loc3_.bitmap == null)
                    {
                        _loc3_.bitmap = new BitmapData(_loc3_.width, _loc3_.height, true, 0xFFFFFF);
                    };
                    _loc3_.bitmap.fillRect(_loc3_.bitmap.rect, 0xFFFFFF);
                    _loc4_ = 2;
                    _loc5_ = new BitmapData((param1.width * _loc4_), (param1.height * _loc4_), true, 0xFFFFFF);
                    _loc5_.draw(param1, new Matrix(_loc4_, 0, 0, _loc4_));
                    _loc6_ = new Point(((_loc3_.width - _loc5_.width) / 2), ((_loc3_.height - _loc5_.height) / 2));
                    _loc3_.bitmap.copyPixels(_loc5_, _loc5_.rect, _loc6_, null, null, true);
                    _loc3_.invalidate();
                    _loc5_.dispose();
                };
            };
            if (param2)
            {
                param1.dispose();
            };
        }

        private function getPetTypeIndexFromProduct(param1:String):int
        {
            if (param1.length == 0)
            {
                return (0);
            };
            var _loc2_:int;
            _loc2_ = (param1.length - 1);
            while (_loc2_ >= 0)
            {
                if (isNaN(parseInt(param1.charAt(_loc2_)))) break;
                _loc2_--;
            };
            if (_loc2_ > 0)
            {
                return (int(param1.substring((_loc2_ + 1))));
            };
            return (-1);
        }

        private function getRaceLocalizationKey(param1:int, param2:int):String
        {
            return ((("pet.breed." + param1) + ".") + param2);
        }

        private function addZeroPadding(param1:String, param2:int):String
        {
            while (param1.length < param2)
            {
                param1 = ("0" + param1);
            };
            return (param1);
        }

        private function updateAvailableBreeds(param1:String):void
        {
            var _loc2_:Array;
            if (this.var_3222 == null)
            {
                _loc2_ = (page.viewer.catalog as HabboCatalog).getSellablePetBreeds(param1);
                this.var_3222 = this.parseSellableBreeds(_loc2_);
            };
        }

        public function imageReady(param1:int, param2:BitmapData):void
        {
            if (disposed)
            {
                return;
            };
            this.setPreviewImage(param2, true);
            this.onWidgetsInitialized();
        }


    }
}