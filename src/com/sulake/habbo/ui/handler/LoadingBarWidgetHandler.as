package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.advertisement.events.InterstitialEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetLoadingBarUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetInterstitialUpdateEvent;
    import flash.events.Event;

    public class LoadingBarWidgetHandler implements IRoomWidgetHandler 
    {

        private var var_1023:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;


        public function get disposed():Boolean
        {
            return (this.var_1023);
        }

        public function get type():String
        {
            return (RoomWidgetEnum.var_428);
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
            return ([]);
        }

        public function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            return (null);
        }

        public function getProcessedEvents():Array
        {
            var _loc1_:Array = [];
            _loc1_.push(InterstitialEvent.var_339);
            _loc1_.push(InterstitialEvent.var_338);
            _loc1_.push(RoomWidgetLoadingBarUpdateEvent.var_1537);
            _loc1_.push(RoomWidgetLoadingBarUpdateEvent.var_1559);
            return (_loc1_);
        }

        public function processEvent(param1:Event):void
        {
            var _loc2_:InterstitialEvent;
            var _loc3_:RoomWidgetInterstitialUpdateEvent;
            if (((this._container == null) || (this._container.events == null)))
            {
                return;
            };
            switch (param1.type)
            {
                case InterstitialEvent.var_339:
                    _loc2_ = (param1 as InterstitialEvent);
                    if (_loc2_ == null)
                    {
                        return;
                    };
                    _loc3_ = new RoomWidgetInterstitialUpdateEvent(RoomWidgetInterstitialUpdateEvent.var_1537, _loc2_.image, _loc2_.clickURL);
                    this._container.events.dispatchEvent(_loc3_);
                    return;
                case InterstitialEvent.var_338:
                    this._container.setInterstitialCompleted();
                    return;
                case RoomWidgetLoadingBarUpdateEvent.var_1537:
                    this._container.events.dispatchEvent(param1);
                    return;
                case RoomWidgetLoadingBarUpdateEvent.var_1559:
                    this._container.events.dispatchEvent(param1);
                    return;
            };
        }

        public function update():void
        {
        }


    }
}