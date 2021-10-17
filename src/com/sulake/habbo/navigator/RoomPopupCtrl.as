package com.sulake.habbo.navigator
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.navigator.roomthumbnails.RoomThumbnailRenderer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.navigator.domain.Tabs;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class RoomPopupCtrl extends PopupCtrl 
    {

        private var var_4367:IWindowContainer;
        private var var_3448:GuestRoomData;
        private var var_4364:RoomThumbnailRenderer;
        private var var_4257:TagRenderer;

        public function RoomPopupCtrl(param1:HabboNavigator, param2:int, param3:int)
        {
            super(param1, param2, param3, "grs_guest_room_details_long");
            this.var_4364 = new RoomThumbnailRenderer(param1);
            this.var_4257 = new TagRenderer(param1, hideInstantly);
        }

        public function set room(param1:GuestRoomData):void
        {
            this.var_3448 = param1;
        }

        override public function refreshContent(param1:IWindowContainer):void
        {
            if (this.var_4367 == null)
            {
                this.var_4367 = IWindowContainer(param1.findChildByName("details_container"));
            };
            this.var_4367.visible = true;
            Util.hideChildren(this.var_4367);
            this.refreshRoomName(this.var_4367, this.var_3448);
            if (((!(this.var_3448.ownerName == "")) && (!(this.var_3448.ownerName == "-"))))
            {
            };
            this.refreshOwnerName();
            this.refreshTextWithCaption("roomctg", this.var_4367, ((this.var_3448.event) ? this.getEventCtg(this.var_3448.categoryId) : this.getRoomCtg(this.var_3448.categoryId)));
            this.refreshRoomDesc(this.var_4367, this.var_3448);
            this.refreshExtraCont();
            this.refreshInfo(this.var_4367, "trading_allowed", this.var_3448.allowTrading);
            this.refreshInfo(this.var_4367, "doormode_doorbell", (this.var_3448.doorMode == 1));
            this.refreshInfo(this.var_4367, "doormode_password", (this.var_3448.doorMode == 2));
            Util.moveChildrenToColumn(this.var_4367, ["roomname", "roomctg_cont", "roomowner_cont", "roomdesc", "extra_cont", "doormode_doorbell", "doormode_password", "trading_allowed"], 0, 0);
            this.var_4367.height = Util.getLowestPoint(this.var_4367);
        }

        private function refreshOwnerName():void
        {
            this.refreshTextWithCaption("roomowner", this.var_4367, this.var_3448.ownerName);
            var _loc1_:ITextWindow = ITextWindow(this.var_4367.findChildByName("roomowner"));
            if (((!(this.var_3448.ownerName == "")) && (!(this.var_3448.ownerName == "-"))))
            {
                _loc1_.procedure = this.onOwnerName;
                _loc1_.setParamFlag(HabboWindowParam.var_158, true);
                _loc1_.underline = true;
            }
            else
            {
                _loc1_.procedure = null;
                _loc1_.setParamFlag(HabboWindowParam.var_158, false);
                _loc1_.underline = false;
            };
        }

        private function refreshExtraCont():void
        {
            var _loc1_:IWindowContainer = IWindowContainer(this.var_4367.findChildByName("extra_cont"));
            Util.hideChildren(_loc1_);
            this.var_4257.refreshTags(_loc1_, this.var_3448.tags);
            this.refreshTextWithCaption("rating", _loc1_, ("" + this.var_3448.score));
            if (this.var_3448.event)
            {
                this.refreshTextWithCaption("startedat", _loc1_, ("" + this.var_3448.eventCreationTime));
            };
            this.var_4364.refreshThumbnail(_loc1_, this.var_3448.thumbnail, false);
            _loc1_.findChildByName("bitmap").visible = true;
            _loc1_.visible = true;
        }

        private function refreshRoomName(param1:IWindowContainer, param2:GuestRoomData):void
        {
            var _loc3_:ITextWindow = ITextWindow(param1.getChildByName("roomname"));
            _loc3_.visible = true;
            _loc3_.text = param2.roomName;
            _loc3_.height = (_loc3_.textHeight + 3);
        }

        private function refreshRoomDesc(param1:IWindowContainer, param2:GuestRoomData):void
        {
            if (param2.description == "")
            {
                return;
            };
            var _loc3_:String = "roomdesc";
            var _loc4_:ITextWindow = ITextWindow(param1.getChildByName(_loc3_));
            _loc4_.text = param2.description;
            _loc4_.height = (_loc4_.textHeight + 10);
            _loc4_.y = Util.getLowestPoint(param1);
            _loc4_.visible = true;
        }

        private function refreshTextWithCaption(param1:String, param2:IWindowContainer, param3:String):void
        {
            var _loc4_:IWindowContainer = IWindowContainer(param2.findChildByName((param1 + "_cont")));
            _loc4_.visible = true;
            var _loc5_:ITextWindow = ITextWindow(_loc4_.getChildByName(param1));
            var _loc6_:ITextWindow = ITextWindow(_loc4_.getChildByName((param1 + ".caption")));
            _loc5_.text = param3;
            Util.moveChildrenToRow(_loc4_, [(param1 + ".caption"), param1], _loc6_.x, 0, 2);
        }

        private function refreshInfo(param1:IWindowContainer, param2:String, param3:Boolean):void
        {
            if (!param3)
            {
                return;
            };
            var _loc4_:IWindowContainer = IWindowContainer(param1.findChildByName(param2));
            _loc4_.visible = true;
            navigator.refreshButton(_loc4_, param2, true, null, 0);
        }

        private function getEventCtg(param1:int):String
        {
            var _loc2_:String = ("roomevent_type_" + param1);
            var _loc3_:String = navigator.getText(_loc2_);
            return ((_loc3_ == null) ? "" : _loc3_);
        }

        private function getRoomCtg(param1:int):String
        {
            var _loc2_:FlatCategory;
            for each (_loc2_ in navigator.data.allCategories)
            {
                if (_loc2_.nodeId == param1)
                {
                    return (_loc2_.nodeName);
                };
            };
            return ("");
        }

        private function onOwnerName(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            var _loc3_:ITextWindow = ITextWindow(param2);
            if (_loc3_ != null)
            {
                navigator.mainViewCtrl.startSearch(Tabs.var_155, Tabs.var_882, _loc3_.text);
                this.hideInstantly();
            };
        }


    }
}