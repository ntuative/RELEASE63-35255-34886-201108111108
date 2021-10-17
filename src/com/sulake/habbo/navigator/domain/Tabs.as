package com.sulake.habbo.navigator.domain
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.EventsTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.MainViewCtrl;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.RoomsTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.OfficialTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.MyRoomsTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.SearchTabPageDecorator;

    public class Tabs 
    {

        public static const var_154:int = 1;
        public static const var_153:int = 2;
        public static const var_152:int = 3;
        public static const var_151:int = 4;
        public static const var_155:int = 5;
        public static const var_879:int = 1;
        public static const var_881:int = 2;
        public static const var_876:int = 3;
        public static const var_880:int = 4;
        public static const var_162:int = 5;
        public static const var_875:int = 6;
        public static const var_877:int = 7;
        public static const var_882:int = 8;
        public static const var_161:int = 9;
        public static const var_958:int = 10;
        public static const var_878:int = 11;
        public static const var_874:int = 12;

        private var var_3281:Array;
        private var _navigator:HabboNavigator;

        public function Tabs(param1:HabboNavigator)
        {
            this._navigator = param1;
            this.var_3281 = new Array();
            this.var_3281.push(new Tab(this._navigator, var_154, var_874, new EventsTabPageDecorator(this._navigator), MainViewCtrl.var_868));
            this.var_3281.push(new Tab(this._navigator, var_153, var_879, new RoomsTabPageDecorator(this._navigator), MainViewCtrl.var_868));
            this.var_3281.push(new Tab(this._navigator, var_151, var_878, new OfficialTabPageDecorator(this._navigator), MainViewCtrl.var_871));
            this.var_3281.push(new Tab(this._navigator, var_152, var_162, new MyRoomsTabPageDecorator(this._navigator), MainViewCtrl.var_868));
            this.var_3281.push(new Tab(this._navigator, var_155, var_882, new SearchTabPageDecorator(this._navigator), MainViewCtrl.var_869));
            this.setSelectedTab(var_154);
        }

        public function onFrontPage():Boolean
        {
            return (this.getSelected().id == var_151);
        }

        public function get tabs():Array
        {
            return (this.var_3281);
        }

        public function setSelectedTab(param1:int):void
        {
            this.clearSelected();
            this.getTab(param1).selected = true;
        }

        public function getSelected():Tab
        {
            var _loc1_:Tab;
            for each (_loc1_ in this.var_3281)
            {
                if (_loc1_.selected)
                {
                    return (_loc1_);
                };
            };
            return (null);
        }

        private function clearSelected():void
        {
            var _loc1_:Tab;
            for each (_loc1_ in this.var_3281)
            {
                _loc1_.selected = false;
            };
        }

        public function getTab(param1:int):Tab
        {
            var _loc2_:Tab;
            for each (_loc2_ in this.var_3281)
            {
                if (_loc2_.id == param1)
                {
                    return (_loc2_);
                };
            };
            return (null);
        }


    }
}