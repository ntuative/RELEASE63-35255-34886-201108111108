package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.room.engine.PlaceObjectErrorMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.parser.room.engine.PlaceObjectErrorMessageParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.events.RoomSessionErrorMessageEvent;
    import com.sulake.habbo.session.enum.PlaceObjectErrorEnum;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class PlaceObjectErrorHandler extends BaseHandler 
    {

        public function PlaceObjectErrorHandler(param1:IConnection, param2:IRoomHandlerListener)
        {
            super(param1, param2);
            if (param1 == null)
            {
                return;
            };
            param1.addMessageEvent(new PlaceObjectErrorMessageEvent(this.onPlaceObjectError));
        }

        private function onPlaceObjectError(param1:IMessageEvent):void
        {
            var _loc4_:String;
            var _loc2_:PlaceObjectErrorMessageParser = (param1 as PlaceObjectErrorMessageEvent).getParser();
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:IRoomSession = listener.getSession(_xxxRoomId, var_99);
            if (_loc3_ == null)
            {
                return;
            };
            switch (_loc2_.errorCode)
            {
                case PlaceObjectErrorEnum.var_351:
                    _loc4_ = RoomSessionErrorMessageEvent.var_351;
                    break;
                case PlaceObjectErrorEnum.var_352:
                    _loc4_ = RoomSessionErrorMessageEvent.var_352;
                    break;
                case PlaceObjectErrorEnum.var_356:
                    _loc4_ = RoomSessionErrorMessageEvent.var_356;
                    break;
                case PlaceObjectErrorEnum.var_365:
                    _loc4_ = RoomSessionErrorMessageEvent.var_365;
                    break;
                case PlaceObjectErrorEnum.var_357:
                    _loc4_ = RoomSessionErrorMessageEvent.var_357;
                    break;
                case PlaceObjectErrorEnum.var_358:
                    _loc4_ = RoomSessionErrorMessageEvent.var_358;
                    break;
                case PlaceObjectErrorEnum.var_359:
                    _loc4_ = RoomSessionErrorMessageEvent.var_359;
                    break;
                default:
                    return;
            };
            if (((listener) && (listener.events)))
            {
                listener.events.dispatchEvent(new RoomSessionErrorMessageEvent(_loc4_, _loc3_));
            };
        }


    }
}