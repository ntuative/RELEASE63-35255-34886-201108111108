package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Dictionary;
    import flash.utils.Timer;
    import com.sulake.core.utils.Map;
    import flash.events.TimerEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomChatlogData;
    import com.sulake.habbo.communication.messages.incoming.moderation.ChatlineData;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class ChatlogCtrl implements IDisposable, TrackedWindow 
    {

        private static var var_2238:Array = [];
        private static var var_2239:int = 1000;
        private static var var_2240:Array = [];
        private static var var_2241:int = 200;

        private var _type:int;
        private var _id:int;
        private var var_3453:IMessageComposer;
        private var var_4014:ModerationManager;
        private var _frame:IFrameWindow;
        private var var_2632:IItemListWindow;
        private var var_3471:Array;
        private var _disposed:Boolean;
        private var var_4152:IWindowContainer;
        private var var_4153:IWindowContainer;
        private var var_4154:Dictionary;
        private var var_4148:Timer;
        private var var_4155:Map;
        private var var_4156:Array = [];
        private var var_4157:Array = [];

        public function ChatlogCtrl(param1:IMessageComposer, param2:ModerationManager, param3:int, param4:int)
        {
            this.var_4014 = param2;
            this._type = param3;
            this._id = param4;
            this.var_3453 = param1;
            this.var_4155 = new Map();
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function show():void
        {
            this.var_4152 = IWindowContainer(this.var_4014.getXmlWindow("chatlog_roomheader"));
            this.var_4153 = IWindowContainer(this.var_4014.getXmlWindow("chatlog_chatline"));
            this.var_4148 = new Timer(1000, 1);
            this.var_4148.addEventListener(TimerEvent.TIMER, this.onResizeTimer);
            this._frame = IFrameWindow(this.var_4014.getXmlWindow("chatlog_frame"));
            this.var_2632 = IItemListWindow(this._frame.findChildByName("chatline_list"));
            this._frame.procedure = this.onWindow;
            var _loc1_:IWindow = this._frame.findChildByTag("close");
            _loc1_.procedure = this.onClose;
            this.var_4014.connection.send(this.var_3453);
            this.var_4014.messageHandler.addChatlogListener(this);
        }

        public function onChatlog(param1:String, param2:int, param3:int, param4:Array, param5:Dictionary):void
        {
            if ((((!(param2 == this._type)) || (!(param3 == this._id))) || (this._disposed)))
            {
                return;
            };
            this.var_4014.messageHandler.removeChatlogListener(this);
            this._frame.caption = param1;
            this.var_3471 = param4;
            this.var_4154 = param5;
            this.populate();
            this.onResizeTimer(null);
            this._frame.visible = true;
        }

        public function getType():int
        {
            return (this._type);
        }

        public function getId():String
        {
            return ("" + this._id);
        }

        public function getFrame():IFrameWindow
        {
            return (this._frame);
        }

        private function populate():void
        {
            var _loc1_:RoomChatlogData;
            this.var_2632.autoArrangeItems = false;
            for each (_loc1_ in this.var_3471)
            {
                this.populateRoomChat(_loc1_);
            };
            this.var_2632.autoArrangeItems = true;
        }

        private function populateRoomChat(param1:RoomChatlogData):void
        {
            var _loc5_:ChatlineData;
            var _loc2_:IWindowContainer = this.getChatHeaderWindow();
            var _loc3_:ITextWindow = ITextWindow(_loc2_.findChildByName("room_name_txt"));
            if (param1.roomId > 0)
            {
                _loc3_.caption = param1.roomName;
                _loc3_.underline = true;
                new OpenRoomTool(this._frame, this.var_4014, _loc3_, param1.isPublic, param1.roomId);
            }
            else
            {
                _loc3_.caption = "Not in room";
                _loc3_.underline = false;
            };
            this.addHeaderLineToList(_loc2_, this.var_2632);
            var _loc4_:Boolean = true;
            for each (_loc5_ in param1.chatlog)
            {
                this.populateChatline(this.var_2632, _loc5_, _loc4_);
                _loc4_ = (!(_loc4_));
            };
        }

        private function addChatLineToList(param1:IWindowContainer, param2:IItemListWindow):void
        {
            param2.addListItem(param1);
            this.var_4156.push(param1);
        }

        private function addHeaderLineToList(param1:IWindowContainer, param2:IItemListWindow):void
        {
            param2.addListItem(param1);
            this.var_4157.push(param1);
        }

        private function getChatLineWindow():IWindowContainer
        {
            if (var_2238.length > 0)
            {
                return (var_2238.pop() as IWindowContainer);
            };
            return (IWindowContainer(this.var_4153.clone()));
        }

        private function storeChatLineWindow(param1:IWindowContainer):void
        {
            var _loc2_:ITextWindow;
            if (var_2238.length < var_2239)
            {
                _loc2_ = ITextWindow(param1.findChildByName("chatter_txt"));
                _loc2_.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onChatLogUserClick);
                param1.width = this.var_4153.width;
                param1.height = this.var_4153.height;
                var_2238.push(param1);
            }
            else
            {
                param1.dispose();
            };
        }

        private function getChatHeaderWindow():IWindowContainer
        {
            if (var_2240.length > 0)
            {
                return (var_2240.pop() as IWindowContainer);
            };
            return (IWindowContainer(this.var_4152.clone()));
        }

        private function storeChatHeaderWindow(param1:IWindowContainer):void
        {
            var _loc2_:ITextWindow;
            if (var_2240.length < var_2241)
            {
                _loc2_ = ITextWindow(param1.findChildByName("room_name_txt"));
                _loc2_.procedure = null;
                param1.width = this.var_4152.width;
                param1.height = this.var_4152.height;
                var_2240.push(param1);
            }
            else
            {
                param1.dispose();
            };
        }

        private function populateChatline(param1:IItemListWindow, param2:ChatlineData, param3:Boolean):void
        {
            var _loc4_:IWindowContainer = this.getChatLineWindow();
            _loc4_.color = ((this.var_4154[param2.chatterId] != null) ? ((param3) ? 4294623571 : 0xFFFFE240) : ((param3) ? 4288861930 : 0xFFFFFFFF));
            var _loc5_:ITextWindow = ITextWindow(_loc4_.findChildByName("time_txt"));
            _loc5_.text = RoomVisitsCtrl.getFormattedTime(param2.hour, param2.minute);
            var _loc6_:ITextWindow = ITextWindow(_loc4_.findChildByName("chatter_txt"));
            _loc6_.color = _loc4_.color;
            if (param2.chatterId > 0)
            {
                _loc6_.text = param2.chatterName;
                _loc6_.underline = true;
                _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onChatLogUserClick);
                if (!this.var_4155.getValue(param2.chatterName))
                {
                    this.var_4155.add(param2.chatterName, param2.chatterId);
                };
            }
            else
            {
                if (param2.chatterId == 0)
                {
                    _loc6_.text = "Bot / pet";
                    _loc6_.underline = false;
                }
                else
                {
                    _loc6_.text = "-";
                    _loc6_.underline = false;
                };
            };
            var _loc7_:ITextWindow = ITextWindow(_loc4_.findChildByName("msg_txt"));
            _loc7_.text = param2.msg;
            _loc7_.height = (_loc7_.textHeight + 5);
            _loc4_.height = _loc7_.height;
            this.addChatLineToList(_loc4_, param1);
        }

        private function onChatLogUserClick(param1:WindowMouseEvent):void
        {
            var _loc2_:String = param1.target.caption;
            var _loc3_:int = this.var_4155.getValue(_loc2_);
            this.var_4014.windowTracker.show(new UserInfoFrameCtrl(this.var_4014, _loc3_), this._frame, false, false, true);
        }

        private function onClose(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this.dispose();
        }

        private function onWindow(param1:WindowEvent, param2:IWindow):void
        {
            if (((!(param1.type == WindowEvent.var_589)) || (!(param2 == this._frame))))
            {
                return;
            };
            this.var_4148.reset();
            this.var_4148.start();
        }

        private function onResizeTimer(param1:TimerEvent):void
        {
            this.refreshListDims();
            var _loc2_:Boolean = this.refreshScrollBarVisibility();
        }

        private function refreshListDims():void
        {
            var _loc1_:IWindowContainer;
            var _loc2_:ITextWindow;
            this.var_2632.autoArrangeItems = false;
            var _loc3_:int = this.var_2632.numListItems;
            var _loc4_:int;
            while (_loc4_ < _loc3_)
            {
                _loc1_ = IWindowContainer(this.var_2632.getListItemAt(_loc4_));
                if (_loc1_.name == "chatline")
                {
                    _loc2_ = ITextWindow(_loc1_.findChildByName("msg_txt"));
                    _loc2_.width = (_loc1_.width - _loc2_.x);
                    _loc2_.height = (_loc2_.textHeight + 5);
                    _loc1_.height = _loc2_.height;
                };
                _loc4_++;
            };
            this.var_2632.autoArrangeItems = true;
        }

        private function refreshScrollBarVisibility():Boolean
        {
            var _loc1_:IWindowContainer = IWindowContainer(this.var_2632.parent);
            var _loc2_:IWindow = (_loc1_.getChildByName("scroller") as IWindow);
            var _loc3_:* = (this.var_2632.scrollableRegion.height > this.var_2632.height);
            var _loc4_:int = 22;
            if (_loc2_.visible)
            {
                if (_loc3_)
                {
                    return (false);
                };
                _loc2_.visible = false;
                this.var_2632.width = (this.var_2632.width + _loc4_);
                return (true);
            };
            if (_loc3_)
            {
                _loc2_.visible = true;
                this.var_2632.width = (this.var_2632.width - _loc4_);
                return (true);
            };
            return (false);
        }

        public function dispose():void
        {
            var _loc1_:IWindowContainer;
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
            this.var_4014 = null;
            this.var_3453 = null;
            if (this.var_2632 != null)
            {
                this.var_2632.removeListItems();
                this.var_2632.dispose();
                this.var_2632 = null;
            };
            if (this._frame != null)
            {
                this._frame.destroy();
                this._frame = null;
            };
            this.var_3471 = null;
            this.var_4154 = null;
            if (this.var_4148 != null)
            {
                this.var_4148.stop();
                this.var_4148.removeEventListener(TimerEvent.TIMER, this.onResizeTimer);
                this.var_4148 = null;
            };
            for each (_loc1_ in this.var_4156)
            {
                this.storeChatLineWindow(_loc1_);
            };
            for each (_loc1_ in this.var_4157)
            {
                this.storeChatHeaderWindow(_loc1_);
            };
            this.var_4156 = [];
            this.var_4157 = [];
            if (this.var_4152 != null)
            {
                this.var_4152.dispose();
                this.var_4152 = null;
            };
            if (this.var_4153 != null)
            {
                this.var_4153.dispose();
                this.var_4153 = null;
            };
        }


    }
}