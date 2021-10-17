package com.sulake.habbo.friendbar.view.tabs
{
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.friendbar.data.FriendEntity;
    import com.sulake.habbo.friendbar.data.FriendRequest;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.IBubbleWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.enum.WindowStyle;
    import com.sulake.core.window.enum.WindowParam;
    import flash.geom.Rectangle;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class FriendRequestTab extends FriendEntityTab 
    {

        protected static const var_2130:String = "friend_request_tab_xml";
        protected static const var_226:String = "bubble";
        protected static const var_2094:String = "message";
        protected static const var_2122:String = "button_accept";
        protected static const var_1101:String = "button_close";
        protected static const var_2132:String = "click_region_reject";
        protected static const REGION_REJECT_TEXT:String = "link_reject";
        private static const var_1446:uint = 16435481;
        private static const var_2096:uint = 16767334;
        private static const REGION_REJECT_COLOR_EXPOSED:uint = 16770666;
        private static const var_2125:uint = 0xFFFFFF;
        private static var var_2114:FriendRequestTab;

        private var var_3926:String;

        public function FriendRequestTab()
        {
            _window = this.allocateRequestTabWindow();
            if (_window)
            {
                _window.findChildByName(var_226).visible = false;
            };
        }

        public static function allocate(param1:FriendRequest):FriendRequestTab
        {
            var _loc3_:IBitmapWrapperWindow;
            var _loc2_:FriendRequestTab = ((var_2114) ? var_2114 : new (FriendRequestTab)());
            _loc2_.var_2091 = false;
            if (_loc2_.friend)
            {
                if (_loc2_.friend.figure != param1.figure)
                {
                    _loc3_ = IBitmapWrapperWindow(_loc2_._window.findChildByName(var_1329));
                    _loc3_.bitmap = var_1324.getAvatarFaceBitmap(param1.figure);
                };
            };
            _loc2_.friend = new FriendEntity(param1.id, param1.name, null, null, -1, false, false, param1.figure, 0, null);
            return (_loc2_);
        }


        override public function dispose():void
        {
            if (_window)
            {
                this.releaseRequestTabWindow(_window);
                _window = null;
            };
            super.dispose();
        }

        override public function recycle():void
        {
            if (!disposed)
            {
                if (!var_2091)
                {
                    var_2131 = null;
                    var_2091 = true;
                    var_2114 = this;
                };
            };
        }

        override public function select(param1:Boolean):void
        {
            var _loc2_:IWindow;
            if (!selected)
            {
                if (_window)
                {
                    _loc2_ = _window.findChildByName(var_226);
                    if (_loc2_)
                    {
                        _loc2_.visible = true;
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
        }

        override protected function conceal():void
        {
            super.conceal();
            _window.color = ((exposed) ? var_2096 : var_1446);
        }

        private function allocateRequestTabWindow():IWindowContainer
        {
            var _loc6_:BitmapDataAsset;
            var _loc1_:IWindowContainer = (WINDOWING.buildFromXML((ASSETS.getAssetByName(var_2130).content as XML)) as IWindowContainer);
            var _loc2_:IBitmapWrapperWindow = IBitmapWrapperWindow(_loc1_.findChildByName(var_1329));
            var _loc3_:IRegionWindow = IRegionWindow(_loc1_.findChildByName(var_222));
            var _loc4_:IWindow = _loc1_.findChildByName(var_2099);
            var _loc5_:IBubbleWindow = (_loc1_.findChildByName(var_226) as IBubbleWindow);
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
            _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, onMouseClick);
            _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, onMouseOver);
            _loc4_.addEventListener(WindowMouseEvent.var_624, onMouseOut);
            _loc2_.disposesBitmap = true;
            _loc5_.procedure = this.bubbleEventProc;
            _loc5_.y = (-(_loc5_.height - (_loc5_.height - _loc5_.margins.bottom)) - 1);
            var _loc7_:IRegionWindow = (WINDOWING.create("ICON", WindowType.var_1120, WindowStyle.var_1192, WindowParam.var_609, new Rectangle(0, 0, 25, 25)) as IRegionWindow);
            _loc7_.mouseThreshold = 0;
            var _loc8_:IBitmapWrapperWindow = (WINDOWING.create("BITMAP", WindowType.var_928, WindowStyle.var_1192, WindowParam.var_713, new Rectangle(0, 0, 25, 25)) as IBitmapWrapperWindow);
            _loc8_.disposesBitmap = false;
            _loc6_ = (ASSETS.getAssetByName("plus_friend_icon_png") as BitmapDataAsset);
            if (_loc6_)
            {
                _loc8_.bitmap = (_loc6_.content as BitmapData);
            };
            _loc7_.addChild(_loc8_);
            IItemListWindow(_loc1_.findChildByName(var_2099)).addListItemAt(_loc7_, 0);
            return (_loc1_);
        }

        private function releaseRequestTabWindow(param1:IWindowContainer):void
        {
            var _loc2_:IRegionWindow;
            var _loc3_:IWindow;
            var _loc4_:IBitmapWrapperWindow;
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
                _loc3_ = param1.findChildByName(var_2099);
                _loc3_.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, onMouseClick);
                _loc3_.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, onMouseClick);
                _loc3_.removeEventListener(WindowMouseEvent.var_624, onMouseClick);
                param1.width = var_645;
                param1.height = var_646;
                param1.color = var_1446;
                _loc4_ = IBitmapWrapperWindow(param1.findChildByName(var_1329));
                _loc4_.bitmap = null;
                ITextWindow(param1.findChildByTag("label")).underline = false;
            };
        }

        private function bubbleEventProc(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                switch (param2.name)
                {
                    case var_2122:
                        var_1323.acceptFriendRequest(var_2131.id);
                        break;
                    case var_1101:
                        if (selected)
                        {
                            var_1324.deSelect(true);
                        };
                        break;
                    case var_2132:
                        var_1323.declineFriendRequest(var_2131.id);
                        break;
                };
            }
            else
            {
                if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
                {
                    if (param2.name == var_2132)
                    {
                        ITextWindow(IWindowContainer(param2).getChildByName(REGION_REJECT_TEXT)).textColor = REGION_REJECT_COLOR_EXPOSED;
                    };
                }
                else
                {
                    if (param1.type == WindowMouseEvent.var_624)
                    {
                        if (param2.name == var_2132)
                        {
                            ITextWindow(IWindowContainer(param2).getChildByName(REGION_REJECT_TEXT)).textColor = var_2125;
                        };
                    };
                };
            };
        }

        public function avatarImageReady(param1:FriendRequest, param2:BitmapData):void
        {
            var _loc3_:IBitmapWrapperWindow;
            var _loc4_:BitmapData;
            if (!disposed)
            {
                if (friend)
                {
                    if (friend.figure == param1.figure)
                    {
                        _loc3_ = (_window.findChildByName(var_1329) as IBitmapWrapperWindow);
                        if (_loc3_)
                        {
                            _loc4_ = var_1324.getAvatarFaceBitmap(param1.figure);
                            if (_loc4_)
                            {
                                _loc3_.bitmap = _loc4_;
                                _loc3_.width = _loc4_.width;
                                _loc3_.height = _loc4_.height;
                            };
                        };
                    };
                };
            };
        }


    }
}