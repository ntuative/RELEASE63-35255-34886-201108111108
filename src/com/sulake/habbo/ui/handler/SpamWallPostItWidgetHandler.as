package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RequestSpamWallPostItMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.RequestSpamWallPostItMessageParser;
    import com.sulake.habbo.inventory.items.IItem;
    import com.sulake.habbo.inventory.enum.FurniModelCategory;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSpamWallPostItEditEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetSpamWallPostItFinishEditingMessage;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.AddSpamWallPostItMessageComposer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public class SpamWallPostItWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer;
        private var _connection:IConnection = null;
        private var var_5181:IMessageEvent;


        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get type():String
        {
            return (RoomWidgetEnum.var_427);
        }

        public function set container(param1:IRoomWidgetHandlerContainer):void
        {
            this._container = param1;
        }

        public function set connection(param1:IConnection):void
        {
            this.var_5181 = new RequestSpamWallPostItMessageEvent(this.onSpamWallPostItRequest);
            this._connection = param1;
            this._connection.addMessageEvent(this.var_5181);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this._disposed = true;
                this._connection.removeMessageEvent(this.var_5181);
                this._connection = null;
            };
        }

        private function onSpamWallPostItRequest(param1:RequestSpamWallPostItMessageEvent):void
        {
            var _loc7_:String;
            if (param1 == null)
            {
                return;
            };
            var _loc2_:RequestSpamWallPostItMessageParser = param1.getParser();
            var _loc3_:int = _loc2_.itemId;
            var _loc4_:String = _loc2_.location;
            var _loc5_:String = "post_it";
            var _loc6_:IItem;
            if (this._container.inventory != null)
            {
                _loc6_ = this._container.inventory.getItemById(FurniModelCategory.var_1278, _loc3_);
            };
            if (((!(_loc6_ == null)) && (!(this._container.roomEngine == null))))
            {
                _loc7_ = this._container.roomEngine.getWallItemType(_loc6_.type);
                _loc5_ = ((_loc7_.match("vd")) ? "post_it_vd" : "post_it");
            };
            if (this._container != null)
            {
                if (this._container.events != null)
                {
                    this._container.events.dispatchEvent(new RoomWidgetSpamWallPostItEditEvent(RoomWidgetSpamWallPostItEditEvent.var_1677, _loc3_, _loc4_, _loc5_));
                };
            };
        }

        public function getWidgetMessages():Array
        {
            return ([RoomWidgetSpamWallPostItEditEvent.var_1677, RoomWidgetSpamWallPostItFinishEditingMessage.var_1680]);
        }

        public function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _loc2_:RoomWidgetSpamWallPostItFinishEditingMessage;
            var _loc3_:AddSpamWallPostItMessageComposer;
            switch (param1.type)
            {
                case RoomWidgetSpamWallPostItFinishEditingMessage.var_1680:
                    _loc2_ = (param1 as RoomWidgetSpamWallPostItFinishEditingMessage);
                    if (_loc2_ != null)
                    {
                        if (this._connection != null)
                        {
                            _loc3_ = new AddSpamWallPostItMessageComposer(_loc2_.objectId, _loc2_.location, ((_loc2_.colorHex + " ") + _loc2_.text));
                            this._connection.send(_loc3_);
                        };
                    };
                    break;
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return ([]);
        }

        public function processEvent(param1:Event):void
        {
        }

        public function update():void
        {
        }


    }
}