package com.sulake.habbo.friendbar.view
{
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.friendbar.data.IHabboFriendBarData;
    import com.sulake.core.window.IWindowContainer;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.friendbar.view.tabs.ITab;
    import com.sulake.habbo.friendbar.view.utils.TextCropper;
    import com.sulake.habbo.friendbar.view.utils.FriendListIcon;
    import com.sulake.habbo.friendbar.view.utils.MessengerIcon;
    import com.sulake.habbo.friendbar.view.utils.StreamIcon;
    import com.sulake.iid.IIDHabboFriendBarData;
    import com.sulake.habbo.friendbar.HabboFriendBar;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.friendbar.events.FriendBarUpdateEvent;
    import com.sulake.habbo.friendbar.events.FindFriendsNotificationEvent;
    import com.sulake.habbo.friendbar.events.FriendRequestUpdateEvent;
    import com.sulake.habbo.friendbar.events.NewMessageEvent;
    import com.sulake.habbo.friendbar.events.NotificationEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.friendbar.data.FriendRequest;
    import com.sulake.habbo.friendbar.data.IFriendEntity;
    import com.sulake.habbo.friendbar.view.tabs.Tab;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.friendbar.view.tabs.FriendRequestTab;
    import com.sulake.habbo.friendbar.view.tabs.FriendRequestsTab;
    import com.sulake.habbo.friendbar.view.tabs.FriendEntityTab;
    import com.sulake.habbo.friendbar.view.tabs.AddFriendsTab;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.friendbar.view.tabs.tokens.Token;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import flash.events.Event;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.window.enum.HabboAlertDialogFlag;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.friendbar.view.utils.Icon;
    import __AS3__.vec.*;

    public class HabboFriendBarView extends AbstractView implements IHabboFriendBarView, IAvatarImageListener 
    {

        private static const var_1341:int = 127;
        private static const var_1305:int = 1;
        private static const var_1315:int = 2;
        private static const var_1314:int = 3;
        private static const var_1316:int = 3;
        private static const var_1317:Boolean = false;
        private static const var_1311:int = 3;
        private static const var_1338:String = "arrow";
        private static const var_1339:String = "left";
        private static const var_1340:String = "right";
        private static const var_1313:String = "bar_xml";
        private static const var_1318:String = "toggle_xml";
        private static const var_218:String = "container";
        private static const var_1337:String = "wrapper";
        private static const var_933:String = "border";
        private static const var_1310:String = "list";
        private static const var_222:String = "header";
        private static const var_1329:String = "canvas";
        private static const ICON:String = "icon";
        private static const var_1328:String = "pieces";
        private static const var_1330:String = "button_left";
        private static const BUTTON_RIGHT_SINGLE:String = "button_right";
        private static const var_1331:String = "button_left_page";
        private static const var_1333:String = "button_right_page";
        private static const var_1332:String = "button_left_end";
        private static const var_1334:String = "button_right_end";
        private static const var_1101:String = "button_close";
        private static const var_1336:String = "button_open";
        private static const var_1335:String = "link_friendlist";
        private static const var_1320:String = "messenger";
        private static const var_1319:String = "friendlist";
        private static const var_1321:String = "stream";
        private static const var_3938:String = "stream_new_label";

        private var var_3942:IHabboFriendBarData;
        private var var_3943:IWindowContainer;
        private var var_3944:IWindowContainer;
        private var var_3945:Vector.<ITab>;
        private var var_3946:ITab;
        private var var_3947:int = -1;
        private var _startIndex:int = 0;
        private var var_3948:TextCropper;
        private var var_3940:FriendListIcon;
        private var var_3939:MessengerIcon;
        private var var_3941:StreamIcon;
        private var var_3949:Boolean = true;

        public function HabboFriendBarView(param1:HabboFriendBar, param2:uint, param3:IAssetLibrary)
        {
            super(param1, param2, param3);
            this.var_3948 = new TextCropper();
            this.var_3945 = new Vector.<ITab>();
            queueInterface(new IIDHabboFriendBarData(), this.onFriendBarDataAvailable);
        }

        public function setMessengerIconNotify(param1:Boolean):void
        {
            if (this.var_3939)
            {
                this.var_3939.notify(param1);
            };
        }

        public function setFriendListIconNotify(param1:Boolean):void
        {
            if (this.var_3940)
            {
                this.var_3940.notify(param1);
            };
        }

        public function setStreamIconNotify(param1:Boolean):void
        {
            if (this.var_3941)
            {
                this.var_3941.notify(param1);
            };
        }

        public function refreshEventStream():void
        {
            this.var_3942.refreshOfflineStream();
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                if (this.var_3939)
                {
                    this.var_3939.dispose();
                    this.var_3939 = null;
                };
                if (this.var_3940)
                {
                    this.var_3940.dispose();
                    this.var_3940 = null;
                };
                if (this.var_3941)
                {
                    this.var_3941.dispose();
                    this.var_3941 = null;
                };
                if (this.var_3944)
                {
                    this.var_3944.dispose();
                    this.var_3944 = null;
                };
                if (this.var_3943)
                {
                    this.var_3943.dispose();
                    this.var_3943 = null;
                };
                while (this.var_3945.length > 0)
                {
                    ITab(this.var_3945.pop()).dispose();
                };
                if (this.var_3942)
                {
                    if (!this.var_3942.disposed)
                    {
                        if (this.var_3942.events)
                        {
                            this.var_3942.events.removeEventListener(FriendBarUpdateEvent.var_1306, this.onRefreshView);
                            this.var_3942.events.removeEventListener(FindFriendsNotificationEvent.TYPE, this.onFindFriendsNotification);
                            this.var_3942.events.removeEventListener(FriendRequestUpdateEvent.var_1307, this.onFriendRequestUpdate);
                            this.var_3942.events.removeEventListener(NewMessageEvent.var_1308, this.onNewInstantMessage);
                            this.var_3942.events.removeEventListener(NotificationEvent.var_1309, this.onFriendNotification);
                        };
                        this.var_3942.release(new IIDHabboFriendBarData());
                        this.var_3942 = null;
                    };
                };
                if (_windowManager)
                {
                    if (!_windowManager.disposed)
                    {
                        _windowManager.getWindowContext(var_1305).getDesktopWindow().removeEventListener(WindowEvent.var_589, this.onDesktopResized);
                    };
                };
                this.var_3948.dispose();
                this.var_3948 = null;
                super.dispose();
            };
        }

        public function set visible(param1:Boolean):void
        {
            if (this.var_3943)
            {
                this.var_3943.visible = param1;
                this.var_3943.activate();
            };
            if (this.var_3944)
            {
                this.var_3944.visible = (!(param1));
                if (this.var_3943)
                {
                    this.var_3944.x = this.var_3943.x;
                    this.var_3944.y = this.var_3943.y;
                    this.var_3944.activate();
                };
            };
        }

        public function get visible():Boolean
        {
            return ((this.var_3943) && (this.var_3943.visible));
        }

        public function populate():void
        {
            var _loc5_:int;
            var _loc12_:FriendRequest;
            var _loc13_:IFriendEntity;
            var _loc14_:Tab;
            var _loc15_:int;
            var _loc16_:Tab;
            var _loc1_:int = this.var_3947;
            this.deSelect(false);
            var _loc2_:IWindowContainer = (this.var_3943.findChildByName(var_218) as IWindowContainer);
            var _loc3_:IItemListWindow = (_loc2_.findChildByName(var_1310) as IItemListWindow);
            _loc3_.autoArrangeItems = false;
            var _loc4_:int = _loc3_.numListItems;
            _loc5_ = _loc4_;
            while (_loc5_ > 0)
            {
                _loc3_.removeListItemAt((_loc5_ - 1));
                _loc5_--;
            };
            while (this.var_3945.length > 0)
            {
                this.var_3945.pop().recycle();
            };
            var _loc6_:int = this.var_3942.numFriends;
            var _loc7_:int = this.var_3942.numFriendRequests;
            var _loc8_:int = this.maxNumOfTabsVisible;
            var _loc9_:int = ((_loc6_ + ((this.var_3949) ? 1 : 0)) + ((_loc7_ > 0) ? 1 : 0));
            var _loc10_:int = Math.min(_loc8_, _loc9_);
            if ((this._startIndex + _loc10_) > _loc9_)
            {
                this._startIndex = Math.max(0, (this._startIndex - ((this._startIndex + _loc10_) - _loc9_)));
            };
            var _loc11_:int = this._startIndex;
            if (_loc7_ > 0)
            {
                if (this._startIndex == 0)
                {
                    if (this.var_3945.length < _loc8_)
                    {
                        if (_loc7_ == 1)
                        {
                            _loc12_ = this.var_3942.getFriendRequestAt(0);
                            _loc14_ = FriendRequestTab.allocate(_loc12_);
                            this.var_3945.push(_loc14_);
                            _loc3_.addListItem(_loc14_.window);
                        }
                        else
                        {
                            if (_loc7_ > 1)
                            {
                                _loc14_ = FriendRequestsTab.allocate(this.var_3942.getFriendRequestList());
                                this.var_3945.push(_loc14_);
                                _loc3_.addListItem(_loc14_.window);
                            };
                        };
                    };
                }
                else
                {
                    _loc11_--;
                };
            };
            _loc5_ = _loc11_;
            while (_loc5_ < (_loc6_ + _loc11_))
            {
                if (_loc5_ >= _loc6_) break;
                if (this.var_3945.length >= _loc8_) break;
                _loc13_ = this.var_3942.getFriendAt(_loc5_);
                _loc14_ = FriendEntityTab.allocate(_loc13_);
                this.var_3945.push(_loc14_);
                _loc3_.addListItem(_loc14_.window);
                _loc5_++;
            };
            if (this.var_3949)
            {
                if (this.var_3945.length < _loc8_)
                {
                    _loc15_ = 1;
                    if ((this.var_3945.length + _loc15_) < var_1311)
                    {
                        _loc15_ = Math.min((_loc8_ - this.var_3945.length), (var_1311 - this.var_3945.length));
                    };
                    _loc9_ = ((_loc6_ + _loc15_) + ((_loc7_ > 0) ? 1 : 0));
                    while (_loc15_-- > 0)
                    {
                        _loc16_ = AddFriendsTab.allocate();
                        _loc3_.addListItem(_loc16_.window);
                        this.var_3945.push(_loc16_);
                    };
                };
            };
            _loc3_.autoArrangeItems = true;
            if (_loc1_ > -1)
            {
                this.selectFriendEntity(_loc1_);
            };
            _loc2_.visible = (this.var_3945.length > 0);
            this.toggleArrowButtons((this.var_3945.length < _loc9_), (!(this._startIndex == 0)), ((this._startIndex + this.var_3945.length) < _loc9_));
        }

        private function getFriendEntityTabByID(param1:int):FriendEntityTab
        {
            var _loc2_:FriendEntityTab;
            var _loc3_:int = this.var_3945.length;
            var _loc4_:int;
            while (_loc4_ < _loc3_)
            {
                _loc2_ = (this.var_3945[_loc4_] as FriendEntityTab);
                if (_loc2_)
                {
                    if (_loc2_.friend.id == param1)
                    {
                        return (_loc2_);
                    };
                };
                _loc4_++;
            };
            return (null);
        }

        private function onFriendBarDataAvailable(param1:IID, param2:IUnknown):void
        {
            this.var_3942 = (param2 as IHabboFriendBarData);
            this.var_3942.events.addEventListener(FriendBarUpdateEvent.var_1306, this.onRefreshView);
            this.var_3942.events.addEventListener(FindFriendsNotificationEvent.TYPE, this.onFindFriendsNotification);
            this.var_3942.events.addEventListener(FriendRequestUpdateEvent.var_1307, this.onFriendRequestUpdate);
            this.var_3942.events.addEventListener(NewMessageEvent.var_1308, this.onNewInstantMessage);
            this.var_3942.events.addEventListener(NotificationEvent.var_1309, this.onFriendNotification);
        }

        private function isUserInterfaceReady():Boolean
        {
            return ((this.var_3943) && (!(this.var_3943.disposed)));
        }

        private function buildUserInterface():void
        {
            var _loc2_:IWindowContainer;
            Tab.var_1323 = this.var_3942;
            Tab.var_1324 = this;
            Tab.ASSETS = assets;
            Tab.WINDOWING = _windowManager;
            Tab.var_1325 = var_1312;
            Tab.var_1326 = this.var_3948;
            Token.WINDOWING = _windowManager;
            Token.ASSETS = assets;
            var _loc1_:IAsset = assets.getAssetByName(var_1313);
            this.var_3943 = (_windowManager.buildFromXML((_loc1_.content as XML), var_1305) as IWindowContainer);
            this.var_3943.x = var_1314;
            this.var_3943.y = (this.var_3943.parent.height - (this.var_3943.height + var_1315));
            this.var_3943.width = (this.var_3943.parent.width - (var_1314 + var_1316));
            this.var_3943.setParamFlag(WindowParam.var_689, true);
            this.var_3943.procedure = this.barWindowEventProc;
            if (var_1317)
            {
                _loc1_ = assets.getAssetByName(var_1318);
                this.var_3944 = (_windowManager.buildFromXML((_loc1_.content as XML), var_1305) as IWindowContainer);
                this.var_3944.x = this.var_3943.x;
                this.var_3944.y = this.var_3943.y;
                this.var_3944.setParamFlag(WindowParam.var_689, true);
                this.var_3944.visible = false;
                this.var_3944.procedure = this.toggleWindowEventProc;
            };
            _loc2_ = IWindowContainer(this.var_3943.findChildByName(var_1319));
            _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onIconMouseEvent);
            _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onIconMouseEvent);
            _loc2_.addEventListener(WindowMouseEvent.var_624, this.onIconMouseEvent);
            this.var_3940 = new FriendListIcon(assets, (_loc2_.getChildByName(ICON) as IBitmapWrapperWindow));
            _loc2_ = IWindowContainer(this.var_3943.findChildByName(var_1320));
            _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onIconMouseEvent);
            _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onIconMouseEvent);
            _loc2_.addEventListener(WindowMouseEvent.var_624, this.onIconMouseEvent);
            this.var_3939 = new MessengerIcon(assets, (_loc2_.getChildByName(ICON) as IBitmapWrapperWindow));
            this.var_3939.enable(false);
            this.visible = true;
            _windowManager.getWindowContext(var_1305).getDesktopWindow().addEventListener(WindowEvent.var_589, this.onDesktopResized);
            this.var_3943.findChildByName(var_1321).visible = (var_1322.getBoolean("friendbar.stream.enabled", false) == true);
            _loc2_ = IWindowContainer(this.var_3943.findChildByName(var_1321));
            _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onIconMouseEvent);
            _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onIconMouseEvent);
            _loc2_.addEventListener(WindowMouseEvent.var_624, this.onIconMouseEvent);
            this.var_3941 = new StreamIcon(assets, (_loc2_.getChildByName(ICON) as IBitmapWrapperWindow));
        }

        public function getAvatarFaceBitmap(param1:String):BitmapData
        {
            var _loc2_:BitmapData;
            var _loc3_:IAvatarImage;
            if (var_1327)
            {
                _loc3_ = var_1327.createAvatarImage(param1, AvatarScaleType.var_128, null, this);
                if (_loc3_)
                {
                    _loc2_ = _loc3_.getCroppedImage(AvatarSetType.var_130);
                    _loc3_.dispose();
                };
            };
            return (_loc2_);
        }

        public function avatarImageReady(param1:String):void
        {
            var _loc2_:IFriendEntity;
            var _loc7_:FriendRequest;
            var _loc8_:BitmapData;
            var _loc9_:IWindowContainer;
            var _loc10_:IItemListWindow;
            var _loc11_:IWindowContainer;
            var _loc12_:IBitmapWrapperWindow;
            var _loc13_:Tab;
            var _loc3_:IItemListWindow = (this.var_3943.findChildByName(var_1310) as IItemListWindow);
            var _loc4_:int = this.var_3942.numFriends;
            var _loc5_:int;
            while (_loc5_ < _loc4_)
            {
                _loc2_ = this.var_3942.getFriendAt(_loc5_);
                if (_loc2_.figure == param1)
                {
                    _loc8_ = this.getAvatarFaceBitmap(param1);
                    if (_loc8_)
                    {
                        _loc9_ = (_loc3_.getListItemByID(_loc2_.id) as IWindowContainer);
                        if (_loc9_)
                        {
                            _loc10_ = (_loc9_.getChildByName(var_1328) as IItemListWindow);
                            if (_loc10_)
                            {
                                _loc11_ = IWindowContainer(_loc10_.getListItemByName(var_222));
                                if (_loc11_)
                                {
                                    _loc12_ = (_loc11_.findChildByName(var_1329) as IBitmapWrapperWindow);
                                    _loc12_.bitmap = _loc8_;
                                    _loc12_.width = _loc8_.width;
                                    _loc12_.height = _loc8_.height;
                                };
                            };
                        };
                    };
                    return;
                };
                _loc5_++;
            };
            var _loc6_:Array = this.var_3942.getFriendRequestList();
            for each (_loc7_ in _loc6_)
            {
                if (_loc7_.figure == param1)
                {
                    for each (_loc13_ in this.var_3945)
                    {
                        if ((_loc13_ is FriendRequestTab))
                        {
                            FriendRequestTab(_loc13_).avatarImageReady(_loc7_, this.getAvatarFaceBitmap(param1));
                            return;
                        };
                        if ((_loc13_ is FriendRequestsTab))
                        {
                            FriendRequestsTab(_loc13_).avatarImageReady(_loc7_, this.getAvatarFaceBitmap(param1));
                            return;
                        };
                    };
                };
            };
        }

        public function faceBookImageReady(param1:BitmapData):void
        {
        }

        private function isFriendSelected(param1:IFriendEntity):Boolean
        {
            return (this.var_3947 == param1.id);
        }

        public function selectTab(param1:ITab, param2:Boolean):void
        {
            if (!param1.selected)
            {
                if (this.var_3946)
                {
                    this.deSelect(true);
                };
                param1.select(param2);
                this.var_3946 = param1;
                if ((param1 is FriendEntityTab))
                {
                    this.var_3947 = FriendEntityTab(param1).friend.id;
                };
            };
        }

        public function selectFriendEntity(param1:int):void
        {
            if (this.var_3947 == param1)
            {
                return;
            };
            var _loc2_:FriendEntityTab = this.getFriendEntityTabByID(param1);
            if (_loc2_)
            {
                this.selectTab(_loc2_, false);
                this.var_3947 = param1;
            };
        }

        public function deSelect(param1:Boolean):void
        {
            if (this.var_3946)
            {
                this.var_3946.deselect(param1);
                this.var_3946 = null;
                this.var_3947 = -1;
            };
        }

        private function onRefreshView(param1:Event):void
        {
            if (!this.isUserInterfaceReady())
            {
                this.buildUserInterface();
            };
            this.resizeAndPopulate(true);
        }

        private function onFindFriendsNotification(event:FindFriendsNotificationEvent):void
        {
            var title:String = ((event.success) ? "${friendbar.find.success.title}" : "${friendbar.find.error.title}");
            var text:String = ((event.success) ? "${friendbar.find.success.text}" : "${friendbar.find.error.text}");
            _windowManager.notify(title, text, function (param1:IAlertDialog, param2:WindowEvent):void
            {
                param1.dispose();
            }, HabboAlertDialogFlag.var_1096);
        }

        private function onFriendRequestUpdate(param1:FriendRequestUpdateEvent):void
        {
            if (this.var_3940)
            {
                this.var_3940.notify((this.var_3942.numFriendRequests > 0));
            };
            this.populate();
        }

        private function onNewInstantMessage(param1:NewMessageEvent):void
        {
            if (this.var_3939)
            {
                if (param1.notify)
                {
                    this.var_3939.notify(true);
                }
                else
                {
                    this.var_3939.enable(true);
                };
            };
        }

        private function onFriendNotification(param1:NotificationEvent):void
        {
            var _loc2_:FriendEntityTab = this.getFriendEntityTabByID(param1.friendId);
            if (!_loc2_)
            {
                return;
            };
            _loc2_.addNotificationToken(param1.notification, true);
        }

        private function barWindowEventProc(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:int;
            var _loc4_:int;
            if (param1.type == WindowMouseEvent.var_650)
            {
                _loc3_ = this._startIndex;
                _loc4_ = ((this.var_3942.numFriends + ((this.var_3949) ? 1 : 0)) + ((this.var_3942.numFriendRequests > 0) ? 1 : 0));
                switch (param2.name)
                {
                    case var_1330:
                        _loc3_ = Math.max(0, (this._startIndex - 1));
                        break;
                    case var_1331:
                        _loc3_ = Math.max(0, (this._startIndex - this.maxNumOfTabsVisible));
                        break;
                    case var_1332:
                        _loc3_ = 0;
                        break;
                    case BUTTON_RIGHT_SINGLE:
                        _loc3_ = Math.max(0, Math.min((_loc4_ - this.maxNumOfTabsVisible), (this._startIndex + 1)));
                        break;
                    case var_1333:
                        _loc3_ = Math.max(0, Math.min((_loc4_ - this.maxNumOfTabsVisible), (this._startIndex + this.maxNumOfTabsVisible)));
                        break;
                    case var_1334:
                        _loc3_ = Math.max(0, (_loc4_ - this.maxNumOfTabsVisible));
                        break;
                    case var_1101:
                        this.visible = false;
                        break;
                    case var_933:
                        this.deSelect(true);
                        break;
                    case var_1335:
                        this.var_3942.toggleFriendList();
                        break;
                };
                if (_loc3_ != this._startIndex)
                {
                    this.deSelect(true);
                    this._startIndex = _loc3_;
                    this.resizeAndPopulate(true);
                };
            };
            if (param1.type == WindowEvent.var_574)
            {
                this.deSelect(true);
            };
        }

        private function onIconMouseEvent(param1:WindowMouseEvent):void
        {
            var _loc2_:Icon;
            switch (param1.window.name)
            {
                case var_1319:
                    _loc2_ = this.var_3940;
                    break;
                case var_1320:
                    _loc2_ = this.var_3939;
                    break;
                case var_1321:
                    _loc2_ = this.var_3941;
                    break;
            };
            if (_loc2_ == null)
            {
                return;
            };
            switch (param1.type)
            {
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
                    if ((_loc2_ is FriendListIcon))
                    {
                        this.var_3942.toggleFriendList();
                        _loc2_.notify(false);
                    }
                    else
                    {
                        if ((_loc2_ is MessengerIcon))
                        {
                            this.var_3942.toggleMessenger();
                            _loc2_.notify(false);
                        }
                        else
                        {
                            if ((_loc2_ is StreamIcon))
                            {
                                this.var_3942.toggleOfflineStream();
                                _loc2_.notify(false);
                            };
                        };
                    };
                    return;
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
                    _loc2_.hover(true);
                    return;
                case WindowMouseEvent.var_624:
                    _loc2_.hover(false);
                    return;
            };
        }

        private function toggleWindowEventProc(param1:WindowEvent, param2:IWindow):void
        {
            if (this.var_3944.visible)
            {
                if (param1.type == WindowMouseEvent.var_650)
                {
                    switch (param2.name)
                    {
                        case var_1336:
                            this.visible = true;
                            return;
                    };
                };
            };
        }

        private function toggleArrowButtons(param1:Boolean, param2:Boolean, param3:Boolean):void
        {
            var _loc4_:IWindow;
            var _loc5_:Array;
            var _loc6_:IWindowContainer = (this.var_3943.findChildByName(var_1337) as IWindowContainer);
            _loc5_ = [];
            _loc6_.groupChildrenWithTag(var_1338, _loc5_);
            for each (_loc4_ in _loc5_)
            {
                _loc4_.visible = param1;
            };
            _loc5_ = [];
            _loc6_.groupChildrenWithTag(var_1339, _loc5_);
            for each (_loc4_ in _loc5_)
            {
                if (param2)
                {
                    _loc4_.enable();
                }
                else
                {
                    _loc4_.disable();
                };
            };
            _loc5_ = [];
            _loc6_.groupChildrenWithTag(var_1340, _loc5_);
            for each (_loc4_ in _loc5_)
            {
                if (param3)
                {
                    _loc4_.enable();
                }
                else
                {
                    _loc4_.disable();
                };
            };
        }

        private function resizeAndPopulate(param1:Boolean=false):void
        {
            var _loc2_:int;
            if (!disposed)
            {
                if (this.var_3943)
                {
                    this.var_3943.width = (this.var_3943.parent.width - (var_1314 + var_1316));
                    if (!param1)
                    {
                        _loc2_ = this.maxNumOfTabsVisible;
                        if (_loc2_ < this.var_3945.length)
                        {
                            param1 = true;
                        }
                        else
                        {
                            if (_loc2_ > this.var_3945.length)
                            {
                                if (this.var_3945.length < var_1311)
                                {
                                    param1 = true;
                                }
                                else
                                {
                                    if (this.var_3945.length < (this.var_3942.numFriends + ((this.var_3949) ? 1 : 0)))
                                    {
                                        param1 = true;
                                    }
                                    else
                                    {
                                        if (this.numFriendEntityTabsVisible < this.var_3942.numFriends)
                                        {
                                            param1 = true;
                                        };
                                    };
                                };
                            };
                        };
                    };
                    if (param1)
                    {
                        this.populate();
                    };
                };
            };
        }

        private function get numFriendEntityTabsVisible():int
        {
            var _loc1_:int;
            var _loc2_:int = this.var_3945.length;
            while (_loc2_-- > 0)
            {
                if ((this.var_3945[_loc2_] is FriendEntityTab))
                {
                    _loc1_++;
                };
            };
            return (_loc1_);
        }

        private function get maxNumOfTabsVisible():int
        {
            var _loc1_:IWindowContainer = (this.var_3943.findChildByName(var_218) as IWindowContainer);
            var _loc2_:IWindowContainer = (_loc1_.getChildByName(var_1337) as IWindowContainer);
            var _loc3_:IItemListWindow = (_loc2_.findChildByName(var_1310) as IItemListWindow);
            var _loc4_:int = (_loc2_.width - _loc3_.width);
            return ((_loc1_.width - _loc4_) / (var_1341 + _loc3_.spacing));
        }

        private function onDesktopResized(param1:WindowEvent):void
        {
            this.resizeAndPopulate(false);
        }


    }
}