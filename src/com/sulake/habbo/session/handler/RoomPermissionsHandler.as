package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreControllerMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreNotControllerMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreOwnerMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class RoomPermissionsHandler extends BaseHandler 
    {

        public function RoomPermissionsHandler(param1:IConnection, param2:IRoomHandlerListener)
        {
            super(param1, param2);
            if (param1 == null)
            {
                return;
            };
            param1.addMessageEvent(new YouAreControllerMessageEvent(this.onYouAreController));
            param1.addMessageEvent(new YouAreNotControllerMessageEvent(this.onYouAreNotController));
            param1.addMessageEvent(new YouAreOwnerMessageEvent(this.onYouAreOwner));
        }

        private function onYouAreController(param1:IMessageEvent):void
        {
            var _loc2_:YouAreControllerMessageEvent = (param1 as YouAreControllerMessageEvent);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:IRoomSession = listener.getSession(_xxxRoomId, var_99);
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.isRoomController = true;
        }

        private function onYouAreNotController(param1:IMessageEvent):void
        {
            var _loc2_:YouAreNotControllerMessageEvent = (param1 as YouAreNotControllerMessageEvent);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:IRoomSession = listener.getSession(_xxxRoomId, var_99);
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.isRoomController = false;
        }

        private function onYouAreOwner(param1:IMessageEvent):void
        {
            var _loc2_:YouAreOwnerMessageEvent = (param1 as YouAreOwnerMessageEvent);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:IRoomSession = listener.getSession(_xxxRoomId, var_99);
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.isRoomOwner = true;
        }


    }
}