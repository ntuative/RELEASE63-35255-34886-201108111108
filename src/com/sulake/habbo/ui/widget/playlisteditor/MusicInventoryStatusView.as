package com.sulake.habbo.ui.widget.playlisteditor
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.components.ITextWindow;
    import flash.display.BitmapData;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.assets.BitmapDataAsset;

    public class MusicInventoryStatusView 
    {

        public static const var_2335:String = "MISV_BUY_MORE";
        public static const var_2334:String = "MISV_PREVIEW_PLAYING";

        private var _container:IWindowContainer;
        private var var_5402:Map = new Map();
        private var _widget:PlayListEditorWidget;
        private var var_4021:String;
        private var var_5403:ITextWindow;
        private var var_5404:ITextWindow;

        public function MusicInventoryStatusView(param1:PlayListEditorWidget, param2:IWindowContainer)
        {
            this._container = param2;
            this._widget = param1;
            this.createWindows();
            this.hide();
        }

        public function destroy():void
        {
            var _loc1_:IWindowContainer;
            for each (_loc1_ in this.var_5402.getValues())
            {
                _loc1_.destroy();
            };
            this.var_5402 = null;
        }

        public function show():void
        {
            this._container.visible = true;
        }

        public function hide():void
        {
            this._container.visible = false;
        }

        public function selectView(param1:String):void
        {
            this._container.removeChildAt(0);
            this._container.addChildAt((this.var_5402[param1] as IWindowContainer), 0);
            this.var_4021 = param1;
        }

        public function set songName(param1:String):void
        {
            if (this.var_5403 == null)
            {
                return;
            };
            this.var_5403.text = param1;
        }

        public function set authorName(param1:String):void
        {
            if (this.var_5404 == null)
            {
                return;
            };
            this.var_5404.text = param1;
        }

        public function setPreviewPlayingBackgroundImage(param1:BitmapData, param2:Boolean=true):void
        {
            this.blitBackgroundImage(var_2334, "preview_play_background_image", param1);
            if (((param2) && (!(param1 == null))))
            {
                param1.dispose();
            };
        }

        public function setGetMoreMusicBackgroundImage(param1:BitmapData, param2:Boolean=true):void
        {
            this.blitBackgroundImage(var_2335, "get_more_music_background_image", param1);
            if (((param2) && (!(param1 == null))))
            {
                param1.dispose();
            };
        }

        private function createWindows():void
        {
            var _loc1_:IWindowContainer;
            var _loc2_:XmlAsset;
            var _loc3_:IButtonWindow;
            var _loc4_:IButtonWindow;
            _loc2_ = (this._widget.assets.getAssetByName("playlisteditor_inventory_subwindow_play_preview") as XmlAsset);
            _loc1_ = (this._widget.windowManager.buildFromXML((_loc2_.content as XML)) as IWindowContainer);
            if (_loc1_ != null)
            {
                this.var_5402.add(var_2334, _loc1_);
                this.var_5403 = (_loc1_.getChildByName("preview_play_track_name") as ITextWindow);
                this.var_5404 = (_loc1_.getChildByName("preview_play_author_name") as ITextWindow);
                _loc3_ = (_loc1_.getChildByName("stop_preview_button") as IButtonWindow);
                _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onStopPreviewClicked);
                this.setPreviewPlayingBackgroundImage(this._widget.getImageGalleryAssetBitmap(PlayListEditorWidgetAssetsEnum.var_2327));
                this.assignAssetByNameToElement("jb_icon_disc", (_loc1_.getChildByName("song_name_icon_bitmap") as IBitmapWrapperWindow));
                this.assignAssetByNameToElement("jb_icon_composer", (_loc1_.getChildByName("author_name_icon_bitmap") as IBitmapWrapperWindow));
            };
            _loc2_ = (this._widget.assets.getAssetByName("playlisteditor_inventory_subwindow_get_more_music") as XmlAsset);
            _loc1_ = (this._widget.windowManager.buildFromXML((_loc2_.content as XML)) as IWindowContainer);
            if (_loc1_ != null)
            {
                this.var_5402.add(var_2335, _loc1_);
                _loc4_ = (_loc1_.getChildByName("open_catalog_button") as IButtonWindow);
                _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onOpenCatalogButtonClicked);
                this.setGetMoreMusicBackgroundImage(this._widget.getImageGalleryAssetBitmap(PlayListEditorWidgetAssetsEnum.var_2328));
            };
        }

        private function blitBackgroundImage(param1:String, param2:String, param3:BitmapData):void
        {
            var _loc6_:BitmapData;
            var _loc4_:IWindowContainer = (this.var_5402[param1] as IWindowContainer);
            if (_loc4_ == null)
            {
                return;
            };
            var _loc5_:IBitmapWrapperWindow = (_loc4_.getChildByName(param2) as IBitmapWrapperWindow);
            if (_loc5_ == null)
            {
                return;
            };
            if (param3 != null)
            {
                _loc6_ = new BitmapData(_loc5_.width, _loc5_.height, false, 0xFFFFFFFF);
                _loc6_.copyPixels(param3, param3.rect, new Point(0, 0));
                _loc5_.bitmap = _loc6_;
            };
        }

        private function assignAssetByNameToElement(param1:String, param2:IBitmapWrapperWindow):void
        {
            var _loc4_:BitmapData;
            var _loc3_:BitmapDataAsset = (this._widget.assets.getAssetByName(param1) as BitmapDataAsset);
            if (_loc3_ != null)
            {
                if (((!(param2 == null)) && (!(_loc3_.content == null))))
                {
                    _loc4_ = (_loc3_.content as BitmapData);
                    param2.bitmap = _loc4_.clone();
                };
            };
        }

        private function onOpenCatalogButtonClicked(param1:WindowMouseEvent):void
        {
            this._widget.openSongDiskShopCataloguePage();
        }

        private function onStopPreviewClicked(param1:WindowMouseEvent):void
        {
            this._widget.stopUserSong();
        }


    }
}