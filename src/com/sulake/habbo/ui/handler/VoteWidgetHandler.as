package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetVoteMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionVoteEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetVoteUpdateEvent;
    import flash.events.Event;

    public class VoteWidgetHandler implements IRoomWidgetHandler 
    {

        private var var_1023:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;


        public function get disposed():Boolean
        {
            return (this.var_1023);
        }

        public function get type():String
        {
            return (RoomWidgetEnum.var_419);
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
            return ([RoomWidgetVoteMessage.var_419]);
        }

        public function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _loc2_:RoomWidgetVoteMessage;
            switch (param1.type)
            {
                case RoomWidgetVoteMessage.var_419:
                    _loc2_ = (param1 as RoomWidgetVoteMessage);
                    if (_loc2_ == null)
                    {
                        return (null);
                    };
                    this._container.roomSession.sendVote(_loc2_.vote);
                    break;
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            var _loc1_:Array = [];
            _loc1_.push(RoomSessionVoteEvent.var_369);
            _loc1_.push(RoomSessionVoteEvent.var_370);
            return (_loc1_);
        }

        public function processEvent(param1:Event):void
        {
            var _loc3_:RoomWidgetVoteUpdateEvent;
            if (((this._container == null) || (this._container.events == null)))
            {
                return;
            };
            var _loc2_:RoomSessionVoteEvent = (param1 as RoomSessionVoteEvent);
            if (_loc2_ == null)
            {
                return;
            };
            switch (param1.type)
            {
                case RoomSessionVoteEvent.var_369:
                    _loc3_ = new RoomWidgetVoteUpdateEvent(RoomWidgetVoteUpdateEvent.var_369, _loc2_.question, _loc2_.choices);
                    break;
                case RoomSessionVoteEvent.var_370:
                    _loc3_ = new RoomWidgetVoteUpdateEvent(RoomWidgetVoteUpdateEvent.var_370, _loc2_.question, _loc2_.choices, _loc2_.votes, _loc2_.totalVotes);
                    break;
            };
            if (_loc3_ == null)
            {
                return;
            };
            this._container.events.dispatchEvent(_loc3_);
        }

        public function update():void
        {
        }


    }
}