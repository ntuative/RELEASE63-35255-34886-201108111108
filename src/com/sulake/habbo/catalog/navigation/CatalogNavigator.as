package com.sulake.habbo.catalog.navigation
{
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
    import com.sulake.habbo.catalog.navigation.events.CatalogPageOpenedEvent;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class CatalogNavigator implements ICatalogNavigator 
    {

        private var _catalog:IHabboCatalog;
        private var _container:IWindowContainer;
        private var var_2632:IItemListWindow;
        private var _index:ICatalogNode;
        private var var_3134:Array;
        private var _scrollBar:IScrollbarWindow;
        private var var_3135:String = "magic.credits";
        private var var_3136:String = "magic.pixels";
        private var var_3137:String = "catalog.page.club";

        public function CatalogNavigator(param1:IHabboCatalog, param2:IWindowContainer)
        {
            var _loc3_:IWindow;
            var _loc4_:IWindow;
            var _loc5_:IWindow;
            super();
            this._catalog = param1;
            this._container = param2;
            this.var_3134 = [];
            this.var_2632 = (this._container.findChildByName("navigationList") as IItemListWindow);
            if (param1.configuration.getBoolean("catalog.show.purse", false))
            {
                _loc3_ = this._container.findChildByName("creditsContainer");
                _loc4_ = this._container.findChildByName("pixelsContainer");
                _loc5_ = this._container.findChildByName("clubContainer");
                _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onNavigatorEvent);
                _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onNavigatorEvent);
                _loc3_.addEventListener(WindowMouseEvent.var_624, this.onNavigatorEvent);
                _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onNavigatorEvent);
                _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onNavigatorEvent);
                _loc4_.addEventListener(WindowMouseEvent.var_624, this.onNavigatorEvent);
                _loc5_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onNavigatorEvent);
                _loc5_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onNavigatorEvent);
                _loc5_.addEventListener(WindowMouseEvent.var_624, this.onNavigatorEvent);
            };
            this._scrollBar = (this._container.findChildByName("navigationListScrollbar") as IScrollbarWindow);
            if (this._scrollBar != null)
            {
                this._scrollBar.visible = false;
                this._scrollBar.addEventListener(WindowEvent.var_583, this.activateScrollbar);
                this._scrollBar.addEventListener(WindowEvent.var_584, this.activateScrollbar);
                this._scrollBar.addEventListener(WindowEvent.var_585, this.deActivateScrollbar);
                this._scrollBar.addEventListener(WindowEvent.var_586, this.deActivateScrollbar);
            };
        }

        public function isInitialized():Boolean
        {
            return (!(this._index == null));
        }

        public function dispose():void
        {
            this._catalog = null;
            this._container = null;
            this.var_2632 = null;
            if (this._index)
            {
                this._index.dispose();
            };
            this._index = null;
            this.var_3134 = null;
            this._scrollBar = null;
        }

        public function buildCatalogIndex(param1:NodeData):void
        {
            var _loc2_:ICatalogNode;
            this._index = null;
            this._index = this.buildIndexNode(param1, 0);
            for each (_loc2_ in this._index.children)
            {
                if (_loc2_.isNavigateable)
                {
                    (_loc2_ as CatalogNodeRenderable).addToList(this.var_2632);
                };
            };
        }

        public function get catalog():IHabboCatalog
        {
            return (this._catalog);
        }

        public function activateNode(param1:ICatalogNode):void
        {
            var _loc5_:ICatalogNode;
            var _loc6_:ICatalogNode;
            var _loc7_:int;
            var _loc2_:* = (this.var_3134.indexOf(param1) > -1);
            var _loc3_:Boolean = param1.isOpen;
            var _loc4_:Array = [];
            for each (_loc5_ in this.var_3134)
            {
                _loc5_.deActivate();
                if (_loc5_.depth >= param1.depth)
                {
                    _loc4_.push(_loc5_);
                };
            };
            for each (_loc6_ in _loc4_)
            {
                _loc6_.close();
                _loc7_ = this.var_3134.indexOf(_loc6_);
                this.var_3134.splice(_loc7_, 1);
            };
            param1.activate();
            if (((_loc2_) && (_loc3_)))
            {
                param1.close();
            }
            else
            {
                param1.open();
            };
            if (this.var_3134.indexOf(param1) == -1)
            {
                this.var_3134.push(param1);
            };
            this._catalog.loadCatalogPage(param1.pageId, -1);
            this._catalog.events.dispatchEvent(new CatalogPageOpenedEvent(param1.pageId, param1.localization));
        }

        public function openPage(param1:String):void
        {
            var _loc2_:ICatalogNode = this.getNodeByName(param1);
            if (_loc2_ != null)
            {
                this._catalog.loadCatalogPage(_loc2_.pageId, -1);
                this.openNavigatorAtNode(_loc2_);
            };
        }

        public function openPageById(param1:int, param2:int):void
        {
            var _loc3_:ICatalogNode = this.getNodeById(param1, this._index);
            if (_loc3_ != null)
            {
                this._catalog.loadCatalogPage(_loc3_.pageId, param2);
                this.openNavigatorAtNode(_loc3_);
            };
        }

        private function openNavigatorAtNode(param1:ICatalogNode):void
        {
            var _loc2_:ICatalogNode;
            var _loc3_:ICatalogNode;
            if (param1 == null)
            {
                return;
            };
            for each (_loc2_ in this.var_3134)
            {
                _loc2_.deActivate();
                _loc2_.close();
            };
            this.var_3134 = [];
            _loc3_ = param1.parent;
            while (((!(_loc3_ == null)) && (!(_loc3_.parent == null))))
            {
                _loc3_.open();
                this.var_3134.push(_loc3_);
                _loc3_ = _loc3_.parent;
            };
            this.activateNode(param1);
        }

        public function loadFrontPage():void
        {
            var _loc1_:ICatalogNode = this.getFirstNavigateable(this._index);
            Logger.log((((("Load front page: " + _loc1_.localization) + "(") + _loc1_.pageId) + ")"));
            this._catalog.loadCatalogPage(_loc1_.pageId, -1);
        }

        public function loadNewAdditionsPage(param1:String):void
        {
            var _loc2_:ICatalogNode = this.getFirstNodeByName(param1, this._index);
            if (_loc2_ != null)
            {
                this._catalog.loadCatalogPage(_loc2_.pageId, -1);
            }
            else
            {
                this.loadFrontPage();
            };
        }

        private function openCreditsPage():void
        {
            if (this._catalog)
            {
                this._catalog.openCreditsHabblet();
            };
        }

        private function onExternalLink(param1:IAlertDialog, param2:WindowEvent):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.dispose();
        }

        private function openPixelsPage():void
        {
            this.openPage(this.var_3136);
        }

        private function openClubPage():void
        {
            this._catalog.openCatalogPage(this.var_3137, true);
        }

        private function getFirstNavigateable(param1:ICatalogNode):ICatalogNode
        {
            var _loc2_:ICatalogNode;
            var _loc3_:ICatalogNode;
            if (((param1.isNavigateable) && (!(param1 == this._index))))
            {
                return (param1);
            };
            for each (_loc2_ in param1.children)
            {
                _loc3_ = this.getFirstNavigateable(_loc2_);
                if (_loc3_ != null)
                {
                    return (_loc3_);
                };
            };
            return (null);
        }

        private function buildIndexNode(param1:NodeData, param2:int):ICatalogNode
        {
            var _loc5_:NodeData;
            var _loc3_:Boolean = param1.navigateable;
            var _loc4_:ICatalogNode;
            if (!_loc3_)
            {
                _loc4_ = (new CatalogNode(this, param1, param2) as ICatalogNode);
            }
            else
            {
                _loc4_ = (new CatalogNodeRenderable(this, param1, param2) as ICatalogNode);
            };
            if (_loc4_ == null)
            {
                Logger.log("Catalog index node creation failed!");
                return (null);
            };
            param2++;
            for each (_loc5_ in param1.nodes)
            {
                _loc4_.addChild(this.buildIndexNode(_loc5_, param2));
            };
            return (_loc4_);
        }

        private function getNodeByName(param1:String):ICatalogNode
        {
            return (this.getFirstNodeByName(param1, this._index));
        }

        private function getNodeById(pageId:int, node:ICatalogNode):ICatalogNode
        {
            var currentPageId:int;
            var child:ICatalogNode;
            var found:ICatalogNode;
            try
            {
                currentPageId = node.pageId;
                if (((currentPageId == pageId) && (!(node == this._index))))
                {
                    found = node;
                }
                else
                {
                    for each (child in node.children)
                    {
                        found = this.getNodeById(pageId, child);
                        if (found != null) break;
                    };
                };
            }
            catch(e:Error)
            {
                Logger.log((("error when loading node by id " + pageId) + ":"), e);
            };
            return (found);
        }

        private function getFirstNodeByName(localizedName:String, node:ICatalogNode):ICatalogNode
        {
            var child:ICatalogNode;
            var found:ICatalogNode;
            try
            {
                if (((node.localization == localizedName) && (!(node == this._index))))
                {
                    found = node;
                }
                else
                {
                    for each (child in node.children)
                    {
                        found = this.getFirstNodeByName(localizedName, child);
                        if (found != null) break;
                    };
                };
            }
            catch(e:Error)
            {
                Logger.log((("error when loading node by name " + localizedName) + ":"), e);
            };
            return (found);
        }

        private function onNavigatorEvent(param1:WindowMouseEvent):void
        {
            var _loc2_:IWindowContainer = IWindowContainer(param1.target);
            var _loc3_:String = IWindow(param1.target).name;
            switch (param1.type)
            {
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
                    _loc2_.getChildByName("background").color = 4281692560;
                    return;
                case WindowMouseEvent.var_624:
                    _loc2_.getChildByName("background").color = 4280767850;
                    return;
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
                    switch (_loc3_)
                    {
                        case "creditsContainer":
                            this.openCreditsPage();
                            break;
                        case "pixelsContainer":
                            this.openPixelsPage();
                            break;
                        case "clubContainer":
                            this.openClubPage();
                            break;
                    };
                    return;
            };
        }

        private function activateScrollbar(param1:WindowEvent):void
        {
            (param1.target as IWindow).visible = true;
        }

        private function deActivateScrollbar(param1:WindowEvent):void
        {
            (param1.target as IWindow).visible = false;
        }


    }
}