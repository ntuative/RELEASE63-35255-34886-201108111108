package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.utils.IInputProcessorRoot;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.enum.WindowStyle;
    import flash.geom.Rectangle;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.WindowContext;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.graphics.WindowRedrawFlag;
    import com.sulake.core.window.utils.Iterator;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.utils.PropertyDefaults;
    import com.sulake.core.window.utils.PropertyStruct;

    public class ItemListController extends WindowController implements IItemListWindow, IInputProcessorRoot 
    {

        protected var var_2681:Number = 0;
        protected var var_2682:Number = 0;
        protected var var_2683:Number = 0;
        protected var var_2684:Number = 0;
        protected var _container:IWindowContainer;
        protected var var_2686:Boolean = false;
        protected var var_2687:Boolean = false;
        protected var _spacing:int = 0;
        protected var _horizontal:Boolean = false;
        protected var var_2076:Number = -1;
        protected var var_2077:Number = -1;
        protected var var_2685:Boolean = true;
        protected var var_2679:Boolean = false;
        protected var var_2680:Boolean = false;
        protected var var_2688:int = 0;
        protected var var_2689:int = 0;
        protected var var_2690:Number;
        protected var var_2691:Number;
        protected var var_2692:Boolean = false;

        public function ItemListController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function=null, param9:Array=null, param10:Array=null, param11:uint=0)
        {
            this._horizontal = (param2 == WindowType.var_891);
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
            var_2666 = ((var_1200) || (!(testParamFlag(WindowParam.var_713))));
            this._container = (_context.create("_CONTAINER", "", WindowType.var_910, WindowStyle.var_1192, ((WindowParam.var_713 | WindowParam.var_719) | WindowParam.var_714), new Rectangle(0, 0, width, height), null, this, 0, null, [TAG_INTERNAL, TAG_EXCLUDE]) as IWindowContainer);
            this._container.addEventListener(WindowEvent.var_589, this.containerEventHandler);
            this._container.addEventListener(WindowEvent.var_597, this.containerEventHandler);
            this._container.addEventListener(WindowEvent.var_599, this.containerEventHandler);
            this._container.addEventListener(WindowEvent.var_598, this.containerEventHandler);
            this._container.clipping = clipping;
            this.resizeOnItemUpdate = this.var_2680;
        }

        public function get spacing():int
        {
            return (this._spacing);
        }

        public function set spacing(param1:int):void
        {
            if (param1 != this._spacing)
            {
                this._spacing = param1;
                this.updateScrollAreaRegion();
            };
        }

        public function get scrollH():Number
        {
            return (this.var_2681);
        }

        public function get scrollV():Number
        {
            return (this.var_2682);
        }

        public function get maxScrollH():int
        {
            return (Math.max(0, (this.var_2683 - width)));
        }

        public function get maxScrollV():int
        {
            return (Math.max(0, (this.var_2684 - height)));
        }

        public function get visibleRegion():Rectangle
        {
            return (new Rectangle((this.var_2681 * this.maxScrollH), (this.var_2682 * this.maxScrollV), width, height));
        }

        public function get scrollableRegion():Rectangle
        {
            return (this._container.rectangle.clone());
        }

        public function set scrollH(param1:Number):void
        {
            var _loc2_:WindowEvent;
            if (param1 < 0)
            {
                param1 = 0;
            };
            if (param1 > 1)
            {
                param1 = 1;
            };
            if (param1 != this.var_2681)
            {
                this.var_2681 = param1;
                this._container.x = (-(this.var_2681) * this.maxScrollH);
                _context.invalidate(this._container, this.visibleRegion, WindowRedrawFlag.var_1194);
                if (_events)
                {
                    _loc2_ = WindowEvent.allocate(WindowEvent.var_607, this, null);
                    _events.dispatchEvent(_loc2_);
                    _loc2_.recycle();
                };
            };
        }

        public function set scrollV(param1:Number):void
        {
            var _loc2_:WindowEvent;
            if (param1 < 0)
            {
                param1 = 0;
            };
            if (param1 > 1)
            {
                param1 = 1;
            };
            if (param1 != this.var_2682)
            {
                this.var_2682 = param1;
                this._container.y = (-(this.var_2682) * this.maxScrollV);
                if (_events)
                {
                    _loc2_ = WindowEvent.allocate(WindowEvent.var_607, this, null);
                    _events.dispatchEvent(_loc2_);
                    _loc2_.recycle();
                };
            };
        }

        public function get scrollStepH():Number
        {
            if (this.var_2076 >= 0)
            {
                return (this.var_2076);
            };
            return ((this._horizontal) ? (this._container.width / this.numListItems) : (0.1 * this._container.width));
        }

        public function get scrollStepV():Number
        {
            if (this.var_2077 >= 0)
            {
                return (this.var_2077);
            };
            return ((this._horizontal) ? (0.1 * this._container.height) : (this._container.height / this.numListItems));
        }

        public function set scrollStepH(param1:Number):void
        {
            this.var_2076 = param1;
        }

        public function set scrollStepV(param1:Number):void
        {
            this.var_2077 = param1;
        }

        public function set scaleToFitItems(param1:Boolean):void
        {
            if (this.var_2679 != param1)
            {
                this.var_2679 = param1;
                this.updateScrollAreaRegion();
            };
        }

        public function get scaleToFitItems():Boolean
        {
            return (this.var_2679);
        }

        public function set autoArrangeItems(param1:Boolean):void
        {
            this.var_2685 = param1;
            this.updateScrollAreaRegion();
        }

        public function get autoArrangeItems():Boolean
        {
            return (this.var_2685);
        }

        public function set resizeOnItemUpdate(param1:Boolean):void
        {
            this.var_2680 = param1;
            if (this._container)
            {
                if (this._horizontal)
                {
                    this._container.setParamFlag(WindowParam.var_709, param1);
                }
                else
                {
                    this._container.setParamFlag(WindowParam.var_710, param1);
                };
            };
        }

        public function get resizeOnItemUpdate():Boolean
        {
            return (this.var_2680);
        }

        public function get iterator():IIterator
        {
            return (new Iterator(this));
        }

        public function get firstListItem():IWindow
        {
            return ((this.numListItems > 0) ? this.getListItemAt(0) : null);
        }

        public function get lastListItem():IWindow
        {
            return ((this.numListItems > 0) ? this.getListItemAt((this.numListItems - 1)) : null);
        }

        override public function set clipping(param1:Boolean):void
        {
            super.clipping = param1;
            if (this._container)
            {
                this._container.clipping = param1;
            };
        }

        override public function dispose():void
        {
            if (!_disposed)
            {
                if (this.var_2692)
                {
                    try
                    {
                        _context.getWindowServices().getGestureAgentService().end(this);
                    }
                    catch(e:Error)
                    {
                    };
                };
                this._container.removeEventListener(WindowEvent.var_589, this.containerEventHandler);
                this._container.removeEventListener(WindowEvent.var_597, this.containerEventHandler);
                this._container.removeEventListener(WindowEvent.var_599, this.containerEventHandler);
                this._container.removeEventListener(WindowEvent.var_598, this.containerEventHandler);
                super.dispose();
            };
        }

        override protected function cloneChildWindows(param1:WindowController):void
        {
            var _loc2_:int;
            while (_loc2_ < this.numListItems)
            {
                IItemListWindow(param1).addListItem(this.getListItemAt(_loc2_).clone());
                _loc2_++;
            };
        }

        public function get numListItems():int
        {
            return ((this._container != null) ? this._container.numChildren : 0);
        }

        public function addListItem(param1:IWindow):IWindow
        {
            this.var_2687 = true;
            if (this._horizontal)
            {
                param1.x = (this.var_2683 + ((this.numListItems > 0) ? this._spacing : 0));
                this.var_2683 = param1.rectangle.right;
                this._container.width = this.var_2683;
            }
            else
            {
                if (this.autoArrangeItems)
                {
                    param1.y = (this.var_2684 + ((this.numListItems > 0) ? this._spacing : 0));
                    this.var_2684 = param1.rectangle.bottom;
                }
                else
                {
                    this.var_2684 = Math.max(this.var_2684, param1.rectangle.bottom);
                };
                this._container.height = this.var_2684;
            };
            param1 = this._container.addChild(param1);
            this.var_2687 = false;
            return (param1);
        }

        public function addListItemAt(param1:IWindow, param2:uint):IWindow
        {
            param1 = this._container.addChildAt(param1, param2);
            this.updateScrollAreaRegion();
            return (param1);
        }

        public function getListItemAt(param1:uint):IWindow
        {
            return (this._container.getChildAt(param1));
        }

        public function getListItemByID(param1:uint):IWindow
        {
            return (this._container.getChildByID(param1));
        }

        public function getListItemByName(param1:String):IWindow
        {
            return (this._container.getChildByName(param1));
        }

        public function getListItemByTag(param1:String):IWindow
        {
            return (this._container.getChildByTag(param1));
        }

        public function getListItemIndex(param1:IWindow):int
        {
            return (this._container.getChildIndex(param1));
        }

        public function removeListItem(param1:IWindow):IWindow
        {
            param1 = this._container.removeChild(param1);
            if (param1)
            {
                this.updateScrollAreaRegion();
            };
            return (param1);
        }

        public function removeListItemAt(param1:int):IWindow
        {
            return (this._container.removeChildAt(param1));
        }

        public function setListItemIndex(param1:IWindow, param2:int):void
        {
            this._container.setChildIndex(param1, param2);
        }

        public function swapListItems(param1:IWindow, param2:IWindow):void
        {
            this._container.swapChildren(param1, param2);
            this.updateScrollAreaRegion();
        }

        public function swapListItemsAt(param1:int, param2:int):void
        {
            this._container.swapChildrenAt(param1, param2);
            this.updateScrollAreaRegion();
        }

        public function groupListItemsWithID(param1:uint, param2:Array, param3:Boolean=false):uint
        {
            return (this._container.groupChildrenWithID(param1, param2, param3));
        }

        public function groupListItemsWithTag(param1:String, param2:Array, param3:Boolean=false):uint
        {
            return (this._container.groupChildrenWithTag(param1, param2, param3));
        }

        public function removeListItems():void
        {
            this.var_2687 = true;
            while (this.numListItems > 0)
            {
                this._container.removeChildAt(0);
            };
            this.var_2687 = false;
            this.updateScrollAreaRegion();
        }

        public function destroyListItems():void
        {
            this.var_2687 = true;
            while (this.numListItems > 0)
            {
                this._container.removeChildAt(0).destroy();
            };
            this.var_2687 = false;
            this.updateScrollAreaRegion();
        }

        public function arrangeListItems():void
        {
            this.updateScrollAreaRegion();
        }

        override public function populate(param1:Array):void
        {
            WindowController(this._container).populate(param1);
            this.updateScrollAreaRegion();
        }

        override public function update(param1:WindowController, param2:WindowEvent):Boolean
        {
            var _loc3_:Boolean = super.update(param1, param2);
            switch (param2.type)
            {
                case WindowEvent.var_588:
                    this.var_2686 = true;
                    break;
                case WindowEvent.var_589:
                    if (!this.var_2679)
                    {
                        if (this._horizontal)
                        {
                            this._container.height = var_1202.height;
                        }
                        else
                        {
                            this._container.width = var_1202.width;
                        };
                    };
                    this.updateScrollAreaRegion();
                    this.var_2686 = false;
                    break;
                default:
                    if ((param2 is WindowEvent))
                    {
                        _loc3_ = this.process((param2 as WindowEvent));
                    };
            };
            return (_loc3_);
        }

        public function process(param1:WindowEvent):Boolean
        {
            var _loc2_:Boolean;
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:int;
            if ((param1 is WindowMouseEvent))
            {
                _loc3_ = WindowMouseEvent(param1).localX;
                _loc4_ = WindowMouseEvent(param1).localY;
                _loc5_ = WindowMouseEvent(param1).delta;
            };
            switch (param1.type)
            {
                case WindowMouseEvent.var_657:
                    if (this._horizontal)
                    {
                        this.scrollH = (this.scrollH - (_loc5_ * 0.01));
                    }
                    else
                    {
                        this.scrollV = (this.scrollV - (_loc5_ * 0.01));
                    };
                    _loc2_ = true;
                    break;
                case WindowMouseEvent.var_650:
                    this.var_2688 = _loc3_;
                    this.var_2689 = _loc4_;
                    this.var_2690 = 0;
                    this.var_2691 = 0;
                    this.var_2692 = true;
                    _loc2_ = true;
                    break;
                case WindowMouseEvent.var_654:
                    if (this.var_2692)
                    {
                        this.var_2690 = (this.var_2688 - _loc3_);
                        this.var_2691 = (this.var_2689 - _loc4_);
                        if (this._horizontal)
                        {
                            if (((!(this.var_2690 == 0)) && (!(this.var_2683 == 0))))
                            {
                                this.scrollH = (this.scrollH + (this.var_2690 / this.var_2683));
                            };
                        }
                        else
                        {
                            if (((!(this.var_2691 == 0)) && (!(this.var_2684 == 0))))
                            {
                                this.scrollV = (this.scrollV + (this.var_2691 / this.var_2684));
                            };
                        };
                        this.var_2688 = _loc3_;
                        this.var_2689 = _loc4_;
                        _loc2_ = true;
                    };
                    break;
                case WindowMouseEvent.var_655:
                case WindowMouseEvent.var_656:
                    if (this.var_2692)
                    {
                        if (this._horizontal)
                        {
                            _context.getWindowServices().getGestureAgentService().begin(this, this.scrollAnimationCallback, 0, -(this.var_2690), 0);
                        }
                        else
                        {
                            _context.getWindowServices().getGestureAgentService().begin(this, this.scrollAnimationCallback, 0, 0, -(this.var_2691));
                        };
                        this.var_2692 = false;
                        _loc2_ = true;
                    };
                    break;
            };
            return (_loc2_);
        }

        private function scrollAnimationCallback(param1:int, param2:int):void
        {
            if (!disposed)
            {
                this.scrollH = (this.scrollH - (param1 / this.var_2683));
                this.scrollV = (this.scrollV - (param2 / this.var_2684));
            };
        }

        private function containerEventHandler(param1:WindowEvent):void
        {
            var _loc2_:WindowEvent;
            switch (param1.type)
            {
                case WindowEvent.var_597:
                    this.updateScrollAreaRegion();
                    return;
                case WindowEvent.var_599:
                    if (!this.var_2686)
                    {
                        this.updateScrollAreaRegion();
                    };
                    return;
                case WindowEvent.var_598:
                    this.updateScrollAreaRegion();
                    return;
                case WindowEvent.var_589:
                    if (_events)
                    {
                        _loc2_ = WindowEvent.allocate(WindowEvent.var_589, this, null);
                        _events.dispatchEvent(_loc2_);
                        _loc2_.recycle();
                    };
                    return;
                default:
                    Logger.log((("ItemListController::containerEventHandler(" + param1.type) + ")"));
            };
        }

        protected function updateScrollAreaRegion():void
        {
            var _loc1_:uint;
            var _loc2_:IWindow;
            var _loc3_:int;
            var _loc4_:uint;
            if ((((this.var_2685) && (!(this.var_2687))) && (this._container)))
            {
                this.var_2687 = true;
                _loc1_ = this._container.numChildren;
                if (this._horizontal)
                {
                    this.var_2683 = 0;
                    this.var_2684 = var_1202.height;
                    _loc4_ = 0;
                    while (_loc4_ < _loc1_)
                    {
                        _loc2_ = this._container.getChildAt(_loc4_);
                        if (_loc2_.visible)
                        {
                            _loc2_.x = this.var_2683;
                            this.var_2683 = (this.var_2683 + (_loc2_.width + this._spacing));
                            if (this.var_2679)
                            {
                                _loc3_ = (_loc2_.height + _loc2_.y);
                                this.var_2684 = ((_loc3_ > this.var_2684) ? _loc3_ : this.var_2684);
                            };
                        };
                        _loc4_++;
                    };
                    if (_loc1_ > 0)
                    {
                        this.var_2683 = (this.var_2683 - this._spacing);
                    };
                }
                else
                {
                    this.var_2683 = var_1202.width;
                    this.var_2684 = 0;
                    _loc4_ = 0;
                    while (_loc4_ < _loc1_)
                    {
                        _loc2_ = this._container.getChildAt(_loc4_);
                        if (_loc2_.visible)
                        {
                            _loc2_.y = this.var_2684;
                            this.var_2684 = (this.var_2684 + (_loc2_.height + this._spacing));
                            if (this.var_2679)
                            {
                                _loc3_ = (_loc2_.width + _loc2_.x);
                                this.var_2683 = ((_loc3_ > this.var_2683) ? _loc3_ : this.var_2683);
                            };
                        };
                        _loc4_++;
                    };
                    if (_loc1_ > 0)
                    {
                        this.var_2684 = (this.var_2684 - this._spacing);
                    };
                };
                if (this.var_2681 > 0)
                {
                    if (this.var_2683 <= var_1202.width)
                    {
                        this.scrollH = 0;
                    }
                    else
                    {
                        this._container.x = -(this.var_2681 * this.maxScrollH);
                    };
                };
                if (this.var_2682 > 0)
                {
                    if (this.var_2684 <= var_1202.height)
                    {
                        this.scrollV = 0;
                    }
                    else
                    {
                        this._container.y = -(this.var_2682 * this.maxScrollV);
                    };
                };
                this._container.height = this.var_2684;
                this._container.width = this.var_2683;
                this.var_2687 = false;
            };
        }

        override public function get properties():Array
        {
            var _loc1_:Array = super.properties;
            if (this._spacing != PropertyDefaults.var_2015)
            {
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_2014, this._spacing, PropertyStruct.var_630, true));
            }
            else
            {
                _loc1_.push(PropertyDefaults.var_2043);
            };
            if (this.var_2685 != PropertyDefaults.var_2005)
            {
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_2004, this.var_2685, PropertyStruct.var_634, true));
            }
            else
            {
                _loc1_.push(PropertyDefaults.var_2039);
            };
            if (this.var_2679 != PropertyDefaults.var_2023)
            {
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_2022, this.var_2679, PropertyStruct.var_634, true));
            }
            else
            {
                _loc1_.push(PropertyDefaults.var_2047);
            };
            if (this.var_2680 != PropertyDefaults.var_2019)
            {
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_2018, this.var_2680, PropertyStruct.var_634, true));
            }
            else
            {
                _loc1_.push(PropertyDefaults.var_2045);
            };
            if (this.var_2076 != PropertyDefaults.var_2025)
            {
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_2024, this.var_2076, PropertyStruct.var_632, true));
            }
            else
            {
                _loc1_.push(PropertyDefaults.var_2048);
            };
            if (this.var_2077 != PropertyDefaults.var_2027)
            {
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_2026, this.var_2077, PropertyStruct.var_632, true));
            }
            else
            {
                _loc1_.push(PropertyDefaults.var_2049);
            };
            return (_loc1_);
        }

        override public function set properties(param1:Array):void
        {
            var _loc2_:PropertyStruct;
            for each (_loc2_ in param1)
            {
                switch (_loc2_.key)
                {
                    case PropertyDefaults.var_2014:
                        this.spacing = (_loc2_.value as int);
                        break;
                    case PropertyDefaults.var_2022:
                        this.scaleToFitItems = (_loc2_.value as Boolean);
                        break;
                    case PropertyDefaults.var_2018:
                        this.resizeOnItemUpdate = (_loc2_.value as Boolean);
                        break;
                    case PropertyDefaults.var_2004:
                        this.var_2685 = (_loc2_.value as Boolean);
                        break;
                    case PropertyDefaults.var_2024:
                        this.var_2076 = (_loc2_.value as Number);
                        break;
                    case PropertyDefaults.var_2026:
                        this.var_2077 = (_loc2_.value as Number);
                        break;
                };
            };
            super.properties = param1;
        }


    }
}