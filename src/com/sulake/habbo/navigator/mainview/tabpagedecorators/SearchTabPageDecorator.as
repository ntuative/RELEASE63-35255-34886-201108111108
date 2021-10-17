package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;

    public class SearchTabPageDecorator implements ITabPageDecorator 
    {

        private var _navigator:HabboNavigator;

        public function SearchTabPageDecorator(param1:HabboNavigator)
        {
            this._navigator = param1;
        }

        public function refreshCustomContent(param1:IWindowContainer):void
        {
        }

        public function tabSelected():void
        {
        }

        public function refreshFooter(param1:IWindowContainer):void
        {
        }

        public function navigatorOpenedWhileInTab():void
        {
            this._navigator.mainViewCtrl.open();
        }

        public function get filterCategory():String
        {
            return (null);
        }


    }
}