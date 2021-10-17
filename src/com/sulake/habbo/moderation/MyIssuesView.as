package com.sulake.habbo.moderation
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class MyIssuesView implements IIssueBrowserView 
    {

        private var _issueManager:IssueManager;
        private var var_4175:IssueBrowser;
        private var _window:IWindowContainer;
        private var var_4207:IssueListView;

        public function MyIssuesView(param1:IssueManager, param2:IssueBrowser, param3:IWindowContainer)
        {
            this._issueManager = param1;
            this.var_4175 = param2;
            this._window = (this.var_4175.createWindow("my_issues_xml") as IWindowContainer);
            param3.addChild(this._window);
            var _loc4_:IItemListWindow = (this._window.findChildByName("issue_list") as IItemListWindow);
            this.var_4207 = new IssueListView(param1, param2, _loc4_, "my_issues_list_item_xml");
            var _loc5_:IWindow = this._window.findChildByName("release_all");
            if (_loc5_ != null)
            {
                _loc5_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onReturnAll);
            };
        }

        public function get view():IWindowContainer
        {
            return (this._window);
        }

        public function set visible(param1:Boolean):void
        {
            this._window.visible = param1;
        }

        public function update():void
        {
            var _loc1_:Array = this._issueManager.getBundles(IssueManager.var_1531);
            this.var_4207.update(_loc1_);
        }

        private function onReturnAll(param1:WindowMouseEvent):void
        {
            if (this._issueManager == null)
            {
                return;
            };
            this._issueManager.releaseAll();
        }


    }
}