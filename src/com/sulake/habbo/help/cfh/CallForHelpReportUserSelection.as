package com.sulake.habbo.help.cfh
{
    import com.sulake.habbo.help.help.HelpViewController;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.help.help.HelpUI;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.help.cfh.data.UserRegistryItem;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.help.enum.HabboHelpViewEnum;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class CallForHelpReportUserSelection extends HelpViewController 
    {

        private var var_3993:Map = new Map();

        public function CallForHelpReportUserSelection(param1:HelpUI, param2:IHabboWindowManager, param3:IAssetLibrary)
        {
            super(param1, param2, param3);
        }

        override public function render():void
        {
            super.render();
            if (container != null)
            {
                container.dispose();
            };
            container = (buildXmlWindow("report_user_pick_user") as IWindowContainer);
            this.update();
            if (container == null)
            {
                return;
            };
        }

        override public function update(parameter:*=null):void
        {
            var user:UserRegistryItem;
            var title:String;
            var item:IWindowContainer;
            super.update();
            if (disposed)
            {
                return;
            };
            if (container == null)
            {
                return;
            };
            var content:IItemListWindow = (container.findChildByTag("content") as IItemListWindow);
            if (content == null)
            {
                return;
            };
            while (content.numListItems > 0)
            {
                content.removeListItemAt(0);
            };
            this.var_3993 = main.component.userRegistry.getRegistry();
            if (this.var_3993.length == 0)
            {
                main.showUI(HabboHelpViewEnum.var_1393);
                windowManager.alert("${generic.alert.title}", "${report.user.error.nolist}", 0, function (param1:IAlertDialog, param2:WindowEvent):void
                {
                    param1.dispose();
                });
                return;
            };
            var i:int;
            while (i < this.var_3993.length)
            {
                user = this.var_3993.getWithIndex(i);
                title = ((user.userName + "/") + user.roomName);
                main.localization.registerParameter("report.user.list.entry", "name", user.userName);
                main.localization.registerParameter("report.user.list.entry", "room", user.roomName);
                title = getText("report.user.list.entry");
                item = buildHelpCategoryListEntryItem(title, "report_user_pick_user_item", this.onListItemClick);
                if (item != null)
                {
                    content.addListItem(item);
                };
                i = (i + 1);
            };
        }

        private function onListItemClick(param1:WindowMouseEvent):void
        {
            var _loc2_:IWindow = (param1.target as IWindow);
            this.handleListItemClick(_loc2_);
        }

        private function handleListItemClick(param1:IWindow):void
        {
            var _loc2_:IItemListWindow = (container.findChildByTag("content") as IItemListWindow);
            if ((((_loc2_ == null) || (param1 == null)) || (param1.parent == null)))
            {
                return;
            };
            var _loc3_:int = _loc2_.getListItemIndex(param1.parent);
            if (((_loc3_ < 0) || (_loc3_ > this.var_3993.length)))
            {
                return;
            };
            var _loc4_:UserRegistryItem = this.var_3993.getWithIndex(_loc3_);
            if (_loc4_ == null)
            {
                return;
            };
            main.component.callForHelpData.reportedUserId = _loc4_.userId;
            main.component.callForHelpData.reportedUserName = _loc4_.userName;
            if (_loc3_ > -1)
            {
                main.showUI(HabboHelpViewEnum.var_279);
            };
        }


    }
}