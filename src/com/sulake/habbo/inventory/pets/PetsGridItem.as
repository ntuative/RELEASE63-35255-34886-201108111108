package com.sulake.habbo.inventory.pets
{
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class PetsGridItem 
    {

        private static const var_1295:int = 0xCCCCCC;
        private static const var_1294:int = 10275685;

        private var _petData:PetData;
        private var _window:IWindowContainer;
        private var var_2918:IWindow;
        private var var_4045:IWindow;
        private var _isSelected:Boolean;
        private var var_4098:PetsView;
        private var var_4099:Boolean;
        private var var_4046:Boolean;

        public function PetsGridItem(param1:PetsView, param2:PetData, param3:IHabboWindowManager, param4:IAssetLibrary, param5:IAvatarRenderManager, param6:Boolean)
        {
            if ((((((param1 == null) || (param2 == null)) || (param3 == null)) || (param4 == null)) || (param5 == null)))
            {
                return;
            };
            this.var_4098 = param1;
            this._petData = param2;
            this.var_4046 = param6;
            var _loc7_:XmlAsset = (param4.getAssetByName("inventory_thumb_xml") as XmlAsset);
            if (((_loc7_ == null) || (_loc7_.content == null)))
            {
                return;
            };
            this._window = (param3.buildFromXML((_loc7_.content as XML)) as IWindowContainer);
            this.var_2918 = this._window.findChildByTag("BG_COLOR");
            this.var_4045 = this._window.findChildByName("outline");
            var _loc8_:BitmapDataAsset = (param4.getAssetByName("thumb_selected_outline_png") as BitmapDataAsset);
            var _loc9_:IBitmapWrapperWindow = (this._window.findChildByName("outline") as IBitmapWrapperWindow);
            _loc9_.bitmap = (_loc8_.content as BitmapData);
            _loc9_.disposesBitmap = false;
            this._window.procedure = this.eventHandler;
            var _loc10_:BitmapData = param1.getPetImage(param2.type, param2.breed, param2.color, 3, false);
            var _loc11_:IBitmapWrapperWindow = (this._window.findChildByName("bitmap") as IBitmapWrapperWindow);
            var _loc12_:BitmapData = new BitmapData(_loc11_.width, _loc11_.height);
            _loc12_.fillRect(_loc12_.rect, 0);
            _loc12_.copyPixels(_loc10_, _loc10_.rect, new Point(((_loc12_.width / 2) - (_loc10_.width / 2)), ((_loc12_.height / 2) - (_loc10_.height / 2))));
            _loc11_.bitmap = _loc12_;
            this.setSelected(false);
        }

        private function eventHandler(param1:WindowEvent, param2:IWindow):void
        {
            switch (param1.type)
            {
                case WindowMouseEvent.var_650:
                    this.var_4098.setSelectedGridItem(this);
                    this.var_4099 = true;
                    return;
                case WindowMouseEvent.var_655:
                    this.var_4099 = false;
                    return;
                case WindowMouseEvent.var_624:
                    if (this.var_4099)
                    {
                        this.var_4099 = false;
                        this.var_4098.placePetToRoom(this._petData.id, true);
                    };
                    return;
            };
        }

        public function setSelected(param1:Boolean):void
        {
            this._isSelected = param1;
            if (((!(this._window)) || (!(this.var_2918))))
            {
                return;
            };
            this.var_2918.color = ((this.var_4046) ? var_1294 : var_1295);
            this.var_4045.visible = param1;
        }

        public function dispose():void
        {
            this.var_4098 = null;
            this._petData = null;
            this.var_2918 = null;
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
        }

        public function get window():IWindow
        {
            return (this._window);
        }

        public function get pet():PetData
        {
            return (this._petData);
        }


    }
}