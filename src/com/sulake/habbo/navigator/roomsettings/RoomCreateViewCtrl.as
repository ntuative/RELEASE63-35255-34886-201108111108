package com.sulake.habbo.navigator.roomsettings
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.navigator.TextFieldManager;
    import com.sulake.habbo.navigator.domain.RoomLayout;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.events.Event;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.habbo.navigator.Util;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.navigator.CreateFlatMessageComposer;
    import com.sulake.habbo.navigator.*;

    public class RoomCreateViewCtrl 
    {

        private var _navigator:HabboNavigator;
        private var var_2578:IWindowContainer;
        private var var_2632:IItemListWindow;
        private var var_4313:TextFieldManager;
        private var var_4312:Array;
        private var var_4314:RoomLayout;
        private var var_4311:Timer;
        private var var_4315:Boolean = true;

        public function RoomCreateViewCtrl(param1:HabboNavigator)
        {
            this._navigator = param1;
            this.var_4311 = new Timer(100);
            this.var_4311.addEventListener(TimerEvent.TIMER, this.updateArrowPos);
            this.var_4312 = new Array();
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_255, 104, "a"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_255, 94, "b"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_255, 36, "c"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_255, 84, "d"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_255, 80, "e"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_255, 80, "f"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_255, 416, "i"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_255, 320, "j"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_255, 448, "k"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_255, 352, "l"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_255, 384, "m"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_255, 372, "n"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_256, 80, "g"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_256, 74, "h"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_256, 416, "o"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_256, 352, "p"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_256, 304, "q"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_256, 336, "r"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_256, 748, "u"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_256, 438, "v"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_114, 540, "t"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_114, 0x0200, "w"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_114, 396, "x"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_114, 440, "y"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_114, 456, "z"));
            this.var_4312.push(new RoomLayout(HabboClubLevelEnum.var_114, 208, "0"));
        }

        public function dispose():void
        {
            if (this.var_4311)
            {
                this.var_4311.removeEventListener(TimerEvent.TIMER, this.updateArrowPos);
                this.var_4311.reset();
                this.var_4311 = null;
            };
        }

        private function updateArrowPos(param1:Event):void
        {
            var _loc2_:String = "select_arrow";
            var _loc3_:IBitmapWrapperWindow = IBitmapWrapperWindow(this.var_4314.view.findChildByName(_loc2_));
            var _loc4_:int;
            var _loc5_:int = 15;
            var _loc6_:int = (((Math.abs((_loc3_.y - _loc4_)) < 2) || (Math.abs((_loc3_.y - _loc5_)) < 2)) ? 1 : 2);
            _loc3_.y = (_loc3_.y + ((this.var_4315) ? _loc6_ : -(_loc6_)));
            if (_loc3_.y < _loc4_)
            {
                this.var_4315 = true;
                _loc3_.y = (_loc4_ + 1);
            }
            else
            {
                if (_loc3_.y > _loc5_)
                {
                    this.var_4315 = false;
                    _loc3_.y = (_loc5_ - 1);
                };
            };
        }

        public function show():void
        {
            this.prepare();
            this.var_2578.visible = true;
            this.refresh();
            this.var_2578.activate();
            this.var_4311.start();
        }

        private function addMouseClickListener(param1:IWindow, param2:Function):void
        {
            if (param1 != null)
            {
                param1.setParamFlag(HabboWindowParam.var_158, true);
                param1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, param2);
            };
        }

        private function prepare():void
        {
            if (this.var_2578 != null)
            {
                return;
            };
            this.var_2578 = IWindowContainer(this._navigator.getXmlWindow("roc_create_room"));
            this.var_2632 = IItemListWindow(this.var_2578.findChildByName("item_list"));
            this.refreshRoomThumbnails();
            var _loc1_:IButtonWindow = this.getCreateButton();
            this.addMouseClickListener(_loc1_, this.onCreateButtonClick);
            var _loc2_:IButtonWindow = this.getCancelButton();
            this.addMouseClickListener(_loc2_, this.onCancelButtonClick);
            var _loc3_:IWindow = this.var_2578.findChildByTag("close");
            this.addMouseClickListener(_loc3_, this.onCancelButtonClick);
            this.var_4313 = new TextFieldManager(this._navigator, ITextFieldWindow(this.var_2578.findChildByName("room_name_input")), 25, null, this._navigator.getText("navigator.createroom.roomnameinfo"));
            var _loc4_:Rectangle = Util.getLocationRelativeTo(this.var_2578.desktop, this.var_2578.width, this.var_2578.height);
            this.var_2578.x = _loc4_.x;
            this.var_2578.y = _loc4_.y;
        }

        public function refresh():void
        {
            this.var_4313.goBackToInitialState();
            this.var_4313.input.textBackgroundColor = 0xFFFFFFFF;
            this.var_4314 = this.var_4312[0];
            this.refreshRoomThumbnails();
            this.refreshSelection();
        }

        private function refreshSelection():void
        {
            var _loc1_:RoomLayout;
            var _loc2_:Boolean;
            var _loc3_:ITextWindow;
            for each (_loc1_ in this.var_4312)
            {
                if (_loc1_.view != null)
                {
                    _loc2_ = (_loc1_ == this.var_4314);
                    _loc1_.view.findChildByName("bg_sel").visible = _loc2_;
                    _loc1_.view.findChildByName("bg_unsel").visible = (!(_loc2_));
                    _loc3_ = ITextWindow(_loc1_.view.findChildByName("tile_size_txt"));
                    _loc3_.textColor = ((_loc2_) ? 0xFFFFFFFF : 0xFF000000);
                    _loc3_.color = ((_loc2_) ? 4285432196 : 4291546059);
                    this._navigator.refreshButton(_loc1_.view, "tile_icon_black", (!(_loc2_)), null, 0);
                    this._navigator.refreshButton(_loc1_.view, "tile_icon_white", _loc2_, null, 0);
                    this._navigator.refreshButton(_loc1_.view, "select_arrow", _loc2_, null, 0);
                };
            };
        }

        private function refreshRoomThumbnails():void
        {
            var _loc1_:RoomLayout;
            var _loc2_:int;
            var _loc3_:IWindowContainer;
            var _loc4_:int;
            var _loc6_:IWindow;
            var _loc7_:RoomLayout;
            var _loc8_:IWindowContainer;
            var _loc9_:IWindow;
            while (this.var_2632.numListItems > 0)
            {
                _loc6_ = this.var_2632.removeListItemAt(0);
                _loc6_.destroy();
            };
            for each (_loc1_ in this.var_4312)
            {
                if (_loc1_.view != null)
                {
                    _loc1_.view.destroy();
                    _loc1_.view = null;
                };
            };
            _loc2_ = 0;
            _loc4_ = 0;
            while (_loc4_ < this.var_4312.length)
            {
                _loc7_ = this.var_4312[_loc4_];
                if (this.isAllowed(_loc7_))
                {
                    if (_loc2_ == 0)
                    {
                        _loc3_ = this.getRow();
                        this.var_2632.addListItem(_loc3_);
                    };
                    this.addThumbnail(_loc3_, this.var_4312[_loc4_], ((_loc2_ % 2) == 0));
                    _loc2_ = ((_loc2_ == 0) ? 1 : 0);
                };
                _loc4_++;
            };
            this.refreshSelection();
            var _loc5_:String = "roc_hc_promo";
            if (this._navigator.sessionData.hasUserRight("fuse_use_special_room_layouts", HabboClubLevelEnum.var_256))
            {
                if (this._navigator.sessionData.hasUserRight("fuse_use_vip_room_layouts", HabboClubLevelEnum.var_114))
                {
                    _loc5_ = null;
                }
                else
                {
                    _loc5_ = "roc_vip_promo";
                };
            };
            if (_loc5_)
            {
                _loc8_ = IWindowContainer(this._navigator.getXmlWindow(_loc5_));
                if (_loc8_)
                {
                    _loc9_ = _loc8_.findChildByName("link");
                    this.addMouseClickListener(_loc9_, this.onHcMoreClick);
                    this.var_2632.addListItem(_loc8_);
                };
            };
        }

        private function addThumbnail(param1:IWindowContainer, param2:RoomLayout, param3:Boolean):void
        {
            var _loc4_:IWindowContainer = IWindowContainer(this._navigator.getXmlWindow("roc_room_thumbnail"));
            _loc4_.tags.push(param2.name);
            if (!param3)
            {
                _loc4_.x = _loc4_.width;
            };
            this.addMouseClickListener(_loc4_, this.onContPicClick);
            var _loc5_:IWindowContainer = (_loc4_.findChildByName("bg_pic") as IWindowContainer);
            var _loc6_:IBitmapWrapperWindow = this._navigator.getButton(param2.name, ("model_" + param2.name), null, 0, 0, 0);
            _loc6_.setParamFlag(HabboWindowParam.var_158, false);
            _loc5_.addChild(_loc6_);
            var _loc7_:Rectangle = Util.getLocationRelativeTo(_loc5_, _loc6_.width, _loc6_.height);
            _loc6_.x = _loc7_.x;
            _loc6_.y = _loc7_.y;
            param1.addChild(_loc4_);
            param1.width = (2 * _loc4_.width);
            param1.height = _loc4_.height;
            param2.view = _loc4_;
            ITextWindow(param2.view.findChildByName("tile_size_txt")).text = ((param2.tileSize + " ") + this._navigator.getText("navigator.createroom.tilesize"));
            var _loc8_:IIconWindow = (_loc4_.findChildByName("club_icon") as IIconWindow);
            if (_loc8_)
            {
                switch (param2.requiredClubLevel)
                {
                    case HabboClubLevelEnum.var_256:
                        _loc8_.style = 11;
                        return;
                    case HabboClubLevelEnum.var_114:
                        _loc8_.style = 12;
                        return;
                    default:
                        _loc8_.visible = false;
                };
            };
        }

        private function isAllowed(param1:RoomLayout):Boolean
        {
            switch (param1.requiredClubLevel)
            {
                case HabboClubLevelEnum.var_255:
                    return (true);
                case HabboClubLevelEnum.var_256:
                    return (this._navigator.sessionData.hasUserRight("fuse_use_special_room_layouts", HabboClubLevelEnum.var_256));
                case HabboClubLevelEnum.var_114:
                    return (this._navigator.sessionData.hasUserRight("fuse_use_vip_room_layouts", HabboClubLevelEnum.var_114));
            };
            return (false);
        }

        private function getRow():IWindowContainer
        {
            return (IWindowContainer(this._navigator.windowManager.createWindow("", "", HabboWindowType.var_218, HabboWindowStyle.var_613, HabboWindowParam.var_159, new Rectangle(0, 0, 100, 300))));
        }

        private function isMandatoryFieldsFilled():Boolean
        {
            return (this.var_4313.checkMandatory(this._navigator.getText("navigator.createroom.nameerr")));
        }

        private function getCreateButton():IButtonWindow
        {
            return (IButtonWindow(this.var_2578.findChildByName("create_button")));
        }

        private function getCancelButton():IButtonWindow
        {
            return (IButtonWindow(this.var_2578.findChildByName("back_button")));
        }

        private function onChooseLayout(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:RoomLayout = this.getLayout(param2);
            if (this.isAllowed(_loc3_))
            {
                this.var_4314 = _loc3_;
                this.refreshSelection();
            };
        }

        private function getLayout(param1:IWindow):RoomLayout
        {
            return (this.findLayout(param1.tags[0]));
        }

        private function findLayout(param1:String):RoomLayout
        {
            var _loc2_:RoomLayout;
            for each (_loc2_ in this.var_4312)
            {
                if (_loc2_.name == param1)
                {
                    return (_loc2_);
                };
            };
            return (this.var_4312[0]);
        }

        private function onContPicClick(param1:WindowEvent):void
        {
            var _loc2_:IWindowContainer = (param1.target as IWindowContainer);
            this.onChooseLayout(param1, _loc2_);
        }

        private function onCancelButtonClick(param1:WindowEvent):void
        {
            this.close();
        }

        private function onHcMoreClick(param1:WindowEvent):void
        {
            this._navigator.openCatalogClubPage();
        }

        private function onCreateButtonClick(param1:WindowEvent):void
        {
            var _loc2_:String = this.var_4313.getText();
            var _loc3_:String = ("model_" + this.var_4314.name);
            if (!this.isMandatoryFieldsFilled())
            {
                return;
            };
            this._navigator.send(new CreateFlatMessageComposer(_loc2_, _loc3_));
            this.var_2578.visible = false;
        }

        private function close():void
        {
            this.var_2578.visible = false;
            this.var_4311.reset();
        }


    }
}