package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.sound.HabboMusicPrioritiesEnum;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.sound.ISongInfo;

    public class TraxPreviewCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var _soundManager:IHabboSoundManager;
        private var var_3259:IButtonWindow;
        private var var_3262:int = -1;

        public function TraxPreviewCatalogWidget(param1:IWindowContainer, param2:IHabboSoundManager)
        {
            super(param1);
            this.var_3259 = (_window.findChildByName("listen") as IButtonWindow);
            Logger.log(("Trax listener found button: " + this.var_3259));
            if (this.var_3259 != null)
            {
                this.var_3259.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClickPlay);
                this.var_3259.disable();
            };
            this._soundManager = param2;
        }

        override public function dispose():void
        {
            if (this.var_3259 != null)
            {
                this.var_3259.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClickPlay);
            };
            if (((!(this._soundManager == null)) && (!(this._soundManager.musicController == null))))
            {
                this._soundManager.musicController.stop(HabboMusicPrioritiesEnum.var_1931);
                this._soundManager = null;
            };
            super.dispose();
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            if (page.offers.length == 0)
            {
                return (false);
            };
            events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT, this.onSelectProduct);
            return (true);
        }

        override public function closed():void
        {
            super.closed();
            if (((!(this._soundManager == null)) && (!(this._soundManager.musicController == null))))
            {
                this._soundManager.musicController.stop(HabboMusicPrioritiesEnum.var_1931);
            };
        }

        private function onSelectProduct(param1:SelectProductEvent):void
        {
            if (((param1 == null) || (param1.offer == null)))
            {
                return;
            };
            var _loc2_:Boolean;
            var _loc3_:IProduct = param1.offer.productContainer.firstProduct;
            if (_loc3_.extraParam.length > 0)
            {
                this.var_3262 = parseInt(_loc3_.extraParam);
                _loc2_ = true;
            };
            if (this.var_3259 != null)
            {
                if (_loc2_)
                {
                    this.var_3259.enable();
                }
                else
                {
                    this.var_3259.disable();
                };
            };
        }

        private function onClickPlay(param1:WindowMouseEvent):void
        {
            if (((!(this._soundManager == null)) && (!(this._soundManager.musicController == null))))
            {
                this.forceNoFadeoutOnPlayingSong(HabboMusicPrioritiesEnum.var_975);
                this.forceNoFadeoutOnPlayingSong(HabboMusicPrioritiesEnum.var_1931);
                this._soundManager.musicController.playSong(this.var_3262, HabboMusicPrioritiesEnum.var_1931, 15, 40, 0, 2);
            };
        }

        private function forceNoFadeoutOnPlayingSong(param1:int):void
        {
            var _loc3_:ISongInfo;
            var _loc2_:int = this._soundManager.musicController.getSongIdPlayingAtPriority(param1);
            if (_loc2_ != -1)
            {
                _loc3_ = this._soundManager.musicController.getSongInfo(_loc2_);
                if (_loc3_.soundObject != null)
                {
                    _loc3_.soundObject.fadeOutSeconds = 0;
                };
            };
        }


    }
}