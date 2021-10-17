package com.sulake.habbo.catalog.purchase
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.communication.messages.parser.catalog.IsOfferGiftableMessageParser;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Matrix;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.club.ClubBuyOfferData;
    import com.sulake.habbo.catalog.enum.ProductTypeEnum;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.ICheckBoxWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import flash.geom.ColorTransform;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.XmlAsset;
    import flash.ui.Keyboard;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class PurchaseConfirmationDialog implements IGetImageListener, IDisposable 
    {

        private const var_3158:int = 10;
        private const var_2138:uint = 4293848814;
        private const var_2139:uint = 0xFFFFFFFF;
        private const var_1714:uint = 4291613146;

        private var _catalog:HabboCatalog;
        private var _roomEngine:IRoomEngine;
        private var _localization:ICoreLocalizationManager;
        private var var_3082:int;
        private var var_3079:int;
        private var var_3091:String;
        private var var_3154:Array;
        private var var_3155:IWindowContainer;
        private var var_3156:IWindowContainer;
        private var var_3157:int = -1;
        private var var_3159:String = "";
        private var var_3160:Boolean;
        private var var_3161:Boolean;
        private var var_3162:int;
        private var var_3147:Array;
        private var var_3149:Array = [];
        private var var_3148:Array = [];
        private var var_3163:int;
        private var var_3164:int;
        private var var_3165:int;
        private var _window:IFrameWindow;
        private var _disposed:Boolean = false;

        public function PurchaseConfirmationDialog(param1:ICoreLocalizationManager)
        {
            this._localization = param1;
        }

        public function showOffer(param1:IHabboCatalog, param2:IRoomEngine, param3:IPurchasableOffer, param4:int, param5:String="", param6:Array=null):void
        {
            this._catalog = (param1 as HabboCatalog);
            this._roomEngine = param2;
            this.var_3082 = param3.offerId;
            this.var_3079 = param4;
            this.var_3091 = param5;
            this.var_3154 = param6;
            this.showConfirmationDialog(param3);
            this._catalog.syncPlacedOfferWithPurchase(param3);
        }

        public function dispose():void
        {
            if (this.disposed)
            {
                return;
            };
            this._disposed = true;
            this._catalog = null;
            this._roomEngine = null;
            this.var_3082 = -1;
            this.var_3079 = -1;
            this.var_3091 = "";
            this.var_3154 = null;
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
            this.var_3155 = null;
            if (this.var_3156 != null)
            {
                this.var_3156.dispose();
                this.var_3156 = null;
            };
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function onIsOfferGiftable(param1:IsOfferGiftableMessageParser):void
        {
            if (this.disposed)
            {
                return;
            };
            if (this.var_3082 != param1.offerId)
            {
                return;
            };
            this.setGiftButtonState(param1.isGiftable);
        }

        public function imageReady(param1:int, param2:BitmapData):void
        {
            if (param1 == this.var_3162)
            {
                this.var_3162 = 0;
                this.setImage(param2, true);
            };
        }

        private function setImage(param1:BitmapData, param2:Boolean):void
        {
            if ((((this._window == null) || (param1 == null)) || (this.disposed)))
            {
                return;
            };
            var _loc3_:IBitmapWrapperWindow = (this._window.findChildByName("product_image") as IBitmapWrapperWindow);
            if (_loc3_ == null)
            {
                return;
            };
            if (_loc3_.bitmap != null)
            {
                _loc3_.bitmap.dispose();
                _loc3_.bitmap = null;
            };
            if (_loc3_.bitmap == null)
            {
                _loc3_.bitmap = new BitmapData(_loc3_.width, _loc3_.height, true, 0);
            };
            var _loc4_:int = ((_loc3_.width - param1.width) * 0.5);
            var _loc5_:int = ((_loc3_.height - param1.height) * 0.5);
            _loc3_.bitmap.draw(param1, new Matrix(1, 0, 0, 1, _loc4_, _loc5_));
            if (param2)
            {
                param1.dispose();
            };
        }

        private function showConfirmationDialog(param1:IPurchasableOffer):void
        {
            var _loc8_:IProductData;
            var _loc9_:IRoomEngine;
            var _loc10_:ImageResult;
            var _loc11_:BitmapData;
            var _loc12_:int;
            var _loc13_:String;
            var _loc14_:String;
            var _loc15_:IProduct;
            if (this._catalog == null)
            {
                return;
            };
            if (this._window != null)
            {
                this._window.dispose();
            };
            this.updateLocalizations(param1);
            this._window = (this.createWindow("purchase_confirmation") as IFrameWindow);
            if (this._window == null)
            {
                return;
            };
            var _loc2_:IWindow = this._window.findChildByName("buy_button");
            if (_loc2_ != null)
            {
                _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onBuyButtonClick);
            };
            var _loc3_:IWindow = this._window.findChildByName("gift_button");
            if (_loc3_ != null)
            {
                _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onGiftButtonClick);
            };
            var _loc4_:IWindow = this._window.findChildByName("cancel_button");
            if (_loc4_ != null)
            {
                _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
            };
            var _loc5_:IWindow = this._window.findChildByName("header_button_close");
            if (_loc5_ != null)
            {
                _loc5_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
            };
            this.setGiftButtonState(false);
            this._window.center();
            var _loc6_:ITextWindow = (this._window.findChildByName("product_name") as ITextWindow);
            if (_loc6_ != null)
            {
                _loc8_ = this._catalog.getProductData(param1.localizationId);
                _loc6_.text = ((_loc8_ == null) ? "" : _loc8_.name);
            };
            var _loc7_:IBitmapWrapperWindow = (this._window.findChildByName("product_image") as IBitmapWrapperWindow);
            if (_loc7_ != null)
            {
                _loc9_ = param1.page.viewer.roomEngine;
                _loc12_ = 0;
                _loc13_ = "";
                _loc14_ = "";
                if ((param1 is Offer))
                {
                    _loc15_ = param1.productContainer.firstProduct;
                    _loc14_ = _loc15_.productType;
                    _loc12_ = _loc15_.productClassId;
                    _loc13_ = _loc15_.extraParam;
                }
                else
                {
                    if ((param1 is ClubBuyOfferData))
                    {
                        _loc14_ = ProductTypeEnum.var_146;
                    };
                };
                switch (_loc14_)
                {
                    case ProductTypeEnum.var_105:
                        _loc10_ = _loc9_.getFurnitureIcon(_loc12_, this);
                        break;
                    case ProductTypeEnum.var_106:
                        _loc10_ = _loc9_.getWallItemIcon(_loc12_, this, _loc13_);
                        break;
                    case ProductTypeEnum.var_111:
                        _loc11_ = this._catalog.getPixelEffectIcon(_loc12_);
                        break;
                    case ProductTypeEnum.var_146:
                        _loc11_ = this._catalog.getSubscriptionProductIcon(_loc12_);
                        break;
                };
                if (_loc10_ != null)
                {
                    _loc11_ = _loc10_.data;
                    this.var_3162 = _loc10_.id;
                };
                this.setImage(_loc11_, true);
            };
        }

        private function setGiftButtonState(param1:Boolean):void
        {
            if (this._window == null)
            {
                return;
            };
            var _loc2_:IButtonWindow = IButtonWindow(this._window.findChildByName("gift_button"));
            if (param1)
            {
                _loc2_.enable();
            }
            else
            {
                _loc2_.disable();
            };
        }

        private function updateLocalizations(param1:IPurchasableOffer):void
        {
            if (param1 == null)
            {
                return;
            };
            var _loc2_:IProductData = this._catalog.getProductData(param1.localizationId);
            var _loc3_:String = ((_loc2_ == null) ? "" : _loc2_.name);
            this._catalog.windowManager.registerLocalizationParameter("catalog.purchase.confirmation.dialog.costs", "offer_name", _loc3_);
            var _loc4_:BalanceAndCost = new BalanceAndCost(this._catalog, this._localization, param1);
            this._catalog.windowManager.registerLocalizationParameter("catalog.purchase.confirmation.dialog.costs", "price", _loc4_.cost);
            this._catalog.windowManager.registerLocalizationParameter("catalog.purchase.confirmation.dialog.amount", "amount", _loc4_.balance);
            _loc4_.dispose();
        }

        private function showGiftDialog():void
        {
            var _loc8_:IWindow;
            var _loc9_:IWindow;
            var _loc10_:IWindow;
            var _loc11_:IWindow;
            var _loc12_:ICheckBoxWindow;
            var _loc13_:IWindow;
            if (this._window != null)
            {
                this._window.dispose();
            };
            var _loc1_:GiftWrappingConfiguration = this._catalog.giftWrappingConfiguration;
            var _loc2_:String = ((_loc1_.isEnabled) ? "gift_wrapping" : "gift_no_wrapping");
            this._window = (this.createWindow(_loc2_) as IFrameWindow);
            if (this._window == null)
            {
                return;
            };
            this._window.center();
            var _loc3_:IWindow = this._window.findChildByName("give_gift_button");
            if (_loc3_ != null)
            {
                _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onGiveGiftButtonClick);
            };
            var _loc4_:IWindow = this._window.findChildByName("cancel_gifting_button");
            if (_loc4_ != null)
            {
                _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCancelGift);
            };
            var _loc5_:IWindow = this._window.findChildByName("header_button_close");
            if (_loc5_ != null)
            {
                _loc5_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCancelGift);
            };
            var _loc6_:ITextFieldWindow = (this._window.findChildByName("name_input") as ITextFieldWindow);
            if (_loc6_ != null)
            {
                _loc6_.addEventListener(WindowEvent.var_606, this.onNameInputChange);
                _loc6_.addEventListener(WindowMouseEvent.var_650, this.onNameInputMouseDown);
                _loc6_.addEventListener(WindowKeyboardEvent.var_744, this.onNameInputKeyUp);
            };
            var _loc7_:ITextFieldWindow = (this._window.findChildByName("message_input") as ITextFieldWindow);
            if (_loc7_ != null)
            {
                _loc7_.addEventListener(WindowMouseEvent.var_650, this.onMessageInputMouseDown);
                _loc7_.addEventListener(WindowEvent.var_568, this.onMessageInputFocus);
            };
            this.var_3160 = true;
            this.var_3161 = true;
            if (_loc1_.isEnabled)
            {
                _loc8_ = this._window.findChildByName("ribbon_prev");
                if (_loc8_ != null)
                {
                    _loc8_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onPreviousGiftWrap);
                };
                _loc9_ = this._window.findChildByName("ribbon_next");
                if (_loc9_ != null)
                {
                    _loc9_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onNextGiftWrap);
                };
                _loc10_ = this._window.findChildByName("box_prev");
                if (_loc10_ != null)
                {
                    _loc10_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onPreviousGiftBox);
                };
                _loc11_ = this._window.findChildByName("box_next");
                if (_loc11_ != null)
                {
                    _loc11_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onNextGiftBox);
                };
                _loc12_ = (this._window.findChildByName("use_free_checkbox") as ICheckBoxWindow);
                if (_loc12_ != null)
                {
                    _loc12_.addEventListener(WindowEvent.var_575, this.onFreeWrappingSelected);
                    _loc12_.addEventListener(WindowEvent.var_578, this.onFreeWrappingUnSelect);
                };
                _loc13_ = this._window.findChildByName("use_free_text");
                if (_loc13_ != null)
                {
                    _loc13_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onGiftWrappingUseFreeTextClicked);
                };
                this._localization.registerParameter("catalog.gift_wrapping.price", "price", _loc1_.price.toString());
                this.var_3147 = _loc1_.stuffTypes;
                this.var_3148 = _loc1_.boxTypes;
                this.var_3149 = _loc1_.ribbonTypes;
                this.var_3165 = this.var_3147[0];
                this.var_3164 = this.var_3148[0];
                this.var_3163 = this.var_3149[0];
                this.initColorGrid();
                this.updateColorGrid();
                this.updatePreview();
            };
        }

        private function updatePreview():void
        {
            if (this.var_3163 < 0)
            {
                this.var_3163 = (this.var_3149.length - 1);
            };
            if (this.var_3163 > (this.var_3149.length - 1))
            {
                this.var_3163 = 0;
            };
            if (this.var_3164 < 0)
            {
                this.var_3164 = (this.var_3148.length - 1);
            };
            if (this.var_3164 > (this.var_3148.length - 1))
            {
                this.var_3164 = 0;
            };
            var _loc1_:int = ((this.var_3148[this.var_3164] * 1000) + this.var_3149[this.var_3163]);
            if (this._window == null)
            {
                return;
            };
            if (this._roomEngine == null)
            {
                return;
            };
            var _loc2_:ImageResult = this._roomEngine.getFurnitureImage(this.var_3165, new Vector3d(180), 64, this, 0, _loc1_.toString());
            if (_loc2_ == null)
            {
                return;
            };
            this.var_3162 = _loc2_.id;
            this.setImage(_loc2_.data, true);
            this.showSuggestions(false);
        }

        private function initColorGrid():void
        {
            var _loc3_:int;
            var _loc4_:IFurnitureData;
            var _loc5_:IWindowContainer;
            var _loc6_:uint;
            var _loc7_:Number;
            var _loc8_:Number;
            var _loc9_:Number;
            var _loc10_:ColorTransform;
            if (this._window == null)
            {
                return;
            };
            var _loc1_:IItemGridWindow = (this._window.findChildByName("color_grid") as IItemGridWindow);
            _loc1_.destroyGridItems();
            var _loc2_:IWindowContainer = (this.createWindow("gift_palette_item") as IWindowContainer);
            for each (_loc3_ in this.var_3147)
            {
                _loc4_ = this._catalog.getFurnitureData(_loc3_, ProductTypeEnum.var_105);
                _loc5_ = (_loc2_.clone() as IWindowContainer);
                if (!((!(_loc4_)) || (!(_loc5_))))
                {
                    _loc5_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onColorItemClick);
                    _loc6_ = _loc4_.colours[0];
                    _loc7_ = (((_loc6_ >> 16) & 0xFF) / 0xFF);
                    _loc8_ = (((_loc6_ >> 8) & 0xFF) / 0xFF);
                    _loc9_ = ((_loc6_ & 0xFF) / 0xFF);
                    _loc10_ = new ColorTransform(_loc7_, _loc8_, _loc9_);
                    this.setBitmapData(_loc5_, "border", "ctlg_clr_27x22_1");
                    this.setBitmapData(_loc5_, "color", "ctlg_clr_27x22_2", _loc10_);
                    this.setBitmapData(_loc5_, "selection", "ctlg_clr_27x22_3");
                    _loc5_.id = _loc3_;
                    _loc1_.addGridItem(_loc5_);
                };
            };
        }

        private function setBitmapData(param1:IWindowContainer, param2:String, param3:String, param4:ColorTransform=null):void
        {
            if (param1 == null)
            {
                return;
            };
            var _loc5_:IBitmapWrapperWindow = (param1.findChildByName(param2) as IBitmapWrapperWindow);
            if (_loc5_ == null)
            {
                return;
            };
            var _loc6_:BitmapDataAsset = (this._catalog.assets.getAssetByName(param3) as BitmapDataAsset);
            if (_loc6_ == null)
            {
                return;
            };
            var _loc7_:BitmapData = (_loc6_.content as BitmapData);
            if (_loc7_ == null)
            {
                return;
            };
            if (_loc5_.bitmap == null)
            {
                _loc5_.bitmap = new BitmapData(_loc5_.width, _loc5_.height, true, 0);
            };
            _loc5_.bitmap.draw(_loc7_, null, param4);
        }

        private function createWindow(param1:String):IWindow
        {
            if (((this._catalog.windowManager == null) || (this._catalog.assets == null)))
            {
                return (null);
            };
            var _loc2_:XmlAsset = (this._catalog.assets.getAssetByName(param1) as XmlAsset);
            if (((_loc2_ == null) || (_loc2_.content == null)))
            {
                return (null);
            };
            return (this._catalog.windowManager.buildFromXML((_loc2_.content as XML)));
        }

        private function giveGift():void
        {
            var _loc1_:ITextFieldWindow = (this._window.findChildByName("name_input") as ITextFieldWindow);
            if (_loc1_ == null)
            {
                return;
            };
            var _loc2_:String = _loc1_.text;
            var _loc3_:ITextFieldWindow = (this._window.findChildByName("message_input") as ITextFieldWindow);
            var _loc4_:String = ((_loc3_ == null) ? "" : _loc3_.text);
            var _loc5_:ICheckBoxWindow = (this._window.findChildByName("use_free_checkbox") as ICheckBoxWindow);
            var _loc6_:Boolean = ((_loc5_ == null) ? false : _loc5_.isSelected);
            var _loc7_:int = ((_loc6_) ? 0 : this.var_3165);
            var _loc8_:int = ((_loc6_) ? 0 : this.var_3148[this.var_3164]);
            var _loc9_:int = ((_loc6_) ? 0 : this.var_3149[this.var_3163]);
            this._catalog.purchaseProductAsGift(this.var_3079, this.var_3082, this.var_3091, _loc2_, _loc4_, _loc7_, _loc8_, _loc9_);
        }

        private function onBuyButtonClick(param1:WindowEvent):void
        {
            this._catalog.purchaseProduct(this.var_3079, this.var_3082, this.var_3091);
            this.dispose();
        }

        private function onGiftButtonClick(param1:WindowEvent):void
        {
            this.showGiftDialog();
        }

        private function onClose(param1:WindowEvent):void
        {
            this._catalog.resetPlacedOfferData();
            this.dispose();
        }

        private function onGiveGiftButtonClick(param1:WindowEvent):void
        {
            this.giveGift();
            this.enableGiftButton(false);
            this._catalog.resetPlacedOfferData();
        }

        private function onCancelGift(param1:WindowEvent):void
        {
            this._catalog.resetPlacedOfferData();
            this.dispose();
        }

        private function onPreviousGiftWrap(param1:WindowEvent):void
        {
            this.var_3163--;
            this.updatePreview();
        }

        private function onNextGiftWrap(param1:WindowEvent):void
        {
            this.var_3163++;
            this.updatePreview();
        }

        private function onPreviousGiftBox(param1:WindowEvent):void
        {
            this.var_3164--;
            this.updatePreview();
        }

        private function onNextGiftBox(param1:WindowEvent):void
        {
            this.var_3164++;
            this.updatePreview();
        }

        private function onGiftWrappingUseFreeTextClicked(param1:WindowEvent):void
        {
            this.toggleCheckbox();
        }

        private function toggleCheckbox():void
        {
            if (this._window == null)
            {
                return;
            };
            var _loc1_:ICheckBoxWindow = (this._window.findChildByName("use_free_checkbox") as ICheckBoxWindow);
            if (_loc1_ == null)
            {
                return;
            };
            if (_loc1_.isSelected)
            {
                _loc1_.unselect();
            }
            else
            {
                _loc1_.select();
            };
        }

        private function onNameInputChange(param1:WindowEvent):void
        {
            var _loc5_:String;
            var _loc2_:ITextFieldWindow = (param1.target as ITextFieldWindow);
            if (_loc2_ == null)
            {
                return;
            };
            if (this.var_3159 == _loc2_.text)
            {
                return;
            };
            var _loc3_:String = _loc2_.text.toLowerCase();
            var _loc4_:Array = [];
            for each (_loc5_ in this.var_3154)
            {
                if (_loc5_.toLowerCase().search(_loc3_) != -1)
                {
                    _loc4_.push(_loc5_);
                };
                if (_loc4_.length >= this.var_3158) break;
            };
            this.updateSuggestions(_loc4_);
            this.var_3159 = _loc2_.text;
        }

        private function onNameInputMouseDown(param1:WindowEvent):void
        {
            var _loc2_:ITextFieldWindow = (param1.target as ITextFieldWindow);
            if (_loc2_ == null)
            {
                return;
            };
            this.showSuggestions(false);
            if (this.var_3160)
            {
                _loc2_.text = "";
                this.var_3160 = false;
            };
        }

        private function onNameInputKeyUp(param1:WindowEvent):void
        {
            var _loc2_:WindowKeyboardEvent = (param1 as WindowKeyboardEvent);
            switch (_loc2_.keyCode)
            {
                case Keyboard.UP:
                    this.highlightSuggestion((this.var_3157 - 1));
                    return;
                case Keyboard.DOWN:
                    this.highlightSuggestion((this.var_3157 + 1));
                    return;
                case Keyboard.ENTER:
                    this.selectHighlighted();
                    return;
                case Keyboard.TAB:
                    this.focusMessageField();
                    return;
            };
        }

        private function focusMessageField():void
        {
            if (this._window == null)
            {
                return;
            };
            var _loc1_:ITextFieldWindow = (this._window.findChildByName("message_input") as ITextFieldWindow);
            if (_loc1_ == null)
            {
                return;
            };
            _loc1_.visible = true;
            _loc1_.focus();
        }

        private function selectHighlighted():void
        {
            if (((this.var_3155 == null) || (!(this.var_3155.visible))))
            {
                return;
            };
            var _loc1_:IItemListWindow = (this.var_3155.findChildByName("suggestion_list") as IItemListWindow);
            if (_loc1_ == null)
            {
                return;
            };
            var _loc2_:IWindowContainer = (_loc1_.getListItemAt(this.var_3157) as IWindowContainer);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:ITextWindow = (_loc2_.findChildByName("name_text") as ITextWindow);
            if (_loc3_ == null)
            {
                return;
            };
            this.setReceiverName(_loc3_.text);
            this.showSuggestions(false);
        }

        private function showSuggestions(param1:Boolean):void
        {
            if (this.var_3155 == null)
            {
                return;
            };
            this.var_3155.visible = param1;
            if (!param1)
            {
                this.showMessageInput(true);
            };
        }

        private function showMessageInput(param1:Boolean):void
        {
            var _loc2_:ITextFieldWindow = (this._window.findChildByName("message_input") as ITextFieldWindow);
            if (_loc2_ != null)
            {
                _loc2_.visible = param1;
            };
        }

        private function onMessageInputMouseDown(param1:WindowEvent):void
        {
            var _loc2_:ITextFieldWindow;
            if (this.var_3161)
            {
                _loc2_ = (param1.target as ITextFieldWindow);
                if (_loc2_ != null)
                {
                    _loc2_.text = "";
                    this.var_3161 = false;
                };
            };
        }

        private function onMessageInputFocus(param1:WindowEvent):void
        {
            this.showSuggestions(false);
        }

        private function onFreeWrappingSelected(param1:WindowEvent):void
        {
            this.showSelectors(false);
        }

        private function onFreeWrappingUnSelect(param1:WindowEvent):void
        {
            this.showSelectors(true);
        }

        private function showSelectors(param1:Boolean):void
        {
            if (this._window == null)
            {
                return;
            };
            var _loc2_:IWindowContainer = (this._window.findChildByName("mask") as IWindowContainer);
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.visible = (!(param1));
        }

        private function updateSuggestions(param1:Array):void
        {
            var _loc4_:String;
            var _loc5_:IWindowContainer;
            var _loc6_:ITextWindow;
            if (this.var_3155 == null)
            {
                this.var_3155 = (this._window.findChildByName("suggestion_container") as IWindowContainer);
            };
            if (this.var_3156 == null)
            {
                this.var_3156 = (this.createWindow("suggestion_list_item") as IWindowContainer);
            };
            if (((this.var_3155 == null) || (this.var_3156 == null)))
            {
                return;
            };
            var _loc2_:IItemListWindow = (this.var_3155.findChildByName("suggestion_list") as IItemListWindow);
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.removeListItems();
            if (param1.length == 0)
            {
                this.showSuggestions(false);
                return;
            };
            this.showSuggestions(true);
            var _loc3_:int;
            for each (_loc4_ in param1)
            {
                _loc5_ = (this.var_3156.clone() as IWindowContainer);
                if (_loc5_ != null)
                {
                    _loc5_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onSuggestionsClick);
                    _loc5_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onSuggestionsMouseOver);
                    _loc6_ = (_loc5_.findChildByName("name_text") as ITextWindow);
                    if (_loc6_ != null)
                    {
                        _loc6_.text = _loc4_;
                        _loc2_.addListItem(_loc5_);
                    };
                    _loc5_.color = this.getColor(_loc3_);
                    _loc3_++;
                };
            };
            this.showMessageInput((param1.length < 2));
            this.highlightSuggestion(0);
        }

        private function onSuggestionsClick(param1:WindowEvent):void
        {
            var _loc2_:IWindowContainer = (param1.target as IWindowContainer);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:ITextWindow = (_loc2_.findChildByName("name_text") as ITextWindow);
            if (_loc3_ == null)
            {
                return;
            };
            this.setReceiverName(_loc3_.text);
            this.showSuggestions(false);
        }

        private function onSuggestionsMouseOver(param1:WindowEvent):void
        {
            var _loc2_:IWindowContainer = (param1.target as IWindowContainer);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:IItemListWindow = (this.var_3155.findChildByName("suggestion_list") as IItemListWindow);
            if (_loc3_ == null)
            {
                return;
            };
            this.highlightSuggestion(_loc3_.getListItemIndex(_loc2_));
        }

        private function highlightSuggestion(param1:int):void
        {
            var _loc3_:IWindowContainer;
            if (this.var_3155 == null)
            {
                return;
            };
            var _loc2_:IItemListWindow = (this.var_3155.findChildByName("suggestion_list") as IItemListWindow);
            if (_loc2_ == null)
            {
                return;
            };
            _loc3_ = (_loc2_.getListItemAt(this.var_3157) as IWindowContainer);
            if (_loc3_ != null)
            {
                _loc3_.color = this.getColor(this.var_3157);
            };
            this.var_3157 = param1;
            if (this.var_3157 < 0)
            {
                this.var_3157 = (_loc2_.numListItems - 1);
            };
            if (this.var_3157 >= _loc2_.numListItems)
            {
                this.var_3157 = 0;
            };
            _loc3_ = (_loc2_.getListItemAt(this.var_3157) as IWindowContainer);
            if (_loc3_ != null)
            {
                _loc3_.color = this.var_1714;
            };
        }

        private function getColor(param1:int):uint
        {
            return (((param1 % 2) == 0) ? this.var_2138 : this.var_2139);
        }

        private function setReceiverName(param1:String):void
        {
            if (this._window == null)
            {
                return;
            };
            var _loc2_:ITextFieldWindow = (this._window.findChildByName("name_input") as ITextFieldWindow);
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.text = param1;
            this.focusMessageField();
        }

        private function onColorItemClick(param1:WindowEvent):void
        {
            this.var_3165 = param1.target.id;
            this.updateColorGrid();
            this.updatePreview();
        }

        private function updateColorGrid():void
        {
            var _loc2_:IWindowContainer;
            var _loc3_:IBitmapWrapperWindow;
            if (this._window == null)
            {
                return;
            };
            var _loc1_:IItemGridWindow = (this._window.findChildByName("color_grid") as IItemGridWindow);
            if (_loc1_ == null)
            {
                return;
            };
            var _loc4_:int;
            while (_loc4_ < _loc1_.numGridItems)
            {
                _loc2_ = (_loc1_.getGridItemAt(_loc4_) as IWindowContainer);
                if (_loc2_ != null)
                {
                    _loc3_ = (_loc2_.findChildByName("selection") as IBitmapWrapperWindow);
                    if (_loc3_ != null)
                    {
                        _loc3_.visible = (_loc2_.id == this.var_3165);
                    };
                };
                _loc4_++;
            };
        }

        public function receiverNotFound():void
        {
            if (this.disposed)
            {
                return;
            };
            this.enableGiftButton(true);
            if (((!(this._catalog)) || (!(this._catalog.windowManager))))
            {
                return;
            };
            this._catalog.windowManager.alert(("$" + "{catalog.gift_wrapping.receiver_not_found.title}"), ("$" + "{catalog.gift_wrapping.receiver_not_found.info}"), 0, this.alertHandler);
        }

        private function alertHandler(param1:IAlertDialog, param2:WindowEvent):void
        {
            param1.dispose();
            this.enableGiftButton(true);
        }

        private function enableGiftButton(param1:Boolean):void
        {
            if (this._window == null)
            {
                return;
            };
            var _loc2_:IButtonWindow = (this._window.findChildByName("give_gift_button") as IButtonWindow);
            if (_loc2_ != null)
            {
                if (param1)
                {
                    _loc2_.enable();
                }
                else
                {
                    _loc2_.disable();
                };
            };
        }

        public function notEnoughCredits():void
        {
            if (this.disposed)
            {
                return;
            };
            if (this._window == null)
            {
                return;
            };
            this.enableGiftButton(true);
            var _loc1_:ICheckBoxWindow = (this._window.findChildByName("use_free_checkbox") as ICheckBoxWindow);
            if (_loc1_ != null)
            {
                _loc1_.select();
            };
        }


    }
}