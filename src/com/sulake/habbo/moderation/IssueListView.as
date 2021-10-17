package com.sulake.habbo.moderation
{
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.utils.getTimer;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class IssueListView 
    {

        private static const var_2537:int = 20;

        private var _issueManager:IssueManager;
        private var var_4175:IssueBrowser;
        private var var_2632:IItemListWindow;
        private var var_2568:String;
        private var var_4176:IWindowContainer;
        private var var_4177:BitmapData;
        private var var_4178:BitmapData;

        public function IssueListView(param1:IssueManager, param2:IssueBrowser, param3:IItemListWindow, param4:String)
        {
            this._issueManager = param1;
            this.var_4175 = param2;
            this.var_2632 = param3;
            this.var_2568 = param4;
            this.var_4176 = (this.var_4175.createWindow(param4) as IWindowContainer);
        }

        public function update(param1:Array):void
        {
            var _loc2_:int;
            var _loc3_:IWindowContainer;
            var _loc6_:IWindow;
            var _loc7_:IssueBundle;
            var _loc9_:IWindow;
            var _loc10_:IssueMessageData;
            var _loc11_:IBitmapWrapperWindow;
            var _loc12_:String;
            var _loc13_:BitmapDataAsset;
            var _loc14_:BitmapData;
            if (this.var_2632 == null)
            {
                return;
            };
            if (((param1 == null) || (param1.length == 0)))
            {
                this.var_2632.destroyListItems();
                return;
            };
            param1.sortOn("prioritySum", (Array.DESCENDING | Array.NUMERIC));
            var _loc4_:int = this.var_2632.numListItems;
            var _loc5_:int = param1.length;
            if (_loc5_ > var_2537)
            {
                _loc5_ = var_2537;
            };
            if (_loc4_ < _loc5_)
            {
                _loc2_ = 0;
                while (_loc2_ < (_loc5_ - _loc4_))
                {
                    _loc3_ = (this.var_4176.clone() as IWindowContainer);
                    this.var_2632.addListItem(_loc3_);
                    _loc2_++;
                };
            }
            else
            {
                if (_loc4_ > _loc5_)
                {
                    _loc2_ = 0;
                    while (_loc2_ < (_loc4_ - _loc5_))
                    {
                        _loc9_ = this.var_2632.removeListItemAt(0);
                        _loc9_.dispose();
                        _loc2_++;
                    };
                };
            };
            _loc2_ = 1;
            var _loc8_:int = getTimer();
            for each (_loc7_ in param1)
            {
                if (_loc2_ > var_2537) break;
                if (((_loc7_ == null) || (this.var_4176 == null)))
                {
                    return;
                };
                _loc3_ = (this.var_2632.getListItemAt((_loc2_ - 1)) as IWindowContainer);
                if (_loc3_ == null)
                {
                    return;
                };
                _loc3_.width = this.var_2632.width;
                _loc3_.color = ((_loc2_++ % 2) ? 4289914618 : 0xFFFFFFFF);
                _loc6_ = _loc3_.findChildByName("score");
                if (_loc6_ != null)
                {
                    _loc6_.caption = _loc7_.prioritySum.toString();
                };
                _loc10_ = _loc7_.getHighestPriorityIssue();
                if (_loc10_ == null)
                {
                    return;
                };
                _loc6_ = _loc3_.findChildByName("category");
                if (_loc6_ != null)
                {
                    _loc6_.caption = IssueCategoryNames.getCategoryName(_loc10_.reportedCategoryId);
                };
                _loc6_ = _loc3_.findChildByName("target_name");
                if (_loc6_ != null)
                {
                    if (_loc10_.reportedUserId != 0)
                    {
                        _loc6_.caption = _loc10_.reportedUserName;
                    }
                    else
                    {
                        _loc6_.caption = _loc10_.roomName;
                    };
                };
                _loc11_ = (_loc3_.findChildByName("target_icon") as IBitmapWrapperWindow);
                if (_loc11_ != null)
                {
                    _loc12_ = ((_loc10_.reportedUserId) ? "user_icon_png" : "room_icon_png");
                    _loc13_ = (this.var_4175.assets.getAssetByName(_loc12_) as BitmapDataAsset);
                    if (((!(_loc13_ == null)) && (!((_loc13_.content as BitmapData) == null))))
                    {
                        _loc14_ = (_loc13_.content as BitmapData);
                        if (_loc14_ != null)
                        {
                            _loc11_.bitmap = _loc14_.clone();
                        };
                    };
                };
                _loc6_ = _loc3_.findChildByName("time");
                if (_loc6_ != null)
                {
                    _loc6_.caption = _loc7_.getOpenTime(_loc8_);
                };
                _loc6_ = _loc3_.findChildByName("msgs");
                if (_loc6_ != null)
                {
                    _loc6_.caption = _loc7_.getMessageCount().toString();
                };
                _loc6_ = _loc3_.findChildByName("picker");
                if (_loc6_ != null)
                {
                    _loc6_.caption = _loc7_.pickerName;
                };
                _loc6_ = _loc3_.findChildByName("pick_button");
                if (_loc6_ != null)
                {
                    _loc6_.id = _loc7_.id;
                    _loc6_.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onPick);
                    _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onPick);
                };
                _loc6_ = _loc3_.findChildByName("handle_button");
                if (_loc6_ != null)
                {
                    _loc6_.id = _loc7_.id;
                    _loc6_.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onHandle);
                    _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onHandle);
                };
                _loc6_ = _loc3_.findChildByName("release_button");
                if (_loc6_ != null)
                {
                    _loc6_.id = _loc7_.id;
                    _loc6_.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onRelease);
                    _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onRelease);
                };
            };
        }

        private function onPick(param1:WindowMouseEvent):void
        {
            if (this._issueManager == null)
            {
                return;
            };
            this._issueManager.pickBundle(param1.window.id);
        }

        private function onHandle(param1:WindowMouseEvent):void
        {
            if (this.var_4175 == null)
            {
                return;
            };
            this._issueManager.handleBundle(param1.window.id);
        }

        private function onRelease(param1:WindowMouseEvent):void
        {
            if (this._issueManager == null)
            {
                return;
            };
            this._issueManager.releaseBundle(param1.window.id);
        }


    }
}