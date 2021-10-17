package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.users.UserNotificationMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.events.RoomSessionUserNotificationEvent;

    public class UserNotificationHandler extends BaseHandler 
    {

        public function UserNotificationHandler(param1:IConnection, param2:IRoomHandlerListener)
        {
            super(param1, param2);
            if (param1 == null)
            {
                return;
            };
            param1.addMessageEvent(new UserNotificationMessageEvent(this.onUserNotification));
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                super.dispose();
            };
        }

        private function onUserNotification(param1:UserNotificationMessageEvent):void
        {
            var _loc2_:IRoomSession = listener.getSession(_xxxRoomId, var_99);
            var _loc3_:RoomSessionUserNotificationEvent = new RoomSessionUserNotificationEvent(RoomSessionUserNotificationEvent.var_375, _loc2_);
            _loc3_.title = param1.title;
            _loc3_.message = param1.message;
            _loc3_.parameters = param1.parameters;
            if (((listener) && (listener.events)))
            {
                listener.events.dispatchEvent(_loc3_);
            };
        }


    }
}