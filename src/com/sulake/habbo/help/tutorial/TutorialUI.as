package com.sulake.habbo.help.tutorial
{
    import com.sulake.habbo.help.INameChangeUI;
    import com.sulake.habbo.help.HabboHelp;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.help.enum.HabboHelpTutorialEvent;
    import com.sulake.habbo.session.events.HabboSessionFigureUpdatedEvent;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.avatar.ChangeUserNameMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.avatar.CheckUserNameMessageComposer;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.communication.messages.parser.avatar.ChangeUserNameResultMessageParser;
    import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
    import com.sulake.habbo.communication.messages.parser.avatar.CheckUserNameResultMessageParser;
    import com.sulake.habbo.communication.messages.incoming.avatar.CheckUserNameResultMessageEvent;

    public class TutorialUI implements INameChangeUI 
    {

        public static const var_1407:String = "TUI_MAIN_VIEW";
        public static const var_280:String = "TUI_NAME_VIEW";
        public static const var_1408:String = "TUI_CLOTHES_VIEW";
        public static const var_1409:String = "TUI_GUIDEBOT_VIEW";

        private var var_4009:int = 0;
        private var var_4010:int = 0;
        private var var_4014:HabboHelp;
        private var _window:IFrameWindow;
        private var var_4021:ITutorialUIView;
        private var var_4029:NameChangeView;
        private var var_3700:Boolean = false;
        private var var_3701:Boolean = false;
        private var var_3702:Boolean = false;
        private var var_4030:Boolean = false;
        private var var_4031:Boolean;

        public function TutorialUI(param1:HabboHelp, param2:Boolean=true)
        {
            this.var_4014 = param1;
            this.var_4031 = param2;
            this.var_4014.events.addEventListener(HabboHelpTutorialEvent.var_1404, this.onTaskDoneEvent);
            this.var_4014.events.addEventListener(HabboHelpTutorialEvent.var_1410, this.onTaskDoneEvent);
            this.var_4014.events.addEventListener(HabboHelpTutorialEvent.var_1411, this.onTaskDoneEvent);
            if (this.var_4014.sessionDataManager != null)
            {
                this.var_4014.sessionDataManager.events.addEventListener(HabboSessionFigureUpdatedEvent.var_1412, this.onFigureUpdate);
            };
        }

        public function get help():HabboHelp
        {
            return (this.var_4014);
        }

        public function get assets():IAssetLibrary
        {
            return (this.var_4014.assets);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (this.var_4014.localization);
        }

        public function get myName():String
        {
            return (this.var_4014.ownUserName);
        }

        public function get hasTasksDone():Boolean
        {
            return (((this.var_3700) && (this.var_3701)) && (this.var_3702));
        }

        public function get hasChangedLooks():Boolean
        {
            return (this.var_3700);
        }

        public function get hasChangedName():Boolean
        {
            return (this.var_3701);
        }

        public function get hasCalledGuideBot():Boolean
        {
            return (this.var_3702);
        }

        public function dispose():void
        {
            this.disposeView();
            if (this.var_4014)
            {
                this.var_4014.events.removeEventListener(HabboHelpTutorialEvent.var_1404, this.onTaskDoneEvent);
                this.var_4014.events.removeEventListener(HabboHelpTutorialEvent.var_1410, this.onTaskDoneEvent);
                this.var_4014.events.removeEventListener(HabboHelpTutorialEvent.var_1411, this.onTaskDoneEvent);
                if (this.var_4014.sessionDataManager != null)
                {
                    this.var_4014.sessionDataManager.events.removeEventListener(HabboSessionFigureUpdatedEvent.var_1412, this.onFigureUpdate);
                };
                this.var_4014 = null;
            };
        }

        public function update(param1:Boolean, param2:Boolean, param3:Boolean):void
        {
            this.var_3700 = param1;
            this.var_3701 = param2;
            this.var_3702 = param3;
            if (((this.var_4021 == null) || (this.var_4021.id == var_1407)))
            {
                this.prepareForTutorial();
                this.showView(var_1407);
            };
        }

        public function onTaskDoneEvent(param1:HabboHelpTutorialEvent):void
        {
            switch (param1.type)
            {
                case HabboHelpTutorialEvent.var_1404:
                    this.var_3702 = true;
                    if (((!(this.var_4021 == null)) && (this.var_4021.id == var_1409)))
                    {
                        this.showView(var_1407);
                    };
                    return;
                case HabboHelpTutorialEvent.var_1410:
                    if (((!(this.var_4021 == null)) && (this.var_4021.id == var_1408)))
                    {
                        this.var_4030 = true;
                        this.disposeWindow();
                    };
                    return;
                case HabboHelpTutorialEvent.var_1411:
                    if (this.var_4030)
                    {
                        this.var_4030 = false;
                        this.showView(var_1407);
                    };
                    return;
            };
        }

        public function showView(param1:String):void
        {
            var _loc2_:IItemListWindow;
            if (this.hasTasksDone)
            {
                if (this.var_4014)
                {
                    this.var_4014.removeTutorialUI();
                };
                return;
            };
            var _loc3_:Boolean;
            if (this._window == null)
            {
                this._window = (this.buildXmlWindow("tutorial_frame") as IFrameWindow);
                if (this._window == null)
                {
                    return;
                };
                this._window.procedure = this.windowProcedure;
                _loc2_ = (this._window.findChildByName("content_list") as IItemListWindow);
                if (_loc2_ == null)
                {
                    return;
                };
                this.var_4009 = (this._window.width - _loc2_.width);
                this.var_4010 = this._window.height;
                _loc3_ = true;
            };
            _loc2_ = (this._window.findChildByName("content_list") as IItemListWindow);
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.destroyListItems();
            _loc2_.height = 0;
            if (this.var_4021 != null)
            {
                this.var_4021.dispose();
            };
            this._window.visible = true;
            switch (param1)
            {
                case var_1407:
                    if (this.var_4029 != null)
                    {
                        this.var_4029.dispose();
                    };
                    if (this.var_4031)
                    {
                        this.var_4021 = new TutorialMainView(_loc2_, this);
                    }
                    else
                    {
                        this._window.visible = false;
                        return;
                    };
                    break;
                case var_280:
                    this._window.visible = false;
                    if (this.var_4029 == null)
                    {
                        this.var_4029 = new NameChangeView(this);
                    };
                    this.var_4029.showMainView();
                    this.prepareForTutorial();
                    break;
                case var_1408:
                    this.var_4021 = new TutorialClothesChangeView(_loc2_, this);
                    break;
                case var_1409:
                    this.var_4021 = new TutorialCallGuideBotView(_loc2_, this);
                    break;
            };
            this._window.height = (_loc2_.height + this.var_4010);
            this._window.width = (_loc2_.width + this.var_4009);
            if (_loc3_)
            {
                if (this._window == null)
                {
                    return;
                };
                this._window.x = ((this._window.context.getDesktopWindow().width / 2) - (this._window.width / 2));
                this._window.y = 0;
            };
        }

        public function buildXmlWindow(param1:String, param2:uint=1):IWindow
        {
            if (((this.var_4014 == null) || (this.var_4014.assets == null)))
            {
                return (null);
            };
            var _loc3_:XmlAsset = XmlAsset(this.var_4014.assets.getAssetByName((param1 + "_xml")));
            if (((_loc3_ == null) || (this.var_4014.windowManager == null)))
            {
                return (null);
            };
            return (this.var_4014.windowManager.buildFromXML(XML(_loc3_.content), param2));
        }

        private function disposeWindow(param1:WindowEvent=null):void
        {
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
        }

        private function disposeView():void
        {
            if (this.var_4021 != null)
            {
                this.var_4021.dispose();
                this.var_4021 = null;
            };
            if (this.var_4029 != null)
            {
                this.var_4029.dispose();
                this.var_4029 = null;
            };
            this.disposeWindow();
        }

        public function setRoomSessionStatus(param1:Boolean):void
        {
            if (param1 == false)
            {
                this.disposeView();
            };
        }

        public function prepareForTutorial():void
        {
            if (((this.var_4014 == null) || (this.var_4014.events == null)))
            {
                return;
            };
            this.var_4014.hideUI();
            this.var_4014.events.dispatchEvent(new HabboHelpTutorialEvent(HabboHelpTutorialEvent.var_1413));
        }

        public function windowProcedure(param1:WindowEvent, param2:IWindow):void
        {
            switch (param1.type)
            {
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
                    if (param2.name == "header_button_close")
                    {
                        this.disposeView();
                    };
                    return;
            };
        }

        public function changeName(param1:String):void
        {
            this.disposeWindow();
            this.var_4014.sendMessage(new ChangeUserNameMessageComposer(param1));
        }

        public function checkName(param1:String):void
        {
            this.disposeWindow();
            this.var_4014.sendMessage(new CheckUserNameMessageComposer(param1));
        }

        public function onUserNameChanged(name:String):void
        {
            if ((((!(this.var_4014)) || (!(this.var_4014.localization))) || (!(this.var_4014.windowManager))))
            {
                return;
            };
            this.var_3701 = true;
            this.var_4014.localization.registerParameter("help.tutorial.name.changed", "name", name);
            this.var_4014.windowManager.alert("${generic.notice}", "${help.tutorial.name.changed}", 0, function (param1:IAlertDialog, param2:WindowEvent):void
            {
                param1.dispose();
            });
            if (((!(this.var_4021 == null)) && ((this.var_4021.id == var_280) || (this.var_4021.id == var_1407))))
            {
                this.showView(var_1407);
            };
        }

        private function onFigureUpdate(param1:HabboSessionFigureUpdatedEvent):void
        {
            var _loc2_:Boolean;
            if (((this.var_4014 == null) || (param1 == null)))
            {
                return;
            };
            if (!this.var_3700)
            {
                if (this.var_4014.sessionDataManager != null)
                {
                    _loc2_ = (param1.userId == this.var_4014.sessionDataManager.userId);
                    if (_loc2_)
                    {
                        this.var_4014.sessionDataManager.events.removeEventListener(HabboSessionFigureUpdatedEvent.var_1412, this.onFigureUpdate);
                        this.onUserChanged();
                    };
                };
            };
        }

        public function onUserChanged():void
        {
            this.var_3700 = true;
            if (((!(this.var_4021 == null)) && ((this.var_4021.id == var_1408) || (this.var_4021.id == var_1407))))
            {
                this.showView(var_1407);
            };
        }

        public function onChangeUserNameResult(param1:ChangeUserNameResultMessageEvent):void
        {
            if (param1 == null)
            {
                return;
            };
            var _loc2_:ChangeUserNameResultMessageParser = param1.getParser();
            if (_loc2_.resultCode == ChangeUserNameResultMessageEvent.var_445)
            {
                this.var_3701 = true;
                this.showView(TutorialUI.var_1407);
            }
            else
            {
                this.var_4029.setNameNotAvailableView(_loc2_.resultCode, _loc2_.name, _loc2_.nameSuggestions);
            };
        }

        public function onCheckUserNameResult(param1:CheckUserNameResultMessageEvent):void
        {
            if (!param1)
            {
                return;
            };
            var _loc2_:CheckUserNameResultMessageParser = param1.getParser();
            if (_loc2_.resultCode == ChangeUserNameResultMessageEvent.var_445)
            {
                this.var_4029.checkedName = _loc2_.name;
            }
            else
            {
                this.var_4029.setNameNotAvailableView(_loc2_.resultCode, _loc2_.name, _loc2_.nameSuggestions);
            };
        }


    }
}