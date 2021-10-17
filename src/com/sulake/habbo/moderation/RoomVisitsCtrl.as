package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetRoomVisitsMessageComposer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomVisitsData;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomVisitData;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class RoomVisitsCtrl implements IDisposable, TrackedWindow 
    {

        private static var var_2247:Array = [];
        private static var var_2248:int = 200;

        private var var_4014:ModerationManager;
        private var _frame:IFrameWindow;
        private var var_2632:IItemListWindow;
        private var _userId:int;
        private var var_3471:Array;
        private var _disposed:Boolean;
        private var var_4212:IWindowContainer;
        private var var_4148:Timer;
        private var var_4213:Array = [];

        public function RoomVisitsCtrl(param1:ModerationManager, param2:int)
        {
            this.var_4014 = param1;
            this._userId = param2;
        }

        public static function getFormattedTime(param1:int, param2:int):String
        {
            return ((padToTwoDigits(param1) + ":") + padToTwoDigits(param2));
        }

        public static function padToTwoDigits(param1:int):String
        {
            return ((param1 < 10) ? ("0" + param1) : ("" + param1));
        }


        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function show():void
        {
            this.var_4212 = IWindowContainer(this.var_4014.getXmlWindow("roomvisits_row"));
            this.var_4148 = new Timer(300, 1);
            this.var_4148.addEventListener(TimerEvent.TIMER, this.onResizeTimer);
            this.var_4014.messageHandler.addRoomVisitsListener(this);
            this.var_4014.connection.send(new GetRoomVisitsMessageComposer(this._userId));
            this._frame = IFrameWindow(this.var_4014.getXmlWindow("roomvisits_frame"));
            this.var_2632 = IItemListWindow(this._frame.findChildByName("visits_list"));
            this._frame.procedure = this.onWindow;
            var _loc1_:IWindow = this._frame.findChildByTag("close");
            _loc1_.procedure = this.onClose;
        }

        public function onRoomVisits(param1:RoomVisitsData):void
        {
            if (param1.userId != this._userId)
            {
                return;
            };
            if (this._disposed)
            {
                return;
            };
            this.var_3471 = param1.rooms;
            this._frame.caption = ("Room visits: " + param1.userName);
            this.populate();
            this.onResizeTimer(null);
            this._frame.visible = true;
            this.var_4014.messageHandler.removeRoomVisitsListener(this);
        }

        public function getType():int
        {
            return (WindowTracker.var_1527);
        }

        public function getId():String
        {
            return ("" + this._userId);
        }

        public function getFrame():IFrameWindow
        {
            return (this._frame);
        }

        private function populate():void
        {
            var _loc2_:RoomVisitData;
            var _loc1_:Boolean = true;
            for each (_loc2_ in this.var_3471)
            {
                this.populateRoomRow(_loc2_, _loc1_);
                _loc1_ = (!(_loc1_));
            };
        }

        private function populateRoomRow(param1:RoomVisitData, param2:Boolean):void
        {
            var _loc3_:IWindowContainer = this.getRoomRowWindow();
            var _loc4_:uint = ((param2) ? 4288861930 : 0xFFFFFFFF);
            _loc3_.color = _loc4_;
            var _loc5_:IWindow = _loc3_.findChildByName("room_name_txt");
            _loc5_.caption = param1.roomName;
            new OpenRoomTool(this._frame, this.var_4014, _loc5_, param1.isPublic, param1.roomId);
            _loc5_.color = _loc4_;
            var _loc6_:ITextWindow = ITextWindow(_loc3_.findChildByName("time_txt"));
            _loc6_.text = getFormattedTime(param1.enterHour, param1.enterMinute);
            var _loc7_:ITextWindow = ITextWindow(_loc3_.findChildByName("view_room_txt"));
            new OpenRoomInSpectatorMode(this.var_4014, _loc7_, param1.isPublic, param1.roomId);
            _loc7_.color = _loc4_;
            this.addRoomRowToList(_loc3_, this.var_2632);
        }

        private function addRoomRowToList(param1:IWindowContainer, param2:IItemListWindow):void
        {
            param2.addListItem(param1);
            this.var_4213.push(param1);
        }

        private function getRoomRowWindow():IWindowContainer
        {
            if (var_2247.length > 0)
            {
                return (var_2247.pop() as IWindowContainer);
            };
            return (IWindowContainer(this.var_4212.clone()));
        }

        private function storeRoomRowWindow(param1:IWindowContainer):void
        {
            var _loc2_:IWindow;
            var _loc3_:IWindow;
            if (var_2247.length < var_2248)
            {
                _loc2_ = param1.findChildByName("room_name_txt");
                _loc2_.procedure = null;
                _loc3_ = param1.findChildByName("view_room_txt");
                _loc3_.procedure = null;
                param1.width = this.var_4212.width;
                param1.height = this.var_4212.height;
                var_2247.push(param1);
            }
            else
            {
                param1.dispose();
            };
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
            if (!this.var_4148.running)
            {
                this.var_4148.reset();
                this.var_4148.start();
            };
        }

        private function onResizeTimer(param1:TimerEvent):void
        {
            var _loc2_:IWindowContainer = IWindowContainer(this.var_2632.parent);
            var _loc3_:IWindow = (_loc2_.getChildByName("scroller") as IWindow);
            var _loc4_:* = (this.var_2632.scrollableRegion.height > this.var_2632.height);
            var _loc5_:int = 17;
            if (_loc3_.visible)
            {
                if (!_loc4_)
                {
                    _loc3_.visible = false;
                    this.var_2632.width = (this.var_2632.width + _loc5_);
                };
            }
            else
            {
                if (_loc4_)
                {
                    _loc3_.visible = true;
                    this.var_2632.width = (this.var_2632.width - _loc5_);
                };
            };
        }

        public function dispose():void
        {
            var _loc1_:IWindowContainer;
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
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
            this.var_4014 = null;
            if (this.var_4148 != null)
            {
                this.var_4148.stop();
                this.var_4148.removeEventListener(TimerEvent.TIMER, this.onResizeTimer);
                this.var_4148 = null;
            };
            for each (_loc1_ in this.var_4213)
            {
                this.storeRoomRowWindow(_loc1_);
            };
            if (this.var_4212 != null)
            {
                this.var_4212.dispose();
                this.var_4212 = null;
            };
            this.var_4213 = [];
        }


    }
}