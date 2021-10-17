package com.sulake.habbo.friendbar.view.tabs
{
    import __AS3__.vec.Vector;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.friendbar.data.IFriendEntity;
    import com.sulake.habbo.friendbar.view.tabs.tokens.Token;
    import com.sulake.habbo.friendbar.data.FriendNotification;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.ITextWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.tracking.HabboTracking;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.friendbar.view.tabs.tokens.RoomEventToken;
    import com.sulake.habbo.friendbar.view.tabs.tokens.AchievementToken;
    import com.sulake.habbo.friendbar.view.tabs.tokens.QuestToken;
    import com.sulake.habbo.friendbar.view.tabs.tokens.MessengerToken;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.*;

    public class FriendEntityTab extends Tab 
    {

        private static const var_2098:String = "entity_xml";
        private static const var_2092:String = "facebook_piece_xml";
        private static const var_2093:String = "controls_piece_xml";
        protected static const var_1328:String = "pieces";
        protected static const var_2099:String = "icons";
        protected static const var_222:String = "header";
        protected static const var_2089:String = "facebook";
        protected static const var_2090:String = "controls";
        protected static const var_1329:String = "canvas";
        protected static const var_316:String = "name";
        protected static const var_2094:String = "btn_message";
        protected static const var_2100:String = "icon_message";
        protected static const var_2095:String = "btn_visit";
        protected static const ICON:String = "icon";
        protected static const var_889:String = "label";
        protected static const var_1667:String = "notification";
        private static const var_1446:uint = 10338138;
        private static const var_2096:uint = 13891476;
        private static const var_2101:String = null;
        private static const var_2102:String = "icon_tag_notify";
        private static const var_2103:String = "icon_tag_message";
        private static const POOL:Vector.<FriendEntityTab> = new Vector.<FriendEntityTab>();
        private static const var_2097:Vector.<IWindowContainer> = new Vector.<IWindowContainer>();

        protected var var_2131:IFriendEntity;
        protected var var_3923:Vector.<Token>;


        public static function allocate(param1:IFriendEntity):FriendEntityTab
        {
            var _loc3_:FriendNotification;
            var _loc2_:FriendEntityTab = ((POOL.length > 0) ? POOL.pop() : new (FriendEntityTab)());
            _loc2_.var_2091 = false;
            _loc2_.friend = param1;
            if (param1.notifications.length > 0)
            {
                for each (_loc3_ in param1.notifications)
                {
                    _loc2_.addNotificationToken(_loc3_, false);
                };
            };
            return (_loc2_);
        }

        private static function purgeEntityPieces(param1:IWindowContainer):void
        {
            var _loc3_:IWindowContainer;
            var _loc5_:IWindow;
            var _loc2_:IItemListWindow = IItemListWindow(param1.getChildByName(var_1328));
            _loc3_ = (_loc2_.getListItemByName(var_2089) as IWindowContainer);
            if (_loc3_)
            {
                _loc3_.dispose();
            };
            _loc3_ = (_loc2_.getListItemByName(var_2090) as IWindowContainer);
            if (_loc3_)
            {
                _loc3_.dispose();
            };
            var _loc4_:Array = [];
            _loc2_.groupListItemsWithTag(var_1667, _loc4_);
            if (_loc4_.length > 0)
            {
                for each (_loc5_ in _loc4_)
                {
                    _loc5_.parent = null;
                };
            };
            param1.height = var_646;
            param1.y = 0;
        }


        public function set friend(param1:IFriendEntity):void
        {
            this.var_2131 = param1;
            this.refresh();
        }

        public function get friend():IFriendEntity
        {
            return (this.var_2131);
        }

        override public function recycle():void
        {
            if (!disposed)
            {
                if (!var_2091)
                {
                    if (_window)
                    {
                        this.releaseFriendTabWindow(_window);
                        _window = null;
                    };
                    if (this.var_3923)
                    {
                        while (this.var_3923.length > 0)
                        {
                            this.var_3923.pop().dispose();
                        };
                        this.var_3923 = null;
                    };
                    this.var_2131 = null;
                    var_2091 = true;
                    POOL.push(this);
                };
            };
        }

        override public function select(param1:Boolean):void
        {
            var _loc2_:IItemListWindow;
            var _loc3_:IWindowContainer;
            var _loc4_:IBitmapWrapperWindow;
            var _loc5_:Boolean;
            var _loc6_:ITextWindow;
            var _loc7_:Token;
            var _loc8_:IWindow;
            if (!selected)
            {
                _loc2_ = IItemListWindow(window.getChildByName(var_1328));
                _loc5_ = false;
                if (((!(this.friend.realName == null)) && (!(this.friend.realName == ""))))
                {
                    _loc3_ = (WINDOWING.buildFromXML((ASSETS.getAssetByName(var_2092).content as XML)) as IWindowContainer);
                    _loc3_.name = var_2089;
                    _loc6_ = (_loc3_.getChildByName(var_316) as ITextWindow);
                    _loc6_.caption = this.friend.realName;
                    if (!_loc6_.wordWrap)
                    {
                        var_1326.crop(_loc6_);
                    };
                    _loc4_ = IBitmapWrapperWindow(_loc3_.getChildByName(ICON));
                    _loc4_.bitmap = (ASSETS.getAssetByName(_loc4_.bitmapAssetName).content as BitmapData);
                    _loc4_.width = _loc4_.bitmap.width;
                    _loc4_.height = _loc4_.bitmap.height;
                    _loc2_.addListItem(_loc3_);
                    _loc5_ = true;
                };
                if (this.var_3923)
                {
                    for each (_loc7_ in this.var_3923)
                    {
                        _loc2_.addListItem(_loc7_.windowElement);
                        _loc5_ = true;
                    };
                };
                if (this.friend.online)
                {
                    _loc3_ = (WINDOWING.buildFromXML((ASSETS.getAssetByName(var_2093).content as XML)) as IWindowContainer);
                    _loc3_.name = var_2090;
                    _loc8_ = _loc3_.getChildByName(var_2094);
                    if (_loc8_)
                    {
                        _loc8_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClick);
                    };
                    _loc8_ = _loc3_.getChildByName(var_2095);
                    if (_loc8_)
                    {
                        if (this.friend.allowFollow)
                        {
                            _loc8_.visible = true;
                            _loc8_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClick);
                        }
                        else
                        {
                            _loc8_.visible = false;
                        };
                    };
                    _loc2_.addListItem(_loc3_);
                    _loc5_ = true;
                };
                if (_loc5_)
                {
                    window.height = _loc2_.height;
                };
                window.y = (var_646 - window.height);
                super.select(param1);
                if (param1)
                {
                    HabboTracking.getInstance().trackEventLog("FriendBar", "", "clicked", "", ((this.friend.logEventId > 0) ? this.friend.logEventId : 0));
                    this.friend.logEventId = -1;
                };
            };
        }

        override public function deselect(param1:Boolean):void
        {
            var _loc2_:int;
            var _loc3_:Token;
            if (selected)
            {
                if (_window)
                {
                    purgeEntityPieces(_window);
                    if (this.var_3923)
                    {
                        _loc2_ = (this.var_3923.length - 1);
                        while (_loc2_ > -1)
                        {
                            _loc3_ = this.var_3923[_loc2_];
                            if (_loc3_.viewOnce)
                            {
                                this.removeNotificationToken(_loc3_.typeCode, param1);
                            };
                            _loc2_--;
                        };
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

        protected function refresh():void
        {
            var _loc1_:IWindowContainer;
            var _loc2_:IBitmapWrapperWindow;
            if (!_window)
            {
                _window = this.allocateFriendTabWindow();
            };
            if (this.var_2131)
            {
                _window.id = this.var_2131.id;
                _loc1_ = (IItemListWindow(_window.getChildByName(var_1328)).getListItemByName(var_222) as IWindowContainer);
                _loc1_.findChildByName(var_316).caption = this.var_2131.name;
                var_1326.crop((_loc1_.getChildByName(var_316) as ITextWindow));
                _loc2_ = IBitmapWrapperWindow(_loc1_.findChildByName(var_1329));
                _loc2_.bitmap = var_1324.getAvatarFaceBitmap(this.var_2131.figure);
                _loc2_.width = _loc2_.bitmap.width;
                _loc2_.height = _loc2_.bitmap.height;
            };
        }

        private function allocateFriendTabWindow():IWindowContainer
        {
            var _loc1_:IWindowContainer = ((var_2097.length > 0) ? var_2097.pop() : (WINDOWING.buildFromXML((ASSETS.getAssetByName(var_2098).content as XML)) as IWindowContainer));
            var _loc2_:IBitmapWrapperWindow = IBitmapWrapperWindow(_loc1_.findChildByName(var_1329));
            var _loc3_:IRegionWindow = IRegionWindow(_loc1_.findChildByName(var_222));
            var _loc4_:IWindow = _loc1_.findChildByName(var_2099);
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
            return (_loc1_);
        }

        private function releaseFriendTabWindow(param1:IWindowContainer):void
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
                purgeEntityPieces(param1);
                if (var_2097.indexOf(param1) == -1)
                {
                    var_2097.push(param1);
                };
            };
        }

        private function onButtonClick(param1:WindowMouseEvent):void
        {
            if (((!(disposed)) && (!(recycled))))
            {
                switch (param1.window.name)
                {
                    case var_2094:
                    case var_2100:
                        this.removeNotificationToken(FriendNotification.var_1385, true);
                        if (((var_1323) && (this.var_2131)))
                        {
                            var_1323.startConversation(this.var_2131.id);
                            this.deselect(true);
                            if (param1.window.name == var_2100)
                            {
                                var_1324.setMessengerIconNotify(false);
                            };
                        };
                        return;
                    case var_2095:
                        if (((var_1323) && (this.var_2131)))
                        {
                            var_1323.followToRoom(this.var_2131.id);
                            this.deselect(true);
                        };
                        return;
                };
            };
        }

        public function addNotificationToken(param1:FriendNotification, param2:Boolean):void
        {
            var _loc4_:Token;
            var _loc6_:Vector.<Token>;
            var _loc7_:IItemListWindow;
            var _loc8_:IWindow;
            this.removeNotificationToken(param1.typeCode, false);
            if (!this.var_3923)
            {
                this.var_3923 = new Vector.<Token>();
            };
            var _loc3_:Boolean = selected;
            if (_loc3_)
            {
                _loc6_ = this.var_3923;
                this.var_3923 = null;
                this.deselect(false);
                this.var_3923 = _loc6_;
            };
            var _loc5_:String = var_2101;
            switch (param1.typeCode)
            {
                case FriendNotification.var_2104:
                    _loc4_ = new RoomEventToken(this.friend, param1, param2);
                    _loc4_.iconElement.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, onMouseClick);
                    _loc5_ = var_2102;
                    break;
                case FriendNotification.TYPE_ACHIEVEMENT:
                    _loc4_ = new AchievementToken(this.friend, param1, param2, var_1325);
                    _loc4_.iconElement.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, onMouseClick);
                    _loc5_ = var_2102;
                    break;
                case FriendNotification.var_2105:
                    _loc4_ = new QuestToken(this.friend, param1, param2, var_1325);
                    _loc4_.iconElement.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, onMouseClick);
                    _loc5_ = var_2102;
                    break;
                case FriendNotification.var_1385:
                    _loc4_ = new MessengerToken(this.friend, param1, param2);
                    _loc4_.iconElement.name = var_2100;
                    _loc4_.iconElement.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClick);
                    _loc5_ = var_2103;
                    break;
                default:
                    throw (new Error((("Unknown friend notification type: " + param1.typeCode) + "!")));
            };
            if (_loc4_)
            {
                this.var_3923.push(_loc4_);
                if (_loc5_ != var_2101)
                {
                    _loc7_ = IItemListWindow(_window.findChildByName(var_2099));
                    if (!_loc7_.getListItemByTag(_loc5_))
                    {
                        _loc8_ = _loc4_.iconElement;
                        if (_loc8_.tags.indexOf(_loc5_) == -1)
                        {
                            _loc8_.tags.push(_loc5_);
                        };
                        _loc7_.addListItemAt(_loc8_, 0);
                    };
                };
            };
            if (_loc3_)
            {
                this.select(false);
            };
        }

        public function removeNotificationToken(param1:int, param2:Boolean):void
        {
            var _loc4_:Token;
            if (!this.var_3923)
            {
                return;
            };
            var _loc3_:int = (this.var_3923.length - 1);
            while (_loc3_ > -1)
            {
                _loc4_ = this.var_3923[_loc3_];
                if (_loc4_.typeCode == param1)
                {
                    this.var_3923.splice(_loc3_, 1);
                    if (param2)
                    {
                        this.var_2131.notifications.splice(this.var_2131.notifications.indexOf(_loc4_.notification), 1);
                    };
                    _loc4_.dispose();
                    return;
                };
                _loc3_--;
            };
        }

        public function toString():String
        {
            return ((getQualifiedClassName(this) + " ") + this.var_2131.name);
        }


    }
}