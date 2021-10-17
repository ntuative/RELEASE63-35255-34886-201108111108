package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.navigator.domain.Tabs;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.enum.*;

    public class EventsTabPageDecorator implements ITabPageDecorator 
    {

        private var _navigator:HabboNavigator;
        private var var_4066:IDropMenuWindow;

        public function EventsTabPageDecorator(param1:HabboNavigator)
        {
            this._navigator = param1;
        }

        public function refreshCustomContent(param1:IWindowContainer):void
        {
            var _loc2_:String = "events_header";
            var _loc3_:IWindowContainer = (param1.getChildByName(_loc2_) as IWindowContainer);
            if (this.var_4066 == null)
            {
                this.var_4066 = IDropMenuWindow(_loc3_.findChildByName("eventCtgFilter"));
                this.prepareEventTypes();
                this.var_4066.addEventListener(WindowEvent.var_576, this.onFilterSelected);
            };
            _loc3_.visible = true;
        }

        public function tabSelected():void
        {
            if (this.var_4066 != null)
            {
                this.var_4066.removeEventListener(WindowEvent.var_576, this.onFilterSelected);
                this.var_4066.selection = 0;
                this.var_4066.addEventListener(WindowEvent.var_576, this.onFilterSelected);
            };
        }

        public function refreshFooter(param1:IWindowContainer):void
        {
            this._navigator.officialRoomEntryManager.refreshAdFooter(param1);
        }

        public function navigatorOpenedWhileInTab():void
        {
            this.startSearch();
        }

        private function prepareEventTypes():void
        {
            var _loc4_:String;
            var _loc5_:String;
            if (this.var_4066 == null)
            {
                return;
            };
            var _loc1_:Array = new Array();
            _loc1_.push(this._navigator.getText("navigator.navisel.alllatestevents"));
            var _loc2_:int = 100;
            var _loc3_:int = 1;
            while (_loc3_ < _loc2_)
            {
                _loc4_ = ("roomevent_type_" + _loc3_);
                _loc5_ = this._navigator.getText(_loc4_);
                if (((_loc5_ == null) || (_loc5_ == _loc4_))) break;
                _loc1_.push(_loc5_);
                _loc3_++;
            };
            this.var_4066.populate(_loc1_);
            this.var_4066.selection = 0;
        }

        private function onFilterSelected(param1:WindowEvent):void
        {
            this.startSearch();
        }

        private function startSearch():void
        {
            var _loc1_:int = ((this.var_4066 == null) ? 0 : this.var_4066.selection);
            Logger.log(("Event filter changed: " + _loc1_));
            this._navigator.mainViewCtrl.startSearch(Tabs.var_154, Tabs.var_874, ((_loc1_ < 1) ? "-1" : (_loc1_ + "")));
        }

        public function get filterCategory():String
        {
            return ((this.var_4066) ? this.var_4066.enumerateSelection()[this.var_4066.selection] : null);
        }


    }
}