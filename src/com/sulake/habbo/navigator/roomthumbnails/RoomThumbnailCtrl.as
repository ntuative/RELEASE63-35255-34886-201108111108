package com.sulake.habbo.navigator.roomthumbnails
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomThumbnailObjectData;
    import com.sulake.habbo.communication.messages.outgoing.navigator.UpdateRoomThumbnailMessageComposer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.utils.Dictionary;
    import flash.geom.Point;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.enum.*;

    public class RoomThumbnailCtrl 
    {

        private var _navigator:HabboNavigator;
        private var _window:IWindowContainer;
        private var _active:Boolean;
        private var var_2533:ThumbnailEditorModel;
        private var var_4340:IButtonWindow;
        private var var_4341:IButtonWindow;
        private var var_4342:IButtonWindow;
        private var var_4343:IWindowContainer;
        private var var_4344:IWindowContainer;

        public function RoomThumbnailCtrl(param1:HabboNavigator)
        {
            this._navigator = param1;
            this.var_2533 = new ThumbnailEditorModel();
        }

        public function set active(param1:Boolean):void
        {
            this._active = param1;
            if (this._active)
            {
                this.var_2533.data = this._navigator.data.enteredGuestRoom.thumbnail.getCopy();
            };
        }

        public function get active():Boolean
        {
            return (this._active);
        }

        public function close():void
        {
            this._active = false;
        }

        private function prepareWindow(param1:IWindowContainer):void
        {
            if (this._window != null)
            {
                return;
            };
            this._window = IWindowContainer(this._navigator.getXmlWindow("ros_roomicon_editor"));
            param1.addChildAt(this._window, 0);
            this.var_4340 = IButtonWindow(this.find("bg_tab"));
            this.var_4341 = IButtonWindow(this.find("top_tab"));
            this.var_4342 = IButtonWindow(this.find("obj_tab"));
            this.var_4343 = IWindowContainer(this.find("tile_grid"));
            this.var_4344 = IWindowContainer(this.find("now_editing_container"));
            Util.setProcDirectly(this.find("save"), this.onSaveButton);
            Util.setProcDirectly(this.find("cancel"), this.onCancelButton);
            Util.setProcDirectly(this.var_4340, this.onBgTabButton);
            Util.setProcDirectly(this.var_4341, this.onTopTabButton);
            Util.setProcDirectly(this.var_4342, this.onObjTabButton);
        }

        private function find(param1:String):IWindow
        {
            var _loc2_:IWindow = this._window.findChildByName(param1);
            if (_loc2_ == null)
            {
                throw (new Error((("Window element with name: " + param1) + " cannot be found!")));
            };
            return (_loc2_);
        }

        private function getImgSelectorContainer(param1:int):IWindowContainer
        {
            return (IWindowContainer(this._window.findChildByName(("img_selector_container_" + param1))));
        }

        private function onSaveButton(param1:WindowEvent, param2:IWindow):void
        {
            var _loc4_:RoomThumbnailObjectData;
            var _loc5_:UpdateRoomThumbnailMessageComposer;
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("save clicked");
            var _loc3_:Array = new Array();
            for each (_loc4_ in this.var_2533.data.objects)
            {
                if (_loc4_.imgId > 0)
                {
                    _loc3_.push(_loc4_);
                };
            };
            _loc5_ = new UpdateRoomThumbnailMessageComposer(this._navigator.data.enteredGuestRoom.flatId, this.var_2533.data.bgImgId, this.var_2533.data.frontImgId, _loc3_.length);
            for each (_loc4_ in _loc3_)
            {
                _loc5_.addObj(_loc4_.pos, _loc4_.imgId);
            };
            this._navigator.send(_loc5_);
        }

        private function onCancelButton(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("cancel clicked");
            this._navigator.roomInfoViewCtrl.backToRoomSettings();
        }

        private function onBgTabButton(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("bg tab clicked");
            this.var_2533.mode = ThumbnailEditorModel.var_947;
            this.reload();
        }

        private function onTopTabButton(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("top tab clicked");
            this.var_2533.mode = ThumbnailEditorModel.var_948;
            this.reload();
        }

        private function onObjTabButton(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("obj tab clicked");
            this.var_2533.mode = ThumbnailEditorModel.var_951;
            this.reload();
        }

        private function onSelectPos(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log(("obj pos clicked: " + param2.id));
            this.var_2533.setPos(param2.id);
            this.reload();
        }

        private function onImgSel(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log(("img selected: " + param2.id));
            this.var_2533.setImg(param2.id);
            this.reload();
        }

        public function refresh(param1:IWindowContainer):void
        {
            if (!this._active)
            {
                return;
            };
            this.prepareWindow(param1);
            this.refreshHeader();
            this.refreshTab();
            this.refreshEditArea();
            this.refreshImgSelectors();
            this._window.height = (Util.getLowestPoint(this._window) + 4);
            this._window.visible = true;
        }

        private function reload():void
        {
            this._navigator.roomInfoViewCtrl.reload();
        }

        private function refreshTab():void
        {
            this.setEnabled(this.var_4340, (!(this.var_2533.mode == ThumbnailEditorModel.var_947)));
            this.setEnabled(this.var_4341, (!(this.var_2533.mode == ThumbnailEditorModel.var_948)));
            this.setEnabled(this.var_4342, (!(this.var_2533.mode == ThumbnailEditorModel.var_951)));
        }

        private function refreshEditArea():void
        {
            var _loc1_:IWindowContainer = this.var_4344;
            Util.hideChildren(_loc1_);
            this.refreshEditImg(_loc1_, "edit_bg", (this.var_2533.mode == ThumbnailEditorModel.var_947));
            this.refreshEditImg(_loc1_, "edit_top", (this.var_2533.mode == ThumbnailEditorModel.var_948));
            this.refreshEditImg(_loc1_, "edit_obj", (this.var_2533.mode == ThumbnailEditorModel.var_951), false);
            if (this.var_2533.mode == ThumbnailEditorModel.var_951)
            {
                this.refreshPositionGrid();
            };
        }

        private function refreshEditImg(param1:IWindowContainer, param2:String, param3:Boolean, param4:Boolean=true):void
        {
            if (!param3)
            {
                return;
            };
            var _loc5_:IBitmapWrapperWindow = IBitmapWrapperWindow(param1.findChildByName(param2));
            if (_loc5_.bitmap != null)
            {
                _loc5_.visible = true;
                return;
            };
            var _loc6_:BitmapData = this._navigator.getButtonImage(param2);
            if (param4)
            {
                this._navigator.thumbRenderer.roundEdges(_loc6_);
            };
            _loc5_.bitmap = _loc6_;
            _loc5_.visible = true;
        }

        private function refreshPositionGrid():void
        {
            var _loc3_:int;
            var _loc4_:IBitmapWrapperWindow;
            var _loc5_:IBitmapWrapperWindow;
            var _loc1_:IWindowContainer = this.var_4343;
            _loc1_.visible = true;
            if (_loc1_.numChildren == 0)
            {
                while (_loc3_ <= RoomThumbnailRenderer.var_944)
                {
                    _loc4_ = this._navigator.getButton(("pos_" + _loc3_), "rico_tile", this.onSelectPos, 0, 0, _loc3_);
                    this.refreshTileLoc(_loc4_, _loc3_);
                    _loc1_.addChild(_loc4_);
                    _loc5_ = this._navigator.getButton(("block_" + _loc3_), "rico_tile_x", this.onSelectPos, 0, 0, _loc3_);
                    _loc5_.visible = false;
                    this.refreshTileLoc(_loc5_, _loc3_);
                    _loc1_.addChild(_loc5_);
                    _loc3_++;
                };
                _loc1_.addChild(this._navigator.getButton("selected", "rico_tile_s", null, 0, 0));
            };
            var _loc2_:IBitmapWrapperWindow = IBitmapWrapperWindow(_loc1_.findChildByName("selected"));
            if (this.var_2533.selected == null)
            {
                _loc2_.visible = false;
                return;
            };
            _loc2_.visible = true;
            this.refreshTileLoc(_loc2_, this.var_2533.selected.pos);
            this.refreshBlockedTiles(_loc1_);
        }

        private function refreshBlockedTiles(param1:IWindowContainer):void
        {
            var _loc3_:int;
            var _loc2_:Dictionary = this.var_2533.getBlockedPositions();
            while (_loc3_ <= RoomThumbnailRenderer.var_944)
            {
                param1.findChildByName(("block_" + _loc3_)).visible = (!(_loc2_[_loc3_] == null));
                _loc3_++;
            };
        }

        private function refreshTileLoc(param1:IBitmapWrapperWindow, param2:int):void
        {
            var _loc3_:Point = this._navigator.thumbRenderer.getScreenLocForPos(param2);
            param1.x = _loc3_.x;
            param1.y = _loc3_.y;
        }

        private function refreshImgSelectors():void
        {
            this.refreshImgSelector(ThumbnailEditorModel.var_947);
            this.refreshImgSelector(ThumbnailEditorModel.var_948);
            this.refreshImgSelector(ThumbnailEditorModel.var_951);
        }

        private function refreshImgSelector(param1:int):void
        {
            var _loc7_:ThumbnailImageConfiguration;
            var _loc2_:IWindowContainer = this.getImgSelectorContainer(param1);
            if (this.var_2533.mode != param1)
            {
                _loc2_.visible = false;
                return;
            };
            _loc2_.visible = true;
            var _loc3_:IItemListWindow = IItemListWindow(_loc2_.findChildByName("img_list"));
            if (_loc3_.numListItems == 0)
            {
                this.populateImgList(_loc3_, param1);
            };
            var _loc4_:Array = this._navigator.thumbRenderer.imageConfigurations.getImageList(param1);
            var _loc5_:int = this.var_2533.getImgId();
            var _loc6_:int;
            while (_loc6_ < _loc4_.length)
            {
                _loc7_ = _loc4_[_loc6_];
                Logger.log(((("CHECK SELECTED: " + _loc5_) + ", ") + _loc7_.id));
                _loc7_.setSelected((_loc7_.id == _loc5_));
                _loc6_++;
            };
        }

        private function populateImgList(param1:IItemListWindow, param2:int):void
        {
            var _loc9_:int;
            var _loc10_:ThumbnailImageConfiguration;
            var _loc11_:IRegionWindow;
            var _loc12_:IBitmapWrapperWindow;
            var _loc3_:int = 66;
            var _loc4_:int = 3;
            var _loc5_:int = 66;
            var _loc6_:Array = this._navigator.thumbRenderer.imageConfigurations.getImageList(param2);
            var _loc7_:IWindowContainer;
            var _loc8_:int;
            while (_loc8_ < _loc6_.length)
            {
                _loc9_ = (_loc8_ % _loc4_);
                if (_loc9_ == 0)
                {
                    _loc7_ = IWindowContainer(this._navigator.windowManager.createWindow(("row_" + _loc8_), "", HabboWindowType.var_218, HabboWindowStyle.var_613, HabboWindowParam.var_159, new Rectangle(0, 0, param1.width, _loc3_)));
                    param1.addListItem(_loc7_);
                };
                _loc10_ = _loc6_[_loc8_];
                _loc11_ = IRegionWindow(this._navigator.windowManager.createWindow(("img_" + _loc8_), "", WindowType.var_1120, HabboWindowStyle.var_157, (HabboWindowParam.var_158 | HabboWindowParam.var_159), new Rectangle((_loc9_ * _loc5_), 0, _loc5_, _loc3_), this.onImgSel, _loc10_.id));
                _loc11_.mouseThreshold = 0;
                _loc12_ = IBitmapWrapperWindow(this._navigator.windowManager.createWindow(("img_" + _loc8_), "", HabboWindowType.var_156, HabboWindowStyle.var_157, HabboWindowParam.var_159, new Rectangle(0, 0, _loc5_, _loc3_), this.onImgSel, _loc10_.id));
                _loc12_.bitmap = new BitmapData(_loc12_.width, _loc12_.height);
                _loc10_.registerListImg(_loc12_);
                _loc11_.addChild(_loc12_);
                _loc7_.addChild(_loc11_);
                _loc8_++;
            };
        }

        private function setEnabled(param1:IButtonWindow, param2:Boolean):void
        {
            if (param2)
            {
                param1.enable();
            }
            else
            {
                param1.disable();
            };
        }

        private function refreshHeader():void
        {
            this._navigator.thumbRenderer.refreshThumbnail(IWindowContainer(this._window.findChildByName("picframe")), this.var_2533.data, false);
        }


    }
}