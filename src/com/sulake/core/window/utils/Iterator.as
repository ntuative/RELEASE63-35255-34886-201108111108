package com.sulake.core.window.utils
{
    import flash.utils.Proxy;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITabButtonWindow;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.window.IWindow;
    import flash.utils.flash_proxy; 

    use namespace flash.utils.flash_proxy;

    public class Iterator extends Proxy implements IIterator 
    {

        private static const var_2784:uint = 0;
        private static const var_2785:uint = 1;
        private static const var_2786:uint = 2;
        private static const var_2787:uint = 3;
        private static const var_2788:uint = 4;
        private static const var_2789:uint = 5;

        private var var_2783:WindowController;
        private var _type:uint;

        public function Iterator(param1:WindowController)
        {
            this.var_2783 = param1;
            if ((this.var_2783 is ITabContextWindow))
            {
                this._type = Iterator.var_2789;
            }
            else
            {
                if ((this.var_2783 is IItemGridWindow))
                {
                    this._type = Iterator.var_2788;
                }
                else
                {
                    if ((this.var_2783 is IItemListWindow))
                    {
                        this._type = Iterator.var_2787;
                    }
                    else
                    {
                        if ((this.var_2783 is ISelectorWindow))
                        {
                            this._type = Iterator.var_2786;
                        }
                        else
                        {
                            if ((this.var_2783 is IWindowContainer))
                            {
                                this._type = Iterator.var_2785;
                            }
                            else
                            {
                                this._type = Iterator.var_2784;
                            };
                        };
                    };
                };
            };
        }

        public function get length():uint
        {
            switch (this._type)
            {
                case Iterator.var_2789:
                    return (ITabContextWindow(this.var_2783).numTabItems);
                case Iterator.var_2786:
                    return (ISelectorWindow(this.var_2783).numSelectables);
                case Iterator.var_2787:
                    return (IItemListWindow(this.var_2783).numListItems);
                case Iterator.var_2788:
                    return (IItemGridWindow(this.var_2783).numGridItems);
                case Iterator.var_2785:
                    return (IWindowContainer(this.var_2783).numChildren);
            };
            return (0);
        }

        public function indexOf(param1:*):int
        {
            switch (this._type)
            {
                case Iterator.var_2789:
                    return (ITabContextWindow(this.var_2783).getTabItemIndex(param1));
                case Iterator.var_2786:
                    return (ISelectorWindow(this.var_2783).getSelectableIndex(param1));
                case Iterator.var_2787:
                    return (IItemListWindow(this.var_2783).getListItemIndex(param1));
                case Iterator.var_2788:
                    return (IItemGridWindow(this.var_2783).getGridItemIndex(param1));
                case Iterator.var_2785:
                    return (IWindowContainer(this.var_2783).getChildIndex(param1));
            };
            return (-1);
        }

        override flash_proxy function getProperty(param1:*):*
        {
            switch (this._type)
            {
                case Iterator.var_2789:
                    return (ITabContextWindow(this.var_2783).getTabItemAt(uint(param1)));
                case Iterator.var_2786:
                    return (this.var_2783.getChildAt(uint(param1)));
                case Iterator.var_2787:
                    return (IItemListWindow(this.var_2783).getListItemAt(uint(param1)));
                case Iterator.var_2788:
                    return (IItemGridWindow(this.var_2783).getGridItemAt(uint(param1)));
                case Iterator.var_2785:
                    return (IWindowContainer(this.var_2783).getChildAt(uint(param1)));
            };
            return (null);
        }

        override flash_proxy function setProperty(param1:*, param2:*):void
        {
            var _loc3_:ITabButtonWindow;
            var _loc4_:ITabContextWindow;
            var _loc5_:ISelectableWindow;
            var _loc6_:ISelectorWindow;
            var _loc7_:IItemListWindow;
            var _loc8_:IWindow;
            var _loc9_:IItemGridWindow;
            var _loc10_:IWindow;
            var _loc11_:IWindowContainer;
            var _loc12_:IWindow;
            switch (this._type)
            {
                case Iterator.var_2789:
                    _loc3_ = (param2 as ITabButtonWindow);
                    _loc4_ = (this.var_2783 as ITabContextWindow);
                    if (_loc4_.getTabItemIndex(_loc3_) > -1)
                    {
                        _loc4_.removeTabItem(_loc3_);
                    };
                    _loc4_.addTabItemAt(_loc3_, uint(param1));
                    return;
                case Iterator.var_2786:
                    _loc5_ = (param2 as ISelectableWindow);
                    _loc6_ = (this.var_2783 as ISelectorWindow);
                    if (_loc5_)
                    {
                        if (_loc6_.getSelectableIndex(_loc5_) > -1)
                        {
                            _loc6_.removeSelectable(_loc5_);
                        };
                        _loc6_.addSelectableAt(_loc5_, uint(param1));
                    }
                    else
                    {
                        this.var_2783.addChildAt(param2, uint(param1));
                    };
                    return;
                case Iterator.var_2787:
                    _loc7_ = (this.var_2783 as IItemListWindow);
                    _loc8_ = (param2 as IWindow);
                    if (_loc7_.getListItemIndex(_loc8_) > -1)
                    {
                        _loc7_.removeListItem(_loc8_);
                    };
                    _loc7_.addListItemAt(_loc8_, uint(param1));
                    return;
                case Iterator.var_2788:
                    _loc9_ = (this.var_2783 as IItemGridWindow);
                    _loc10_ = (param2 as IWindow);
                    if (_loc9_.getGridItemIndex(_loc10_) > -1)
                    {
                        _loc9_.removeGridItem(_loc10_);
                    };
                    _loc9_.addGridItemAt(_loc10_, uint(param1));
                    return;
                case Iterator.var_2785:
                    _loc11_ = (this.var_2783 as IWindowContainer);
                    _loc12_ = (param2 as IWindow);
                    if (_loc11_.getChildIndex(_loc12_) > -1)
                    {
                        _loc11_.removeChild(_loc12_);
                    };
                    _loc11_.addChildAt(_loc12_, uint(param1));
                    return;
            };
        }

        override flash_proxy function nextNameIndex(param1:int):int
        {
            var _loc2_:uint;
            switch (this._type)
            {
                case Iterator.var_2789:
                    _loc2_ = ITabContextWindow(this.var_2783).numTabItems;
                    break;
                case Iterator.var_2786:
                    _loc2_ = ISelectorWindow(this.var_2783).numSelectables;
                    break;
                case Iterator.var_2787:
                    _loc2_ = IItemListWindow(this.var_2783).numListItems;
                    break;
                case Iterator.var_2788:
                    _loc2_ = IItemGridWindow(this.var_2783).numGridItems;
                    break;
                case Iterator.var_2785:
                    _loc2_ = IWindowContainer(this.var_2783).numChildren;
                    break;
            };
            if (param1 < _loc2_)
            {
                return (param1 + 1);
            };
            return (0);
        }

        override flash_proxy function nextValue(param1:int):*
        {
            switch (this._type)
            {
                case Iterator.var_2789:
                    return (ITabContextWindow(this.var_2783).getTabItemAt((uint(param1) - 1)));
                case Iterator.var_2786:
                    return (ISelectorWindow(this.var_2783).getSelectableAt((uint(param1) - 1)));
                case Iterator.var_2787:
                    return (IItemListWindow(this.var_2783).getListItemAt((uint(param1) - 1)));
                case Iterator.var_2788:
                    return (IItemGridWindow(this.var_2783).getGridItemAt((uint(param1) - 1)));
                case Iterator.var_2785:
                    return (IWindowContainer(this.var_2783).getChildAt((uint(param1) - 1)));
            };
            return (null);
        }


    }
}