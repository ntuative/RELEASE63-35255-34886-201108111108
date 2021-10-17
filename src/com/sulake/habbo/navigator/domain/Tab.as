package com.sulake.habbo.navigator.domain
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.components.ITabButtonWindow;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.ITabPageDecorator;

    public class Tab 
    {

        private var _navigator:HabboNavigator;
        private var _id:int;
        private var _defaultSearchType:int;
        private var _button:ITabButtonWindow;
        private var var_4238:ITabPageDecorator;
        private var _selected:Boolean;
        private var var_4239:int;

        public function Tab(param1:HabboNavigator, param2:int, param3:int, param4:ITabPageDecorator, param5:int=1)
        {
            this._navigator = param1;
            this._id = param2;
            this._defaultSearchType = param3;
            this.var_4238 = param4;
            this.var_4239 = param5;
        }

        public function sendSearchRequest():void
        {
            this._navigator.mainViewCtrl.startSearch(this._id, this._defaultSearchType, "-1", this.var_4239);
        }

        public function set selected(param1:Boolean):void
        {
            this._selected = param1;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get defaultSearchType():int
        {
            return (this._defaultSearchType);
        }

        public function get selected():Boolean
        {
            return (this._selected);
        }

        public function get tabPageDecorator():ITabPageDecorator
        {
            return (this.var_4238);
        }

        public function get searchMsg():int
        {
            return (this.var_4239);
        }

        public function get button():ITabButtonWindow
        {
            return (this._button);
        }

        public function set button(param1:ITabButtonWindow):void
        {
            this._button = param1;
        }


    }
}