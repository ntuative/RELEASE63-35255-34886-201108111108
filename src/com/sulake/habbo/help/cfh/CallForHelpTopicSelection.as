package com.sulake.habbo.help.cfh
{
    import com.sulake.habbo.help.help.HelpViewController;
    import com.sulake.habbo.help.help.IHelpViewController;
    import com.sulake.habbo.help.help.HelpUI;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.help.enum.HabboHelpViewEnum;

    public class CallForHelpTopicSelection extends HelpViewController implements IHelpViewController 
    {

        private static const var_2152:int = 0;
        private static const var_2153:int = 1;

        private var var_3994:Array;

        public function CallForHelpTopicSelection(param1:HelpUI, param2:IHabboWindowManager, param3:IAssetLibrary)
        {
            super(param1, param2, param3);
        }

        override public function render():void
        {
            var _loc3_:String;
            var _loc5_:String;
            var _loc6_:int;
            var _loc7_:int;
            var _loc8_:int;
            var _loc9_:String;
            var _loc10_:String;
            var _loc11_:IWindowContainer;
            super.render();
            if (container != null)
            {
                container.dispose();
            };
            var _loc1_:int = var_2152;
            if (main.component.callForHelpData.userSelected)
            {
                _loc1_ = var_2153;
            };
            if (_loc1_ == var_2153)
            {
                container = (buildXmlWindow("report_user_pick_topic") as IWindowContainer);
            }
            else
            {
                container = (buildXmlWindow("help_cfh_pick_topic") as IWindowContainer);
            };
            if (container == null)
            {
                return;
            };
            var _loc2_:IItemListWindow = (container.findChildByTag("content") as IItemListWindow);
            if (_loc2_ == null)
            {
                return;
            };
            if (_loc1_ == var_2153)
            {
                _loc3_ = main.getConfigurationKey("cfh.usercategories.withharasser");
            }
            else
            {
                _loc3_ = main.getConfigurationKey("cfh.usercategories.withnoharasser");
            };
            var _loc4_:Array = _loc3_.split(",");
            this.var_3994 = new Array();
            for each (_loc5_ in _loc4_)
            {
                _loc7_ = int(_loc5_.replace(" ", ""));
                if (_loc7_ != 0)
                {
                    this.var_3994.push(_loc7_);
                };
            };
            _loc6_ = 0;
            while (_loc6_ < this.var_3994.length)
            {
                _loc8_ = this.var_3994[_loc6_];
                _loc9_ = main.component.callForHelpData.getTopicKey(_loc8_);
                if (_loc1_ == var_2153)
                {
                    main.localization.registerParameter(_loc9_, "name", main.component.callForHelpData.reportedUserName);
                };
                _loc10_ = getText(main.component.callForHelpData.getTopicKey(_loc8_));
                _loc11_ = buildHelpCategoryListEntryItem(((_loc10_ != null) ? _loc10_ : _loc9_), "help_cfh_pick_topic_item", this.onListItemClick);
                if (_loc11_ != null)
                {
                    _loc2_.addListItem(_loc11_);
                };
                _loc6_++;
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
            if ((((this.var_3994 == null) || (_loc3_ < 0)) || (_loc3_ >= this.var_3994.length)))
            {
                return;
            };
            if (_loc3_ > -1)
            {
                main.component.callForHelpData.topicIndex = this.var_3994[_loc3_];
                main.showUI(HabboHelpViewEnum.var_1397);
                main.tellUI(HabboHelpViewEnum.var_1397, null);
            };
        }


    }
}