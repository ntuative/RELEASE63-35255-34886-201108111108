package com.sulake.habbo.friendbar.stream
{
    import com.sulake.habbo.friendbar.view.AbstractView;
    import com.sulake.core.window.IWindowContainer;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.connection.IConnection;
    import flash.utils.Timer;
    import com.sulake.habbo.friendbar.view.IHabboFriendBarView;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.utils.Map;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboFriendBarView;
    import flash.events.TimerEvent;
    import com.sulake.habbo.friendbar.HabboFriendBar;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.communication.messages.incoming.friendlist.EventStreamData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.localization.ILocalization;
    import com.sulake.habbo.friendbar.utils.LinkTarget;
    import flash.display.BitmapData;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.GetEventStreamComposer;
    import com.sulake.habbo.communication.messages.incoming.friendlist.EventStreamEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.friendbar.utils.TestMessageWrapper;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.SetEventStreamingAllowedComposer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.LikeStreamEventMessageComposer;
    import __AS3__.vec.*;
    import com.sulake.habbo.friendbar.view.*;

    public class HabboEventStream extends AbstractView implements IHabboEventStream 
    {

        private static const var_1369:String = "page_content";
        private static const var_1365:String = "page_welcome";
        private static const var_1367:String = "page_empty";
        private static const var_1310:String = "list";
        private static const var_222:String = "header";
        private static const var_1282:String = "badge";
        private static const CLOSE:String = "close";
        private static const var_1364:String = "scroll";
        private static const var_1366:String = "image";
        private static const var_1362:String = "disable_stream";
        private static const ACTIVATE:String = "activate_stream";
        private static const var_1363:String = "see_more";
        private static const var_1370:uint = 0;
        private static const var_3908:uint = 1;
        private static const var_1344:int = -2;
        private static const var_1343:int = -3;
        private static const var_1345:int = 42;
        private static const var_1368:int = (1000 * 60);//60000
        private static const var_1342:int = (1000 * 60);//60000
        private static const GENDER_LOCALIZATION_PREFIX:String = "friendbar.stream.";

        private var _window:IWindowContainer;
        private var var_3911:Vector.<EventStreamEntity>;
        private var _connection:IConnection;
        private var var_2709:Boolean = false;
        private var var_3912:Timer;
        private var var_3907:Timer;
        private var var_3913:IHabboFriendBarView;
        private var var_3893:IHabboCommunicationManager;
        private var var_3909:Boolean;
        private var var_3914:Vector.<int> = new Vector.<int>();
        private var var_3915:Boolean = false;
        private var var_3916:Boolean = false;
        private var var_3917:Boolean = false;
        private var var_3910:int = 1;
        private var var_3918:Array = ["friend_made", "room_liked", "achievement_earned", "motto_changed", "room_decorated"];
        private var var_3919:Array = ["no_link", "open_mini_profile", "visit_room", "open_achievements", "open_motto_changer", "friend_request"];
        private var var_3906:Map = new Map();

        public function HabboEventStream(param1:HabboFriendBar, param2:uint, param3:IAssetLibrary)
        {
            super(param1, param2, param3);
            this.var_3911 = new Vector.<EventStreamEntity>();
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationManagerAvailable);
            queueInterface(new IIDHabboFriendBarView(), this.onFriendBarViewAvailable);
            this.var_3906.add("m", "his");
            this.var_3906.add("f", "her");
            if (!this.var_3907)
            {
                this.var_3907 = new Timer(var_1342);
                this.var_3907.addEventListener(TimerEvent.TIMER, this.onRefreshTimerEvent);
            };
        }

        public function set visible(param1:Boolean):void
        {
            if (!this._window)
            {
                this.setupUserInterface();
            };
            this._window.visible = param1;
            if (param1)
            {
                this._window.x = (this._window.desktop.width - (this._window.width + var_1343));
                this._window.y = var_1344;
                this._window.height = (this._window.desktop.height - (var_1344 + var_1345));
                this._window.activate();
                if (this.var_3909)
                {
                    this.requestEventStreamData(this.var_3910);
                };
            };
        }

        public function get visible():Boolean
        {
            return ((this._window) ? this._window.visible : false);
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                if (this.var_3912)
                {
                    this.var_3912.stop();
                    this.var_3912.removeEventListener(TimerEvent.TIMER, this.onMinuteTimerEvent);
                    this.var_3912 = null;
                };
                if (this.var_3907)
                {
                    this.var_3907.stop();
                    this.var_3907.removeEventListener(TimerEvent.TIMER, this.onRefreshTimerEvent);
                    this.var_3907 = null;
                };
                while (this.var_3911.length > 0)
                {
                    this.var_3911.pop().dispose();
                };
                if (EventStreamEntity.var_1346)
                {
                    EventStreamEntity.var_1346.dispose();
                };
                EventStreamEntity.var_1346 = null;
                EventStreamEntity.var_1347 = null;
                EventStreamEntity.ASSETS = null;
                EventStreamEntity.var_1348 = null;
                if (this._window)
                {
                    this._window.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseClick);
                    this._window.dispose();
                    this._window = null;
                };
                if (this.var_3893)
                {
                    if (!this.var_3893.disposed)
                    {
                        this.var_3893.release(new IIDHabboCommunicationManager());
                        this.var_3893 = null;
                    };
                };
                if (this.var_3913)
                {
                    if (!this.var_3913.disposed)
                    {
                        this.var_3913.release(new IIDHabboFriendBarView());
                        this.var_3913 = null;
                    };
                };
                super.dispose();
            };
        }

        private function clearStreamList():void
        {
            while (this.var_3911.length > 0)
            {
                this.var_3911.pop().recycle();
            };
        }

        public function populate(param1:Vector.<EventStreamData>):void
        {
            var _loc2_:Boolean;
            var _loc3_:EventStreamEntity;
            var _loc4_:IItemListWindow;
            var _loc5_:int;
            var _loc6_:EventStreamData;
            var _loc7_:IItemListWindow;
            var _loc8_:IWindow;
            var _loc9_:EventStreamData;
            if (!this._window)
            {
                this.setupUserInterface();
            };
            if (this.visible)
            {
                this.clearStreamList();
                _loc2_ = ((this.var_3911.length % 2) == 0);
                _loc4_ = (this._window.findChildByName(var_1310) as IItemListWindow);
                _loc5_ = 0;
                for each (_loc6_ in param1)
                {
                    _loc3_ = EventStreamEntity.allocate();
                    _loc3_.id = _loc6_.id;
                    _loc3_.title = _loc6_.accountName;
                    _loc3_.message = this.resolveMessageText(_loc6_);
                    _loc3_.linkTarget = this.resolveLinkTarget(_loc6_);
                    _loc3_.numberOfLikes = _loc6_.numberOfLikes;
                    _loc3_.isLikingEnabled = this.var_3917;
                    _loc3_.isLikable = ((_loc6_.isLikable) && (this.var_3917));
                    _loc3_.minutesElapsed = _loc6_.minutesSinceEvent;
                    _loc3_.even = _loc2_;
                    this.resolveImagePath(_loc3_, _loc6_);
                    this.var_3911.push(_loc3_);
                    _loc4_.addListItem(_loc3_.window);
                    _loc2_ = (!(_loc2_));
                    if (this.var_3914.indexOf(_loc6_.id) == -1)
                    {
                        _loc5_++;
                        this.var_3914.push(_loc6_.id);
                    };
                };
                if (param1.length == 0)
                {
                };
                _loc7_ = (this._window.findChildByName(var_222) as IItemListWindow);
                _loc8_ = _loc7_.getListItemByName(var_1282);
                _loc8_.visible = false;
                this.var_3915 = false;
            }
            else
            {
                for each (_loc9_ in param1)
                {
                    if (this.var_3914.indexOf(_loc9_.id) == -1)
                    {
                        this.var_3915 = true;
                        break;
                    };
                };
            };
            this.selectCorrectView();
        }

        private function resolveMessageText(param1:EventStreamData):String
        {
            var _loc6_:ILocalization;
            var _loc2_:int = param1.actionId;
            var _loc3_:String = ("friendbar.stream.type." + this.var_3918[_loc2_]);
            var _loc4_:ILocalization = var_1312.getLocalization(_loc3_);
            if (!_loc4_)
            {
                return (_loc3_);
            };
            var _loc5_:String = _loc4_.raw;
            switch (_loc2_)
            {
                case EventStreamData.var_1349:
                    _loc5_ = _loc5_.replace("%targetString%", param1.extraDataStruct.friendName);
                    break;
                case EventStreamData.var_1350:
                    _loc5_ = _loc5_.replace("%targetString%", param1.extraDataStruct.roomName);
                    break;
                case EventStreamData.var_1351:
                    _loc5_ = _loc5_.replace("%targetString%", var_1312.getAchievementName(param1.extraDataStruct.achievementCode));
                    break;
                case EventStreamData.var_1352:
                    _loc6_ = var_1312.getLocalization((GENDER_LOCALIZATION_PREFIX + this.var_3906.getValue(param1.accountGender)));
                    _loc5_ = _loc5_.replace("%gender%", _loc6_.value);
                    _loc5_ = _loc5_.replace("%targetString%", param1.extraDataStruct.motto);
                    break;
                case EventStreamData.var_1353:
                    break;
            };
            return (_loc5_);
        }

        private function resolveLinkTarget(param1:EventStreamData):LinkTarget
        {
            var _loc3_:String;
            var _loc2_:String = ("friendbar.stream.link." + this.var_3919[param1.linkTargetType]);
            var _loc4_:uint = LinkTarget.NONE;
            var _loc5_:uint;
            var _loc6_:String;
            var _loc7_:ILocalization = var_1312.getLocalization(_loc2_);
            _loc3_ = ((_loc7_) ? _loc7_.raw : "");
            switch (param1.linkTargetType)
            {
                case EventStreamData.var_1357:
                    _loc4_ = LinkTarget.NONE;
                    _loc3_ = "";
                    break;
                case EventStreamData.var_1358:
                    _loc3_ = _loc3_.replace("%targetString%", param1.extraDataStruct.friendName);
                    _loc4_ = LinkTarget.var_1355;
                    _loc5_ = param1.extraDataStruct.friendId;
                    break;
                case EventStreamData.var_1359:
                    _loc4_ = LinkTarget.ROOM;
                    _loc5_ = param1.extraDataStruct.roomId;
                    break;
                case EventStreamData.var_1360:
                    _loc4_ = LinkTarget.ACHIEVEMENTS;
                    break;
                case EventStreamData.LINK_TARGET_OPEN_MOTTO_CHANGER:
                    _loc4_ = LinkTarget.var_1356;
                    _loc5_ = var_1354.userId;
                    break;
                case EventStreamData.var_1361:
                    _loc3_ = _loc3_.replace("%targetString%", param1.extraDataStruct.friendName);
                    _loc4_ = LinkTarget.var_374;
                    _loc5_ = param1.extraDataStruct.friendId;
                    _loc6_ = param1.extraDataStruct.friendName;
                    break;
            };
            return (new LinkTarget(_loc3_, _loc4_, _loc5_, _loc6_));
        }

        private function resolveImagePath(entity:EventStreamEntity, data:EventStreamData):void
        {
            var image:BitmapData;
            var callback:Function;
            var result:String = data.imageFilePath;
            var action:int = data.actionId;
            switch (action)
            {
                case EventStreamData.var_1351:
                    image = var_1354.requestBadgeImage(data.extraDataStruct.achievementCode);
                    if (image)
                    {
                        entity.image = image;
                    }
                    else
                    {
                        callback = function (param1:BadgeImageReadyEvent):void
                        {
                            if (param1.badgeId == data.extraDataStruct.achievementCode)
                            {
                                entity.image = param1.badgeImage;
                                var_1354.events.removeEventListener(BadgeImageReadyEvent.var_100, arguments.callee);
                            };
                        };
                        var_1354.events.addEventListener(BadgeImageReadyEvent.var_100, callback);
                    };
                    return;
                default:
                    entity.imageFilePath = result;
            };
        }

        private function setupUserInterface():void
        {
            var scroll:IScrollbarWindow;
            var page:IWindowContainer;
            var image:IBitmapWrapperWindow;
            var list:IItemListWindow;
            var item:IWindowContainer;
            var icon:IBitmapWrapperWindow;
            if (!this._window)
            {
                this._window = (_windowManager.buildFromXML((assets.getAssetByName("event_stream_display_xml").content as XML)) as IWindowContainer);
                this._window.height = (this._window.desktop.height - (var_1344 + var_1345));
                this._window.setParamFlag(WindowParam.var_685);
                this._window.setParamFlag(WindowParam.var_690);
                this._window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseClick);
                this._window.findChildByName(CLOSE).addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseClick);
                this._window.findChildByName(var_1362).addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseClick);
                this._window.findChildByName(ACTIVATE).addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseClick);
                this._window.findChildByName(var_1363).addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseClick);
                this._window.visible = false;
                scroll = (this._window.findChildByName(var_1364) as IScrollbarWindow);
                if (scroll)
                {
                    scroll.addEventListener(WindowEvent.var_584, function (param1:WindowEvent):void
                    {
                        var _loc2_:IScrollbarWindow = (param1.target as IScrollbarWindow);
                        if (_loc2_)
                        {
                            _loc2_.visible = true;
                            _loc2_.scrollable.width = (_loc2_.scrollable.parent.width - _loc2_.width);
                        };
                    });
                    scroll.addEventListener(WindowEvent.var_586, function (param1:WindowEvent):void
                    {
                        scroll.visible = false;
                        scroll.scrollable.width = scroll.scrollable.parent.width;
                    });
                    scroll.visible = false;
                    scroll.scrollable.width = scroll.scrollable.parent.width;
                };
                page = (this._window.findChildByName(var_1365) as IWindowContainer);
                image = (page.findChildByName(var_1366) as IBitmapWrapperWindow);
                image.bitmap = (assets.getAssetByName(image.bitmapAssetName).content as BitmapData);
                page = (this._window.findChildByName(var_1367) as IWindowContainer);
                image = (page.findChildByName(var_1366) as IBitmapWrapperWindow);
                image.bitmap = (assets.getAssetByName(image.bitmapAssetName).content as BitmapData);
                this.selectCorrectView();
                list = (this._window.findChildByName(var_1310) as IItemListWindow);
                item = (list.removeListItemAt(0) as IWindowContainer);
                icon = (IWindowContainer(item.findChildByName("like")).findChildByName("icon") as IBitmapWrapperWindow);
                icon.bitmap = (assets.getAssetByName("stream_thumb_png").content as BitmapData);
                icon.disposesBitmap = false;
                EventStreamEntity.var_1348 = this;
                EventStreamEntity.var_1346 = item;
                EventStreamEntity.var_1347 = var_1312;
                EventStreamEntity.ASSETS = assets;
                if (!this.var_3912)
                {
                    this.var_3912 = new Timer(var_1368);
                    this.var_3912.addEventListener(TimerEvent.TIMER, this.onMinuteTimerEvent);
                    this.var_3912.start();
                };
            };
        }

        private function selectCorrectView():void
        {
            var _loc1_:IWindow = this._window.findChildByName(var_1369);
            var _loc2_:IWindow = this._window.findChildByName(var_1365);
            var _loc3_:IWindow = this._window.findChildByName(var_1367);
            if (this.var_3909)
            {
                _loc1_.visible = true;
                _loc2_.visible = false;
                _loc3_.visible = (this.var_3911.length == 0);
            }
            else
            {
                _loc1_.visible = false;
                _loc2_.visible = true;
                _loc3_.visible = false;
            };
        }

        private function onMouseClick(param1:WindowMouseEvent):void
        {
            switch (param1.target.name)
            {
                case CLOSE:
                    this.visible = false;
                    return;
                case var_1362:
                    this.changeStreamState(false);
                    return;
                case ACTIVATE:
                    this.changeStreamState(true);
                    return;
                case var_1363:
                    _windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, null);
                    HabboWebTools.openWebPage(var_1322.getKey("link.friendbar.stream.settings.see.more", ""));
                    return;
            };
        }

        private function changeStreamState(param1:Boolean):void
        {
            this.var_3909 = param1;
            this.sendSetEventStreamingEnabled(param1);
            this.selectCorrectView();
            if (param1)
            {
                this.var_3907.start();
                this.refreshEventStream();
            }
            else
            {
                this.var_3907.stop();
            };
            Logger.log(("Streaming enabled: " + param1));
        }

        private function onMinuteTimerEvent(param1:TimerEvent):void
        {
            var _loc2_:EventStreamEntity;
            for each (_loc2_ in this.var_3911)
            {
                _loc2_.minutesElapsed = (_loc2_.minutesElapsed + 1);
            };
        }

        private function onRefreshTimerEvent(param1:TimerEvent):void
        {
            if (((this.visible) || (!(this.var_3915))))
            {
                this.requestEventStreamData(this.var_3910);
            };
        }

        private function requestEventStreamData(param1:uint):void
        {
            if ((((this._connection) && (this._connection.connected)) && (this.var_3916)))
            {
                this._connection.send(new GetEventStreamComposer(((param1 == var_1370) ? GetEventStreamComposer.var_1371 : GetEventStreamComposer.var_1372)));
                this.var_2709 = true;
                Logger.log(("Requested stream events in mode " + param1));
            };
        }

        private function onCommunicationManagerAvailable(param1:IID, param2:IUnknown):void
        {
            this.var_3893 = (param2 as IHabboCommunicationManager);
            this.var_3893.addHabboConnectionMessageEvent(new EventStreamEvent(this.onEventStreamEvent));
            this.var_3893.addHabboConnectionMessageEvent(new UserObjectEvent(this.onUserObjectEvent));
            this._connection = this.var_3893.getHabboMainConnection(this.onConnectionInstanceAvailable);
        }

        private function onConnectionInstanceAvailable(param1:IConnection):void
        {
            this._connection = param1;
        }

        private function onEventStreamEvent(param1:EventStreamEvent):void
        {
            this.populate(param1.events);
            this.var_3913.setStreamIconNotify(((!(this.visible)) && (this.var_3915)));
        }

        private function testEventStream(param1:int=1):void
        {
            var _loc2_:Vector.<EventStreamData> = new Vector.<EventStreamData>();
            var _loc3_:int;
            while (_loc3_ < param1)
            {
                _loc2_.push(new EventStreamData(_loc3_, EventStreamData.var_1349, String((_loc3_ * 1000)), ("FooBar" + _loc3_), "m", "http://d63.varoke.net/habbo-imaging/badge/b1003Xs05175s05173s091145ec244dcc5eaf54aaabf367665f39c67.gif", _loc3_, EventStreamData.var_1358, 3, true, new TestMessageWrapper(["1234", ("Friend's friend" + _loc3_)])));
                _loc3_++;
            };
            this.populate(_loc2_);
        }

        private function onFriendBarViewAvailable(param1:IID, param2:IUnknown):void
        {
            this.var_3913 = (param2 as IHabboFriendBarView);
        }

        override protected function onConfigurationAvailable(param1:IID, param2:IUnknown):void
        {
            super.onConfigurationAvailable(param1, param2);
            this.var_3916 = var_1322.getBoolean("friendbar.stream.enabled", false);
            this.var_3917 = var_1322.getBoolean("friendbar.stream.liking.enabled", false);
        }

        private function sendSetEventStreamingEnabled(param1:Boolean):void
        {
            if (((this._connection) && (this._connection.connected)))
            {
                this._connection.send(new SetEventStreamingAllowedComposer(param1));
            };
        }

        private function onUserObjectEvent(param1:UserObjectEvent):void
        {
            this.var_3909 = param1.getParser().streamPublishingAllowed;
            if (this.var_3909)
            {
                this.var_3907.start();
            };
            Logger.log(("Stream events allowed " + this.var_3909));
        }

        public function refreshEventStream():void
        {
            if (this.var_3909)
            {
                this.requestEventStreamData(this.var_3910);
            };
        }

        public function likeStreamEvent(param1:EventStreamEntity):void
        {
            if (((((this._connection) && (this._connection.connected)) && (this.var_3916)) && (this.var_3917)))
            {
                param1.isLikable = false;
                param1.numberOfLikes++;
                this._connection.send(new LikeStreamEventMessageComposer(param1.id, var_1354.userId));
                Logger.log(("Like event " + param1));
            };
        }


    }
}