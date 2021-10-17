package com.sulake.habbo.friendbar.data
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.messenger.IHabboMessenger;
    import com.sulake.habbo.friendbar.stream.IHabboEventStream;
    import com.sulake.core.utils.Map;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.iid.IIDHabboMessenger;
    import com.sulake.iid.IIDHabboEventStream;
    import com.sulake.habbo.friendbar.HabboFriendBar;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.friendlist.events.FriendRequestEvent;
    import com.sulake.habbo.friendbar.events.FriendBarUpdateEvent;
    import com.sulake.habbo.friendbar.events.FriendRequestUpdateEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.friendbar.events.NewMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FindNewFriendsMessageComposer;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.utils.WindowToggle;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerInitEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FindFriendsProcessResultEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewBuddyRequestEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.BuddyRequestsEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewConsoleMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendNotificationEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
    import com.sulake.habbo.communication.messages.parser.friendlist.FriendListUpdateMessageParser;
    import com.sulake.habbo.friendbar.events.FindFriendsNotificationEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;
    import com.sulake.habbo.messenger.IConversation;
    import com.sulake.habbo.communication.messages.parser.friendlist.NewConsoleMessageMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.FriendNotificationMessageParser;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.friendbar.events.NotificationEvent;
    import com.sulake.habbo.tracking.HabboTracking;

    public class HabboFriendBarData extends Component implements IHabboFriendBarData 
    {

        private static const var_1384:Boolean = false;
        private static const var_1386:Boolean = false;
        private static const var_1374:String = "Navigation";
        private static const var_1375:String = "Friend Bar";
        private static const var_1376:String = "go.friendbar";
        private static const var_1377:String = "chat_btn_click";
        private static const var_1378:String = "find_friends_btn_click";
        private static const var_1379:String = "Toolbar";
        private static const var_1381:String = "open";
        private static const var_1382:String = "close";
        private static const var_1380:String = "FRIENDLIST";
        private static const var_1383:String = "MESSENGER";

        private var var_3892:IHabboConfigurationManager;
        private var var_3893:IHabboCommunicationManager;
        private var var_3894:IHabboFriendList;
        private var var_3895:IHabboMessenger;
        private var var_3896:IHabboEventStream;
        private var var_3897:Array;
        private var var_3898:Map;
        private var var_3899:Array;
        private var var_3900:int;
        private var var_3901:Boolean = false;
        private var var_3902:Boolean = false;

        public function HabboFriendBarData(param1:HabboFriendBar, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            this.var_3897 = new Array();
            this.var_3898 = new Map();
            this.var_3899 = new Array();
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationAvailable);
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationManagerAvailable);
            queueInterface(new IIDHabboFriendList(), this.onFriendListComponentAvailable);
            queueInterface(new IIDHabboMessenger(), this.onMessengerComponentAvailable);
            queueInterface(new IIDHabboEventStream(), this.onOfflineStreamAvailable);
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                if (this.var_3892)
                {
                    this.var_3892.release(new IIDHabboConfigurationManager());
                    this.var_3892 = null;
                };
                if (this.var_3893)
                {
                    this.var_3893.release(new IIDHabboCommunicationManager());
                    this.var_3893 = null;
                };
                if (this.var_3894)
                {
                    if (!this.var_3894.disposed)
                    {
                        this.var_3894.events.removeEventListener(FriendRequestEvent.var_345, this.onFriendRequestEvent);
                        this.var_3894.events.removeEventListener(FriendRequestEvent.var_1373, this.onFriendRequestEvent);
                    };
                    this.var_3894.release(new IIDHabboFriendList());
                    this.var_3894 = null;
                };
                if (this.var_3895)
                {
                    this.var_3895.release(new IIDHabboMessenger());
                    this.var_3895 = null;
                };
                if (this.var_3896)
                {
                    this.var_3896.release(new IIDHabboEventStream());
                    this.var_3896 = null;
                };
                this.var_3897 = null;
                this.var_3898.dispose();
                this.var_3898 = null;
                this.var_3899 = null;
                super.dispose();
            };
        }

        public function get numFriends():int
        {
            return (this.var_3897.length);
        }

        public function getFriendAt(param1:int):IFriendEntity
        {
            return (this.var_3897[param1]);
        }

        public function getFriendByID(param1:int):IFriendEntity
        {
            return (this.var_3898.getValue(param1));
        }

        public function getFriendByName(param1:String):IFriendEntity
        {
            var _loc2_:FriendEntity;
            for each (_loc2_ in this.var_3897)
            {
                if (_loc2_.name == param1)
                {
                    return (_loc2_);
                };
            };
            return (null);
        }

        public function setFriendAt(param1:IFriendEntity, param2:int):void
        {
            var _loc3_:int = this.var_3897.indexOf(param1);
            if (((_loc3_ > -1) && (!(_loc3_ == param2))))
            {
                this.var_3897.splice(_loc3_, 1);
                this.var_3897.splice(param2, 0, param1);
                events.dispatchEvent(new FriendBarUpdateEvent());
            };
        }

        public function get numFriendRequests():int
        {
            return ((this.var_3899) ? this.var_3899.length : 0);
        }

        public function getFriendRequestAt(param1:int):FriendRequest
        {
            return ((this.var_3899) ? this.var_3899[param1] : null);
        }

        public function getFriendRequestByID(param1:int):FriendRequest
        {
            var _loc2_:FriendRequest;
            if (this.var_3899)
            {
                for each (_loc2_ in this.var_3899)
                {
                    if (_loc2_.id == param1)
                    {
                        return (_loc2_);
                    };
                };
            };
            return (null);
        }

        public function getFriendRequestByName(param1:String):FriendRequest
        {
            var _loc2_:FriendRequest;
            if (this.var_3899)
            {
                for each (_loc2_ in this.var_3899)
                {
                    if (_loc2_.name == param1)
                    {
                        return (_loc2_);
                    };
                };
            };
            return (null);
        }

        public function getFriendRequestList():Array
        {
            return (this.var_3899);
        }

        public function acceptFriendRequest(param1:int):void
        {
            this.removeFriendRequest(param1);
            if (this.var_3894)
            {
                if (!this.var_3894.disposed)
                {
                    this.var_3894.acceptFriendRequest(param1);
                };
            };
        }

        public function acceptAllFriendRequests():void
        {
            this.var_3899 = [];
            this.var_3894.acceptAllFriendRequests();
            events.dispatchEvent(new FriendRequestUpdateEvent());
        }

        public function declineFriendRequest(param1:int):void
        {
            this.removeFriendRequest(param1);
            if (this.var_3894)
            {
                if (!this.var_3894.disposed)
                {
                    this.var_3894.declineFriendRequest(param1);
                };
            };
        }

        public function declineAllFriendRequests():void
        {
            this.var_3899 = [];
            this.var_3894.declineAllFriendRequests();
            events.dispatchEvent(new FriendRequestUpdateEvent());
        }

        private function removeFriendRequest(param1:int):void
        {
            var _loc2_:FriendRequest;
            if (this.var_3899)
            {
                for each (_loc2_ in this.var_3899)
                {
                    if (_loc2_.id == param1)
                    {
                        this.var_3899.splice(this.var_3899.indexOf(_loc2_), 1);
                        events.dispatchEvent(new FriendRequestUpdateEvent());
                        return;
                    };
                };
            };
        }

        public function followToRoom(param1:int):void
        {
            if (this.var_3893)
            {
                this.var_3893.getHabboMainConnection(null).send(new FollowFriendMessageComposer(param1));
                this.var_3893.getHabboMainConnection(null).send(new EventLogMessageComposer(var_1374, var_1375, var_1376));
            };
        }

        public function startConversation(param1:int):void
        {
            if (this.var_3895)
            {
                this.var_3895.startConversation(param1);
                events.dispatchEvent(new NewMessageEvent(false, param1));
                if (this.var_3893)
                {
                    this.var_3893.getHabboMainConnection(null).send(new EventLogMessageComposer(var_1374, var_1375, var_1377));
                };
            };
        }

        public function findNewFriends():void
        {
            if (this.var_3893)
            {
                this.var_3893.getHabboMainConnection(null).send(new FindNewFriendsMessageComposer());
                this.var_3893.getHabboMainConnection(null).send(new EventLogMessageComposer(var_1374, var_1375, var_1378));
            };
        }

        public function toggleFriendList():void
        {
            var _loc1_:IWindowContainer;
            if (this.var_3894)
            {
                if (!this.var_3894.disposed)
                {
                    if (!this.var_3894.isOpen())
                    {
                        if (this.var_3899.length > 0)
                        {
                            this.var_3894.openFriendRequests();
                        }
                        else
                        {
                            this.var_3894.openFriendList();
                        };
                    }
                    else
                    {
                        _loc1_ = this.var_3894.mainWindow;
                        if (((!(_loc1_ == null)) && (WindowToggle.isHiddenByOtherWindows(_loc1_))))
                        {
                            _loc1_.activate();
                            return;
                        };
                        this.var_3894.close();
                    };
                    if (this.var_3893)
                    {
                        this.var_3893.getHabboMainConnection(null).send(new EventLogMessageComposer(var_1379, var_1380, ((this.var_3894.isOpen()) ? var_1381 : var_1382)));
                    };
                };
            };
        }

        public function toggleMessenger():void
        {
            if (this.var_3895)
            {
                if (!this.var_3895.disposed)
                {
                    this.var_3895.toggleMessenger();
                    if (this.var_3893)
                    {
                        this.var_3893.getHabboMainConnection(null).send(new EventLogMessageComposer(var_1379, var_1383, ((this.var_3895.isOpen()) ? var_1381 : var_1382)));
                    };
                };
            };
        }

        public function toggleOfflineStream():void
        {
            if (this.var_3896)
            {
                if (!this.var_3896.disposed)
                {
                    this.var_3896.visible = (!(this.var_3896.visible));
                };
            };
        }

        public function refreshOfflineStream():void
        {
            if (this.var_3896)
            {
                if (!this.var_3896.disposed)
                {
                    this.var_3896.refreshEventStream();
                };
            };
        }

        private function onConfigurationAvailable(param1:IID, param2:IUnknown):void
        {
            this.var_3892 = (param2 as IHabboConfigurationManager);
            this.var_3901 = this.var_3892.getBoolean("friendbar.notifications.enabled", false);
            this.var_3902 = this.var_3892.getBoolean("friendbar.requests.enabled", false);
        }

        private function onCommunicationManagerAvailable(param1:IID, param2:IUnknown):void
        {
            this.var_3893 = (param2 as IHabboCommunicationManager);
            this.var_3893.addHabboConnectionMessageEvent(new MessengerInitEvent(this.onMessengerInitialized));
            this.var_3893.addHabboConnectionMessageEvent(new FriendListUpdateEvent(this.onFriendListUpdate));
            this.var_3893.addHabboConnectionMessageEvent(new FindFriendsProcessResultEvent(this.onFindFriendProcessResult));
            this.var_3893.addHabboConnectionMessageEvent(new NewBuddyRequestEvent(this.onNewFriendRequest));
            this.var_3893.addHabboConnectionMessageEvent(new BuddyRequestsEvent(this.onFriendRequestList));
            this.var_3893.addHabboConnectionMessageEvent(new NewConsoleMessageEvent(this.onNewConsoleMessage));
            this.var_3893.addHabboConnectionMessageEvent(new RoomInviteEvent(this.onRoomInvite));
            this.var_3893.addHabboConnectionMessageEvent(new FriendNotificationEvent(this.onFriendNotification));
        }

        private function onMessengerComponentAvailable(param1:IID, param2:IUnknown):void
        {
            this.var_3895 = (param2 as IHabboMessenger);
        }

        private function onOfflineStreamAvailable(param1:IID, param2:IUnknown):void
        {
            this.var_3896 = (param2 as IHabboEventStream);
        }

        private function onFriendListComponentAvailable(param1:IID, param2:IUnknown):void
        {
            this.var_3894 = (param2 as IHabboFriendList);
            this.var_3894.events.addEventListener(FriendRequestEvent.var_345, this.onFriendRequestEvent);
            this.var_3894.events.addEventListener(FriendRequestEvent.var_1373, this.onFriendRequestEvent);
        }

        private function onMessengerInitialized(param1:IMessageEvent):void
        {
            this.buildFriendList(MessengerInitEvent(param1).getParser().friends);
        }

        private function onFriendListUpdate(param1:IMessageEvent):void
        {
            var _loc3_:FriendEntity;
            var _loc4_:FriendData;
            var _loc8_:int;
            var _loc2_:FriendListUpdateMessageParser = FriendListUpdateEvent(param1).getParser();
            var _loc5_:Array = _loc2_.removedFriendIds;
            var _loc6_:Array = _loc2_.updatedFriends;
            var _loc7_:Array = _loc2_.addedFriends;
            for each (_loc8_ in _loc5_)
            {
                _loc3_ = this.var_3898.getValue(_loc8_);
                if (_loc3_)
                {
                    this.var_3898.remove(_loc8_);
                    this.var_3897.splice(this.var_3897.indexOf(_loc3_), 1);
                };
            };
            for each (_loc4_ in _loc6_)
            {
                _loc3_ = this.var_3898.getValue(_loc4_.id);
                if (_loc3_)
                {
                    if (((_loc4_.online) || (var_1384)))
                    {
                        _loc3_.name = _loc4_.name;
                        _loc3_.realName = _loc4_.realName;
                        _loc3_.motto = _loc4_.motto;
                        _loc3_.gender = _loc4_.gender;
                        _loc3_.online = _loc4_.online;
                        _loc3_.allowFollow = _loc4_.followingAllowed;
                        _loc3_.figure = _loc4_.figure;
                        _loc3_.categoryId = _loc4_.categoryId;
                        _loc3_.lastAccess = _loc4_.lastAccess;
                    }
                    else
                    {
                        this.var_3898.remove(_loc4_.id);
                        this.var_3897.splice(this.var_3897.indexOf(_loc3_), 1);
                    };
                }
                else
                {
                    if (((_loc4_.online) || (var_1384)))
                    {
                        _loc3_ = new FriendEntity(_loc4_.id, _loc4_.name, _loc4_.realName, _loc4_.motto, _loc4_.gender, _loc4_.online, _loc4_.followingAllowed, _loc4_.figure, _loc4_.categoryId, _loc4_.lastAccess);
                        this.var_3897.splice(0, 0, _loc3_);
                        this.var_3898.add(_loc3_.id, _loc3_);
                    };
                };
            };
            for each (_loc4_ in _loc7_)
            {
                if (((_loc4_.online) || (var_1384)))
                {
                    if (this.var_3898.getValue(_loc4_.id) == null)
                    {
                        _loc3_ = new FriendEntity(_loc4_.id, _loc4_.name, _loc4_.realName, _loc4_.motto, _loc4_.gender, _loc4_.online, _loc4_.followingAllowed, _loc4_.figure, _loc4_.categoryId, _loc4_.lastAccess);
                        this.var_3897.push(_loc3_);
                        this.var_3898.add(_loc3_.id, _loc3_);
                    };
                };
                this.removeFriendRequest(_loc4_.id);
            };
            if (((_loc7_.length > 0) || (_loc6_.length > 0)))
            {
                this.var_3897 = ((var_1384) ? this.sortByNameAndOnlineStatus(this.var_3897) : this.sortByName(this.var_3897));
            };
            events.dispatchEvent(new FriendBarUpdateEvent());
        }

        private function onFindFriendProcessResult(param1:FindFriendsProcessResultEvent):void
        {
            events.dispatchEvent(new FindFriendsNotificationEvent(param1.success));
        }

        private function onNewFriendRequest(param1:NewBuddyRequestEvent):void
        {
            var _loc2_:FriendRequestData;
            if (this.var_3902)
            {
                _loc2_ = param1.getParser().req;
                this.var_3899.push(new FriendRequest(_loc2_.requestId, _loc2_.requesterName, _loc2_.figureString));
                events.dispatchEvent(new FriendRequestUpdateEvent());
            };
        }

        private function onFriendRequestList(param1:BuddyRequestsEvent):void
        {
            var _loc2_:Array;
            var _loc3_:FriendRequestData;
            if (this.var_3902)
            {
                _loc2_ = param1.getParser().reqs;
                for each (_loc3_ in _loc2_)
                {
                    this.var_3899.push(new FriendRequest(_loc3_.requestId, _loc3_.requesterName, _loc3_.figureString));
                };
                events.dispatchEvent(new FriendRequestUpdateEvent());
            };
        }

        private function onFriendRequestEvent(param1:FriendRequestEvent):void
        {
            this.removeFriendRequest(param1.requestId);
        }

        private function onNewConsoleMessage(param1:NewConsoleMessageEvent):void
        {
            var _loc4_:IConversation;
            var _loc2_:NewConsoleMessageMessageParser = param1.getParser();
            this.var_3900 = _loc2_.senderId;
            var _loc3_:Boolean = true;
            if (this.var_3895)
            {
                if (this.var_3895.isOpen())
                {
                    _loc4_ = this.var_3895.getActiveConversation();
                    if (_loc4_)
                    {
                        if (_loc4_.id == this.var_3900)
                        {
                            _loc3_ = false;
                        };
                    };
                };
            };
            if (_loc3_)
            {
                events.dispatchEvent(new NewMessageEvent(true, this.var_3900));
                this.makeNotification(String(this.var_3900), FriendNotification.var_1385, null, false, false);
            };
        }

        private function onRoomInvite(param1:RoomInviteEvent):void
        {
            var _loc2_:RoomInviteMessageParser = param1.getParser();
            this.var_3900 = _loc2_.senderId;
            if (((this.var_3895) && (!(this.var_3895.isOpen()))))
            {
                events.dispatchEvent(new NewMessageEvent(true, this.var_3900));
                this.makeNotification(String(this.var_3900), FriendNotification.var_1385, null, true, false);
            };
        }

        private function onFriendNotification(param1:FriendNotificationEvent):void
        {
            var _loc2_:FriendNotificationMessageParser = param1.getParser();
            this.makeNotification(_loc2_.avatarId, _loc2_.typeCode, _loc2_.message, true, true);
        }

        private function makeNotification(param1:String, param2:int, param3:String, param4:Boolean, param5:Boolean):void
        {
            var _loc6_:IFriendEntity;
            var _loc7_:FriendNotification;
            var _loc8_:Vector.<FriendNotification>;
            if (this.var_3901)
            {
                _loc6_ = this.getFriendByID(parseInt(param1));
                if (_loc6_)
                {
                    _loc8_ = _loc6_.notifications;
                    for each (_loc7_ in _loc8_)
                    {
                        if (_loc7_.typeCode == param2)
                        {
                            _loc7_.message = param3;
                            _loc7_.viewOnce = param4;
                            break;
                        };
                        _loc7_ = null;
                    };
                    if (!_loc7_)
                    {
                        _loc7_ = new FriendNotification(param2, param3, param4);
                        _loc8_.push(_loc7_);
                    };
                    events.dispatchEvent(new NotificationEvent(_loc6_.id, _loc7_));
                    if (param5)
                    {
                        this.setFriendAt(_loc6_, 0);
                    };
                    if (_loc6_.logEventId < 0)
                    {
                        _loc6_.logEventId = _loc6_.getNextLogEventId();
                    };
                    HabboTracking.getInstance().trackEventLog("FriendBar", FriendNotification.typeCodeToString(param2), "notified", "", ((_loc6_.logEventId > 0) ? _loc6_.logEventId : 0));
                };
            };
        }

        private function buildFriendList(param1:Array):void
        {
            var _loc2_:FriendData;
            var _loc3_:FriendEntity;
            for each (_loc2_ in param1)
            {
                if (((_loc2_.online) || (var_1384)))
                {
                    _loc3_ = new FriendEntity(_loc2_.id, _loc2_.name, _loc2_.realName, _loc2_.motto, _loc2_.gender, _loc2_.online, _loc2_.followingAllowed, _loc2_.figure, _loc2_.categoryId, _loc2_.lastAccess);
                    this.var_3897.push(_loc3_);
                    this.var_3898.add(_loc3_.id, _loc3_);
                };
            };
            this.var_3897 = ((var_1384) ? this.sortByNameAndOnlineStatus(this.var_3897) : this.sortByName(this.var_3897));
            events.dispatchEvent(new FriendBarUpdateEvent());
        }

        private function sortByName(param1:Array):Array
        {
            if (var_1386)
            {
                param1.sortOn("name", [Array.CASEINSENSITIVE]);
            };
            return (param1);
        }

        private function sortByNameAndOnlineStatus(param1:Array):Array
        {
            var _loc4_:FriendEntity;
            var _loc2_:Array = [];
            var _loc3_:Array = [];
            var _loc5_:int = param1.length;
            while (_loc5_-- > 0)
            {
                _loc4_ = param1[_loc5_];
                if (_loc4_.online)
                {
                    _loc2_.push(_loc4_);
                }
                else
                {
                    _loc3_.push(_loc4_);
                };
            };
            if (var_1386)
            {
                _loc2_.sortOn("name", [Array.CASEINSENSITIVE]);
                _loc3_.sortOn("name", [(Array.CASEINSENSITIVE | Array.DESCENDING)]);
            };
            _loc5_ = _loc3_.length;
            while (_loc5_-- > 0)
            {
                _loc2_.push(_loc3_.pop());
            };
            return (_loc2_);
        }


    }
}