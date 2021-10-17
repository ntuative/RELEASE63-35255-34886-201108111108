package com.sulake.core.window.components
{
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.enum.WindowStyle;
    import com.sulake.core.window.enum.WindowParam;

    public class ItemGridController extends ItemListController implements IItemGridWindow 
    {

        public function ItemGridController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function=null, param9:Array=null, param10:Array=null, param11:uint=0)
        {
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
            _horizontal = (!(param2 == WindowType.var_894));
            var_2679 = true;
            if (!_horizontal)
            {
                throw (new Error("Horizontal item grid not yet implemented!"));
            };
        }

        override public function set spacing(param1:int):void
        {
            var _loc2_:uint = numListItems;
            while (_loc2_-- > 0)
            {
                IItemListWindow(getListItemAt(_loc2_)).spacing = param1;
            };
            super.spacing = param1;
        }

        override public function set background(param1:Boolean):void
        {
            super.background = param1;
            var _loc2_:uint;
            while (_loc2_ < numListItems)
            {
                getListItemAt(_loc2_).background = param1;
                _loc2_++;
            };
        }

        override public function set color(param1:uint):void
        {
            super.color = param1;
            var _loc2_:uint;
            while (_loc2_ < numListItems)
            {
                getListItemAt(_loc2_).color = param1;
                _loc2_++;
            };
        }

        override public function set autoArrangeItems(param1:Boolean):void
        {
            super.autoArrangeItems = param1;
            var _loc2_:int;
            while (_loc2_ < this.numColumns)
            {
                IItemListWindow(getListItemAt(_loc2_)).autoArrangeItems = param1;
                _loc2_++;
            };
        }

        override public function get scrollStepH():Number
        {
            if (var_2076 >= 0)
            {
                return (var_2076);
            };
            return ((_horizontal) ? (0.1 * scrollableRegion.height) : (scrollableRegion.width / this.numColumns));
        }

        override public function get scrollStepV():Number
        {
            if (var_2077 >= 0)
            {
                return (var_2077);
            };
            return ((_horizontal) ? (scrollableRegion.height / this.numRows) : (0.1 * scrollableRegion.width));
        }

        override public function update(param1:WindowController, param2:WindowEvent):Boolean
        {
            var _loc3_:Boolean = super.update(param1, param2);
            switch (param2.type)
            {
                case WindowEvent.var_589:
                    this.rebuildGridStructure();
                    break;
                case WindowMouseEvent.var_657:
                    if (_horizontal)
                    {
                        scrollV = (scrollV - (WindowMouseEvent(param2).delta * 0.01));
                    }
                    else
                    {
                        scrollH = (scrollH - (WindowMouseEvent(param2).delta * 0.01));
                    };
                    _loc3_ = true;
                    break;
            };
            return (_loc3_);
        }

        public function get numGridItems():uint
        {
            var _loc1_:uint = numListItems;
            var _loc2_:uint;
            while (_loc1_-- > 0)
            {
                _loc2_ = (_loc2_ + IItemListWindow(getListItemAt(_loc1_)).numListItems);
            };
            return (_loc2_);
        }

        public function get numColumns():uint
        {
            return (numListItems);
        }

        public function get numRows():uint
        {
            var _loc1_:uint;
            var _loc2_:uint = this.numColumns;
            var _loc3_:uint;
            while (_loc3_ < _loc2_)
            {
                _loc1_ = Math.max(_loc1_, IItemListWindow(getListItemAt(_loc3_)).numListItems);
                _loc3_++;
            };
            return (_loc1_);
        }

        public function addGridItem(param1:IWindow):IWindow
        {
            var _loc2_:IItemListWindow = this.resolveColumnForNextItem(param1);
            return (param1);
        }

        public function addGridItemAt(param1:IWindow, param2:uint):IWindow
        {
            this.offsetGridItemsForwards(param1, Math.min(this.numGridItems, param2));
            return (param1);
        }

        public function getGridItemAt(param1:uint):IWindow
        {
            var _loc2_:IItemListWindow = this.resolveColumnByIndex(param1);
            if (_loc2_ == null)
            {
                return (null);
            };
            return (_loc2_.getListItemAt((param1 / this.numColumns)));
        }

        public function getGridItemByID(param1:uint):IWindow
        {
            var _loc3_:IItemListWindow;
            var _loc4_:IWindow;
            var _loc5_:uint;
            var _loc2_:uint = this.numColumns;
            _loc5_ = 0;
            while (_loc5_ < _loc2_)
            {
                _loc3_ = (getChildAt(_loc5_) as IItemListWindow);
                _loc4_ = _loc3_.getListItemByID(param1);
                if (_loc4_)
                {
                    return (_loc4_);
                };
                _loc5_++;
            };
            return (null);
        }

        public function getGridItemByName(param1:String):IWindow
        {
            var _loc3_:IItemListWindow;
            var _loc4_:IWindow;
            var _loc5_:uint;
            var _loc2_:uint = this.numColumns;
            _loc5_ = 0;
            while (_loc5_ < _loc2_)
            {
                _loc3_ = (getChildAt(_loc5_) as IItemListWindow);
                _loc4_ = _loc3_.getListItemByName(param1);
                if (_loc4_)
                {
                    return (_loc4_);
                };
                _loc5_++;
            };
            return (null);
        }

        public function getGridItemByTag(param1:String):IWindow
        {
            var _loc3_:IItemListWindow;
            var _loc4_:IWindow;
            var _loc5_:uint;
            var _loc2_:uint = this.numColumns;
            _loc5_ = 0;
            while (_loc5_ < _loc2_)
            {
                _loc3_ = (getChildAt(_loc5_) as IItemListWindow);
                _loc4_ = _loc3_.getListItemByTag(param1);
                if (_loc4_)
                {
                    return (_loc4_);
                };
                _loc5_++;
            };
            return (null);
        }

        public function getGridItemIndex(param1:IWindow):int
        {
            var _loc2_:IItemListWindow = this.resolveColumnByItem(param1);
            if (_loc2_ == null)
            {
                return (-1);
            };
            return ((_loc2_.getListItemIndex(param1) * this.numColumns) + this.getColumnIndex(_loc2_));
        }

        public function removeGridItem(param1:IWindow):IWindow
        {
            var _loc2_:int = this.getGridItemIndex(param1);
            if (_loc2_ == -1)
            {
                return (null);
            };
            if (this.offsetGridItemsBackwards(_loc2_) != param1)
            {
                throw (new Error("Item grid is out of order!"));
            };
            var _loc3_:IItemListWindow = this.resolveColumnByIndex(_loc2_);
            if (!_horizontal)
            {
                _loc3_.width = _loc3_.scrollableRegion.width;
            }
            else
            {
                _loc3_.height = _loc3_.scrollableRegion.height;
            };
            return (param1);
        }

        public function removeGridItemAt(param1:int):IWindow
        {
            return (this.removeGridItem(this.getGridItemAt(param1)));
        }

        public function setGridItemIndex(param1:IWindow, param2:int):void
        {
            if (this.removeGridItem(param1) == null)
            {
                throw (new Error("Item not found in grid!"));
            };
            addListItemAt(param1, param2);
        }

        public function swapGridItems(param1:IWindow, param2:IWindow):void
        {
            throw (new Error("ItemGridWindow / Unimplemented method!"));
        }

        public function swapGridItemsAt(param1:int, param2:int):void
        {
            this.swapGridItems(this.getGridItemAt(param1), this.getGridItemAt(param2));
        }

        public function removeGridItems():void
        {
            var _loc2_:IItemListWindow;
            var _loc1_:uint = this.numColumns;
            var _loc3_:uint;
            while (_loc3_ < _loc1_)
            {
                _loc2_ = IItemListWindow(getListItemAt(_loc3_));
                _loc2_.removeListItems();
                if (!_horizontal)
                {
                    _loc2_.width = 0;
                }
                else
                {
                    _loc2_.height = 0;
                };
                _loc3_++;
            };
        }

        public function destroyGridItems():void
        {
            var _loc2_:IItemListWindow;
            var _loc1_:uint = this.numColumns;
            var _loc3_:uint;
            while (_loc3_ < _loc1_)
            {
                _loc2_ = IItemListWindow(getListItemAt(_loc3_));
                _loc2_.destroyListItems();
                if (!_horizontal)
                {
                    _loc2_.width = 0;
                }
                else
                {
                    _loc2_.height = 0;
                };
                _loc3_++;
            };
        }

        protected function listEventProc(param1:WindowEvent, param2:IWindow):void
        {
        }

        protected function listItemEventHandler(param1:WindowEvent):void
        {
            var _loc2_:IWindow;
            if (param1.type == WindowEvent.var_562)
            {
                _loc2_ = (param1.target as IWindow);
                this.removeGridItem(_loc2_);
            };
        }

        protected function getColumnIndex(param1:IItemListWindow):int
        {
            return (getListItemIndex(param1));
        }

        protected function resolveColumnByIndex(param1:uint):IItemListWindow
        {
            return (getListItemAt((param1 % this.numColumns)) as IItemListWindow);
        }

        public function getColumnNumberByItemIndex(param1:uint):uint
        {
            return (param1 % this.numColumns);
        }

        public function getRowNumberByItemIndex(param1:uint):uint
        {
            return (param1 / this.numColumns);
        }

        protected function resolveColumnByItem(param1:IWindow):IItemListWindow
        {
            var _loc3_:IItemListWindow;
            var _loc2_:uint = this.numColumns;
            while (_loc2_-- > 0)
            {
                _loc3_ = IItemListWindow(getListItemAt(_loc2_));
                if (_loc3_.getListItemIndex(param1) > -1)
                {
                    return (_loc3_);
                };
            };
            return (null);
        }

        protected function resolveColumnForNextItem(param1:IWindow):IItemListWindow
        {
            var _loc3_:IItemListWindow;
            var _loc4_:IItemListWindow;
            var _loc5_:int;
            var _loc6_:Boolean;
            if (this.numColumns == 0)
            {
                return (this.addColumnForItem(param1));
            };
            var _loc2_:uint = this.numGridItems;
            if (_loc2_ > 0)
            {
                _loc4_ = this.resolveColumnByIndex(((_loc2_ > 0) ? (_loc2_ - 1) : 0));
                _loc5_ = getListItemIndex(_loc4_);
                _loc6_ = ((_loc5_ > -1) ? (_loc5_ == (this.numColumns - 1)) : true);
                if (_loc6_)
                {
                    if (_loc4_.numListItems == 1)
                    {
                        if ((_loc4_.rectangle.right + param1.width) <= var_1202.width)
                        {
                            return (this.addColumnForItem(param1));
                        };
                    };
                };
                _loc3_ = (getListItemAt(((_loc6_) ? 0 : (_loc5_ + 1))) as IItemListWindow);
            }
            else
            {
                _loc3_ = (getListItemAt(0) as IItemListWindow);
            };
            _loc3_.addListItem(param1);
            if (param1.width > _loc3_.width)
            {
                _loc3_.width = param1.width;
            };
            if (param1.rectangle.bottom > _loc3_.height)
            {
                _loc3_.height = param1.rectangle.bottom;
            };
            return (_loc3_);
        }

        protected function addColumnForItem(param1:IWindow):IItemListWindow
        {
            var _loc2_:IItemListWindow = (_context.create(((_name + "_COLUMN_") + numListItems), null, WindowType.var_892, WindowStyle.var_1192, (WindowParam.var_713 | WindowParam.var_714), new Rectangle(0, 0, Math.max(param1.width, 0), Math.max(param1.height, 0)), this.listEventProc, null, numListItems, null, [WindowController.TAG_INTERNAL, WindowController.TAG_EXCLUDE]) as IItemListWindow);
            _loc2_.background = background;
            _loc2_.color = color;
            _loc2_.spacing = _spacing;
            addListItem(_loc2_);
            _loc2_.addListItem(param1);
            return (_loc2_);
        }

        protected function removeColumnAt(param1:uint):void
        {
            var _loc2_:IItemListWindow = (removeChildAt(param1) as IItemListWindow);
            if (_loc2_)
            {
                _loc2_.dispose();
            };
        }

        protected function offsetGridItemsForwards(param1:IWindow, param2:uint):void
        {
            var _loc5_:IItemListWindow;
            var _loc7_:IWindow;
            var _loc8_:uint;
            var _loc3_:uint = this.numGridItems;
            var _loc4_:int = (_loc3_ - 1);
            var _loc6_:uint = this.numColumns;
            var _loc9_:int;
            while (_loc9_ < _loc6_)
            {
                IItemListWindow(getListItemAt(_loc9_)).autoArrangeItems = false;
                _loc9_++;
            };
            if (_loc3_ <= param2)
            {
                this.resolveColumnForNextItem(param1);
            }
            else
            {
                if (this.numRows == 1)
                {
                    _loc7_ = this.getGridItemAt(_loc4_);
                    _loc5_ = this.resolveColumnForNextItem(_loc7_);
                    _loc4_--;
                };
                while (_loc4_ >= param2)
                {
                    _loc7_ = this.getGridItemAt(_loc4_);
                    _loc8_ = this.getRowNumberByItemIndex((_loc4_ + 1));
                    _loc5_ = this.resolveColumnByIndex((_loc4_ + 1));
                    _loc5_.addListItemAt(_loc7_, _loc8_);
                    _loc4_--;
                };
                this.resolveColumnByIndex(param2).addListItemAt(param1, (param2 / this.numColumns));
            };
            var _loc10_:uint;
            _loc9_ = 0;
            while (_loc9_ < _loc6_)
            {
                _loc5_ = IItemListWindow(getListItemAt(_loc9_));
                _loc5_.autoArrangeItems = true;
                _loc5_.height = _loc5_.scrollableRegion.height;
                _loc10_ = Math.max(_loc10_, _loc5_.height);
                _loc9_++;
            };
            _container.height = _loc10_;
        }

        protected function offsetGridItemsBackwards(param1:uint):IWindow
        {
            var _loc7_:IWindow;
            var _loc2_:uint = this.getRowNumberByItemIndex(param1);
            var _loc3_:IItemListWindow = this.resolveColumnByIndex(param1);
            var _loc4_:IWindow = _loc3_.removeListItemAt(_loc2_);
            var _loc5_:uint = this.numGridItems;
            var _loc6_:uint = param1;
            if (_loc4_ == null)
            {
                return (null);
            };
            var _loc8_:int;
            while (_loc8_ < this.numColumns)
            {
                IItemListWindow(getListItemAt(_loc8_)).autoArrangeItems = false;
                _loc8_++;
            };
            while (_loc6_ < _loc5_)
            {
                _loc2_ = this.getRowNumberByItemIndex(_loc6_);
                _loc7_ = this.getGridItemAt((_loc6_ + 1));
                _loc3_ = this.resolveColumnByIndex(_loc6_);
                _loc3_.addListItemAt(_loc7_, _loc2_);
                _loc6_++;
            };
            var _loc9_:uint;
            _loc8_ = 0;
            while (_loc8_ < this.numColumns)
            {
                _loc3_ = IItemListWindow(getListItemAt(_loc8_));
                _loc3_.autoArrangeItems = true;
                _loc3_.height = _loc3_.scrollableRegion.height;
                _loc9_ = Math.max(_loc9_, _loc3_.height);
                _loc8_++;
            };
            _container.height = _loc9_;
            return (_loc4_);
        }

        protected function rebuildGridStructure():void
        {
            var _loc4_:IItemListWindow;
            var _loc5_:IWindow;
            var _loc6_:int;
            var _loc1_:int = this.numGridItems;
            var _loc2_:Array = new Array();
            var _loc3_:int = this.numColumns;
            while (_loc1_ > 0)
            {
                _loc6_ = 0;
                while (_loc6_ < _loc3_)
                {
                    _loc4_ = (getListItemAt(_loc6_) as IItemListWindow);
                    _loc5_ = _loc4_.removeListItemAt(0);
                    _loc2_.push(_loc5_);
                    if (--_loc1_ < 1) break;
                    _loc6_++;
                };
            };
            destroyListItems();
            for each (_loc5_ in _loc2_)
            {
                this.addGridItem(_loc5_);
            };
        }


    }
}