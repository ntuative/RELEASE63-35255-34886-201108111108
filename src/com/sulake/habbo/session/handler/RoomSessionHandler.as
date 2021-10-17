package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.room.session.OpenConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.FlatAccessibleMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatAccessDeniedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.RoomQueueStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.YouAreSpectatorMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.communication.messages.parser.room.session.FlatAccessibleMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.room.session.GoToFlatMessageComposer;
    import com.sulake.habbo.session.events.RoomSessionDoorbellEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.FlatAccessDeniedMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomQueueSet;
    import com.sulake.habbo.session.events.RoomSessionQueueEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomQueueStatusMessageParser;

    public class RoomSessionHandler extends BaseHandler 
    {

        public static const var_95:String = "RS_CONNECTED";
        public static const var_96:String = "RS_READY";
        public static const var_97:String = "RS_DISCONNECTED";

        public function RoomSessionHandler(param1:IConnection, param2:IRoomHandlerListener)
        {
            super(param1, param2);
            if (param1 == null)
            {
                return;
            };
            param1.addMessageEvent(new OpenConnectionMessageEvent(this.onRoomConnected));
            param1.addMessageEvent(new FlatAccessibleMessageEvent(this.onFlatAccessible));
            param1.addMessageEvent(new RoomReadyMessageEvent(this.onRoomReady));
            param1.addMessageEvent(new CloseConnectionMessageEvent(this.onRoomDisconnected));
            param1.addMessageEvent(new FlatAccessDeniedMessageEvent(this.onFlatAccessDenied));
            param1.addMessageEvent(new RoomQueueStatusMessageEvent(this.onRoomQueueStatus));
            param1.addMessageEvent(new YouAreSpectatorMessageEvent(this.onYouAreSpectator));
        }

        private function onRoomConnected(param1:IMessageEvent):void
        {
            var _loc2_:int = _xxxRoomId;
            var _loc3_:int = var_99;
            if (listener)
            {
                listener.sessionUpdate(_loc2_, _loc3_, RoomSessionHandler.var_95);
            };
        }

        private function onFlatAccessible(param1:FlatAccessibleMessageEvent):void
        {
            var _loc6_:IRoomSession;
            var _loc2_:int = _xxxRoomId;
            var _loc3_:int = var_99;
            var _loc4_:FlatAccessibleMessageParser = param1.getParser();
            if (_loc4_ == null)
            {
                return;
            };
            var _loc5_:String = _loc4_.userName;
            if (((_loc5_ == null) || (_loc5_.length == 0)))
            {
                connection.send(new GoToFlatMessageComposer(_loc2_));
            }
            else
            {
                if (((listener) && (listener.events)))
                {
                    _loc6_ = listener.getSession(_loc2_, _loc3_);
                    if (_loc6_ != null)
                    {
                        listener.events.dispatchEvent(new RoomSessionDoorbellEvent(RoomSessionDoorbellEvent.var_345, _loc6_, _loc5_));
                    };
                };
            };
        }

        private function onRoomReady(param1:IMessageEvent):void
        {
            var _loc7_:RoomReadyMessageParser;
            var _loc2_:int = _xxxRoomId;
            var _loc3_:int = var_99;
            var _loc4_:int = _loc2_;
            var _loc5_:int = _loc3_;
            var _loc6_:RoomReadyMessageEvent = (param1 as RoomReadyMessageEvent);
            if (_loc6_ != null)
            {
                _loc7_ = _loc6_.getParser();
                if (_loc7_ != null)
                {
                    _loc4_ = _loc7_.roomId;
                    _loc5_ = _loc7_.roomCategory;
                };
            };
            if (listener)
            {
                listener.sessionReinitialize(_loc2_, _loc3_, _loc4_, _loc5_);
                listener.sessionUpdate(_loc2_, _loc3_, RoomSessionHandler.var_96);
            };
        }

        private function onFlatAccessDenied(param1:FlatAccessDeniedMessageEvent):void
        {
            var _loc6_:IRoomSession;
            var _loc2_:int = _xxxRoomId;
            var _loc3_:int = var_99;
            var _loc4_:FlatAccessDeniedMessageParser = param1.getParser();
            if (_loc4_ == null)
            {
                return;
            };
            var _loc5_:String = _loc4_.userName;
            if (((_loc5_ == null) || (_loc5_.length == 0)))
            {
                if (listener)
                {
                    listener.sessionUpdate(_loc2_, _loc3_, RoomSessionHandler.var_97);
                };
            }
            else
            {
                if (((listener) && (listener.events)))
                {
                    _loc6_ = listener.getSession(_loc2_, _loc3_);
                    if (_loc6_ != null)
                    {
                        listener.events.dispatchEvent(new RoomSessionDoorbellEvent(RoomSessionDoorbellEvent.var_344, _loc6_, _loc5_));
                    };
                };
            };
        }

        private function onRoomDisconnected(param1:IMessageEvent):void
        {
            var _loc2_:int = _xxxRoomId;
            var _loc3_:int = var_99;
            if (listener)
            {
                listener.sessionUpdate(_loc2_, _loc3_, RoomSessionHandler.var_97);
            };
        }

        private function onRoomQueueStatus(param1:RoomQueueStatusMessageEvent):void
        {
            var _loc4_:RoomQueueSet;
            var _loc5_:RoomSessionQueueEvent;
            var _loc7_:Array;
            var _loc9_:int;
            var _loc10_:String;
            if (((listener == null) || (listener.events == null)))
            {
                return;
            };
            var _loc2_:RoomQueueStatusMessageParser = param1.getParser();
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:IRoomSession = listener.getSession(_xxxRoomId, var_99);
            if (_loc3_ == null)
            {
                return;
            };
            var _loc6_:Array = _loc2_.getQueueSetTargets();
            var _loc8_:int = _loc2_.activeTarget;
            for each (_loc9_ in _loc6_)
            {
                _loc4_ = _loc2_.getQueueSet(_loc9_);
                _loc5_ = new RoomSessionQueueEvent(_loc3_, _loc4_.name, _loc4_.target, (_loc4_.target == _loc8_));
                _loc7_ = _loc4_.queueTypes;
                for each (_loc10_ in _loc7_)
                {
                    _loc5_.addQueue(_loc10_, _loc4_.getQueueSize(_loc10_));
                };
                listener.events.dispatchEvent(_loc5_);
            };
        }

        private function onYouAreSpectator(param1:YouAreSpectatorMessageEvent):void
        {
            if (listener == null)
            {
                return;
            };
            var _loc2_:IRoomSession = listener.getSession(_xxxRoomId, var_99);
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.isSpectatorMode = true;
        }


    }
}