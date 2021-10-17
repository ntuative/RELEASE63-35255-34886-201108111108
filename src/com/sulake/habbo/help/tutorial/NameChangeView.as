package com.sulake.habbo.help.tutorial
{
    import com.sulake.habbo.help.INameChangeUI;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class NameChangeView 
    {

        private static var var_2157:uint = 13232628;
        private static var var_2158:uint = 11129827;

        private var var_2438:INameChangeUI;
        private var _window:IFrameWindow;
        private var var_4016:String;
        private var var_4017:String;
        private var var_4018:IWindowContainer;
        private var var_4019:IWindowContainer;
        private var var_4020:IWindowContainer;
        private var var_4021:IWindowContainer;
        private var var_4022:Boolean = false;
        private var var_4023:NameSuggestionListRenderer;

        public function NameChangeView(param1:INameChangeUI):void
        {
            this.var_2438 = param1;
        }

        public function get id():String
        {
            return (TutorialUI.var_280);
        }

        public function set checkedName(param1:String):void
        {
            this.var_4016 = param1;
            if (this.var_4017 == this.var_4016)
            {
                this.showConfirmationView();
                return;
            };
            this.setNameAvailableView();
        }

        public function dispose():void
        {
            this.disposeWindow();
            if (this.var_4023 != null)
            {
                this.var_4023.dispose();
                this.var_4023 = null;
            };
        }

        private function disposeWindow():void
        {
            this.var_4018 = null;
            this.var_4019 = null;
            this.var_4020 = null;
            this.var_4021 = null;
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
        }

        private function showView(param1:IWindowContainer):void
        {
            this.var_4022 = false;
            if (this.var_4021)
            {
                this.var_4021.visible = false;
            };
            this.var_4021 = param1;
            this.var_4021.visible = true;
            if (this._window)
            {
                this._window.content.width = this.var_4021.width;
                this._window.content.height = this.var_4021.height;
            };
        }

        public function showMainView():void
        {
            if (!this._window)
            {
                this._window = (this.var_2438.buildXmlWindow("welcome_name_change") as IFrameWindow);
                this._window.center();
                this._window.procedure = this.windowEventHandler;
                this.var_4018 = (this._window.content.getChildAt(0) as IWindowContainer);
            };
            this.var_2438.localization.registerParameter("tutorial.name_change.current", "name", this.var_2438.myName);
            this._window.caption = this.var_2438.localization.getKey("tutorial.name_change.title.main");
            this.showView(this.var_4018);
        }

        private function showSelectionView():void
        {
            if (!this.var_4019)
            {
                this.var_4019 = (this.var_2438.buildXmlWindow("welcome_name_selection") as IWindowContainer);
                if (!this.var_4019)
                {
                    return;
                };
                this._window.content.addChild(this.var_4019);
            };
            this._window.caption = this.var_2438.localization.getKey("tutorial.name_change.title.select");
            var _loc1_:IButtonWindow = (this._window.findChildByName("select_name_button") as IButtonWindow);
            if (_loc1_)
            {
                _loc1_.disable();
            };
            this.setNormalView();
            this.showView(this.var_4019);
        }

        private function showConfirmationView():void
        {
            if (!this.var_4020)
            {
                this.var_4020 = (this.var_2438.buildXmlWindow("welcome_name_confirmation") as IWindowContainer);
                if (!this.var_4020)
                {
                    return;
                };
                this._window.content.addChild(this.var_4020);
            };
            this._window.caption = this.var_2438.localization.getKey("tutorial.name_change.title.confirm");
            var _loc1_:ITextWindow = (this.var_4020.findChildByName("final_name") as ITextWindow);
            if (_loc1_)
            {
                _loc1_.text = this.var_4016;
            };
            this.showView(this.var_4020);
        }

        public function get view():IWindowContainer
        {
            return (this._window);
        }

        public function setNormalView():void
        {
            if (this._window == null)
            {
                return;
            };
            var _loc1_:ITextWindow = (this._window.findChildByName("info_text") as ITextWindow);
            if (_loc1_ == null)
            {
                return;
            };
            _loc1_.text = this.var_2438.localization.getKey("help.tutorial.name.info");
            var _loc2_:IWindowContainer = (this._window.findChildByName("suggestions") as IWindowContainer);
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.visible = false;
        }

        public function setNameAvailableView():void
        {
            if (this._window == null)
            {
                return;
            };
            this.nameCheckWaitEnd(true);
            var _loc1_:ITextWindow = (this._window.findChildByName("info_text") as ITextWindow);
            if (_loc1_ == null)
            {
                return;
            };
            this.var_2438.localization.registerParameter("help.tutorial.name.available", "name", this.var_4016);
            _loc1_.text = this.var_2438.localization.getKey("help.tutorial.name.available");
            var _loc2_:ITextFieldWindow = (this._window.findChildByName("input") as ITextFieldWindow);
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.text = this.var_4016;
            var _loc3_:IWindowContainer = (this._window.findChildByName("suggestions") as IWindowContainer);
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.visible = false;
        }

        public function setNameNotAvailableView(param1:int, param2:String, param3:Array):void
        {
            var _loc8_:IWindow;
            this.nameCheckWaitEnd(false);
            if (this.var_4021 != this.var_4019)
            {
                this.showSelectionView();
            };
            this.var_4017 = null;
            this.var_4016 = null;
            if (this._window == null)
            {
                return;
            };
            var _loc4_:ITextWindow = (this._window.findChildByName("info_text") as ITextWindow);
            if (_loc4_ == null)
            {
                return;
            };
            switch (param1)
            {
                case ChangeUserNameResultMessageEvent.var_1748:
                    this.var_2438.localization.registerParameter("help.tutorial.name.taken", "name", param2);
                    _loc4_.text = this.var_2438.localization.getKey("help.tutorial.name.taken");
                    break;
                case ChangeUserNameResultMessageEvent.var_1747:
                    this.var_2438.localization.registerParameter("help.tutorial.name.invalid", "name", param2);
                    _loc4_.text = this.var_2438.localization.getKey("help.tutorial.name.invalid");
                    break;
                case ChangeUserNameResultMessageEvent.var_1744:
                    break;
                case ChangeUserNameResultMessageEvent.var_1746:
                    _loc4_.text = this.var_2438.localization.getKey("help.tutorial.name.long");
                    break;
                case ChangeUserNameResultMessageEvent.var_1745:
                    _loc4_.text = this.var_2438.localization.getKey("help.tutorial.name.short");
                    break;
                case ChangeUserNameResultMessageEvent.var_1749:
                    _loc4_.text = this.var_2438.localization.getKey("help.tutorial.name.change_not_allowed");
                    break;
                case ChangeUserNameResultMessageEvent.var_1750:
                    _loc4_.text = this.var_2438.localization.getKey("help.tutorial.name.merge_hotel_down");
                    break;
            };
            var _loc5_:IWindowContainer = (this._window.findChildByName("suggestions") as IWindowContainer);
            if (_loc5_ == null)
            {
                return;
            };
            if (((param1 == ChangeUserNameResultMessageEvent.var_1750) || (param1 == ChangeUserNameResultMessageEvent.var_1749)))
            {
                _loc5_.visible = false;
                return;
            };
            _loc5_.visible = true;
            this.var_4023 = new NameSuggestionListRenderer(this.var_2438);
            var _loc6_:int = this.var_4023.render(param3, _loc5_);
            var _loc7_:int;
            while (_loc7_ < _loc5_.numChildren)
            {
                _loc8_ = _loc5_.getChildAt(_loc7_);
                _loc8_.color = var_2157;
                _loc8_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.nameSelected);
                _loc8_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.nameOver);
                _loc8_.addEventListener(WindowMouseEvent.var_624, this.nameOut);
                _loc7_++;
            };
        }

        private function nameSelected(param1:WindowMouseEvent):void
        {
            this.nameCheckWaitEnd(true);
            var _loc2_:ITextWindow = (param1.target as ITextWindow);
            if (!_loc2_)
            {
                return;
            };
            var _loc3_:String = _loc2_.text;
            this.setNormalView();
            var _loc4_:ITextFieldWindow = (this._window.findChildByName("input") as ITextFieldWindow);
            if (_loc4_ == null)
            {
                return;
            };
            _loc4_.text = _loc3_;
        }

        private function nameOver(param1:WindowMouseEvent):void
        {
            var _loc2_:ITextWindow = (param1.target as ITextWindow);
            if (_loc2_ != null)
            {
                _loc2_.color = var_2158;
            };
        }

        private function nameOut(param1:WindowMouseEvent):void
        {
            var _loc2_:ITextWindow = (param1.target as ITextWindow);
            if (_loc2_ != null)
            {
                _loc2_.color = var_2157;
            };
        }

        public function nameCheckWaitBegin():void
        {
            var _loc1_:IWindow;
            if (((this._window) && (!(this._window.disposed))))
            {
                _loc1_ = this._window.findChildByName("select_name_button");
                if (_loc1_)
                {
                    _loc1_.disable();
                };
                _loc1_ = this._window.findChildByName("check_name_button");
                if (_loc1_)
                {
                    _loc1_.disable();
                };
                _loc1_ = this._window.findChildByName("input");
                if (_loc1_)
                {
                    _loc1_.disable();
                };
                _loc1_ = this._window.findChildByName("info_text");
                if (_loc1_)
                {
                    _loc1_.caption = this.var_2438.localization.getKey("help.tutorial.name.wait_while_checking");
                };
            };
            this.var_4022 = true;
        }

        public function nameCheckWaitEnd(param1:Boolean):void
        {
            var _loc2_:IWindow;
            if (((this._window) && (!(this._window.disposed))))
            {
                if (param1)
                {
                    _loc2_ = this._window.findChildByName("select_name_button");
                    if (_loc2_)
                    {
                        _loc2_.enable();
                    };
                };
                _loc2_ = this._window.findChildByName("check_name_button");
                if (_loc2_)
                {
                    _loc2_.enable();
                };
                _loc2_ = this._window.findChildByName("input");
                if (_loc2_)
                {
                    _loc2_.enable();
                };
            };
            this.var_4022 = false;
        }

        private function windowEventHandler(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:IWindow;
            var _loc4_:ITextFieldWindow;
            var _loc5_:String;
            if (!this.var_4022)
            {
                if (param1.type == WindowEvent.var_606)
                {
                    if (param2.name == "input")
                    {
                        _loc3_ = this._window.findChildByName("select_name_button");
                        _loc4_ = (param2 as ITextFieldWindow);
                        if (((_loc3_) && (_loc4_)))
                        {
                            if (_loc4_.text.length > 2)
                            {
                                _loc3_.enable();
                            }
                            else
                            {
                                _loc3_.disable();
                            };
                        };
                    };
                };
            };
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            switch (param2.name)
            {
                case "change_name_button":
                    this.showSelectionView();
                    return;
                case "keep_name_button":
                    this.var_4016 = this.var_2438.myName;
                    this.showConfirmationView();
                    return;
                case "check_name_button":
                    this.var_2438.checkName(this.getName());
                    this.nameCheckWaitBegin();
                    return;
                case "select_name_button":
                    _loc5_ = this.getName();
                    if (_loc5_.length < 1)
                    {
                        return;
                    };
                    if (this.var_4016 != _loc5_)
                    {
                        this.var_4017 = _loc5_;
                        this.var_2438.checkName(_loc5_);
                        this.nameCheckWaitBegin();
                    }
                    else
                    {
                        this.showConfirmationView();
                    };
                    return;
                case "cancel_selection_button":
                    this.nameCheckWaitEnd(true);
                    this.showMainView();
                    return;
                case "confirm_name_button":
                    this.var_2438.changeName(this.var_4016);
                    return;
                case "cancel_confirmation_button":
                    this.nameCheckWaitEnd(true);
                    this.showMainView();
                    return;
                case "header_button_close":
                    this.var_2438.showView(TutorialUI.var_1407);
                    return;
            };
        }

        private function getName():String
        {
            var _loc1_:ITextFieldWindow;
            if (this._window)
            {
                _loc1_ = (this._window.findChildByName("input") as ITextFieldWindow);
                if (_loc1_)
                {
                    return (_loc1_.text);
                };
            };
            return (null);
        }


    }
}