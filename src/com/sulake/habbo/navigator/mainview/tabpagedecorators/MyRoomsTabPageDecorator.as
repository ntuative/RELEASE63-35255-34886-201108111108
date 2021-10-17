package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.navigator.CanCreateRoomMessageComposer;
    import com.sulake.habbo.navigator.domain.Tabs;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.enum.*;

    public class MyRoomsTabPageDecorator implements ITabPageDecorator 
    {

        private var _navigator:HabboNavigator;
        private var var_4066:IDropMenuWindow;

        public function MyRoomsTabPageDecorator(param1:HabboNavigator)
        {
            this._navigator = param1;
        }

        public function refreshCustomContent(param1:IWindowContainer):void
        {
            var _loc2_:String = "me_header";
            var _loc3_:IWindowContainer = (param1.getChildByName(_loc2_) as IWindowContainer);
            if (this.var_4066 == null)
            {
                this.var_4066 = IDropMenuWindow(_loc3_.findChildByName("meSubNavi"));
                this.prepareSubNavi();
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
            var _loc2_:IWindowContainer = (param1.getChildByName("me_footer") as IWindowContainer);
            var _loc3_:IWindow = _loc2_.findChildByName("create_room_but");
            if (_loc3_ != null)
            {
                _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCreateRoomClick);
            };
            this._navigator.refreshButton(_loc2_, "create_room", true, null, 0);
            _loc2_.visible = true;
        }

        public function navigatorOpenedWhileInTab():void
        {
            this.startSearch();
        }

        private function onCreateRoomClick(param1:WindowEvent):void
        {
            this._navigator.send(new CanCreateRoomMessageComposer());
        }

        private function prepareSubNavi():void
        {
            if (this.var_4066 == null)
            {
                return;
            };
            var _loc1_:Array = new Array();
            _loc1_.push(this._navigator.getText("navigator.navisel.myrooms"));
            _loc1_.push(this._navigator.getText("navigator.navisel.wherearemyfriends"));
            _loc1_.push(this._navigator.getText("navigator.navisel.myfriendsrooms"));
            _loc1_.push(this._navigator.getText("navigator.navisel.myfavourites"));
            _loc1_.push(this._navigator.getText("navigator.navisel.visitedrooms"));
            this.var_4066.populate(_loc1_);
            this.var_4066.selection = 0;
        }

        private function onFilterSelected(param1:WindowEvent):void
        {
            this.startSearch();
            var _loc2_:IWindow = param1.target;
            if ((_loc2_ is IDropMenuWindow))
            {
                this._navigator.trackNavigationDataPoint(IDropMenuWindow(_loc2_).enumerateSelection()[IDropMenuWindow(_loc2_).selection], "me.category.view");
            };
        }

        private function startSearch():void
        {
            var _loc1_:int = ((this.var_4066 == null) ? 0 : this.var_4066.selection);
            Logger.log(("Me subNavi selection changed: " + _loc1_));
            this._navigator.mainViewCtrl.startSearch(Tabs.var_152, this.getSearchTypeForIndex(_loc1_));
        }

        private function getSearchTypeForIndex(param1:int):int
        {
            if (param1 == 1)
            {
                return (Tabs.var_880);
            };
            if (param1 == 2)
            {
                return (Tabs.var_876);
            };
            if (param1 == 3)
            {
                return (Tabs.var_875);
            };
            if (param1 == 4)
            {
                return (Tabs.var_877);
            };
            return (Tabs.var_162);
        }

        public function get filterCategory():String
        {
            return ((this.var_4066) ? this.var_4066.enumerateSelection()[this.var_4066.selection] : null);
        }


    }
}