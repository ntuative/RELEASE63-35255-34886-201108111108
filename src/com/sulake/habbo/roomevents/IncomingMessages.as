package com.sulake.habbo.roomevents
{
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.OpenEvent;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniTriggerEvent;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniActionEvent;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniConditionEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectRemoveMessageEvent;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.OpenMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.OpenMessageComposer;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniTriggerMessageParser;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniActionMessageParser;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniConditionMessageParser;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectRemoveMessageParser;

    public class IncomingMessages 
    {

        private var var_4942:HabboUserDefinedRoomEvents;

        public function IncomingMessages(param1:HabboUserDefinedRoomEvents)
        {
            this.var_4942 = param1;
            var _loc2_:IHabboCommunicationManager = this.var_4942.communication;
            _loc2_.addHabboConnectionMessageEvent(new OpenEvent(this.onOpen));
            _loc2_.addHabboConnectionMessageEvent(new WiredFurniTriggerEvent(this.onTrigger));
            _loc2_.addHabboConnectionMessageEvent(new WiredFurniActionEvent(this.onAction));
            _loc2_.addHabboConnectionMessageEvent(new WiredFurniConditionEvent(this.onCondition));
            _loc2_.addHabboConnectionMessageEvent(new UserObjectEvent(this.onUserObject));
            _loc2_.addHabboConnectionMessageEvent(new CloseConnectionMessageEvent(this.onRoomExit));
            _loc2_.addHabboConnectionMessageEvent(new ObjectRemoveMessageEvent(this.onObjectRemove));
        }

        private function onOpen(param1:IMessageEvent):void
        {
            var _loc2_:OpenMessageParser = (param1 as OpenEvent).getParser();
            this.var_4942.send(new OpenMessageComposer(_loc2_.stuffId));
        }

        private function onTrigger(param1:IMessageEvent):void
        {
            var _loc2_:WiredFurniTriggerMessageParser = (param1 as WiredFurniTriggerEvent).getParser();
            this.var_4942.userDefinedRoomEventsCtrl.prepareForUpdate(_loc2_.def);
        }

        private function onAction(param1:IMessageEvent):void
        {
            var _loc2_:WiredFurniActionMessageParser = (param1 as WiredFurniActionEvent).getParser();
            this.var_4942.userDefinedRoomEventsCtrl.prepareForUpdate(_loc2_.def);
        }

        private function onCondition(param1:IMessageEvent):void
        {
            var _loc2_:WiredFurniConditionMessageParser = (param1 as WiredFurniConditionEvent).getParser();
            this.var_4942.userDefinedRoomEventsCtrl.prepareForUpdate(_loc2_.def);
        }

        private function onUserObject(param1:IMessageEvent):void
        {
            var _loc2_:UserObjectMessageParser = (param1 as UserObjectEvent).getParser();
            this.var_4942.userName = _loc2_.name;
        }

        private function onRoomExit(param1:IMessageEvent):void
        {
            this.var_4942.userDefinedRoomEventsCtrl.close();
        }

        private function onObjectRemove(param1:IMessageEvent):void
        {
            var _loc2_:ObjectRemoveMessageParser = (param1 as ObjectRemoveMessageEvent).getParser();
            Logger.log(((("Received object remove event: " + _loc2_.id) + ", ") + _loc2_.isExpired));
            this.var_4942.userDefinedRoomEventsCtrl.stuffRemoved(_loc2_.id);
        }


    }
}