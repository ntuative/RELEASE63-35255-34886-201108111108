package com.sulake.habbo.help.help
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IHTMLTextWindow;
    import com.sulake.habbo.help.help.data.FaqIndex;
    import com.sulake.habbo.communication.messages.outgoing.help.GetClientFaqsMessageComposer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.help.enum.HabboHelpViewEnum;
    import com.sulake.habbo.help.help.data.FaqCategory;
    import com.sulake.habbo.help.help.data.FaqItem;

    public class HelpMainView extends HelpViewController 
    {

        private static const var_2154:int = 60;

        public function HelpMainView(param1:HelpUI, param2:IHabboWindowManager, param3:IAssetLibrary)
        {
            super(param1, param2, param3);
        }

        override public function render():void
        {
            var _loc8_:String;
            var _loc9_:String;
            var _loc10_:BitmapData;
            if (container != null)
            {
                container.dispose();
            };
            container = (buildXmlWindow("help_front_page") as IWindowContainer);
            if (container == null)
            {
                return;
            };
            var _loc1_:IWindow = container.findChildByName("help_faq_browse");
            if (_loc1_ != null)
            {
                _loc1_.setParamFlag(WindowParam.var_609);
                _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onFaqBrowse);
            };
            var _loc2_:IHTMLTextWindow = (container.findChildByName("help_habboway_text") as IHTMLTextWindow);
            if (_loc2_ != null)
            {
                _loc8_ = main.getText("help.button.habboway.url", "");
                if (_loc8_ != null)
                {
                    _loc9_ = main.getText("help.button.habboway");
                    if (_loc9_ != null)
                    {
                        _loc2_.htmlText = (((('<a href="' + _loc8_) + '">') + _loc9_) + "</a>");
                    };
                };
            };
            var _loc3_:IWindow = container.findChildByTag("help_cfh_button");
            if (_loc3_ != null)
            {
                _loc3_.setParamFlag(WindowParam.var_609);
                _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCallForHelp);
            };
            var _loc4_:IWindow = container.findChildByTag("help_report_user_button");
            if (_loc4_ != null)
            {
                _loc4_.setParamFlag(WindowParam.var_609);
                _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onReportUser);
            };
            var _loc5_:IWindow = container.findChildByTag("call_guide_bot_button");
            if (_loc5_ != null)
            {
                _loc5_.setParamFlag(WindowParam.var_609);
                _loc5_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCallGuideBot);
            };
            var _loc6_:FaqIndex = main.getFaq();
            if (((_loc6_ == null) || (_loc6_.getFrontPageUrgentCategory().getAgeSeconds() > var_2154)))
            {
                main.sendMessage(new GetClientFaqsMessageComposer());
            };
            var _loc7_:IBitmapWrapperWindow = (container.findChildByName("guidebot_icon") as IBitmapWrapperWindow);
            if (_loc7_ != null)
            {
                _loc10_ = (assetLibrary.getAssetByName("guidebot_icon_png").content as BitmapData);
                _loc7_.bitmap = new BitmapData(_loc7_.width, _loc7_.height, true);
                _loc7_.bitmap.copyPixels(_loc10_, _loc10_.rect, new Point(0, 0));
            };
            super.render();
            this.update();
        }

        override public function update(param1:*=null):void
        {
            var _loc7_:IItemListWindow;
            var _loc8_:int;
            var _loc9_:IWindowContainer;
            var _loc10_:Array;
            var _loc11_:String;
            super.update(param1);
            if (container == null)
            {
                return;
            };
            var _loc2_:IWindow = container.findChildByName("help_cfh");
            if (_loc2_ != null)
            {
                _loc2_.visible = roomSessionActive;
            };
            var _loc3_:IWindow = container.findChildByName("help_report_user");
            if (_loc3_ != null)
            {
                _loc3_.visible = roomSessionActive;
            };
            var _loc4_:IWindow = container.findChildByName("call_guide_bot_container");
            if (_loc4_ != null)
            {
                _loc4_.visible = ((main.isCallForGuideBotEnabled()) && (roomSessionActive));
            };
            var _loc5_:FaqIndex = main.getFaq();
            if (_loc5_ != null)
            {
                _loc10_ = _loc5_.getFrontPageUrgentCategory().getQuestionTitleArray();
                _loc7_ = (container.findChildByTag("content_urgent") as IItemListWindow);
                if (_loc7_ != null)
                {
                    _loc7_.destroyListItems();
                    _loc8_ = 0;
                    while (_loc8_ < _loc10_.length)
                    {
                        _loc11_ = _loc10_[_loc8_];
                        _loc9_ = buildHelpCategoryListEntryItem(_loc11_, "help_itemlist_item_urgent", this.onListItemClick);
                        if (_loc9_ != null)
                        {
                            _loc9_.name = "content_urgent_item";
                            _loc7_.addListItem(_loc9_);
                        };
                        _loc8_++;
                    };
                };
                _loc10_ = _loc5_.getFrontPageNormalCategory().getQuestionTitleArray();
                _loc7_ = (container.findChildByTag("content_normal") as IItemListWindow);
                if (_loc7_ != null)
                {
                    _loc7_.destroyListItems();
                    _loc8_ = 0;
                    while (_loc8_ < _loc10_.length)
                    {
                        _loc11_ = _loc10_[_loc8_];
                        _loc9_ = buildHelpCategoryListEntryItem(_loc11_, "help_itemlist_item_white_bg", this.onListItemClick);
                        if (_loc9_ != null)
                        {
                            _loc9_.name = "content_normal_item";
                            _loc7_.addListItem(_loc9_);
                        };
                        _loc8_++;
                    };
                };
            };
            var _loc6_:IItemListWindow = (container.findChildByName("help_itemlist") as IItemListWindow);
            _loc6_.arrangeListItems();
            main.updateWindowDimensions();
        }

        private function onFaqBrowse(param1:WindowMouseEvent):void
        {
            main.showUI(HabboHelpViewEnum.var_1394);
        }

        private function onCallForHelp(param1:WindowMouseEvent):void
        {
            main.component.callForHelpData.reportedUserId = 0;
            main.showUI(HabboHelpViewEnum.var_279);
        }

        private function onReportUser(param1:WindowMouseEvent):void
        {
            main.component.callForHelpData.reportedUserId = 0;
            main.showUI(HabboHelpViewEnum.var_1401);
        }

        private function onListItemClick(param1:WindowMouseEvent):void
        {
            var _loc2_:IWindow = (param1.target as IWindow);
            this.handleListItemClick(_loc2_);
        }

        private function onCallGuideBot(param1:WindowMouseEvent):void
        {
            main.handleCallGuideBot();
        }

        private function handleListItemClick(param1:IWindow):void
        {
            var _loc3_:FaqCategory;
            var _loc4_:IItemListWindow;
            var _loc2_:FaqIndex = main.getFaq();
            if ((((_loc2_ == null) || (param1 == null)) || (param1.parent == null)))
            {
                return;
            };
            if (param1.parent.name.indexOf("normal") > -1)
            {
                _loc4_ = (container.findChildByTag("content_normal") as IItemListWindow);
                _loc3_ = _loc2_.getFrontPageNormalCategory();
            }
            else
            {
                _loc4_ = (container.findChildByTag("content_urgent") as IItemListWindow);
                _loc3_ = _loc2_.getFrontPageUrgentCategory();
            };
            if (_loc4_ == null)
            {
                return;
            };
            var _loc5_:int = _loc4_.getListItemIndex(param1.parent);
            if (_loc3_ == null)
            {
                return;
            };
            var _loc6_:FaqItem = _loc3_.getItemByIndex(_loc5_);
            if (_loc6_ != null)
            {
                main.showUI(HabboHelpViewEnum.var_1396);
                main.tellUI(HabboHelpViewEnum.var_1396, _loc6_);
            };
        }


    }
}