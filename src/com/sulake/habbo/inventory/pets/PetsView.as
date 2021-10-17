package com.sulake.habbo.inventory.pets
{
    import com.sulake.habbo.inventory.IInventoryView;
    import com.sulake.habbo.avatar.IPetImageListener;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.inventory.enum.FurniModelCategory;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.communication.messages.outgoing.notifications.UnseenItemCategoryEnum;

    public class PetsView implements IInventoryView, IPetImageListener, IGetImageListener 
    {

        private static const var_2082:int = 4;

        private const var_4079:int = 0;
        private const var_1817:int = 1;
        private const var_2083:int = 2;
        private const var_2084:int = 3;

        private var _windowManager:IHabboWindowManager;
        private var _assetLibrary:IAssetLibrary;
        private var _view:IWindowContainer;
        private var var_2533:PetsModel;
        private var _disposed:Boolean = false;
        private var var_3306:IItemGridWindow;
        private var _roomEngine:IRoomEngine;
        private var _avatarRenderer:IAvatarRenderManager;
        private var var_4102:Map;
        private var var_2485:PetsGridItem;
        private var var_4081:int = 0;

        public function PetsView(param1:PetsModel, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager, param5:IRoomEngine, param6:IAvatarRenderManager)
        {
            var _loc11_:IButtonWindow;
            super();
            this.var_2533 = param1;
            this._assetLibrary = param3;
            this._windowManager = param2;
            this._roomEngine = param5;
            this._avatarRenderer = param6;
            this.var_4102 = new Map();
            var _loc7_:XmlAsset = (this._assetLibrary.getAssetByName("inventory_pets_view_xml") as XmlAsset);
            if (((_loc7_ == null) || (_loc7_.content == null)))
            {
                return;
            };
            this._view = (this._windowManager.buildFromXML((_loc7_.content as XML)) as IWindowContainer);
            if (this._view == null)
            {
                return;
            };
            this._view.visible = false;
            this._view.procedure = this.windowEventHandler;
            this.addUnseenItemSymbols();
            this.var_3306 = (this._view.findChildByName("grid") as IItemGridWindow);
            var _loc8_:IBitmapWrapperWindow = (this._view.findChildByName("download_image") as IBitmapWrapperWindow);
            _loc8_.bitmap = new BitmapData(_loc8_.width, _loc8_.height);
            var _loc9_:BitmapData = (this._assetLibrary.getAssetByName("download_icon_png").content as BitmapData);
            _loc8_.bitmap.copyPixels(_loc9_, _loc9_.rect, new Point(((_loc8_.width - _loc9_.width) / 2), ((_loc8_.height - _loc9_.height) / 2)), null, null, true);
            _loc8_ = (this._view.findChildByName("image") as IBitmapWrapperWindow);
            _loc8_.bitmap = new BitmapData(_loc8_.width, _loc8_.height);
            var _loc10_:BitmapData = (this._assetLibrary.getAssetByName("inventory_empty_png").content as BitmapData);
            _loc8_.bitmap.copyPixels(_loc10_, _loc10_.rect, new Point(((_loc8_.width - _loc10_.width) / 2), ((_loc8_.height - _loc10_.height) / 2)), null, null, true);
            _loc11_ = (this._view.findChildByName("place_button") as IButtonWindow);
            if (_loc11_ != null)
            {
                _loc11_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.placeButtonClickHandler);
            };
            _loc11_ = (this._view.findChildByName("open_catalog_btn") as IButtonWindow);
            if (_loc11_ != null)
            {
                _loc11_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.catalogButtonClickHandler);
            };
            this.selectPetsTab();
            this.updatePreview();
            this.updateState();
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this._windowManager = null;
                this.var_2533 = null;
                this._view = null;
                this._disposed = true;
            };
        }

        public function get isVisible():Boolean
        {
            return ((!(this._view.parent == null)) && (this._view.visible));
        }

        public function update():void
        {
            this.updateCategoryButtons();
            this.updateGrid();
            this.updatePreview(this.var_2485);
        }

        public function removePet(param1:int):void
        {
            var _loc2_:PetsGridItem = (this.var_4102.remove(param1) as PetsGridItem);
            if (_loc2_ == null)
            {
                return;
            };
            this.var_3306.removeGridItem(_loc2_.window);
            if (this.var_2485 == _loc2_)
            {
                this.var_2485 = null;
                this.selectFirst();
            };
        }

        private function selectFirst():void
        {
            if (((this.var_4102 == null) || (this.var_4102.length == 0)))
            {
                this.updatePreview();
                return;
            };
            this.setSelectedGridItem(this.var_4102.getWithIndex(0));
        }

        public function addPet(param1:PetData):void
        {
            if (param1 == null)
            {
                return;
            };
            if (this.var_4102.getValue(param1.id) != null)
            {
                return;
            };
            var _loc2_:PetsGridItem = new PetsGridItem(this, param1, this._windowManager, this._assetLibrary, this._avatarRenderer, this.var_2533.isUnseen(param1.id));
            if (_loc2_ != null)
            {
                this.var_3306.addGridItem(_loc2_.window);
                this.var_4102.add(param1.id, _loc2_);
                if (this.var_2485 == null)
                {
                    this.selectFirst();
                };
            };
        }

        private function updateGrid():void
        {
            var _loc1_:PetsGridItem;
            var _loc2_:Map;
            var _loc3_:PetData;
            if (this._view == null)
            {
                return;
            };
            this.var_3306.removeGridItems();
            for each (_loc1_ in this.var_4102)
            {
                _loc1_.dispose();
            };
            this.var_4102.reset();
            _loc2_ = this.var_2533.pets;
            if (_loc2_ == null)
            {
                return;
            };
            for each (_loc3_ in _loc2_)
            {
                this.addPet(_loc3_);
            };
        }

        private function catalogButtonClickHandler(param1:WindowMouseEvent):void
        {
            this.var_2533.requestCatalogOpen();
        }

        private function placeButtonClickHandler(param1:WindowMouseEvent):void
        {
            if (this.var_2485 == null)
            {
                return;
            };
            var _loc2_:PetData = this.var_2485.pet;
            if (_loc2_ == null)
            {
                return;
            };
            this.placePetToRoom(_loc2_.id);
        }

        public function placePetToRoom(param1:int, param2:Boolean=false):void
        {
            this.var_2533.placePetToRoom(param1, param2);
        }

        public function getWindowContainer():IWindowContainer
        {
            if (this._view == null)
            {
                return (null);
            };
            if (this._view.disposed)
            {
                return (null);
            };
            return (this._view);
        }

        private function windowEventHandler(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type == WindowEvent.var_576)
            {
                switch (param2.name)
                {
                    case "tab_floor":
                        this.var_2533.switchToFurnitureCategory(FurniModelCategory.var_1277);
                        break;
                    case "tab_wall":
                        this.var_2533.switchToFurnitureCategory(FurniModelCategory.var_1278);
                        break;
                };
                this.selectPetsTab();
            };
        }

        private function selectPetsTab():void
        {
            if (this._view == null)
            {
                return;
            };
            var _loc1_:ISelectorWindow = (this._view.findChildByName("category_selector") as ISelectorWindow);
            if (_loc1_ != null)
            {
                _loc1_.setSelected(_loc1_.getSelectableByName("tab_pets"));
            };
        }

        public function setSelectedGridItem(param1:PetsGridItem):void
        {
            if (this.var_2485 != null)
            {
                this.var_2485.setSelected(false);
            };
            this.var_2485 = param1;
            if (this.var_2485 != null)
            {
                this.var_2485.setSelected(true);
            };
            this.updatePreview(param1);
        }

        public function updateState():void
        {
            var _loc2_:int;
            var _loc1_:Map = this.var_2533.pets;
            if (!this.var_2533.isListInitialized())
            {
                _loc2_ = this.var_1817;
            }
            else
            {
                if (((!(_loc1_)) || (_loc1_.length == 0)))
                {
                    _loc2_ = this.var_2083;
                }
                else
                {
                    _loc2_ = this.var_2084;
                };
            };
            if (this.var_4081 == _loc2_)
            {
                return;
            };
            this.var_4081 = _loc2_;
            var _loc3_:IWindowContainer = (this._view.findChildByName("loading_container") as IWindowContainer);
            var _loc4_:IWindowContainer = (this._view.findChildByName("empty_container") as IWindowContainer);
            var _loc5_:IWindowContainer = (this._view.findChildByName("grid_container") as IWindowContainer);
            var _loc6_:IWindowContainer = (this._view.findChildByName("preview_container") as IWindowContainer);
            switch (_loc2_)
            {
                case this.var_1817:
                    _loc3_.visible = true;
                    _loc4_.visible = false;
                    _loc5_.visible = false;
                    _loc6_.visible = false;
                    return;
                case this.var_2083:
                    _loc3_.visible = false;
                    _loc4_.visible = true;
                    _loc5_.visible = false;
                    _loc6_.visible = false;
                    return;
                case this.var_2084:
                    _loc3_.visible = false;
                    _loc4_.visible = false;
                    _loc5_.visible = true;
                    _loc6_.visible = true;
                    this.updateGrid();
                    this.updatePreview();
                    return;
            };
        }

        private function updatePreview(param1:PetsGridItem=null):void
        {
            var _loc2_:BitmapData;
            var _loc3_:String;
            var _loc4_:String;
            var _loc5_:Boolean;
            var _loc12_:PetData;
            var _loc13_:BitmapData;
            if (this._view == null)
            {
                return;
            };
            if (((param1 == null) || (param1.pet == null)))
            {
                _loc2_ = new BitmapData(1, 1);
                _loc3_ = "";
                _loc4_ = "";
                _loc5_ = false;
            }
            else
            {
                _loc12_ = param1.pet;
                _loc3_ = _loc12_.name;
                _loc2_ = this.getPetImage(_loc12_.type, _loc12_.breed, _loc12_.color, 4, true);
                _loc5_ = true;
            };
            var _loc6_:IBitmapWrapperWindow = (this._view.findChildByName("preview_image") as IBitmapWrapperWindow);
            if (_loc6_ != null)
            {
                _loc13_ = new BitmapData(_loc6_.width, _loc6_.height);
                _loc13_.fillRect(_loc13_.rect, 0);
                _loc13_.copyPixels(_loc2_, _loc2_.rect, new Point(((_loc13_.width / 2) - (_loc2_.width / 2)), ((_loc13_.height / 2) - (_loc2_.height / 2))));
                _loc6_.bitmap = _loc13_;
            };
            _loc2_.dispose();
            var _loc7_:ITextWindow = (this._view.findChildByName("preview_text") as ITextWindow);
            if (_loc7_ != null)
            {
                _loc7_.caption = _loc3_;
            };
            _loc7_ = (this._view.findChildByName("preview_description") as ITextWindow);
            if (_loc7_ != null)
            {
                _loc7_.caption = _loc4_;
            };
            var _loc8_:Boolean;
            var _loc9_:Boolean;
            if (this.var_2533.roomSession != null)
            {
                _loc8_ = this.var_2533.roomSession.arePetsAllowed;
                _loc9_ = this.var_2533.roomSession.isRoomOwner;
            };
            var _loc10_:String = "";
            if (!_loc9_)
            {
                if (_loc8_)
                {
                    _loc10_ = "${inventory.pets.allowed}";
                }
                else
                {
                    _loc10_ = "${inventory.pets.forbidden}";
                };
            };
            _loc7_ = (this._view.findChildByName("preview_info") as ITextWindow);
            if (_loc7_ != null)
            {
                _loc7_.caption = _loc10_;
            };
            var _loc11_:IButtonWindow = (this._view.findChildByName("place_button") as IButtonWindow);
            if (_loc11_ != null)
            {
                if (((_loc5_) && ((_loc9_) || (_loc8_))))
                {
                    _loc11_.enable();
                }
                else
                {
                    _loc11_.disable();
                };
            };
        }

        public function getPetImage(param1:int, param2:int, param3:String, param4:int, param5:Boolean):BitmapData
        {
            var _loc7_:uint;
            var _loc8_:IAvatarImage;
            var _loc9_:uint;
            var _loc10_:ImageResult;
            var _loc6_:BitmapData;
            if (param1 < 8)
            {
                _loc7_ = parseInt(param3, 16);
                _loc8_ = this._avatarRenderer.createPetImage(param1, param2, _loc7_, AvatarScaleType.var_128, this);
                if (_loc8_ != null)
                {
                    _loc8_.setDirection(AvatarSetType.var_129, param4);
                    if (param5)
                    {
                        _loc6_ = _loc8_.getCroppedImage(AvatarSetType.var_129);
                    }
                    else
                    {
                        _loc6_ = _loc8_.getCroppedImage(AvatarSetType.var_130);
                    };
                    _loc8_.dispose();
                };
            }
            else
            {
                _loc9_ = 0;
                _loc10_ = this._roomEngine.getPetImage(param1, param2, new Vector3d((param4 * 45)), 64, this, _loc9_);
                if (_loc10_ != null)
                {
                    _loc6_ = _loc10_.data;
                };
            };
            if (_loc6_ == null)
            {
                _loc6_ = new BitmapData(30, 30, false, 4289374890);
            };
            return (_loc6_);
        }

        public function petImageReady(param1:String):void
        {
            this.update();
        }

        public function imageReady(param1:int, param2:BitmapData):void
        {
            param2.dispose();
            this.update();
        }

        private function addUnseenItemSymbols():void
        {
            var _loc3_:IWindowContainer;
            var _loc4_:IWindow;
            var _loc5_:String;
            var _loc6_:IWindow;
            var _loc1_:XmlAsset = (this._assetLibrary.getAssetByName("unseen_item_symbol_xml") as XmlAsset);
            var _loc2_:IWindow = this._windowManager.buildFromXML((_loc1_.content as XML));
            for each (_loc5_ in ["floor", "wall", "pets"])
            {
                _loc4_ = this._view.findChildByName(("tab_" + _loc5_));
                _loc3_ = (_loc2_.clone() as IWindowContainer);
                _loc6_ = _loc3_.findChildByName("text");
                if (_loc6_)
                {
                    _loc6_.caption = ((("$" + "{") + _loc6_.caption) + "}");
                };
                _loc3_.x = ((_loc4_.rectangle.right - _loc3_.width) - var_2082);
                _loc3_.y = (_loc4_.y + var_2082);
                _loc3_.tags.push(("unseen_symbol_" + _loc5_));
                _loc3_.visible = false;
                this._view.addChild(_loc3_);
            };
            _loc2_.dispose();
        }

        public function updateCategoryButtons():void
        {
            var _loc1_:IWindow;
            _loc1_ = this._view.findChildByTag("unseen_symbol_floor");
            _loc1_.visible = (this.var_2533.furniModel.getUnseenItemCount(UnseenItemCategoryEnum.var_1280) > 0);
            _loc1_ = this._view.findChildByTag("unseen_symbol_wall");
            _loc1_.visible = (this.var_2533.furniModel.getUnseenItemCount(UnseenItemCategoryEnum.var_1281) > 0);
            _loc1_ = this._view.findChildByTag("unseen_symbol_pets");
            _loc1_.visible = (this.var_2533.getUnseenItemCount() > 0);
        }


    }
}