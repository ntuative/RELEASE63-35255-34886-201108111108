package com.sulake.habbo.messenger
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.components.IFrameWindow;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.habbo.messenger.domain.Conversation;
    import com.sulake.habbo.messenger.domain.Message;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.ui.Keyboard;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.SendMsgMessageComposer;

    public class MessengerView implements IDisposable 
    {

        private var _messenger:HabboMessenger;
        private var var_4149:ConversationsTabView;
        private var var_3988:ITextFieldWindow;
        private var var_3966:IFrameWindow;
        private var var_4150:ConversationView;
        private var var_4148:Timer;
        private var _disposed:Boolean = false;

        public function MessengerView(param1:HabboMessenger)
        {
            this._messenger = param1;
            this.var_4148 = new Timer(300, 1);
            this.var_4148.addEventListener(TimerEvent.TIMER, this.onResizeTimer);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                if (this.var_4148)
                {
                    this.var_4148.stop();
                    this.var_4148.removeEventListener(TimerEvent.TIMER, this.onResizeTimer);
                    this.var_4148 = null;
                };
                this._messenger = null;
                this._disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function isMessengerOpen():Boolean
        {
            return ((!(this.var_3966 == null)) && (this.var_3966.visible));
        }

        public function close():void
        {
            if (this.var_3966 != null)
            {
                this.var_3966.visible = false;
            };
        }

        public function openMessenger():void
        {
            if (this._messenger.conversations.openConversations.length < 1)
            {
                return;
            };
            if (this.var_3966 == null)
            {
                this.prepareContent();
                this.refresh();
            }
            else
            {
                this.refresh();
                this.var_3966.visible = true;
                this.var_3966.activate();
            };
        }

        public function refresh():void
        {
            if (this.var_3966 == null)
            {
                return;
            };
            var _loc1_:Conversation = this._messenger.conversations.findSelectedConversation();
            this.var_3966.caption = ((_loc1_ == null) ? "" : _loc1_.name);
            this.var_4149.refresh();
            this.var_4150.refresh();
            if (this._messenger.conversations.openConversations.length < 1)
            {
                this.var_3966.visible = false;
            };
        }

        public function addMsgToView(param1:Conversation, param2:Message):void
        {
            if (this.var_3966 == null)
            {
                return;
            };
            if (!param1.selected)
            {
                return;
            };
            this.var_4150.addMessage(param2);
        }

        private function prepareContent():void
        {
            this.var_3966 = IFrameWindow(this._messenger.getXmlWindow("main_window"));
            var _loc1_:IWindow = this.var_3966.findChildByTag("close");
            _loc1_.procedure = this.onWindowClose;
            this.var_3966.procedure = this.onWindow;
            this.var_3966.title.color = 0xFFFAC200;
            this.var_3966.title.textColor = 4287851525;
            this.var_4149 = new ConversationsTabView(this._messenger, this.var_3966);
            this.var_4149.refresh();
            this.var_3988 = ITextFieldWindow(this.var_3966.findChildByName("message_input"));
            this.var_3988.addEventListener(WindowKeyboardEvent.var_1253, this.onMessageInput);
            this.var_4150 = new ConversationView(this._messenger, this.var_3966);
            this.var_3966.scaler.setParamFlag(HabboWindowParam.var_862, false);
            this.var_3966.scaler.setParamFlag(HabboWindowParam.var_859, true);
            this.var_3966.center();
        }

        private function onMessageInput(param1:WindowKeyboardEvent):void
        {
            var _loc2_:int;
            var _loc3_:String;
            if (param1.charCode == Keyboard.ENTER)
            {
                this.sendMsg();
            }
            else
            {
                _loc2_ = 120;
                _loc3_ = this.var_3988.text;
                if (_loc3_.length > _loc2_)
                {
                    this.var_3988.text = _loc3_.substring(0, _loc2_);
                };
            };
        }

        private function onWindow(param1:WindowEvent, param2:IWindow):void
        {
            if (((!(param1.type == WindowEvent.var_589)) || (!(param2 == this.var_3966))))
            {
                return;
            };
            if (!this.var_4148.running)
            {
                this.var_4148.reset();
                this.var_4148.start();
            };
        }

        private function onResizeTimer(param1:TimerEvent):void
        {
            Logger.log("XXX RESIZE XXX");
            this.var_4150.afterResize();
            this.var_4149.refresh();
        }

        private function onWindowClose(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("Close window");
            this.var_3966.visible = false;
        }

        private function sendMsg():void
        {
            var _loc1_:String = this.var_3988.text;
            Logger.log(("Send msg: " + _loc1_));
            if (_loc1_ == "")
            {
                Logger.log("No text...");
                return;
            };
            var _loc2_:Conversation = this._messenger.conversations.findSelectedConversation();
            if (_loc2_ == null)
            {
                Logger.log("No conversation...");
                return;
            };
            this._messenger.send(new SendMsgMessageComposer(_loc2_.id, _loc1_));
            if (_loc2_.messages.length == 1)
            {
                this._messenger.playSendSound();
            };
            this.var_3988.text = "";
            this._messenger.conversations.addMessageAndUpdateView(new Message(Message.var_1387, _loc2_.id, _loc1_, Util.getFormattedNow()));
        }

        public function getTabCount():int
        {
            return ((this.var_4149 == null) ? 7 : this.var_4149.getTabCount());
        }


    }
}