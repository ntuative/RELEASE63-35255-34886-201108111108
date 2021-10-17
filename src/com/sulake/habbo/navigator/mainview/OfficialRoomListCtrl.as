package com.sulake.habbo.navigator.mainview
{
    import com.sulake.habbo.navigator.IViewCtrl;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomEntryData;
    import com.sulake.core.window.components.*;
    import com.sulake.habbo.navigator.*;
    import com.sulake.core.window.*;

    public class OfficialRoomListCtrl implements IViewCtrl 
    {

        private var _navigator:HabboNavigator;
        private var var_2578:IWindowContainer;
        private var var_2632:IItemListWindow;

        public function OfficialRoomListCtrl(param1:HabboNavigator):void
        {
            this._navigator = param1;
        }

        public function dispose():void
        {
        }

        public function set content(param1:IWindowContainer):void
        {
            this.var_2578 = param1;
            this.var_2632 = IItemListWindow(this.var_2578.findChildByName("item_list_official"));
        }

        public function get content():IWindowContainer
        {
            return (this.var_2578);
        }

        public function refresh():void
        {
            var _loc3_:Boolean;
            var _loc1_:Array = this.getVisibleEntries();
            this.var_2632.autoArrangeItems = false;
            var _loc2_:int;
            while (true)
            {
                if (_loc2_ < _loc1_.length)
                {
                    this.refreshEntry(true, _loc2_, _loc1_[_loc2_]);
                }
                else
                {
                    _loc3_ = this.refreshEntry(false, _loc2_, null);
                    if (_loc3_) break;
                };
                _loc2_++;
            };
            this.var_2632.autoArrangeItems = true;
        }

        private function getVisibleEntries():Array
        {
            var _loc4_:OfficialRoomEntryData;
            var _loc1_:Array = this._navigator.data.officialRooms.entries;
            var _loc2_:Array = new Array();
            var _loc3_:int;
            for each (_loc4_ in _loc1_)
            {
                if (_loc4_.folderId > 0)
                {
                    if (_loc4_.folderId == _loc3_)
                    {
                        _loc2_.push(_loc4_);
                    };
                }
                else
                {
                    _loc3_ = ((_loc4_.open) ? _loc4_.index : 0);
                    _loc2_.push(_loc4_);
                };
            };
            return (_loc2_);
        }

        private function refreshEntry(param1:Boolean, param2:int, param3:OfficialRoomEntryData):Boolean
        {
            var _loc4_:IWindowContainer = IWindowContainer(this.var_2632.getListItemAt(param2));
            var _loc5_:Boolean;
            if (_loc4_ == null)
            {
                if (!param1)
                {
                    return (true);
                };
                _loc4_ = this._navigator.officialRoomEntryManager.createEntry(param2);
                this.var_2632.addListItem(_loc4_);
                _loc5_ = true;
            };
            this._navigator.officialRoomEntryManager.refreshEntry(_loc4_, param1, param2, param3);
            return (false);
        }


    }
}