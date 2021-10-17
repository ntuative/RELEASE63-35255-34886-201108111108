package com.sulake.habbo.avatar.common
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class AvatarEditorGridView 
    {

        private const each:int = 2;

        private var _windowManager:IHabboWindowManager;
        private var _assetLibrary:IAssetLibrary;
        private var _view:IWindowContainer;
        private var var_2929:Boolean = true;
        private var var_2533:IAvatarEditorCategoryModel;
        private var var_2930:String;
        private var var_2931:IItemGridWindow;
        private var var_2928:Array;

        public function AvatarEditorGridView(param1:IAvatarEditorCategoryModel, param2:String, param3:IHabboWindowManager, param4:IAssetLibrary)
        {
            this.var_2533 = param1;
            this.var_2930 = param2;
            this._assetLibrary = param4;
            this._windowManager = param3;
            var _loc5_:XmlAsset = (this._assetLibrary.getAssetByName("AvatarEditorGrid") as XmlAsset);
            this._view = IWindowContainer(this._windowManager.buildFromXML((_loc5_.content as XML)));
            if (this._view != null)
            {
                this.var_2931 = (this._view.findChildByName("part_thumbs") as IItemGridWindow);
                this.var_2928 = new Array();
                this.var_2928.push((this._view.findChildByName("palette0") as IItemGridWindow));
                this.var_2928.push((this._view.findChildByName("palette1") as IItemGridWindow));
            };
        }

        public function dispose():void
        {
            var _loc1_:IItemGridWindow;
            if (this.var_2931)
            {
                this.var_2931.dispose();
                this.var_2931 = null;
            };
            if (this.var_2928)
            {
                for each (_loc1_ in this.var_2928)
                {
                    if (_loc1_ != null)
                    {
                        _loc1_.dispose();
                        _loc1_ = null;
                    };
                };
                this.var_2928 = null;
            };
            this.var_2533 = null;
            if (this._view)
            {
                this._view.dispose();
                this._view = null;
            };
            this._windowManager = null;
            this._assetLibrary = null;
        }

        public function get window():IWindowContainer
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

        public function initFromList():void
        {
            var _loc2_:AvatarEditorGridPartItem;
            var _loc3_:int;
            var _loc4_:Array;
            var _loc5_:IItemGridWindow;
            var _loc6_:AvatarEditorGridColorItem;
            var _loc1_:CategoryData = this.var_2533.getCategoryData(this.var_2930);
            if (!_loc1_)
            {
                return;
            };
            this.var_2931.removeGridItems();
            for each (_loc2_ in _loc1_.parts)
            {
                if (_loc2_)
                {
                    this.var_2931.addGridItem(_loc2_.view);
                    _loc2_.view.procedure = this.partEventProc;
                    if (_loc2_.isSelected)
                    {
                        this.showPalettes(_loc2_.colorLayerCount);
                    };
                };
            };
            _loc3_ = 0;
            while (_loc3_ < this.each)
            {
                _loc4_ = _loc1_.getPalette(_loc3_);
                _loc5_ = (this.var_2928[_loc3_] as IItemGridWindow);
                if (!((!(_loc4_)) || (!(_loc5_))))
                {
                    for each (_loc6_ in _loc4_)
                    {
                        _loc5_.addGridItem(_loc6_.view);
                        _loc6_.view.procedure = this.paletteEventProc;
                    };
                };
                _loc3_++;
            };
            this.var_2929 = false;
        }

        public function showPalettes(param1:int):void
        {
            var _loc2_:IWindowContainer = (this._view.findChildByName("palette_container0") as IWindowContainer);
            var _loc3_:IWindowContainer = (this._view.findChildByName("palette_container1") as IWindowContainer);
            if (((!(_loc2_)) || (!(_loc3_))))
            {
                return;
            };
            var _loc4_:ITextWindow = (this._view.findChildByName("palette_desc_0") as ITextWindow);
            var _loc5_:ITextWindow = (this._view.findChildByName("palette_desc_1") as ITextWindow);
            if (((!(_loc4_)) || (!(_loc5_))))
            {
                return;
            };
            var _loc6_:* = 318;
            var _loc7_:* = 156;
            if (param1 <= 1)
            {
                _loc2_.width = _loc6_;
                _loc3_.visible = false;
                _loc4_.visible = false;
                _loc5_.visible = false;
            }
            else
            {
                _loc2_.width = _loc7_;
                _loc3_.width = _loc7_;
                _loc3_.visible = true;
                _loc4_.visible = true;
                _loc5_.visible = true;
            };
        }

        public function get firstView():Boolean
        {
            return (this.var_2929);
        }

        public function updatePart(param1:int, param2:IWindowContainer):void
        {
            var _loc3_:IWindow = this.var_2931.getGridItemAt(param1);
            if (!_loc3_)
            {
                return;
            };
            _loc3_ = param2;
        }

        private function partEventProc(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:int;
            if (param1.type == WindowMouseEvent.var_650)
            {
                _loc3_ = this.var_2931.getGridItemIndex(param1.window);
                this.var_2533.var_2932(this.var_2930, _loc3_);
            };
        }

        private function paletteEventProc(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:int;
            var _loc4_:IItemGridWindow;
            var _loc5_:int;
            var _loc6_:IWindow;
            var _loc7_:int;
            if (param1.type == WindowMouseEvent.var_650)
            {
                _loc6_ = param1.window;
                _loc7_ = 0;
                while (_loc7_ < this.each)
                {
                    if (this.var_2928.length > _loc7_)
                    {
                        _loc4_ = (this.var_2928[_loc7_] as IItemGridWindow);
                        _loc5_ = _loc4_.getGridItemIndex(_loc6_);
                        if (_loc5_ > -1)
                        {
                            this.var_2533.selectColor(this.var_2930, _loc5_, _loc7_);
                            return;
                        };
                    };
                    _loc7_++;
                };
            };
        }


    }
}