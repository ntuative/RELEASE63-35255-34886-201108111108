package com.sulake.habbo.ui.widget.chatinput
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindow;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.events.WindowEvent;
    import flash.geom.Point;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChatTypingMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChatMessage;
    import flash.display.Stage;
    import flash.display.InteractiveObject;
    import flash.display.DisplayObject;
    import flash.text.TextField;

    public class RoomChatInputView 
    {

        private static const var_2340:int = 250;
        private static const var_2341:int = 0;
        private static const BOTTOM_MARGIN:int = 55;
        private static const var_2339:String = "${widgets.chatinput.say}";

        private var _widget:RoomChatInputWidget;
        private var _window:IWindowContainer;
        private var var_5210:ITextFieldWindow;
        private var var_5211:IWindow;
        private var _button:IWindow;
        private var var_5212:IWindow;
        private var var_5213:IWindow;
        private var var_5214:String;
        private var var_5215:String;
        private var var_5216:String;
        private var var_5217:Boolean = false;
        private var var_3803:Boolean = false;
        private var var_5218:Boolean = false;
        private var var_5208:Timer;
        private var var_5209:Timer;
        private var var_5219:String = "";

        public function RoomChatInputView(param1:RoomChatInputWidget)
        {
            this._widget = param1;
            this.var_5215 = param1.localizations.getKey("widgets.chatinput.mode.whisper", ":tell");
            this.var_5214 = param1.localizations.getKey("widgets.chatinput.mode.shout", ":shout");
            this.var_5216 = param1.localizations.getKey("widgets.chatinput.mode.speak", ":speak");
            this.var_5208 = new Timer(1000, 1);
            this.var_5208.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTypingTimerComplete);
            this.var_5209 = new Timer(10000, 1);
            this.var_5209.addEventListener(TimerEvent.TIMER_COMPLETE, this.onIdleTimerComplete);
            this.createWindow();
        }

        public function get window():IWindowContainer
        {
            return (this._window);
        }

        public function dispose():void
        {
            this._widget = null;
            this.var_5210 = null;
            this.var_5211 = null;
            this._button = null;
            this.var_5212 = null;
            this.var_5213 = null;
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
            if (this.var_5208 != null)
            {
                this.var_5208.reset();
                this.var_5208.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTypingTimerComplete);
                this.var_5208 = null;
            };
            if (this.var_5209 != null)
            {
                this.var_5209.reset();
                this.var_5209.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onIdleTimerComplete);
                this.var_5209 = null;
            };
        }

        private function createWindow():void
        {
            if (this._window != null)
            {
                return;
            };
            var _loc1_:XmlAsset = (this._widget.assets.getAssetByName("chatinput_window") as XmlAsset);
            if (((_loc1_ == null) || (_loc1_.content == null)))
            {
                return;
            };
            this._window = (this._widget.windowManager.buildFromXML((_loc1_.content as XML), 0) as IWindowContainer);
            this._window.x = ((this._window.desktop.width - this._window.width) / 2);
            this._window.y = ((this._window.desktop.height - this._window.height) - BOTTOM_MARGIN);
            this._window.tags.push("room_widget_chatinput");
            this.var_5210 = (this._window.findChildByName("chat_input") as ITextFieldWindow);
            this.var_5211 = this._window.findChildByName("input_border");
            this._button = this._window.findChildByName("send_button");
            this.var_5212 = this._window.findChildByName("send_button_text");
            this.var_5213 = this._window.findChildByName("block_text");
            this.var_5212.caption = var_2339;
            this.var_5210.setParamFlag(HabboWindowParam.var_158, true);
            this.var_5210.addEventListener(WindowMouseEvent.var_650, this.windowMouseEventProcessor);
            this.var_5210.addEventListener(WindowKeyboardEvent.var_1253, this.windowKeyEventProcessor);
            this.var_5210.addEventListener(WindowKeyboardEvent.var_744, this.keyUpHandler);
            this.var_5210.addEventListener(WindowEvent.var_606, this.var_5220);
            this._window.findChildByName("send_button").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onSend);
            this.var_5217 = true;
            this.var_5219 = "";
            this._window.addEventListener(WindowEvent.var_604, this.updatePosition);
            this._window.addEventListener(WindowEvent.var_601, this.updatePosition);
        }

        private function updatePosition(param1:WindowEvent=null):void
        {
            var _loc2_:Point = new Point();
            this._window.getGlobalPosition(_loc2_);
            var _loc3_:int = (_loc2_.x - this._window.x);
            var _loc4_:int = int((((this._window.desktop.width - this.var_5211.width) / 2) - _loc3_));
            var _loc5_:int = (((this._window.desktop.width - this._window.width) - var_2340) - _loc3_);
            this._window.x = Math.max(Math.min(_loc4_, _loc5_), var_2341);
        }

        private function onSend(param1:WindowMouseEvent):void
        {
            if (!this.var_5217)
            {
                this.sendChatFromInputField();
            };
        }

        public function hideFloodBlocking():void
        {
            this.var_5210.visible = true;
            this.var_5213.visible = false;
            if (this._button != null)
            {
                this._button.enable();
            };
        }

        public function showFloodBlocking():void
        {
            this.var_5210.visible = false;
            this.var_5213.visible = true;
            if (this._button != null)
            {
                this._button.disable();
            };
        }

        public function updateBlockText(param1:int):void
        {
            this._widget.localizations.registerParameter("chat.input.alert.flood", "time", param1.toString());
        }

        public function displaySpecialChatMessage(param1:String, param2:String=""):void
        {
            if (((this._window == null) || (this.var_5210 == null)))
            {
                return;
            };
            this.var_5210.enable();
            this.var_5210.selectable = true;
            this.var_5210.text = "";
            this.setInputFieldFocus();
            this.var_5210.text = (this.var_5210.text + (param1 + " "));
            if (param2.length > 0)
            {
                this.var_5210.text = (this.var_5210.text + (param2 + " "));
            };
            this.var_5210.setSelection(this.var_5210.text.length, this.var_5210.text.length);
            this.var_5219 = this.var_5210.text;
        }

        private function windowMouseEventProcessor(param1:WindowEvent=null, param2:IWindow=null):void
        {
            this.setInputFieldFocus();
        }

        private function windowKeyEventProcessor(param1:WindowEvent=null, param2:IWindow=null):void
        {
            var _loc3_:uint;
            var _loc4_:Boolean;
            var _loc5_:WindowKeyboardEvent;
            var _loc6_:KeyboardEvent;
            var _loc7_:String;
            var _loc8_:Array;
            if ((((this._window == null) || (this._widget == null)) || (this._widget.floodBlocked)))
            {
                return;
            };
            if (this.anotherFieldHasFocus())
            {
                return;
            };
            this.setInputFieldFocus();
            if ((param1 is WindowKeyboardEvent))
            {
                _loc5_ = (param1 as WindowKeyboardEvent);
                _loc3_ = _loc5_.charCode;
                _loc4_ = _loc5_.shiftKey;
            };
            if ((param1 is KeyboardEvent))
            {
                _loc6_ = (param1 as KeyboardEvent);
                _loc3_ = _loc6_.charCode;
                _loc4_ = _loc6_.shiftKey;
            };
            if (((_loc6_ == null) && (_loc5_ == null)))
            {
                return;
            };
            if (_loc3_ == Keyboard.SPACE)
            {
                this.checkSpecialKeywordForInput();
            };
            if (_loc3_ == Keyboard.ENTER)
            {
                this.sendChatFromInputField(_loc4_);
                this.setButtonPressedState(true);
            };
            if (_loc3_ == Keyboard.BACKSPACE)
            {
                if (this.var_5210 != null)
                {
                    _loc7_ = this.var_5210.text;
                    _loc8_ = _loc7_.split(" ");
                    if ((((_loc8_[0] == this.var_5215) && (_loc8_.length == 3)) && (_loc8_[2] == "")))
                    {
                        this.var_5210.text = "";
                        this.var_5219 = "";
                    };
                };
            };
        }

        private function keyUpHandler(param1:WindowKeyboardEvent):void
        {
            if (param1.keyCode == Keyboard.ENTER)
            {
                this.setButtonPressedState(false);
            };
        }

        private function setButtonPressedState(param1:Boolean):void
        {
            if (this._button)
            {
                this._button.setStateFlag(WindowState.var_1185, param1);
            };
        }

        private function var_5220(param1:WindowEvent):void
        {
            var _loc2_:ITextFieldWindow = (param1.window as ITextFieldWindow);
            if (_loc2_ == null)
            {
                return;
            };
            this.var_5209.reset();
            var _loc3_:* = (_loc2_.text.length == 0);
            if (_loc3_)
            {
                this.var_3803 = false;
                this.var_5208.start();
            }
            else
            {
                if (_loc2_.text.length > (this.var_5219.length + 1))
                {
                    if (this._widget.allowPaste)
                    {
                        this._widget.setLastPasteTime();
                    }
                    else
                    {
                        _loc2_.text = "";
                    };
                };
                this.var_5219 = _loc2_.text;
                if (!this.var_3803)
                {
                    this.var_3803 = true;
                    this.var_5208.reset();
                    this.var_5208.start();
                };
                this.var_5209.start();
            };
        }

        private function checkSpecialKeywordForInput():void
        {
            if (((this.var_5210 == null) || (this.var_5210.text == "")))
            {
                return;
            };
            var _loc1_:String = this.var_5210.text;
            var _loc2_:String = this._widget.selectedUserName;
            if (_loc1_ == this.var_5215)
            {
                if (_loc2_.length > 0)
                {
                    this.var_5210.text = (this.var_5210.text + (" " + this._widget.selectedUserName));
                    this.var_5210.setSelection(this.var_5210.text.length, this.var_5210.text.length);
                    this.var_5219 = this.var_5210.text;
                };
            };
        }

        private function onIdleTimerComplete(param1:TimerEvent):void
        {
            if (this.var_3803)
            {
                this.var_5218 = false;
            };
            this.var_3803 = false;
            this.sendTypingMessage();
        }

        private function onTypingTimerComplete(param1:TimerEvent):void
        {
            if (this.var_3803)
            {
                this.var_5218 = true;
            };
            this.sendTypingMessage();
        }

        private function sendTypingMessage():void
        {
            if (this._widget == null)
            {
                return;
            };
            if (this._widget.floodBlocked)
            {
                return;
            };
            var _loc1_:RoomWidgetChatTypingMessage = new RoomWidgetChatTypingMessage(this.var_3803);
            this._widget.messageListener.processWidgetMessage(_loc1_);
        }

        private function setInputFieldFocus():void
        {
            if (this.var_5210 == null)
            {
                return;
            };
            if (this.var_5217)
            {
                this.var_5210.text = "";
                this.var_5210.textColor = 0;
                this.var_5210.italic = false;
                this.var_5217 = false;
                this.var_5219 = "";
            };
            this.var_5210.focus();
        }

        private function sendChatFromInputField(param1:Boolean=false):void
        {
            if (((this.var_5210 == null) || (this.var_5210.text == "")))
            {
                return;
            };
            var _loc2_:int = ((param1) ? RoomWidgetChatMessage.var_546 : RoomWidgetChatMessage.var_542);
            var _loc3_:String = this.var_5210.text;
            var _loc4_:Array = _loc3_.split(" ");
            var _loc5_:String = "";
            var _loc6_:String = "";
            switch (_loc4_[0])
            {
                case this.var_5215:
                    _loc2_ = RoomWidgetChatMessage.var_545;
                    _loc5_ = _loc4_[1];
                    _loc6_ = (((this.var_5215 + " ") + _loc5_) + " ");
                    _loc4_.shift();
                    _loc4_.shift();
                    break;
                case this.var_5214:
                    _loc2_ = RoomWidgetChatMessage.var_546;
                    _loc4_.shift();
                    break;
                case this.var_5216:
                    _loc2_ = RoomWidgetChatMessage.var_542;
                    _loc4_.shift();
                    break;
            };
            _loc3_ = _loc4_.join(" ");
            if (this._widget != null)
            {
                if (this.var_5208.running)
                {
                    this.var_5208.reset();
                };
                if (this.var_5209.running)
                {
                    this.var_5209.reset();
                };
                this._widget.sendChat(_loc3_, _loc2_, _loc5_);
                this.var_3803 = false;
                if (this.var_5218)
                {
                    this.sendTypingMessage();
                };
                this.var_5218 = false;
            };
            this.var_5210.text = _loc6_;
            this.var_5219 = _loc6_;
        }

        private function anotherFieldHasFocus():Boolean
        {
            var _loc2_:Stage;
            var _loc3_:InteractiveObject;
            if (this.var_5210 != null)
            {
                if (this.var_5210.focused)
                {
                    return (false);
                };
            };
            var _loc1_:DisplayObject = this._window.context.getDesktopWindow().getDisplayObject();
            if (_loc1_ != null)
            {
                _loc2_ = _loc1_.stage;
                if (_loc2_ != null)
                {
                    _loc3_ = _loc2_.focus;
                    if (_loc3_ == null)
                    {
                        return (false);
                    };
                    if ((_loc3_ is TextField))
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }


    }
}