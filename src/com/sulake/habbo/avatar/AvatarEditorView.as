package com.sulake.habbo.avatar
{
    import com.sulake.core.window.IWindowContainer;
    import flash.geom.Point;
    import com.sulake.core.window.components.ITabSelectorWindow;
    import com.sulake.core.window.components.IFrameWindow;
    import flash.utils.Timer;
    import com.sulake.habbo.avatar.enum.AvatarEditorFigureCategory;
    import com.sulake.core.assets.XmlAsset;
    import flash.events.TimerEvent;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import flash.events.Event;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IContainerButtonWindow;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.avatar.enum.AvatarEditorSideCategory;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.assets.IAsset;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.catalog.enum.CatalogPageName;

    public class AvatarEditorView 
    {

        public static var var_1851:IWindowContainer;
        public static var var_1849:IWindowContainer;
        public static var var_2440:int = 0x666666;
        private static const var_2441:int = 5000;
        private static const var_1728:Point = new Point(100, 30);

        private var var_3015:HabboAvatarEditor;
        private var var_3018:IWindowContainer;
        private var var_3019:String;
        private var var_3020:ITabSelectorWindow;
        private var var_3021:IFrameWindow;
        private var var_2764:IWindowContainer;
        private var var_3022:IFrameWindow;
        private var _saveTimer:Timer;
        private var var_3023:String;
        private var var_3024:Boolean = true;
        private var var_3017:Array = [];
        private var var_3016:Array = [AvatarEditorFigureCategory.var_1844, AvatarEditorFigureCategory.var_130, AvatarEditorFigureCategory.var_1845, AvatarEditorFigureCategory.var_1846, AvatarEditorFigureCategory.HOTLOOKS, AvatarEditorFigureCategory.var_1847];

        public function AvatarEditorView(param1:HabboAvatarEditor, param2:Array)
        {
            var _loc3_:String;
            var _loc4_:XmlAsset;
            var _loc5_:XmlAsset;
            super();
            this.var_3015 = param1;
            if (var_1851 == null)
            {
                _loc4_ = (this.var_3015.manager.assets.getAssetByName("AvatarEditorThumb") as XmlAsset);
                var_1851 = (this.var_3015.manager.windowManager.buildFromXML((_loc4_.content as XML)) as IWindowContainer);
            };
            if (var_1849 == null)
            {
                _loc5_ = (this.var_3015.manager.assets.getAssetByName("color_chooser_cell") as XmlAsset);
                var_1849 = (this.var_3015.manager.windowManager.buildFromXML((_loc5_.content as XML)) as IWindowContainer);
            };
            this._saveTimer = new Timer(var_2441, 1);
            this._saveTimer.addEventListener(TimerEvent.TIMER, this.onUpdate);
            if (param2 == null)
            {
                param2 = this.var_3016;
            };
            for each (_loc3_ in param2)
            {
                this.var_3017.push(_loc3_);
            };
            this.createWindow();
        }

        public function dispose():void
        {
            var _loc1_:IWindowContainer;
            var _loc2_:IWindowContainer;
            var _loc3_:IWindowContainer;
            if (this._saveTimer != null)
            {
                this._saveTimer.stop();
                this._saveTimer.removeEventListener(TimerEvent.TIMER, this.onUpdate);
                this._saveTimer = null;
            };
            if (this.var_3020)
            {
                this.var_3020.dispose();
                this.var_3020 = null;
            };
            if (this.var_3022)
            {
                this.var_3022.dispose();
                this.var_3022 = null;
            };
            if (this.var_3018)
            {
                this.var_3018.dispose();
                this.var_3018 = null;
            };
            if (this.var_2764 != null)
            {
                this.var_2764.dispose();
                this.var_2764 = null;
            };
            if (this.var_3021)
            {
                this.var_3021.dispose();
                this.var_3021 = null;
            };
            if (this.var_3018 != null)
            {
                _loc1_ = (this.var_3018.findChildByName("figureContainer") as IWindowContainer);
                if (_loc1_ != null)
                {
                    while (_loc1_.numChildren > 0)
                    {
                        _loc1_.removeChildAt(0);
                    };
                };
                _loc2_ = (this.var_3018.findChildByName("contentArea") as IWindowContainer);
                if (_loc2_ != null)
                {
                    while (_loc2_.numChildren > 0)
                    {
                        _loc2_.removeChildAt(0);
                    };
                };
                _loc3_ = (this.var_3018.findChildByName("sideContainer") as IWindowContainer);
                if (_loc3_ != null)
                {
                    while (_loc3_.numChildren > 0)
                    {
                        _loc3_.removeChildAt(0);
                    };
                };
                this.var_3015 = null;
            };
        }

        public function getFrame(param1:Array, param2:String=null):IFrameWindow
        {
            if (this.var_3021)
            {
                this.var_3021.visible = true;
                this.var_3021.activate();
                return (this.var_3021);
            };
            if (this.var_3021)
            {
                this.var_3021.dispose();
                this.var_3021 = null;
            };
            var _loc3_:XmlAsset = (this.var_3015.manager.assets.getAssetByName("AvatarEditorFrame") as XmlAsset);
            if (_loc3_)
            {
                this.var_3021 = (this.var_3015.manager.windowManager.buildFromXML((_loc3_.content as XML)) as IFrameWindow);
            };
            if (this.var_3021 == null)
            {
                Logger.log("Failed to construct Avatar editor window!");
                return (null);
            };
            var _loc4_:IWindowContainer = (this.var_3021.findChildByName("maincontent") as IWindowContainer);
            if (!this.embedToContext(_loc4_, param1))
            {
                this.var_3021.dispose();
                this.var_3021 = null;
                return (null);
            };
            if (param2)
            {
                this.var_3021.header.title.text = param2;
            };
            this.var_3021.position = var_1728;
            this.var_3021.findChildByName("header_button_close").procedure = this.windowEventProc;
            return (this.var_3021);
        }

        public function embedToContext(param1:IWindowContainer, param2:Array):Boolean
        {
            var _loc3_:int;
            if (!this.validateAvailableCategories(param2))
            {
                Logger.log("Could not validate categories for avatar editor!");
                return (false);
            };
            if (param1)
            {
                _loc3_ = param1.getChildIndex(this.var_3018);
                if (_loc3_)
                {
                    param1.removeChildAt(_loc3_);
                };
                param1.addChild(this.var_3018);
            }
            else
            {
                if (this.var_2764 == null)
                {
                    this.var_2764 = (this.var_3015.manager.windowManager.createWindow("avatarEditorContainer", "", HabboWindowType.var_218, HabboWindowStyle.var_613, (HabboWindowParam.var_829 | HabboWindowParam.var_158), new Rectangle(0, 0, 2, 2), null, 0) as IWindowContainer);
                    this.var_2764.addChild(this.var_3018);
                };
                _loc3_ = this.var_2764.getChildIndex(this.var_3018);
                if (_loc3_)
                {
                    param1.removeChildAt(_loc3_);
                };
                this.var_2764.visible = true;
            };
            return (true);
        }

        public function validateAvailableCategories(param1:Array):Boolean
        {
            var _loc2_:String;
            if (param1 == null)
            {
                return (this.validateAvailableCategories(this.var_3016));
            };
            if (param1.length != this.var_3017.length)
            {
                return (false);
            };
            for each (_loc2_ in param1)
            {
                if (this.var_3017.indexOf(_loc2_) < 0)
                {
                    return (false);
                };
            };
            return (true);
        }

        private function onUpdate(param1:Event=null):void
        {
            this._saveTimer.stop();
            if (this.var_3018)
            {
                this.var_3018.findChildByName("save").enable();
            };
        }

        public function show():void
        {
            if (this.var_3021)
            {
                this.var_3021.visible = true;
            }
            else
            {
                if (this.var_3018)
                {
                    this.var_3018.visible = true;
                };
            };
        }

        public function hide():void
        {
            if (this.var_3021)
            {
                this.var_3021.visible = false;
            }
            else
            {
                if (this.var_3018)
                {
                    this.var_3018.visible = false;
                };
            };
        }

        private function createWindow():void
        {
            var _loc2_:ISelectableWindow;
            var _loc3_:ISelectableWindow;
            var _loc4_:int;
            if (this.var_3018 == null)
            {
                this.var_3018 = (this.var_3015.manager.windowManager.buildFromXML(((this.var_3015.manager.assets.getAssetByName("AvatarEditorContent") as XmlAsset).content as XML)) as IWindowContainer);
            };
            this.var_3018.procedure = this.windowEventProc;
            this.var_3020 = (this.var_3018.findChildByName("mainTabs") as ITabSelectorWindow);
            var _loc1_:int = (this.var_3020.numSelectables - 1);
            while (_loc1_ >= 0)
            {
                _loc2_ = this.var_3020.getSelectableAt(_loc1_);
                if (((!(_loc2_ == null)) && (this.var_3017.indexOf(_loc2_.name) < 0)))
                {
                    _loc3_ = this.var_3020.removeSelectable(_loc2_);
                    _loc4_ = (_loc1_ + 1);
                    while (_loc4_ < this.var_3020.numSelectables)
                    {
                        this.var_3020.getSelectableAt(_loc4_).x = (this.var_3020.getSelectableAt(_loc4_).x - _loc3_.width);
                        _loc4_++;
                    };
                };
                _loc1_--;
            };
            this.var_3020.setSelected(this.var_3020.getSelectableAt(0));
            this.attachImages();
            this.update();
        }

        private function attachImages():void
        {
            var _loc3_:String;
            var _loc4_:IWindowContainer;
            var _loc5_:IBitmapWrapperWindow;
            var _loc6_:BitmapDataAsset;
            var _loc7_:BitmapData;
            var _loc1_:Array = this.var_3016;
            var _loc2_:Point = new Point();
            for each (_loc3_ in _loc1_)
            {
                _loc4_ = (this.var_3018.findChildByName(_loc3_) as IWindowContainer);
                if (_loc4_ != null)
                {
                    _loc5_ = (_loc4_.findChildByTag("BITMAP") as IBitmapWrapperWindow);
                    if (_loc5_ != null)
                    {
                        _loc6_ = (this.var_3015.manager.assets.getAssetByName(("ae_tabs_" + _loc3_)) as BitmapDataAsset);
                        _loc7_ = (_loc6_.content as BitmapData);
                        _loc5_.bitmap = new BitmapData(_loc5_.width, _loc5_.height, true, 0xFFFFFF);
                        _loc2_.x = ((_loc5_.width - _loc7_.width) / 2);
                        _loc2_.y = ((_loc5_.height - _loc7_.height) / 2);
                        _loc5_.bitmap.copyPixels(_loc7_, _loc7_.rect, _loc2_);
                    };
                };
            };
        }

        public function update():void
        {
            var _loc1_:IWindowContainer = this.var_3015.figureData.view.window;
            var _loc2_:IWindowContainer = (this.var_3018.findChildByName("figureContainer") as IWindowContainer);
            if (_loc2_.numChildren > 0)
            {
                _loc2_.removeChildAt(0);
            };
            if (_loc2_ != null)
            {
                _loc2_.addChild(_loc1_);
            };
            var _loc3_:IContainerButtonWindow = (this.var_3018.findChildByName("wardrobe") as IContainerButtonWindow);
            if (((_loc3_) && (this.var_3015.manager.sessionData)))
            {
                _loc3_.visible = ((this.var_3015.manager.sessionData.clubLevel >= HabboClubLevelEnum.var_256) && (this.var_3015.isSideContentEnabled()));
            };
            var _loc4_:String = AvatarEditorSideCategory.var_2439;
            if ((((this.var_3015.manager.sessionData) && (this.var_3015.manager.sessionData.clubLevel >= HabboClubLevelEnum.var_256)) && ((this.var_3023 == AvatarEditorSideCategory.var_1847) || (this.var_3024))))
            {
                _loc4_ = AvatarEditorSideCategory.var_1847;
            };
            if (((this.var_3015.isClubTryoutAllowed()) && (this.var_3015.clubMemberLevel <= 0)))
            {
                _loc4_ = AvatarEditorSideCategory.var_1848;
            };
            if (!this.var_3015.isSideContentEnabled())
            {
                _loc4_ = AvatarEditorSideCategory.var_2439;
            };
            this.setSideContent(_loc4_);
            this.setViewToCategory(this.var_3019);
        }

        public function toggleCategoryView(param1:String, param2:Boolean=false):void
        {
            if (param2)
            {
            };
            this.setViewToCategory(param1);
        }

        private function toggleWardrobe():void
        {
            if (this.var_3023 == AvatarEditorSideCategory.var_1847)
            {
                this.var_3024 = false;
                this.setSideContent(AvatarEditorSideCategory.var_2439);
            }
            else
            {
                this.setSideContent(AvatarEditorSideCategory.var_1847);
            };
        }

        private function setSideContent(param1:String):void
        {
            var _loc5_:int;
            if (this.var_3023 == param1)
            {
                return;
            };
            var _loc2_:IWindowContainer = (this.var_3018.findChildByName("sideContainer") as IWindowContainer);
            if (!_loc2_)
            {
                return;
            };
            var _loc3_:IWindow;
            switch (param1)
            {
                case AvatarEditorSideCategory.var_2439:
                    break;
                case AvatarEditorSideCategory.var_1848:
                    _loc3_ = this.var_3015.getSideContentWindowContainer(AvatarEditorSideCategory.var_1848);
                    break;
                case AvatarEditorSideCategory.var_1847:
                    _loc3_ = this.var_3015.getSideContentWindowContainer(AvatarEditorSideCategory.var_1847);
                    break;
            };
            var _loc4_:IWindow = _loc2_.removeChildAt(0);
            if (_loc4_)
            {
                this.var_3018.width = (this.var_3018.width - _loc4_.width);
            };
            if (_loc3_)
            {
                _loc2_.addChild(_loc3_);
                _loc3_.visible = true;
                _loc2_.width = _loc3_.width;
            }
            else
            {
                _loc2_.width = 0;
            };
            this.var_3023 = param1;
            if (this.var_3021)
            {
                _loc5_ = 8;
                this.var_3021.content.width = (this.var_3018.width + _loc5_);
            };
        }

        private function setViewToCategory(param1:String):void
        {
            if (param1 == null)
            {
                return;
            };
            if (param1 == "")
            {
                return;
            };
            var _loc2_:IWindowContainer = (this.var_3018.findChildByName("contentArea") as IWindowContainer);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:IWindowContainer = (_loc2_.getChildAt(0) as IWindowContainer);
            _loc2_.removeChild(_loc3_);
            _loc2_.invalidate();
            var _loc4_:IWindowContainer = this.var_3015.getCategoryWindowContainer(param1);
            if (_loc4_ == null)
            {
                return;
            };
            _loc4_.visible = true;
            _loc2_.addChild(_loc4_);
            this.var_3019 = param1;
            this.var_3020.setSelected(this.var_3020.getSelectableByName(param1));
        }

        public function windowEventProc(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:String;
            if (param1.type == WindowEvent.var_576)
            {
                _loc3_ = param2.name;
                Logger.log(("Select tab: " + _loc3_));
                if (_loc3_ != this.var_3019)
                {
                    this.var_3015.toggleAvatarEditorPage(_loc3_);
                };
            }
            else
            {
                if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
                {
                    switch (param2.name)
                    {
                        case "save":
                            if (this.var_3015.hasInvalidClubItems())
                            {
                                this.displayStripClubDialog();
                                return;
                            };
                            this._saveTimer.start();
                            this.var_3018.findChildByName("save").disable();
                            this.var_3015.saveCurrentSelection();
                            this.var_3015.manager.close(this.var_3015.instanceId);
                            return;
                        case "cancel":
                            this.var_3015.manager.close(this.var_3015.instanceId);
                            return;
                        case "wardrobe":
                            this.toggleWardrobe();
                            return;
                        case "header_button_close":
                            this.var_3015.manager.close(this.var_3015.instanceId);
                    };
                };
            };
        }

        private function displayStripClubDialog():void
        {
            var _loc1_:IAsset;
            var _loc2_:XML;
            if (!this.var_3022)
            {
                _loc1_ = this.var_3015.manager.assets.getAssetByName("StripClubItemsInfo");
                if (!_loc1_)
                {
                    Logger.log("Failed to initialize strip club info dialog; missing asset!");
                    return;
                };
                _loc2_ = (_loc1_.content as XML);
                this.var_3022 = (this.var_3015.manager.windowManager.buildFromXML(_loc2_, 2) as IFrameWindow);
                this.var_3022.procedure = this.stripClubDialogEventProc;
                this.var_3022.center();
            }
            else
            {
                this.var_3022.visible = true;
                this.var_3022.center();
            };
        }

        private function stripClubDialogEventProc(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                switch (param2.name)
                {
                    case "header_button_close":
                        this.var_3022.visible = false;
                        if (this.var_3015.manager.communication)
                        {
                            this.var_3015.manager.communication.getHabboMainConnection(null).send(new EventLogMessageComposer("AvatarEditor", "click", "strip_club_items_close"));
                        };
                        return;
                    case "strip_button_ok":
                        if (this.var_3015)
                        {
                            this.var_3015.stripClubItems();
                        };
                        this.var_3022.visible = false;
                        if (this.var_3015.manager.communication)
                        {
                            this.var_3015.manager.communication.getHabboMainConnection(null).send(new EventLogMessageComposer("AvatarEditor", "click", "strip_club_items_ok"));
                        };
                        return;
                    case "strip_button_club_info":
                        this.openCatalogClubPage();
                        this.var_3022.visible = false;
                        if (this.var_3015.manager.communication)
                        {
                            this.var_3015.manager.communication.getHabboMainConnection(null).send(new EventLogMessageComposer("AvatarEditor", "click", "strip_club_items_info"));
                        };
                };
            };
        }

        private function openCatalogClubPage():void
        {
            if (this.var_3015.manager.catalog)
            {
                this.var_3015.manager.catalog.openCatalogPage(CatalogPageName.var_160, true);
            };
        }


    }
}