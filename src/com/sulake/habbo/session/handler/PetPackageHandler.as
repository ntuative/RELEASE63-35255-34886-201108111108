package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.room.furniture.OpenPetPackageRequestedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.OpenPetPackageResultMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.parser.room.furniture.OpenPetPackageRequestedMessageParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.events.RoomSessionPetPackageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.OpenPetPackageResultMessageParser;

    public class PetPackageHandler extends BaseHandler 
    {

        public function PetPackageHandler(param1:IConnection, param2:IRoomHandlerListener)
        {
            super(param1, param2);
            if (param1 == null)
            {
                return;
            };
            param1.addMessageEvent(new OpenPetPackageRequestedMessageEvent(this.onOpenPetPackageRequested));
            param1.addMessageEvent(new OpenPetPackageResultMessageEvent(this.onOpenPetPackageResult));
        }

        private function onOpenPetPackageRequested(param1:IMessageEvent):void
        {
            var _loc2_:OpenPetPackageRequestedMessageParser = (param1 as OpenPetPackageRequestedMessageEvent).getParser();
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:IRoomSession = listener.getSession(_xxxRoomId, var_99);
            if (_loc3_ == null)
            {
                return;
            };
            if (((listener) && (listener.events)))
            {
                listener.events.dispatchEvent(new RoomSessionPetPackageEvent(RoomSessionPetPackageEvent.var_347, _loc3_, _loc2_.objectId, _loc2_.petType, _loc2_.breed, _loc2_.color, 0, null));
            };
        }

        private function onOpenPetPackageResult(param1:IMessageEvent):void
        {
            var _loc2_:OpenPetPackageResultMessageParser = (param1 as OpenPetPackageResultMessageEvent).getParser();
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:IRoomSession = listener.getSession(_xxxRoomId, var_99);
            if (_loc3_ == null)
            {
                return;
            };
            if (((listener) && (listener.events)))
            {
                listener.events.dispatchEvent(new RoomSessionPetPackageEvent(RoomSessionPetPackageEvent.var_348, _loc3_, _loc2_.objectId, -1, -1, "", _loc2_.nameValidationStatus, _loc2_.nameValidationInfo));
            };
        }


    }
}