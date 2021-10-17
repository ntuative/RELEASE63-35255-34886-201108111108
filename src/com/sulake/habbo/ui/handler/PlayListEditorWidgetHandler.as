package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.sound.events.SongDiskInventoryReceivedEvent;
    import com.sulake.habbo.sound.events.PlayListStatusEvent;
    import com.sulake.habbo.sound.events.NowPlayingEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListUpdateEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListRemoveEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListInsertEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPlayListModificationMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPlayListPlayStateMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPlayListUserActionMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPlayListEditorEvent;
    import com.sulake.habbo.communication.messages.outgoing.sound.AddJukeboxDiskComposer;
    import com.sulake.habbo.communication.messages.outgoing.sound.RemoveJukeboxDiskComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.room.events.RoomEngineSoundMachineEvent;
    import flash.events.Event;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPlayListEditorNowPlayingEvent;

    public class PlayListEditorWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer;
        private var _connection:IConnection = null;
        private var var_5178:IMessageEvent;
        private var var_5179:IMessageEvent;
        private var var_5180:IMessageEvent;


        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get type():String
        {
            return (RoomWidgetEnum.var_426);
        }

        public function set container(param1:IRoomWidgetHandlerContainer):void
        {
            this._container = param1;
            if (this._container.soundManager)
            {
                this._container.soundManager.events.addEventListener(SongDiskInventoryReceivedEvent.SONG_DISK_INVENTORY_RECEIVED, this.processSoundManagerEvent);
                this._container.soundManager.events.addEventListener(PlayListStatusEvent.var_1580, this.processSoundManagerEvent);
                this._container.soundManager.events.addEventListener(PlayListStatusEvent.var_1581, this.processSoundManagerEvent);
                this._container.soundManager.events.addEventListener(NowPlayingEvent.var_1582, this.processSoundManagerEvent);
                this._container.soundManager.events.addEventListener(NowPlayingEvent.var_984, this.processSoundManagerEvent);
                this._container.soundManager.events.addEventListener(NowPlayingEvent.var_981, this.processSoundManagerEvent);
            };
        }

        public function set connection(param1:IConnection):void
        {
            this.var_5178 = new FurniListUpdateEvent(this.onFurniListUpdated);
            this.var_5179 = new FurniListRemoveEvent(this.onFurniListUpdated);
            this.var_5180 = new FurniListInsertEvent(this.onFurniListUpdated);
            this._connection = param1;
            this._connection.addMessageEvent(this.var_5178);
            this._connection.addMessageEvent(this.var_5179);
            this._connection.addMessageEvent(this.var_5180);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this._disposed = true;
                if (this._connection)
                {
                    this._connection.removeMessageEvent(this.var_5178);
                    this._connection.removeMessageEvent(this.var_5179);
                    this._connection.removeMessageEvent(this.var_5180);
                };
                this._connection = null;
                this.var_5178 = null;
                if (this._container)
                {
                    if (this._container.soundManager)
                    {
                        if (this._container.soundManager.events)
                        {
                            this._container.soundManager.events.removeEventListener(SongDiskInventoryReceivedEvent.SONG_DISK_INVENTORY_RECEIVED, this.processSoundManagerEvent);
                            this._container.soundManager.events.removeEventListener(PlayListStatusEvent.var_1580, this.processSoundManagerEvent);
                            this._container.soundManager.events.removeEventListener(PlayListStatusEvent.var_1581, this.processSoundManagerEvent);
                            this._container.soundManager.events.removeEventListener(NowPlayingEvent.var_1582, this.processSoundManagerEvent);
                            this._container.soundManager.events.removeEventListener(NowPlayingEvent.var_984, this.processSoundManagerEvent);
                            this._container.soundManager.events.removeEventListener(NowPlayingEvent.var_981, this.processSoundManagerEvent);
                        };
                    };
                    this._container = null;
                };
            };
        }

        public function getWidgetMessages():Array
        {
            return ([RoomWidgetFurniToWidgetMessage.var_1555, RoomWidgetPlayListModificationMessage.var_1589, RoomWidgetPlayListModificationMessage.var_1590, RoomWidgetPlayListPlayStateMessage.var_1591, RoomWidgetPlayListUserActionMessage.var_1592]);
        }

        public function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _loc2_:RoomWidgetFurniToWidgetMessage;
            var _loc3_:IRoomObject;
            var _loc4_:RoomWidgetPlayListModificationMessage;
            var _loc5_:RoomWidgetPlayListModificationMessage;
            var _loc6_:RoomWidgetPlayListPlayStateMessage;
            var _loc7_:Boolean;
            var _loc8_:RoomWidgetPlayListEditorEvent;
            switch (param1.type)
            {
                case RoomWidgetFurniToWidgetMessage.var_1555:
                    _loc2_ = (param1 as RoomWidgetFurniToWidgetMessage);
                    _loc3_ = this._container.roomEngine.getRoomObject(_loc2_.roomId, _loc2_.roomCategory, _loc2_.id, _loc2_.category);
                    if (_loc3_ != null)
                    {
                        _loc7_ = this._container.roomSession.isRoomOwner;
                        if (_loc7_)
                        {
                            _loc8_ = new RoomWidgetPlayListEditorEvent(RoomWidgetPlayListEditorEvent.var_1576, _loc2_.id);
                            this._container.events.dispatchEvent(_loc8_);
                        };
                    };
                    break;
                case RoomWidgetPlayListModificationMessage.var_1589:
                    _loc4_ = (param1 as RoomWidgetPlayListModificationMessage);
                    if (this._connection != null)
                    {
                        this._connection.send(new AddJukeboxDiskComposer(_loc4_.diskId, _loc4_.slotNumber));
                    };
                    break;
                case RoomWidgetPlayListModificationMessage.var_1590:
                    _loc5_ = (param1 as RoomWidgetPlayListModificationMessage);
                    if (this._connection != null)
                    {
                        this._connection.send(new RemoveJukeboxDiskComposer(_loc5_.slotNumber));
                    };
                    break;
                case RoomWidgetPlayListPlayStateMessage.var_1591:
                    _loc6_ = (param1 as RoomWidgetPlayListPlayStateMessage);
                    if (this._connection != null)
                    {
                        this._connection.send(new UseFurnitureMessageComposer(_loc6_.furniId, _loc6_.position));
                    };
                    break;
                case RoomWidgetPlayListUserActionMessage.var_1592:
                    this._container.habboTracking.trackGoogle("playlistEditorPanelOpenCatalogue", "click");
                    break;
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            var _loc1_:Array = [];
            _loc1_.push(RoomEngineSoundMachineEvent.var_403);
            return (_loc1_);
        }

        public function processEvent(param1:Event):void
        {
            var _loc2_:RoomEngineSoundMachineEvent;
            var _loc3_:RoomWidgetPlayListEditorEvent;
            switch (param1.type)
            {
                case RoomEngineSoundMachineEvent.var_403:
                    _loc2_ = (param1 as RoomEngineSoundMachineEvent);
                    _loc3_ = new RoomWidgetPlayListEditorEvent(RoomWidgetPlayListEditorEvent.var_1577, _loc2_.objectId);
                    this._container.events.dispatchEvent(_loc3_);
                    return;
            };
        }

        public function update():void
        {
        }

        private function onFurniListUpdated(param1:IMessageEvent):void
        {
            if (this._container != null)
            {
                if (this._container.events != null)
                {
                    this._container.events.dispatchEvent(new RoomWidgetPlayListEditorEvent(RoomWidgetPlayListEditorEvent.var_1578, -1));
                };
            };
        }

        private function processSoundManagerEvent(param1:Event):void
        {
            var _loc2_:NowPlayingEvent;
            switch (param1.type)
            {
                case SongDiskInventoryReceivedEvent.SONG_DISK_INVENTORY_RECEIVED:
                    this._container.events.dispatchEvent(new RoomWidgetPlayListEditorEvent(RoomWidgetPlayListEditorEvent.var_1579));
                    return;
                case PlayListStatusEvent.var_1580:
                    this._container.events.dispatchEvent(new RoomWidgetPlayListEditorEvent(RoomWidgetPlayListEditorEvent.var_1580));
                    return;
                case PlayListStatusEvent.var_1581:
                    this._container.events.dispatchEvent(new RoomWidgetPlayListEditorEvent(RoomWidgetPlayListEditorEvent.var_1581));
                    return;
                case NowPlayingEvent.var_1582:
                    _loc2_ = (param1 as NowPlayingEvent);
                    this._container.events.dispatchEvent(new RoomWidgetPlayListEditorNowPlayingEvent(RoomWidgetPlayListEditorNowPlayingEvent.var_1582, _loc2_.id, _loc2_.position, _loc2_.priority));
                    return;
                case NowPlayingEvent.var_984:
                    _loc2_ = (param1 as NowPlayingEvent);
                    this._container.events.dispatchEvent(new RoomWidgetPlayListEditorNowPlayingEvent(RoomWidgetPlayListEditorNowPlayingEvent.var_984, _loc2_.id, _loc2_.position, _loc2_.priority));
                    return;
                case NowPlayingEvent.var_981:
                    _loc2_ = (param1 as NowPlayingEvent);
                    this._container.events.dispatchEvent(new RoomWidgetPlayListEditorNowPlayingEvent(RoomWidgetPlayListEditorNowPlayingEvent.var_981, _loc2_.id, _loc2_.position, _loc2_.priority));
                    return;
            };
        }


    }
}