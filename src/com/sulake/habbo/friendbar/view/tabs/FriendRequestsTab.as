package com.sulake.habbo.friendbar.view.tabs
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBubbleWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.friendbar.data.FriendRequest;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class FriendRequestsTab extends Tab 
    {

        protected static const var_2119:String = "friend_requests_tab_xml";
        protected static const ICON:String = "icon";
        protected static const var_889:String = "label";
        protected static const var_222:String = "header";
        protected static const var_1329:String = "canvas";
        protected static const var_226:String = "bubble";
        protected static const var_2116:String = "request_entity_list";
        protected static const var_316:String = "name";
        protected static const var_2115:String = "badge_counter";
        protected static const var_2120:String = "button_accept_all";
        protected static const var_2121:String = "click_area_discard_all";
        protected static const var_1101:String = "button_close";
        protected static const var_2122:String = "button_accept";
        protected static const var_2123:String = "click_area_discard";
        protected static const var_2124:String = "text_discard";
        private static var var_2114:FriendRequestsTab;
        private static const var_1446:uint = 4294625561;
        private static const var_2096:uint = 0xFFFFD966;
        private static const var_2117:uint = 4289431312;
        private static const var_2118:uint = 4290616362;
        private static const REGION_REJECT_COLOR_EXPOSED:uint = 16770666;
        private static const var_2125:uint = 0xFFFFFF;

        private var _requests:Array;
        private var var_3924:Boolean = false;
        private var var_3925:IWindowContainer;

        public function FriendRequestsTab()
        {
            _window = this.allocateRequestsTabWindow();
        }

        public static function allocate(param1:Array):FriendRequestsTab
        {
            var _loc2_:FriendRequestsTab = ((var_2114) ? var_2114 : new (FriendRequestsTab)());
            _loc2_.var_2091 = false;
            _loc2_._requests = param1;
            _loc2_._window.findChildByName(var_2115).caption = String(param1.length);
            return (_loc2_);
        }


        override public function dispose():void
        {
            if (_window)
            {
                this.releaseRequestsTabWindow(_window);
                _window = null;
            };
            if (this.var_3925)
            {
                this.var_3925.dispose();
                this.var_3925 = null;
            };
            super.dispose();
        }

        override public function recycle():void
        {
            var _loc1_:IBubbleWindow;
            var _loc2_:IItemListWindow;
            if (!disposed)
            {
                if (!var_2091)
                {
                    if (_window)
                    {
                        _loc1_ = (_window.findChildByName(var_226) as IBubbleWindow);
                        if (_loc1_)
                        {
                            _loc2_ = (_loc1_.content.getChildByName(var_2116) as IItemListWindow);
                            if (_loc2_)
                            {
                                while (_loc2_.numListItems > 0)
                                {
                                    _loc2_.removeListItemAt(0).dispose();
                                };
                            };
                        };
                    };
                    this.var_3924 = false;
                    this._requests = null;
                    var_2091 = true;
                    var_2114 = this;
                };
            };
        }

        override public function select(param1:Boolean):void
        {
            var _loc2_:IBubbleWindow;
            var _loc3_:IItemListWindow;
            var _loc4_:IWindowContainer;
            var _loc5_:FriendRequest;
            var _loc6_:IBitmapWrapperWindow;
            var _loc7_:int;
            var _loc8_:int;
            var _loc9_:BitmapData;
            if (!selected)
            {
                if (_window)
                {
                    _loc2_ = (_window.findChildByName(var_226) as IBubbleWindow);
                    if (_loc2_)
                    {
                        _loc2_.visible = true;
                        if (!this.var_3924)
                        {
                            _loc3_ = (_loc2_.content.getChildByName(var_2116) as IItemListWindow);
                            if (_loc3_)
                            {
                                _loc7_ = 0;
                                _loc8_ = 0;
                                while (_loc8_ < this._requests.length)
                                {
                                    _loc4_ = (this.var_3925.clone() as IWindowContainer);
                                    _loc4_.color = (((_loc8_ % 2) == 0) ? var_2117 : var_2118);
                                    _loc5_ = this._requests[_loc8_];
                                    _loc4_.id = _loc5_.id;
                                    _loc4_.getChildByName(var_316).caption = _loc5_.name;
                                    _loc6_ = (_loc4_.getChildByName(var_1329) as IBitmapWrapperWindow);
                                    _loc9_ = var_1324.getAvatarFaceBitmap(_loc5_.figure);
                                    if (_loc9_)
                                    {
                                        _loc6_.disposesBitmap = false;
                                        _loc6_.bitmap = _loc9_;
                                        _loc6_.width = _loc9_.width;
                                        _loc6_.height = _loc9_.height;
                                        _loc6_.disposesBitmap = true;
                                    };
                                    _loc3_.addListItem(_loc4_);
                                    _loc7_ = (_loc7_ + (_loc4_.height + _loc3_.spacing));
                                    _loc8_++;
                                };
                                _loc3_.height = _loc7_;
                            };
                        };
                        this.var_3924 = true;
                    };
                };
                super.select(param1);
            };
        }

        override public function deselect(param1:Boolean):void
        {
            var _loc2_:IWindow;
            if (selected)
            {
                if (_window)
                {
                    _loc2_ = _window.findChildByName(var_226);
                    if (_loc2_)
                    {
                        _loc2_.visible = false;
                    };
                };
                super.deselect(param1);
            };
        }

        override protected function expose():void
        {
            super.expose();
            _window.color = ((exposed) ? var_2096 : var_1446);
            ITextWindow(_window.findChildByTag(var_889)).underline = exposed;
        }

        override protected function conceal():void
        {
            super.conceal();
            _window.color = ((exposed) ? var_2096 : var_1446);
            ITextWindow(_window.findChildByTag(var_889)).underline = exposed;
        }

        private function allocateRequestsTabWindow():IWindowContainer
        {
            var _loc5_:BitmapDataAsset;
            var _loc1_:IWindowContainer = (WINDOWING.buildFromXML((ASSETS.getAssetByName(var_2119).content as XML)) as IWindowContainer);
            var _loc2_:IBitmapWrapperWindow = IBitmapWrapperWindow(_loc1_.findChildByName(var_1329));
            var _loc3_:IRegionWindow = IRegionWindow(_loc1_.findChildByName(var_222));
            var _loc4_:IBubbleWindow = (_loc1_.findChildByName(var_226) as IBubbleWindow);
            _loc1_.x = 0;
            _loc1_.y = 0;
            _loc1_.width = var_645;
            _loc1_.height = var_646;
            _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, onMouseClick);
            _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, onMouseOver);
            _loc1_.addEventListener(WindowMouseEvent.var_624, onMouseOut);
            _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, onMouseClick);
            _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, onMouseOver);
            _loc3_.addEventListener(WindowMouseEvent.var_624, onMouseOut);
            _loc2_.disposesBitmap = true;
            _loc4_.visible = false;
            _loc4_.y = (-(_loc4_.height - (_loc4_.height - _loc4_.margins.bottom)) - 1);
            _loc4_.procedure = this.bubbleEventProc;
            _loc5_ = (ASSETS.getAssetByName("add_friends_icon_png") as BitmapDataAsset);
            var _loc6_:IBitmapWrapperWindow = (_loc1_.findChildByName(ICON) as IBitmapWrapperWindow);
            _loc6_.disposesBitmap = false;
            _loc6_.bitmap = (_loc5_.content as BitmapData);
            var _loc7_:IItemListWindow = (_loc4_.content.getChildByName(var_2116) as IItemListWindow);
            this.var_3925 = (_loc7_.removeListItemAt(0) as IWindowContainer);
            return (_loc1_);
        }

        private function releaseRequestsTabWindow(param1:IWindowContainer):void
        {
            var _loc2_:IRegionWindow;
            var _loc3_:IBitmapWrapperWindow;
            if (((param1) && (!(param1.disposed))))
            {
                param1.procedure = null;
                param1.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, onMouseClick);
                param1.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, onMouseOver);
                param1.removeEventListener(WindowMouseEvent.var_624, onMouseOut);
                _loc2_ = IRegionWindow(param1.findChildByName(var_222));
                _loc2_.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, onMouseClick);
                _loc2_.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, onMouseOver);
                _loc2_.removeEventListener(WindowMouseEvent.var_624, onMouseOut);
                param1.width = var_645;
                param1.height = var_646;
                param1.color = var_1446;
                _loc3_ = IBitmapWrapperWindow(param1.findChildByName(var_1329));
                _loc3_.bitmap = null;
                ITextWindow(param1.findChildByTag(var_889)).underline = false;
            };
        }

        private function bubbleEventProc(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                switch (param2.name)
                {
                    case var_1101:
                        if (selected)
                        {
                            var_1324.deSelect(true);
                        };
                        break;
                    case var_2120:
                        var_1323.acceptAllFriendRequests();
                        break;
                    case var_2121:
                        var_1323.declineAllFriendRequests();
                        break;
                    case var_2122:
                        var_1323.acceptFriendRequest(param2.parent.id);
                        break;
                    case var_2123:
                        var_1323.declineFriendRequest(param2.parent.id);
                        break;
                };
            }
            else
            {
                if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
                {
                    if (param2.name == var_2123)
                    {
                        ITextWindow(IWindowContainer(param2).getChildByName(var_2124)).textColor = REGION_REJECT_COLOR_EXPOSED;
                    };
                }
                else
                {
                    if (param1.type == WindowMouseEvent.var_624)
                    {
                        if (param2.name == var_2123)
                        {
                            ITextWindow(IWindowContainer(param2).getChildByName(var_2124)).textColor = var_2125;
                        };
                    };
                };
            };
        }

        public function avatarImageReady(param1:FriendRequest, param2:BitmapData):void
        {
            var _loc4_:IItemListWindow;
            var _loc5_:IWindowContainer;
            var _loc6_:int;
            var _loc7_:IBitmapWrapperWindow;
            if (disposed)
            {
                return;
            };
            var _loc3_:IBubbleWindow = (_window.findChildByName(var_226) as IBubbleWindow);
            if (_loc3_)
            {
                _loc4_ = (_loc3_.content.getChildByName(var_2116) as IItemListWindow);
                if (_loc4_)
                {
                    _loc6_ = 0;
                    while (_loc6_ < _loc4_.numListItems)
                    {
                        _loc5_ = (_loc4_.getListItemAt(_loc6_) as IWindowContainer);
                        if (_loc5_.id == param1.id)
                        {
                            _loc7_ = (_loc5_.getChildByName(var_1329) as IBitmapWrapperWindow);
                            _loc7_.disposesBitmap = true;
                            _loc7_.bitmap = param2;
                            _loc7_.width = param2.width;
                            _loc7_.height = param2.height;
                            return;
                        };
                        _loc6_++;
                    };
                };
            };
        }


    }
}