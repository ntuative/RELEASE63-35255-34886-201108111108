package com.sulake.habbo.ui.widget.chooser
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.ui.widget.events.ChooserItem;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindow;

    public class ChooserView 
    {

        private const var_2138:uint = 4293848814;
        private const var_2139:uint = 0;
        private const var_5227:uint = 4282169599;

        private var _widget:ChooserWidgetBase;
        private var _title:String;
        private var _window:IFrameWindow;
        private var _itemList:IItemListWindow;
        private var _items:Array;
        private var var_5225:Boolean;
        private var var_5226:int;

        public function ChooserView(param1:ChooserWidgetBase, param2:String)
        {
            this._widget = param1;
            this._title = param2;
        }

        public function dispose():void
        {
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
        }

        public function isOpen():Boolean
        {
            return ((!(this._window == null)) && (this._window.visible));
        }

        public function populate(param1:Array, param2:Boolean):void
        {
            var _loc4_:ChooserItem;
            var _loc5_:IWindowContainer;
            var _loc6_:int;
            var _loc7_:ITextWindow;
            if (this._widget == null)
            {
                return;
            };
            if (this._window == null)
            {
                this.createWindow();
            };
            if ((((this._window == null) || (this._itemList == null)) || (param1 == null)))
            {
                return;
            };
            this._itemList.destroyListItems();
            var _loc3_:XmlAsset = XmlAsset(this._widget.assets.getAssetByName("chooser_item"));
            if (_loc3_ == null)
            {
                return;
            };
            this._items = param1.slice();
            this.var_5225 = param2;
            _loc6_ = 0;
            while (_loc6_ < param1.length)
            {
                _loc4_ = (param1[_loc6_] as ChooserItem);
                if (_loc4_ != null)
                {
                    _loc5_ = (this._widget.windowManager.buildFromXML((_loc3_.content as XML)) as IWindowContainer);
                    if (_loc5_ == null)
                    {
                        return;
                    };
                    _loc7_ = (_loc5_.findChildByName("itemtext") as ITextWindow);
                    if (_loc7_ == null)
                    {
                        return;
                    };
                    _loc5_.id = _loc6_;
                    if (this.var_5225)
                    {
                        _loc7_.text = ((_loc4_.name + " id: ") + _loc4_.id);
                    }
                    else
                    {
                        _loc7_.text = _loc4_.name;
                    };
                    _loc5_.color = ((_loc6_ % 2) ? this.var_2139 : this.var_2138);
                    _loc5_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onListItemClicked);
                    this._itemList.addListItem(_loc5_);
                };
                _loc6_++;
            };
            _loc6_ = 0;
            while (_loc6_ < this._itemList.numListItems)
            {
                _loc5_ = (this._itemList.getListItemAt(_loc6_) as IWindowContainer);
                if (_loc5_ != null)
                {
                    _loc5_.width = this._itemList.width;
                };
                _loc6_++;
            };
            this.var_5226 = -1;
        }

        private function createWindow():void
        {
            var _loc1_:XmlAsset = XmlAsset(this._widget.assets.getAssetByName("chooser_view"));
            if (_loc1_ == null)
            {
                return;
            };
            this._window = (this._widget.windowManager.buildFromXML((_loc1_.content as XML)) as IFrameWindow);
            if (this._window == null)
            {
                return;
            };
            this._window.caption = this._title;
            this._itemList = (this._window.findChildByName("item_list") as IItemListWindow);
            var _loc2_:IWindow = this._window.findChildByTag("close");
            if (_loc2_ != null)
            {
                _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
            };
            if (this._window.parent != null)
            {
                this._window.x = (this._window.parent.width - this._window.width);
                this._window.y = 0;
            };
        }

        private function hideWindow():void
        {
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
        }

        private function onListItemClicked(param1:WindowMouseEvent):void
        {
            if ((((param1 == null) || (param1.window == null)) || (this._items == null)))
            {
                return;
            };
            var _loc2_:int = param1.window.id;
            if (((_loc2_ < 0) || (_loc2_ > this._items.length)))
            {
                return;
            };
            var _loc3_:ChooserItem = (this._items[_loc2_] as ChooserItem);
            if (_loc3_ == null)
            {
                return;
            };
            this._widget.choose(_loc3_.id, _loc3_.category);
            this.highlightItem(_loc2_);
        }

        private function highlightItem(param1:int):void
        {
            var _loc2_:IWindowContainer;
            if (((((this._itemList == null) || (param1 < 0)) || (param1 > this._itemList.numListItems)) || (param1 == this.var_5226)))
            {
                return;
            };
            if (this.var_5226 != -1)
            {
                _loc2_ = (this._itemList.getListItemAt(this.var_5226) as IWindowContainer);
                if (_loc2_ != null)
                {
                    _loc2_.color = ((this.var_5226 % 2) ? this.var_2139 : this.var_2138);
                };
            };
            _loc2_ = (this._itemList.getListItemAt(param1) as IWindowContainer);
            if (_loc2_ != null)
            {
                _loc2_.color = this.var_5227;
                this.var_5226 = param1;
            };
        }

        public function removeItem(param1:int, param2:int):void
        {
            var _loc3_:ChooserItem;
            if (((this._items == null) || (this._itemList == null)))
            {
                return;
            };
            var _loc4_:int;
            while (_loc4_ < this._items.length)
            {
                _loc3_ = (this._items[_loc4_] as ChooserItem);
                if (_loc3_ != null)
                {
                    if (((_loc3_.id == param1) && (_loc3_.category == param2)))
                    {
                        this._items.splice(_loc4_, 1);
                        break;
                    };
                };
                _loc4_++;
            };
            this.populate(this._items, this.var_5225);
        }

        private function onClose(param1:WindowMouseEvent):void
        {
            this.hideWindow();
        }


    }
}