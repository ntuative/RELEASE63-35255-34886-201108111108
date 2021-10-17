package com.sulake.habbo.ui.widget.playlisteditor
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPlayListEditorEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPlayListEditorNowPlayingEvent;
    import flash.events.IEventDispatcher;
    import flash.geom.ColorTransform;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPlayListModificationMessage;
    import com.sulake.habbo.sound.IPlayListController;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPlayListPlayStateMessage;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.sound.HabboMusicPrioritiesEnum;
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPlayListUserActionMessage;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;

    public class PlayListEditorWidget extends RoomWidgetBase 
    {

        private static const var_1584:int = 130;
        private static const var_1583:int = 100;
        private static const var_1586:int = 130;
        private static const var_1585:int = 100;
        private static const var_1588:int = 130;
        private static const var_1587:int = 100;

        private var _catalog:IHabboCatalog;
        private var _configuration:IHabboConfigurationManager;
        private var _soundManager:IHabboSoundManager;
        private var var_3966:MainWindowHandler;
        private var _furniId:int;

        public function PlayListEditorWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IHabboSoundManager, param4:IAssetLibrary, param5:IHabboLocalizationManager, param6:IHabboConfigurationManager, param7:IHabboCatalog)
        {
            super(param1, param2, param4, param5);
            this._soundManager = param3;
            this._configuration = param6;
            this._catalog = param7;
            this.var_3966 = null;
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                if (this.var_3966)
                {
                    this.var_3966.destroy();
                    this.var_3966 = null;
                };
                this._soundManager = null;
                super.dispose();
            };
        }

        override public function get mainWindow():IWindow
        {
            if (this.var_3966 == null)
            {
                return (null);
            };
            return (this.var_3966.window);
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            param1.addEventListener(RoomWidgetPlayListEditorEvent.var_1576, this.onShowPlayListEditorEvent);
            param1.addEventListener(RoomWidgetPlayListEditorEvent.var_1577, this.onHidePlayListEditorEvent);
            param1.addEventListener(RoomWidgetPlayListEditorEvent.var_1578, this.onInventoryUpdatedEvent);
            param1.addEventListener(RoomWidgetPlayListEditorEvent.var_1579, this.onSongDiskInventoryUpdatedEvent);
            param1.addEventListener(RoomWidgetPlayListEditorEvent.var_1580, this.onPlayListUpdatedEvent);
            param1.addEventListener(RoomWidgetPlayListEditorEvent.var_1581, this.onPlayListFullEvent);
            param1.addEventListener(RoomWidgetPlayListEditorNowPlayingEvent.var_1582, this.onNowPlayingChangedEvent);
            param1.addEventListener(RoomWidgetPlayListEditorNowPlayingEvent.var_984, this.onNowPlayingChangedEvent);
            param1.addEventListener(RoomWidgetPlayListEditorNowPlayingEvent.var_981, this.onNowPlayingChangedEvent);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            param1.removeEventListener(RoomWidgetPlayListEditorEvent.var_1576, this.onShowPlayListEditorEvent);
            param1.removeEventListener(RoomWidgetPlayListEditorEvent.var_1577, this.onHidePlayListEditorEvent);
            param1.removeEventListener(RoomWidgetPlayListEditorEvent.var_1578, this.onInventoryUpdatedEvent);
            param1.removeEventListener(RoomWidgetPlayListEditorEvent.var_1579, this.onSongDiskInventoryUpdatedEvent);
            param1.removeEventListener(RoomWidgetPlayListEditorEvent.var_1580, this.onPlayListUpdatedEvent);
            param1.removeEventListener(RoomWidgetPlayListEditorEvent.var_1581, this.onPlayListFullEvent);
            param1.removeEventListener(RoomWidgetPlayListEditorNowPlayingEvent.var_1582, this.onNowPlayingChangedEvent);
            param1.removeEventListener(RoomWidgetPlayListEditorNowPlayingEvent.var_984, this.onNowPlayingChangedEvent);
            param1.removeEventListener(RoomWidgetPlayListEditorNowPlayingEvent.var_981, this.onNowPlayingChangedEvent);
        }

        public function get mainWindowHandler():MainWindowHandler
        {
            return (this.var_3966);
        }

        public function getDiskColorTransformFromSongData(param1:String):ColorTransform
        {
            var _loc2_:uint;
            var _loc3_:uint;
            var _loc4_:uint;
            var _loc5_:int;
            while (_loc5_ < param1.length)
            {
                switch ((_loc5_ % 3))
                {
                    case 0:
                        _loc2_ = (_loc2_ + ((param1.charCodeAt(_loc5_) * 37) as int));
                        break;
                    case 1:
                        _loc3_ = (_loc3_ + ((param1.charCodeAt(_loc5_) * 37) as int));
                        break;
                    case 2:
                        _loc4_ = (_loc4_ + ((param1.charCodeAt(_loc5_) * 37) as int));
                        break;
                };
                _loc5_++;
            };
            _loc2_ = ((_loc2_ % var_1583) + var_1584);
            _loc3_ = ((_loc3_ % var_1585) + var_1586);
            _loc4_ = ((_loc4_ % var_1587) + var_1588);
            return (new ColorTransform((_loc2_ / 0xFF), (_loc3_ / 0xFF), (_loc4_ / 0xFF)));
        }

        public function sendAddToPlayListMessage(param1:int):void
        {
            var _loc3_:int;
            var _loc4_:RoomWidgetPlayListModificationMessage;
            var _loc2_:IPlayListController = this._soundManager.musicController.getRoomItemPlaylist();
            if (_loc2_ != null)
            {
                _loc3_ = _loc2_.length;
                _loc4_ = new RoomWidgetPlayListModificationMessage(RoomWidgetPlayListModificationMessage.var_1589, _loc3_, param1);
                if (messageListener != null)
                {
                    messageListener.processWidgetMessage(_loc4_);
                };
            };
        }

        public function sendRemoveFromPlayListMessage(param1:int):void
        {
            var _loc2_:RoomWidgetPlayListModificationMessage = new RoomWidgetPlayListModificationMessage(RoomWidgetPlayListModificationMessage.var_1590, param1);
            if (messageListener != null)
            {
                messageListener.processWidgetMessage(_loc2_);
            };
        }

        public function sendTogglePlayPauseStateMessage():void
        {
            var _loc1_:int;
            if (((!(this.var_3966 == null)) && (!(this.var_3966.playListEditorView == null))))
            {
                _loc1_ = ((this.var_3966.playListEditorView.selectedItemIndex != -1) ? this.var_3966.playListEditorView.selectedItemIndex : 0);
            };
            var _loc2_:RoomWidgetPlayListPlayStateMessage = new RoomWidgetPlayListPlayStateMessage(RoomWidgetPlayListPlayStateMessage.var_1591, this._furniId, _loc1_);
            if (messageListener != null)
            {
                messageListener.processWidgetMessage(_loc2_);
            };
        }

        public function playUserSong(param1:int):void
        {
            var _loc3_:ISongInfo;
            var _loc2_:int = this._soundManager.musicController.getSongIdPlayingAtPriority(HabboMusicPrioritiesEnum.var_975);
            if (_loc2_ != -1)
            {
                _loc3_ = this._soundManager.musicController.getSongInfo(_loc2_);
                if (_loc3_.soundObject != null)
                {
                    _loc3_.soundObject.fadeOutSeconds = 0;
                };
            };
            this._soundManager.musicController.playSong(param1, HabboMusicPrioritiesEnum.var_980, 0, 0, 0, 0);
        }

        public function stopUserSong():void
        {
            this._soundManager.musicController.stop(HabboMusicPrioritiesEnum.var_980);
        }

        public function getImageGalleryAssetBitmap(param1:String):BitmapData
        {
            var _loc3_:BitmapData;
            var _loc2_:BitmapDataAsset = (this.assets.getAssetByName(param1) as BitmapDataAsset);
            if (_loc2_ == null)
            {
                return (null);
            };
            _loc3_ = (_loc2_.content as BitmapData);
            return (_loc3_.clone());
        }

        public function retrieveWidgetImage(param1:String):void
        {
            var _loc2_:String = this._configuration.getKey("image.library.playlist.url");
            var _loc3_:* = ((_loc2_ + param1) + ".gif");
            Logger.log(("[PlayListEditorWidget]  : " + _loc3_));
            var _loc4_:URLRequest = new URLRequest(_loc3_);
            var _loc5_:AssetLoaderStruct = this.assets.loadAssetFromFile(param1, _loc4_, "image/gif");
            _loc5_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onWidgetImageReady);
        }

        public function openSongDiskShopCataloguePage():void
        {
            var _loc1_:RoomWidgetPlayListUserActionMessage = new RoomWidgetPlayListUserActionMessage(RoomWidgetPlayListUserActionMessage.var_1592);
            if (messageListener != null)
            {
                messageListener.processWidgetMessage(_loc1_);
            };
            this._catalog.openCatalogPage(CatalogPageName.var_739, true);
        }

        public function alertPlayListFull():void
        {
            this.windowManager.alert(("$" + "{playlist.editor.alert.playlist.full.title}"), ("$" + "{playlist.editor.alert.playlist.full}"), 0, this.alertHandler);
        }

        private function alertHandler(param1:IAlertDialog, param2:WindowEvent):void
        {
            param1.dispose();
        }

        private function onShowPlayListEditorEvent(param1:RoomWidgetPlayListEditorEvent):void
        {
            var _loc2_:IPlayListController;
            this._furniId = param1.furniId;
            if (!this.var_3966)
            {
                this.var_3966 = new MainWindowHandler(this, this._soundManager.musicController);
                this.var_3966.window.visible = false;
            };
            if (!this.var_3966.window.visible)
            {
                this.var_3966.show();
                this._soundManager.musicController.requestUserSongDisks();
                _loc2_ = this._soundManager.musicController.getRoomItemPlaylist();
                if (_loc2_ != null)
                {
                    _loc2_.requestPlayList();
                };
            };
        }

        private function onHidePlayListEditorEvent(param1:RoomWidgetPlayListEditorEvent):void
        {
            if (this.var_3966 != null)
            {
                if (this.var_3966.window.visible)
                {
                    this.var_3966.hide();
                };
            };
        }

        private function onInventoryUpdatedEvent(param1:RoomWidgetPlayListEditorEvent):void
        {
            if (!this.var_3966)
            {
                return;
            };
            if (this.var_3966.window.visible)
            {
                this._soundManager.musicController.requestUserSongDisks();
            };
        }

        private function onWidgetImageReady(param1:AssetLoaderEvent):void
        {
            var _loc2_:AssetLoaderStruct;
            if (param1.type == AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE)
            {
                _loc2_ = (param1.target as AssetLoaderStruct);
                if (_loc2_ != null)
                {
                    if (this.var_3966 != null)
                    {
                        this.var_3966.refreshLoadableAsset(_loc2_.assetName);
                    };
                };
            };
        }

        private function onSongDiskInventoryUpdatedEvent(param1:RoomWidgetPlayListEditorEvent):void
        {
            if (this.var_3966)
            {
                this.var_3966.onSongDiskInventoryReceived();
            };
        }

        private function onPlayListUpdatedEvent(param1:RoomWidgetPlayListEditorEvent):void
        {
            if (this.var_3966)
            {
                this.var_3966.onPlayListUpdated();
            };
        }

        private function onPlayListFullEvent(param1:RoomWidgetPlayListEditorEvent):void
        {
            this.alertPlayListFull();
        }

        private function onNowPlayingChangedEvent(param1:RoomWidgetPlayListEditorNowPlayingEvent):void
        {
            if (this.var_3966)
            {
                this.var_3966.onNowPlayingChanged(param1);
            };
        }


    }
}