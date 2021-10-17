package com.sulake.habbo.ui.widget.playlisteditor
{
    import com.sulake.habbo.sound.IHabboMusicController;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBorderWindow;
    import com.sulake.core.window.components.IScrollbarWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.sound.HabboMusicPrioritiesEnum;
    import com.sulake.habbo.sound.IPlayListController;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.XmlAsset;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPlayListEditorNowPlayingEvent;

    public class MainWindowHandler 
    {

        private static const var_2333:int = 6;
        private static const var_2337:int = 9;
        private static const var_2336:int = 5;

        private var _widget:PlayListEditorWidget;
        private var var_5038:IHabboMusicController;
        private var var_3966:IWindowContainer;
        private var var_5391:IBorderWindow;
        private var var_5392:IBorderWindow;
        private var var_5393:MusicInventoryGridView;
        private var var_5394:PlayListEditorItemListView;
        private var var_5395:MusicInventoryStatusView;
        private var var_5396:PlayListStatusView;
        private var var_5397:IScrollbarWindow;
        private var var_5398:IScrollbarWindow;

        public function MainWindowHandler(param1:PlayListEditorWidget, param2:IHabboMusicController)
        {
            var _loc4_:String;
            var _loc5_:BitmapData;
            super();
            this._widget = param1;
            this.var_5038 = param2;
            var _loc3_:Array = [PlayListEditorWidgetAssetsEnum.var_2325, PlayListEditorWidgetAssetsEnum.var_2326, PlayListEditorWidgetAssetsEnum.var_2327, PlayListEditorWidgetAssetsEnum.var_2328, PlayListEditorWidgetAssetsEnum.var_2329];
            for each (_loc4_ in _loc3_)
            {
                _loc5_ = this._widget.getImageGalleryAssetBitmap(_loc4_);
                if (_loc5_ != null)
                {
                    _loc5_.dispose();
                }
                else
                {
                    this._widget.retrieveWidgetImage(_loc4_);
                };
            };
            this.createWindow();
            this.var_5393 = new MusicInventoryGridView(param1, this.getMusicInventoryGrid(), param2);
            this.var_5394 = new PlayListEditorItemListView(param1, this.getPlayListEditorItemList());
            this.var_5395 = new MusicInventoryStatusView(param1, this.getMusicInventoryStatusContainer());
            this.var_5396 = new PlayListStatusView(param1, this.getPlayListStatusContainer());
            this.refreshLoadableAsset();
        }

        public function get window():IWindow
        {
            return (this.var_3966);
        }

        public function get musicInventoryView():MusicInventoryGridView
        {
            return (this.var_5393);
        }

        public function get playListEditorView():PlayListEditorItemListView
        {
            return (this.var_5394);
        }

        public function destroy():void
        {
            if (this.var_5038)
            {
                this.var_5038.stop(HabboMusicPrioritiesEnum.var_980);
                this.var_5038 = null;
            };
            if (this.var_5393)
            {
                this.var_5393.destroy();
                this.var_5393 = null;
            };
            if (this.var_5394)
            {
                this.var_5394.destroy();
                this.var_5394 = null;
            };
            if (this.var_5396)
            {
                this.var_5396.destroy();
                this.var_5396 = null;
            };
            if (this.var_5395)
            {
                this.var_5395.destroy();
                this.var_5395 = null;
            };
            this.var_3966.destroy();
            this.var_3966 = null;
        }

        public function hide():void
        {
            this.var_3966.visible = false;
            if (this._widget != null)
            {
                this._widget.stopUserSong();
            };
        }

        public function show():void
        {
            this.var_5038.requestUserSongDisks();
            var _loc1_:IPlayListController = this.var_5038.getRoomItemPlaylist();
            if (_loc1_ != null)
            {
                _loc1_.requestPlayList();
                this.selectPlayListStatusViewByFurniPlayListState();
            };
            this.var_3966.visible = true;
        }

        public function refreshLoadableAsset(param1:String=""):void
        {
            if (((param1 == "") || (param1 == PlayListEditorWidgetAssetsEnum.var_2325)))
            {
                this.assignWindowBitmapByAsset(this.var_5391, "music_inventory_splash_image", PlayListEditorWidgetAssetsEnum.var_2325);
            };
            if (((param1 == "") || (param1 == PlayListEditorWidgetAssetsEnum.var_2326)))
            {
                this.assignWindowBitmapByAsset(this.var_5392, "playlist_editor_splash_image", PlayListEditorWidgetAssetsEnum.var_2326);
            };
            if (((param1 == "") || (param1 == PlayListEditorWidgetAssetsEnum.var_2327)))
            {
                this.var_5395.setPreviewPlayingBackgroundImage(this._widget.getImageGalleryAssetBitmap(PlayListEditorWidgetAssetsEnum.var_2327));
            };
            if (((param1 == "") || (param1 == PlayListEditorWidgetAssetsEnum.var_2328)))
            {
                this.var_5395.setGetMoreMusicBackgroundImage(this._widget.getImageGalleryAssetBitmap(PlayListEditorWidgetAssetsEnum.var_2328));
            };
            if (((param1 == "") || (param1 == PlayListEditorWidgetAssetsEnum.var_2329)))
            {
                this.var_5396.addSongsBackgroundImage = this._widget.getImageGalleryAssetBitmap(PlayListEditorWidgetAssetsEnum.var_2329);
            };
        }

        private function assignWindowBitmapByAsset(param1:IWindowContainer, param2:String, param3:String):void
        {
            var _loc5_:BitmapData;
            var _loc4_:IBitmapWrapperWindow = (param1.getChildByName(param2) as IBitmapWrapperWindow);
            if (_loc4_ != null)
            {
                _loc5_ = this._widget.getImageGalleryAssetBitmap(param3);
                if (_loc5_ != null)
                {
                    _loc4_.bitmap = _loc5_;
                    _loc4_.width = _loc5_.width;
                    _loc4_.height = _loc5_.height;
                };
            };
        }

        private function createWindow():void
        {
            if (this._widget == null)
            {
                return;
            };
            var _loc1_:XmlAsset = (this._widget.assets.getAssetByName("playlisteditor_main_window") as XmlAsset);
            Logger.log(("Show window: " + _loc1_));
            this.var_3966 = (this._widget.windowManager.buildFromXML((_loc1_.content as XML)) as IWindowContainer);
            if (this.var_3966 == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            this.var_3966.position = new Point(80, 0);
            var _loc2_:IWindowContainer = (this.var_3966.getChildByName("content_area") as IWindowContainer);
            if (_loc2_ == null)
            {
                throw (new Error("Window is missing 'content_area' element"));
            };
            this.var_5391 = (_loc2_.getChildByName("my_music_border") as IBorderWindow);
            this.var_5392 = (_loc2_.getChildByName("playlist_border") as IBorderWindow);
            if (this.var_5391 == null)
            {
                throw (new Error("Window content area is missing 'my_music_border' window element"));
            };
            if (this.var_5392 == null)
            {
                throw (new Error("Window content area is missing 'playlist_border' window element"));
            };
            this.var_5397 = (this.var_5391.getChildByName("music_inventory_scrollbar") as IScrollbarWindow);
            this.var_5398 = (this.var_5392.getChildByName("playlist_scrollbar") as IScrollbarWindow);
            if (this.var_5397 == null)
            {
                throw (new Error("Window content area is missing 'music_inventory_scrollbar' window element"));
            };
            if (this.var_5398 == null)
            {
                throw (new Error("Window content area is missing 'playlist_scrollbar' window element"));
            };
            var _loc3_:IWindow = this.var_3966.findChildByTag("close");
            if (_loc3_ != null)
            {
                _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
            };
        }

        private function getMusicInventoryGrid():IItemGridWindow
        {
            return (this.var_5391.getChildByName("music_inventory_itemgrid") as IItemGridWindow);
        }

        private function getPlayListEditorItemList():IItemListWindow
        {
            return (this.var_5392.getChildByName("playlist_editor_itemlist") as IItemListWindow);
        }

        private function getMusicInventoryStatusContainer():IWindowContainer
        {
            return (this.var_5391.getChildByName("preview_play_container") as IWindowContainer);
        }

        private function getPlayListStatusContainer():IWindowContainer
        {
            return (this.var_5392.getChildByName("now_playing_container") as IWindowContainer);
        }

        private function selectPlayListStatusViewByFurniPlayListState():void
        {
            var _loc1_:IPlayListController = this.var_5038.getRoomItemPlaylist();
            if (_loc1_ == null)
            {
                return;
            };
            if (_loc1_.isPlaying)
            {
                this.var_5396.selectView(PlayListStatusView.var_2330);
            }
            else
            {
                if (_loc1_.length > 0)
                {
                    this.var_5396.selectView(PlayListStatusView.var_2331);
                }
                else
                {
                    this.var_5396.selectView(PlayListStatusView.var_2332);
                };
            };
        }

        private function selectMusicStatusViewByMusicState():void
        {
            if (this.isPreviewPlaying())
            {
                this.var_5395.show();
                this.var_5395.selectView(MusicInventoryStatusView.var_2334);
            }
            else
            {
                if (this.var_5038.getSongDiskInventorySize() <= var_2333)
                {
                    this.var_5395.show();
                    this.var_5395.selectView(MusicInventoryStatusView.var_2335);
                }
                else
                {
                    this.var_5395.hide();
                };
            };
        }

        private function updatePlaylistEditorView():void
        {
            var _loc4_:int;
            var _loc5_:ISongInfo;
            var _loc1_:IPlayListController = this.var_5038.getRoomItemPlaylist();
            var _loc2_:Array = [];
            var _loc3_:int = -1;
            if (_loc1_ != null)
            {
                _loc4_ = 0;
                while (_loc4_ < _loc1_.length)
                {
                    _loc5_ = _loc1_.getEntry(_loc4_);
                    if (_loc5_ != null)
                    {
                        _loc2_.push(_loc5_);
                    };
                    _loc4_++;
                };
                _loc3_ = _loc1_.playPosition;
            };
            this.var_5394.refresh(_loc2_, _loc3_);
        }

        public function onPlayListUpdated():void
        {
            var _loc3_:ISongInfo;
            this.updatePlaylistEditorView();
            this.selectPlayListStatusViewByFurniPlayListState();
            var _loc1_:IPlayListController = this.var_5038.getRoomItemPlaylist();
            if (_loc1_ == null)
            {
                return;
            };
            var _loc2_:int = _loc1_.nowPlayingSongId;
            if (_loc2_ != -1)
            {
                _loc3_ = this.var_5038.getSongInfo(_loc2_);
                this.var_5396.nowPlayingTrackName = _loc3_.name;
                this.var_5396.nowPlayingAuthorName = _loc3_.creator;
            };
            this.var_5398.visible = (_loc1_.length > var_2336);
        }

        public function onSongDiskInventoryReceived():void
        {
            this.var_5393.refresh();
            this.selectMusicStatusViewByMusicState();
            this.var_5397.visible = (this.var_5393.itemCount > var_2337);
        }

        public function onNowPlayingChanged(param1:RoomWidgetPlayListEditorNowPlayingEvent):void
        {
            var _loc2_:ISongInfo;
            var _loc3_:ISongInfo;
            switch (param1.type)
            {
                case RoomWidgetPlayListEditorNowPlayingEvent.var_1582:
                    this.selectPlayListStatusViewByFurniPlayListState();
                    this.var_5394.setItemIndexPlaying(param1.position);
                    if (param1.id != -1)
                    {
                        _loc3_ = this.var_5038.getSongInfo(param1.id);
                        this.var_5396.nowPlayingTrackName = ((_loc3_ != null) ? _loc3_.name : "");
                        this.var_5396.nowPlayingAuthorName = ((_loc3_ != null) ? _loc3_.creator : "");
                    };
                    return;
                case RoomWidgetPlayListEditorNowPlayingEvent.var_984:
                    this.var_5393.setPreviewIconToPause();
                    _loc2_ = this.var_5038.getSongInfo(param1.id);
                    this.var_5395.songName = ((_loc2_ != null) ? _loc2_.name : "");
                    this.var_5395.songName = ((_loc2_ != null) ? _loc2_.name : "");
                    this.var_5395.authorName = ((_loc2_ != null) ? _loc2_.creator : "");
                    this.selectMusicStatusViewByMusicState();
                    return;
                case RoomWidgetPlayListEditorNowPlayingEvent.var_981:
                    this.var_5393.setPreviewIconToPlay();
                    this.selectMusicStatusViewByMusicState();
                    return;
            };
        }

        private function onClose(param1:WindowMouseEvent):void
        {
            this.hide();
        }

        private function isPreviewPlaying():Boolean
        {
            return (!(this.var_5038.getSongIdPlayingAtPriority(HabboMusicPrioritiesEnum.var_980) == -1));
        }


    }
}