package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.PublicSpaceCastLibsMessageParser;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetRoomChatlogMessageComposer;

    public class StartPanelCtrl implements IDisposable 
    {

        private var var_4014:ModerationManager;
        private var _frame:IFrameWindow;
        private var _userId:int;
        private var var_4214:Boolean;
        private var _roomId:int;
        private var _disposed:Boolean = false;

        public function StartPanelCtrl(param1:ModerationManager)
        {
            this.var_4014 = param1;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this.var_4014 = null;
                if (this._frame)
                {
                    this._frame.dispose();
                    this._frame = null;
                };
            };
        }

        public function userSelected(param1:int, param2:String):void
        {
            if (this._frame == null)
            {
                return;
            };
            this._userId = param1;
            var _loc3_:IButtonWindow = IButtonWindow(this._frame.findChildByName("userinfo_but"));
            _loc3_.enable();
            _loc3_.caption = ("User info: " + param2);
        }

        public function guestRoomEntered(param1:RoomEntryInfoMessageParser):void
        {
            if (((this._frame == null) || (param1 == null)))
            {
                return;
            };
            this._frame.findChildByName("room_tool_but").enable();
            this.enableChatlogButton();
            this.var_4214 = true;
            this._roomId = param1.guestRoomId;
        }

        public function publicSpaceEntered(param1:PublicSpaceCastLibsMessageParser):void
        {
            if (((this._frame == null) || (param1 == null)))
            {
                return;
            };
            this._frame.findChildByName("room_tool_but").disable();
            this.enableChatlogButton();
            this.var_4214 = false;
            this._roomId = param1.nodeId;
        }

        public function roomExited():void
        {
            if (this._frame == null)
            {
                return;
            };
            this._frame.findChildByName("room_tool_but").disable();
            this._frame.findChildByName("chatlog_but").disable();
        }

        public function show():void
        {
            if (this._frame == null)
            {
                this._frame = IFrameWindow(this.var_4014.getXmlWindow("start_panel"));
                this._frame.findChildByName("room_tool_but").procedure = this.onRoomToolButton;
                this._frame.findChildByName("chatlog_but").procedure = this.onChatlogButton;
                this._frame.findChildByName("ticket_queue_but").procedure = this.onTicketQueueButton;
                this._frame.findChildByName("userinfo_but").procedure = this.onUserinfoButton;
                this._frame.findChildByName("userinfo_but").disable();
                this._frame.findChildByName("room_tool_but").disable();
                this._frame.findChildByName("chatlog_but").disable();
                this.var_4014.disableButton(this.var_4014.initMsg.cfhPermission, this._frame, "ticket_queue_but");
                this.var_4014.disableButton(this.var_4014.initMsg.chatlogsPermission, this._frame, "chatlog_but");
            };
            this._frame.visible = true;
        }

        private function enableChatlogButton():void
        {
            if (this.var_4014.initMsg.chatlogsPermission)
            {
                this._frame.findChildByName("chatlog_but").enable();
            };
        }

        private function onRoomToolButton(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this.var_4014.windowTracker.show(new RoomToolCtrl(this.var_4014, this._roomId), this._frame, false, false, true);
        }

        private function onChatlogButton(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this.var_4014.windowTracker.show(new ChatlogCtrl(new GetRoomChatlogMessageComposer(((this.var_4214) ? 0 : 1), this._roomId), this.var_4014, WindowTracker.var_1522, this._roomId), this._frame, false, false, true);
        }

        private function onUserinfoButton(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this.var_4014.windowTracker.show(new UserInfoFrameCtrl(this.var_4014, this._userId), this._frame, false, false, true);
        }

        private function onTicketQueueButton(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this.var_4014.issueManager.init();
        }


    }
}