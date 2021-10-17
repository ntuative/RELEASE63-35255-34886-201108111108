package com.sulake.habbo.ui.widget.poll
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import flash.utils.Timer;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import flash.events.TimerEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetVoteUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.core.window.IWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IDesktopWindow;
    import flash.utils.getTimer;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.IBorderWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetVoteMessage;
    import com.sulake.core.window.events.WindowEvent;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Rectangle;

    public class VoteWidget extends RoomWidgetBase 
    {

        private var _window:IFrameWindow;
        private var var_2632:IItemListWindow;
        private var _config:IHabboConfigurationManager;
        private var var_5388:int = -1;
        private var var_5414:int = 30000;
        private var var_2634:int;
        private var var_5346:Timer;

        public function VoteWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager, param5:IHabboConfigurationManager)
        {
            super(param1, param2, param3, param4);
            this._config = param5;
            if (this._config != null)
            {
                this.var_5414 = int(this._config.getKey("vote.time.limit", "30000"));
            };
        }

        override public function dispose():void
        {
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
            if (this.var_5346)
            {
                this.var_5346.reset();
                this.var_5346.removeEventListener(TimerEvent.TIMER, this.updateEvent);
                this.var_5346 = null;
            };
            this._config = null;
            super.dispose();
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.addEventListener(RoomWidgetVoteUpdateEvent.var_369, this.showVoteQuestion);
            param1.addEventListener(RoomWidgetVoteUpdateEvent.var_370, this.showVoteResult);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetVoteUpdateEvent.var_369, this.showVoteQuestion);
            param1.removeEventListener(RoomWidgetVoteUpdateEvent.var_370, this.showVoteResult);
        }

        private function showVoteQuestion(param1:RoomWidgetVoteUpdateEvent):void
        {
            var _loc6_:IWindow;
            var _loc12_:Point;
            if (param1 == null)
            {
                return;
            };
            if (!this.createWindow())
            {
                return;
            };
            var _loc2_:ITextWindow = (this._window.findChildByName("question") as ITextWindow);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:IWindowContainer = (this._window.findChildByName("list_container") as IWindowContainer);
            if (_loc3_ == null)
            {
                return;
            };
            _loc2_.text = param1.question;
            var _loc4_:int = Math.max(((_loc2_.textHeight + 10) - _loc2_.height), 0);
            _loc2_.scale(0, _loc4_);
            _loc3_.offset(0, _loc4_);
            var _loc5_:Array = param1.choices;
            var _loc7_:int;
            while (_loc7_ < _loc5_.length)
            {
                _loc6_ = this.createChoice(_loc7_, _loc5_[_loc7_]);
                if (_loc6_ == null)
                {
                    return;
                };
                this.var_2632.addListItem(_loc6_);
                _loc7_++;
            };
            var _loc8_:int = Math.max((this.var_2632.scrollableRegion.height - this.var_2632.height), 0);
            _loc3_.scale(0, _loc8_);
            this._window.scale(0, (_loc4_ + _loc8_));
            var _loc9_:IWindow = this._window.findChildByName("waiting_text");
            if (_loc9_ != null)
            {
                _loc9_.visible = false;
            };
            var _loc10_:IDesktopWindow = this._window.desktop;
            if (_loc10_ != null)
            {
                _loc12_ = new Point((_loc10_.width - this._window.width), (_loc10_.height - this._window.height));
                _loc12_.offset(-10, -10);
                this._window.setGlobalPosition(_loc12_);
            };
            this._window.visible = true;
            this.var_5388 = -1;
            if (this.var_5346 == null)
            {
                this.var_5346 = new Timer(1000);
                this.var_5346.addEventListener(TimerEvent.TIMER, this.updateEvent);
            };
            this.var_2634 = getTimer();
            this.var_5346.reset();
            this.var_5346.start();
            var _loc11_:IWindow = this._window.findChildByName("timer");
            if (_loc11_ != null)
            {
                _loc11_.visible = true;
            };
        }

        private function createWindow():Boolean
        {
            if (this._window != null)
            {
                this._window.dispose();
            };
            var _loc1_:XmlAsset = (assets.getAssetByName("vote_question") as XmlAsset);
            this._window = (windowManager.buildFromXML((_loc1_.content as XML)) as IFrameWindow);
            if (this._window == null)
            {
                return (false);
            };
            this.var_2632 = (this._window.findChildByName("choices") as IItemListWindow);
            if (this.var_2632 == null)
            {
                return (false);
            };
            this._window.visible = false;
            var _loc2_:IWindow = this._window.findChildByTag("close");
            if (_loc2_ != null)
            {
                _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.close);
            };
            var _loc3_:IWindow = this._window.findChildByName("timer");
            if (_loc3_ != null)
            {
                _loc3_.visible = false;
            };
            return (true);
        }

        private function createChoice(param1:int, param2:String):IWindow
        {
            var _loc3_:XmlAsset = (assets.getAssetByName("vote_choice") as XmlAsset);
            if (_loc3_ == null)
            {
                return (null);
            };
            var _loc4_:IWindowContainer = (windowManager.buildFromXML((_loc3_.content as XML)) as IWindowContainer);
            if (_loc4_ == null)
            {
                return (null);
            };
            var _loc5_:ITextWindow = (_loc4_.findChildByName("text") as ITextWindow);
            if (_loc5_ == null)
            {
                return (null);
            };
            var _loc6_:IButtonWindow = (_loc4_.findChildByName("button") as IButtonWindow);
            if (_loc6_ == null)
            {
                return (null);
            };
            _loc6_.id = param1;
            _loc6_.caption = String.fromCharCode((97 + param1));
            _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onChoiceClicked);
            _loc5_.text = param2;
            var _loc7_:IWindowContainer = (_loc4_.findChildByName("bg") as IWindowContainer);
            if (_loc7_ != null)
            {
                _loc7_.visible = false;
            };
            return (_loc4_);
        }

        private function onChoiceClicked(param1:WindowMouseEvent):void
        {
            if (((param1 == null) || (param1.window == null)))
            {
                return;
            };
            this.vote(param1.window.id);
        }

        private function vote(param1:int=-1):void
        {
            var _loc2_:IBorderWindow;
            var _loc3_:IButtonWindow;
            this.var_5388 = param1;
            if (param1 >= 0)
            {
                if (messageListener == null)
                {
                    return;
                };
                messageListener.processWidgetMessage(new RoomWidgetVoteMessage((param1 + 1)));
            };
            if (((this._window == null) || (this.var_2632 == null)))
            {
                return;
            };
            var _loc4_:int;
            while (_loc4_ < this.var_2632.numListItems)
            {
                _loc2_ = (this.var_2632.getListItemAt(_loc4_) as IBorderWindow);
                if (_loc2_ == null)
                {
                    return;
                };
                if (_loc4_ != this.var_5388)
                {
                    _loc2_.blend = 0.5;
                };
                _loc3_ = (_loc2_.findChildByName("button") as IButtonWindow);
                if (_loc3_ == null)
                {
                    return;
                };
                _loc3_.disable();
                _loc4_++;
            };
            var _loc5_:IWindow = this._window.findChildByName("timer");
            if (_loc5_ != null)
            {
                _loc5_.visible = false;
            };
            var _loc6_:IWindow = this._window.findChildByName("waiting_text");
            if (_loc6_ != null)
            {
                _loc6_.visible = true;
            };
            this.var_5346.reset();
        }

        private function close(param1:WindowEvent=null):void
        {
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
        }

        private function updateTimerView():void
        {
            var _loc4_:Number;
            var _loc5_:BitmapData;
            var _loc6_:int;
            if (this._window == null)
            {
                return;
            };
            var _loc1_:int = (getTimer() - this.var_2634);
            var _loc2_:IBitmapWrapperWindow = (this._window.findChildByName("timer_bar") as IBitmapWrapperWindow);
            if (_loc2_ != null)
            {
                _loc4_ = (Number(_loc1_) / this.var_5414);
                _loc5_ = new BitmapData(_loc2_.width, _loc2_.height, true, 0xFF339900);
                if (_loc4_ > 0)
                {
                    _loc5_.fillRect(new Rectangle(0, 0, _loc5_.width, int((_loc5_.height * _loc4_))), 4292006610);
                };
                _loc2_.bitmap = _loc5_;
            };
            var _loc3_:ITextWindow = (this._window.findChildByName("timer_text") as ITextWindow);
            if (_loc3_ != null)
            {
                _loc6_ = int(Math.max(((this.var_5414 - _loc1_) / 1000), 0));
                _loc3_.text = (_loc6_ + " s");
            };
        }

        private function updateEvent(param1:TimerEvent):void
        {
            var _loc2_:int = (getTimer() - this.var_2634);
            if (_loc2_ > this.var_5414)
            {
                this.vote();
                return;
            };
            this.updateTimerView();
        }

        private function showVoteResult(param1:RoomWidgetVoteUpdateEvent):void
        {
            var _loc2_:IWindow;
            var _loc4_:IWindowContainer;
            var _loc5_:IBitmapWrapperWindow;
            var _loc6_:IWindowContainer;
            var _loc7_:ITextWindow;
            var _loc8_:IButtonWindow;
            var _loc9_:BitmapData;
            var _loc10_:int;
            if (((this._window == null) || (this.var_2632 == null)))
            {
                return;
            };
            _loc2_ = this._window.findChildByName("timer");
            if (_loc2_ != null)
            {
                _loc2_.visible = false;
            };
            _loc2_ = this._window.findChildByName("waiting_text");
            if (_loc2_ != null)
            {
                _loc2_.visible = false;
            };
            if (this.var_2632.numListItems != param1.votes.length)
            {
                return;
            };
            var _loc3_:int;
            while (_loc3_ < this.var_2632.numListItems)
            {
                _loc4_ = (this.var_2632.getListItemAt(_loc3_) as IWindowContainer);
                if (_loc4_ != null)
                {
                    _loc5_ = (_loc4_.findChildByName("vote_bar") as IBitmapWrapperWindow);
                    if (_loc5_ != null)
                    {
                        _loc9_ = new BitmapData(_loc5_.width, _loc5_.height, true, 0);
                        _loc10_ = int(int(((Number(param1.votes[_loc3_]) / param1.totalVotes) * _loc9_.width)));
                        if (_loc10_ > 0)
                        {
                            _loc9_.fillRect(new Rectangle(0, 0, _loc10_, _loc9_.height), 0xFF339900);
                            _loc5_.bitmap = _loc9_;
                        };
                    };
                    _loc6_ = (_loc4_.findChildByName("bg") as IWindowContainer);
                    if (_loc6_ != null)
                    {
                        _loc6_.visible = true;
                    };
                    _loc7_ = (_loc4_.findChildByName("text") as ITextWindow);
                    if (_loc7_ != null)
                    {
                        _loc7_.text = (((((_loc7_.text + " ( ") + param1.votes[_loc3_]) + "/") + param1.totalVotes) + " )");
                    };
                    _loc8_ = (_loc4_.findChildByName("button") as IButtonWindow);
                    if (_loc8_ != null)
                    {
                        _loc8_.disable();
                    };
                };
                _loc3_++;
            };
        }


    }
}