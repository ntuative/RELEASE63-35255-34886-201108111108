package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomDimmerPresetsMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomDimmerPresetsMessageData;
    import com.sulake.habbo.communication.messages.parser.room.furniture.RoomDimmerPresetsMessageParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.events.RoomSessionDimmerPresetsEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class RoomDimmerPresetsHandler extends BaseHandler 
    {

        public function RoomDimmerPresetsHandler(param1:IConnection, param2:IRoomHandlerListener)
        {
            super(param1, param2);
            if (param1 == null)
            {
                return;
            };
            param1.addMessageEvent(new RoomDimmerPresetsMessageEvent(this.onRoomDimmerPresets));
        }

        private function onRoomDimmerPresets(param1:IMessageEvent):void
        {
            var _loc9_:RoomDimmerPresetsMessageData;
            var _loc2_:RoomDimmerPresetsMessageEvent = (param1 as RoomDimmerPresetsMessageEvent);
            if (((_loc2_ == null) || (_loc2_.getParser() == null)))
            {
                return;
            };
            var _loc3_:RoomDimmerPresetsMessageParser = _loc2_.getParser();
            var _loc4_:int = _loc3_.roomId;
            var _loc5_:int = _loc3_.roomCategory;
            var _loc6_:IRoomSession = listener.getSession(_xxxRoomId, var_99);
            if (_loc6_ == null)
            {
                return;
            };
            var _loc7_:RoomSessionDimmerPresetsEvent = new RoomSessionDimmerPresetsEvent(RoomSessionDimmerPresetsEvent.var_373, _loc6_);
            _loc7_.selectedPresetId = _loc3_.selectedPresetId;
            var _loc8_:int;
            while (_loc8_ < _loc3_.presetCount)
            {
                _loc9_ = _loc3_.getPreset(_loc8_);
                if (_loc9_ != null)
                {
                    _loc7_.storePreset(_loc9_.id, _loc9_.type, _loc9_.color, _loc9_.light);
                };
                _loc8_++;
            };
            if (((listener) && (listener.events)))
            {
                listener.events.dispatchEvent(_loc7_);
            };
        }


    }
}