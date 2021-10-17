package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetUserLocationMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFriendRequestMessage;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.IUserData;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserLocationUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionFriendRequestEvent;
    import com.sulake.habbo.friendlist.events.FriendRequestEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFriendRequestUpdateEvent;
    import flash.events.Event;

    public class FriendRequestWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;


        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get type():String
        {
            return (RoomWidgetEnum.var_418);
        }

        public function set container(param1:IRoomWidgetHandlerContainer):void
        {
            this._container = param1;
        }

        public function dispose():void
        {
            this._disposed = true;
            this._container = null;
        }

        public function getWidgetMessages():Array
        {
            var _loc1_:Array = [];
            _loc1_.push(RoomWidgetGetUserLocationMessage.var_2315);
            _loc1_.push(RoomWidgetFriendRequestMessage.var_1595);
            _loc1_.push(RoomWidgetFriendRequestMessage.var_1596);
            return (_loc1_);
        }

        public function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _loc2_:RoomWidgetGetUserLocationMessage;
            var _loc3_:IRoomSession;
            var _loc4_:IUserData;
            var _loc5_:Rectangle;
            var _loc6_:Point;
            var _loc7_:RoomWidgetFriendRequestMessage;
            var _loc8_:RoomWidgetFriendRequestMessage;
            var _loc9_:Rectangle;
            if (((!(param1)) || (!(this._container))))
            {
                return (null);
            };
            switch (param1.type)
            {
                case RoomWidgetGetUserLocationMessage.var_2315:
                    _loc2_ = (param1 as RoomWidgetGetUserLocationMessage);
                    if (!_loc2_)
                    {
                        return (null);
                    };
                    _loc3_ = this._container.roomSession;
                    if (((!(_loc3_)) || (!(_loc3_.userDataManager))))
                    {
                        return (null);
                    };
                    _loc4_ = _loc3_.userDataManager.getUserDataByType(_loc2_.userId, _loc2_.userType);
                    if (_loc4_)
                    {
                        _loc5_ = this._container.roomEngine.getRoomObjectBoundingRectangle(_loc3_.roomId, _loc3_.roomCategory, _loc4_.id, RoomObjectCategoryEnum.OBJECT_CATEGORY_USER, this._container.getFirstCanvasId());
                        _loc6_ = this._container.roomEngine.getRoomObjectScreenLocation(_loc3_.roomId, _loc3_.roomCategory, _loc4_.id, RoomObjectCategoryEnum.OBJECT_CATEGORY_USER, this._container.getFirstCanvasId());
                        _loc9_ = this._container.getRoomViewRect();
                        if ((((_loc5_) && (_loc9_)) && (_loc6_)))
                        {
                            _loc5_.offset(_loc9_.x, _loc9_.y);
                            _loc6_.offset(_loc9_.x, _loc9_.y);
                        };
                    };
                    return (new RoomWidgetUserLocationUpdateEvent(_loc2_.userId, _loc5_, _loc6_));
                case RoomWidgetFriendRequestMessage.var_1595:
                    _loc7_ = (param1 as RoomWidgetFriendRequestMessage);
                    if (((!(_loc7_)) || (!(this._container.friendList))))
                    {
                        return (null);
                    };
                    this._container.friendList.acceptFriendRequest(_loc7_.requestId);
                    break;
                case RoomWidgetFriendRequestMessage.var_1596:
                    _loc8_ = (param1 as RoomWidgetFriendRequestMessage);
                    if (((!(_loc8_)) || (!(this._container.friendList))))
                    {
                        return (null);
                    };
                    this._container.friendList.declineFriendRequest(_loc8_.requestId);
                    break;
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            var _loc1_:Array = [];
            _loc1_.push(RoomSessionFriendRequestEvent.var_374);
            _loc1_.push(FriendRequestEvent.var_345);
            _loc1_.push(FriendRequestEvent.var_1373);
            return (_loc1_);
        }

        public function processEvent(param1:Event):void
        {
            var _loc2_:RoomWidgetFriendRequestUpdateEvent;
            var _loc3_:String;
            var _loc4_:RoomSessionFriendRequestEvent;
            var _loc5_:FriendRequestEvent;
            if (((this._container == null) || (this._container.events == null)))
            {
                return;
            };
            switch (param1.type)
            {
                case RoomSessionFriendRequestEvent.var_374:
                    _loc4_ = (param1 as RoomSessionFriendRequestEvent);
                    if (!_loc4_)
                    {
                        return;
                    };
                    _loc3_ = RoomWidgetFriendRequestUpdateEvent.var_1593;
                    _loc2_ = new RoomWidgetFriendRequestUpdateEvent(_loc3_, _loc4_.requestId, _loc4_.userId, _loc4_.userName);
                    break;
                case FriendRequestEvent.var_345:
                case FriendRequestEvent.var_1373:
                    _loc5_ = (param1 as FriendRequestEvent);
                    if (!_loc5_)
                    {
                        return;
                    };
                    _loc3_ = RoomWidgetFriendRequestUpdateEvent.var_1594;
                    _loc2_ = new RoomWidgetFriendRequestUpdateEvent(_loc3_, _loc5_.requestId);
                    break;
            };
            if (_loc2_)
            {
                this._container.events.dispatchEvent(_loc2_);
            };
        }

        public function update():void
        {
        }


    }
}