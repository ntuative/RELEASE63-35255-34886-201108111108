package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.session.events.RoomSessionPropertyUpdateEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class RoomDataHandler extends BaseHandler 
    {

        public function RoomDataHandler(param1:IConnection, param2:IRoomHandlerListener)
        {
            super(param1, param2);
            if (param1 == null)
            {
                return;
            };
            param1.addMessageEvent(new GetGuestRoomResultEvent(this.onRoomResult));
        }

        private function onRoomResult(param1:IMessageEvent):void
        {
            var _loc2_:GetGuestRoomResultEvent = (param1 as GetGuestRoomResultEvent);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:GetGuestRoomResultMessageParser = _loc2_.getParser();
            if (_loc3_.roomForward)
            {
                return;
            };
            var _loc4_:IRoomSession = listener.getSession(_xxxRoomId, var_99);
            if (_loc4_ == null)
            {
                return;
            };
            var _loc5_:GuestRoomData = _loc3_.data;
            _loc4_.isTradingRoom = _loc5_.allowTrading;
            _loc4_.arePetsAllowed = _loc5_.allowPets;
            listener.events.dispatchEvent(new RoomSessionPropertyUpdateEvent(RoomSessionPropertyUpdateEvent.var_250, _loc4_));
        }


    }
}