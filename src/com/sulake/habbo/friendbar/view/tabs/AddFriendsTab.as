package com.sulake.habbo.friendbar.view.tabs
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;

    public class AddFriendsTab extends Tab 
    {

        protected static const ICON:String = "icon";
        protected static const TEXT:String = "text";
        protected static const var_222:String = "header";
        protected static const var_889:String = "label";
        protected static const BUTTON:String = "button";
        private static const var_2134:String = "add_friends_tab_xml";
        private static const var_2136:String = "find_friends_icon_png";
        private static var var_2135:int = -1;
        private static const var_1446:uint = 6907230;
        private static const var_2096:uint = 9209986;
        private static const POOL:Array = [];
        private static const var_2133:Array = [];


        public static function allocate():AddFriendsTab
        {
            var _loc1_:AddFriendsTab = ((POOL.length > 0) ? POOL.pop() : new (AddFriendsTab)());
            _loc1_.var_2091 = false;
            _loc1_._window = _loc1_.allocateEntityWindow();
            return (_loc1_);
        }


        public function allocateEntityWindow():IWindowContainer
        {
            var _loc1_:IWindowContainer = ((var_2133.length > 0) ? var_2133.pop() : (WINDOWING.buildFromXML((ASSETS.getAssetByName(var_2134).content as XML)) as IWindowContainer));
            var _loc2_:IRegionWindow = IRegionWindow(_loc1_.findChildByName(var_222));
            _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, onMouseClick);
            _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, onMouseOver);
            _loc1_.addEventListener(WindowMouseEvent.var_624, onMouseOut);
            _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, onMouseClick);
            _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, onMouseOver);
            _loc2_.addEventListener(WindowMouseEvent.var_624, onMouseOut);
            if (var_2135 < 0)
            {
                var_2135 = _loc1_.height;
            };
            _loc1_.height = var_646;
            var _loc3_:IBitmapWrapperWindow = (_loc1_.findChildByName(ICON) as IBitmapWrapperWindow);
            _loc3_.disposesBitmap = false;
            _loc3_.bitmap = (ASSETS.getAssetByName(var_2136).content as BitmapData);
            var _loc4_:IWindow = _loc1_.findChildByName(BUTTON);
            _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClick);
            var _loc5_:IWindow = _loc1_.findChildByName(TEXT);
            _loc5_.visible = false;
            return (_loc1_);
        }

        private function releaseEntityWindow(param1:IWindowContainer):void
        {
            var _loc2_:IRegionWindow;
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
                param1.findChildByName(BUTTON).removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClick);
                param1.findChildByName(TEXT).visible = false;
                param1.width = var_645;
                param1.height = var_646;
                if (var_2133.indexOf(param1) == -1)
                {
                    var_2133.push(param1);
                };
            };
        }

        override public function select(param1:Boolean):void
        {
            if (!selected)
            {
                _window.height = var_2135;
                _window.y = (_window.y - (_window.height - var_646));
                _window.findChildByName(TEXT).visible = true;
                super.select(param1);
            };
        }

        override public function deselect(param1:Boolean):void
        {
            if (selected)
            {
                _window.y = 0;
                _window.height = var_646;
                _window.findChildByName(TEXT).visible = false;
                super.deselect(param1);
            };
        }

        override public function recycle():void
        {
            if (!disposed)
            {
                if (!var_2091)
                {
                    if (_window)
                    {
                        this.releaseEntityWindow(_window);
                        _window = null;
                    };
                    var_2091 = true;
                    POOL.push(this);
                };
            };
        }

        override protected function expose():void
        {
            super.expose();
            ITextWindow(_window.findChildByTag(var_889)).underline = exposed;
            _window.color = ((exposed) ? var_2096 : var_1446);
        }

        override protected function conceal():void
        {
            super.conceal();
            ITextWindow(_window.findChildByTag(var_889)).underline = exposed;
            _window.color = ((exposed) ? var_2096 : var_1446);
        }

        private function onButtonClick(param1:WindowMouseEvent):void
        {
            if (((!(disposed)) && (!(recycled))))
            {
                var_1323.findNewFriends();
                this.deselect(true);
            };
        }


    }
}