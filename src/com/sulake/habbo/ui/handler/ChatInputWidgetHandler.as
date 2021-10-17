package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChatTypingMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionChatEvent;
    import flash.events.Event;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFloodControlEvent;

    public class ChatInputWidgetHandler implements IRoomWidgetHandler 
    {

        private var var_1023:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;


        public function get disposed():Boolean
        {
            return (this.var_1023);
        }

        public function get type():String
        {
            return (RoomWidgetEnum.var_408);
        }

        public function set container(param1:IRoomWidgetHandlerContainer):void
        {
            this._container = param1;
        }

        public function dispose():void
        {
            this.var_1023 = true;
            this._container = null;
        }

        public function getWidgetMessages():Array
        {
            var _loc1_:Array = [];
            _loc1_.push(RoomWidgetChatTypingMessage.var_2318);
            return (_loc1_);
        }

        public function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _loc2_:RoomWidgetChatTypingMessage;
            switch (param1.type)
            {
                case RoomWidgetChatTypingMessage.var_2318:
                    _loc2_ = (param1 as RoomWidgetChatTypingMessage);
                    if (_loc2_ != null)
                    {
                        this._container.roomSession.sendChatTypingMessage(_loc2_.isTyping);
                    };
                    break;
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return ([RoomSessionChatEvent.var_341]);
        }

        public function processEvent(param1:Event):void
        {
            var _loc3_:RoomSessionChatEvent;
            var _loc4_:int;
            var _loc2_:Event;
            if (((this._container == null) || (this._container.events == null)))
            {
                return;
            };
            switch (param1.type)
            {
                case RoomSessionChatEvent.var_341:
                    _loc3_ = (param1 as RoomSessionChatEvent);
                    _loc4_ = parseInt(_loc3_.text);
                    _loc2_ = new RoomWidgetFloodControlEvent(_loc4_);
                    break;
            };
            if ((((!(this._container == null)) && (!(this._container.events == null))) && (!(_loc2_ == null))))
            {
                this._container.events.dispatchEvent(_loc2_);
            };
        }

        public function update():void
        {
        }


    }
}