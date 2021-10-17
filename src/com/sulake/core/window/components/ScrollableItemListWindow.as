package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.utils.IIterator;

    public class ScrollableItemListWindow extends WindowController implements IScrollableListWindow 
    {

        private var var_2697:IItemListWindow;
        private var var_2696:IScrollbarWindow;
        private var var_2698:Boolean = true;

        public function ScrollableItemListWindow(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function=null, param9:Array=null, param10:Array=null, param11:uint=0)
        {
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
            this._scrollBar.scrollable = this._itemList;
            if (this._scrollBar.testStateFlag(WindowState.var_1184))
            {
                this.hideScrollBar();
            };
        }

        override public function dispose():void
        {
            if (this.var_2696)
            {
                this.var_2696.removeEventListener(WindowEvent.var_584, this.scrollBarEventProc);
                this.var_2696.removeEventListener(WindowEvent.var_586, this.scrollBarEventProc);
                this.var_2696 = null;
            };
            if (this.var_2697)
            {
                this.var_2697 = null;
            };
            super.dispose();
        }

        protected function get _itemList():IItemListWindow
        {
            if (!this.var_2697)
            {
                this.var_2697 = (findChildByTag("_ITEMLIST") as IItemListWindow);
            };
            return (this.var_2697);
        }

        protected function get _scrollBar():IScrollbarWindow
        {
            if (!this.var_2696)
            {
                this.var_2696 = (findChildByTag("_SCROLLBAR") as IScrollbarWindow);
                if (this.var_2696)
                {
                    this.var_2696.addEventListener(WindowEvent.var_584, this.scrollBarEventProc);
                    this.var_2696.addEventListener(WindowEvent.var_586, this.scrollBarEventProc);
                };
            };
            return (this.var_2696);
        }

        private function scrollBarEventProc(param1:WindowEvent):void
        {
            if (param1.type == WindowEvent.var_584)
            {
                this.showScrollBar();
            }
            else
            {
                if (param1.type == WindowEvent.var_586)
                {
                    this.hideScrollBar();
                };
            };
        }

        private function hideScrollBar():void
        {
            if (this._scrollBar.visible)
            {
                this._scrollBar.visible = false;
                this._itemList.width = var_1202.width;
            };
        }

        private function showScrollBar():void
        {
            if (!this._scrollBar.visible)
            {
                this._scrollBar.visible = true;
                this._itemList.width = (var_1202.width - this._scrollBar.width);
            };
        }

        private function updateScrollBarVisibility():void
        {
            if (this.var_2698)
            {
                if (this._scrollBar.testStateFlag(WindowState.var_1184))
                {
                    if (this._scrollBar.visible)
                    {
                        this.hideScrollBar();
                    };
                };
            }
            else
            {
                if (this._scrollBar.visible)
                {
                    this.showScrollBar();
                };
            };
        }

        protected function isConstructionReady():Boolean
        {
            return ((this._itemList) && (this._scrollBar));
        }

        public function set autoHideScrollBar(param1:Boolean):void
        {
            this.var_2698 = param1;
            this.updateScrollBarVisibility();
        }

        public function get autoHideScrollBar():Boolean
        {
            return (this.var_2698);
        }

        public function get iterator():IIterator
        {
            return ((this.isConstructionReady()) ? this._itemList.iterator : null);
        }

        public function get scrollH():Number
        {
            return (this._itemList.scrollH);
        }

        public function get scrollV():Number
        {
            return (this._itemList.scrollV);
        }

        public function set scrollH(param1:Number):void
        {
            this._itemList.scrollH = param1;
        }

        public function set scrollV(param1:Number):void
        {
            this._itemList.scrollV = param1;
        }

        public function get maxScrollH():int
        {
            return (this._itemList.maxScrollH);
        }

        public function get maxScrollV():int
        {
            return (this._itemList.maxScrollV);
        }

        public function get visibleRegion():Rectangle
        {
            return (this._itemList.visibleRegion);
        }

        public function get scrollableRegion():Rectangle
        {
            return (this._itemList.scrollableRegion);
        }

        public function get scrollStepH():Number
        {
            return (this._itemList.scrollStepH);
        }

        public function get scrollStepV():Number
        {
            return (this._itemList.scrollStepV);
        }

        public function set scrollStepH(param1:Number):void
        {
            this._itemList.scrollStepH = param1;
        }

        public function set scrollStepV(param1:Number):void
        {
            this._itemList.scrollStepV = param1;
        }

        public function get spacing():int
        {
            return (this._itemList.spacing);
        }

        public function set spacing(param1:int):void
        {
            this._itemList.spacing = param1;
        }

        public function get scaleToFitItems():Boolean
        {
            return (this._itemList.scaleToFitItems);
        }

        public function set scaleToFitItems(param1:Boolean):void
        {
            this._itemList.scaleToFitItems = param1;
        }

        public function get autoArrangeItems():Boolean
        {
            return (this._itemList.autoArrangeItems);
        }

        public function set autoArrangeItems(param1:Boolean):void
        {
            this._itemList.autoArrangeItems = param1;
        }

        public function set resizeOnItemUpdate(param1:Boolean):void
        {
            this._itemList.resizeOnItemUpdate = param1;
        }

        public function get resizeOnItemUpdate():Boolean
        {
            return (this._itemList.resizeOnItemUpdate);
        }

        public function get numListItems():int
        {
            return (this._itemList.numListItems);
        }

        public function addListItem(param1:IWindow):IWindow
        {
            return (this._itemList.addListItem(param1));
        }

        public function addListItemAt(param1:IWindow, param2:uint):IWindow
        {
            return (this._itemList.addListItemAt(param1, param2));
        }

        public function getListItemAt(param1:uint):IWindow
        {
            return (this._itemList.getListItemAt(param1));
        }

        public function getListItemByID(param1:uint):IWindow
        {
            return (this._itemList.getListItemByID(param1));
        }

        public function getListItemByName(param1:String):IWindow
        {
            return (this._itemList.getListItemByName(param1));
        }

        public function getListItemByTag(param1:String):IWindow
        {
            return (this._itemList.getListItemByTag(param1));
        }

        public function getListItemIndex(param1:IWindow):int
        {
            return (this._itemList.getListItemIndex(param1));
        }

        public function removeListItem(param1:IWindow):IWindow
        {
            return (this._itemList.removeListItem(param1));
        }

        public function removeListItemAt(param1:int):IWindow
        {
            return (this._itemList.removeListItemAt(param1));
        }

        public function setListItemIndex(param1:IWindow, param2:int):void
        {
            this._itemList.setListItemIndex(param1, param2);
        }

        public function swapListItems(param1:IWindow, param2:IWindow):void
        {
            this._itemList.swapListItems(param1, param2);
        }

        public function swapListItemsAt(param1:int, param2:int):void
        {
            this._itemList.swapListItemsAt(param1, param2);
        }

        public function groupListItemsWithID(param1:uint, param2:Array, param3:Boolean=false):uint
        {
            return (this._itemList.groupListItemsWithID(param1, param2, param3));
        }

        public function groupListItemsWithTag(param1:String, param2:Array, param3:Boolean=false):uint
        {
            return (this._itemList.groupListItemsWithTag(param1, param2, param3));
        }

        public function removeListItems():void
        {
            this._itemList.removeListItems();
        }

        public function destroyListItems():void
        {
            this._itemList.destroyListItems();
        }

        public function arrangeListItems():void
        {
            this._itemList.arrangeListItems();
        }


    }
}