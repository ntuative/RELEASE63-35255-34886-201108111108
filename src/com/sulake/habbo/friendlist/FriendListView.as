package com.sulake.habbo.friendlist
{
    import flash.geom.Point;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.habbo.friendlist.events.HabboFriendListTrackingEvent;
    import com.sulake.core.window.IWindow;
    import flash.utils.Dictionary;

    public class FriendListView 
    {

        private static const var_1728:Point = new Point(110, 50);

        private var _friendList:HabboFriendList;
        private var var_3965:FriendListTabsView;
        private var var_3966:IFrameWindow;
        private var var_3967:IWindowContainer;
        private var var_3968:IWindowContainer;
        private var var_3969:ITextWindow;
        private var var_3970:int = -1;
        private var var_3971:int = -1;
        private var var_3972:Boolean;

        public function FriendListView(param1:HabboFriendList)
        {
            this._friendList = param1;
            this.var_3965 = new FriendListTabsView(this._friendList);
        }

        public function isFriendListOpen():Boolean
        {
            return ((!(this.var_3966 == null)) && (this.var_3966.visible));
        }

        public function openFriendList():void
        {
            if (this.var_3966 == null)
            {
                this.prepare();
                this.var_3966.position = var_1728;
            }
            else
            {
                this.var_3966.visible = true;
                this.var_3966.activate();
            };
        }

        public function showInfo(param1:WindowEvent, param2:String):void
        {
            var _loc3_:WindowMouseEvent = (param1 as WindowMouseEvent);
            if (_loc3_ == null)
            {
                return;
            };
            if (_loc3_.type == WindowMouseEvent.var_624)
            {
                this.var_3969.text = "";
            }
            else
            {
                if (_loc3_.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
                {
                    this.var_3969.text = param2;
                };
            };
        }

        public function refresh(param1:String):void
        {
            if (this.var_3966 == null)
            {
                return;
            };
            this.var_3965.refresh(param1);
            this.refreshWindowSize();
        }

        public function close():void
        {
            if (this.var_3966 != null)
            {
                this.var_3966.visible = false;
            };
        }

        public function isOpen():Boolean
        {
            return ((this.var_3966) && (this.var_3966.visible));
        }

        private function prepare():void
        {
            this.var_3966 = IFrameWindow(this._friendList.getXmlWindow("main_window"));
            this.var_3966.findChildByTag("close").procedure = this.onWindowClose;
            this.var_3967 = IWindowContainer(this.var_3966.content.findChildByName("main_content"));
            this.var_3968 = IWindowContainer(this.var_3966.content.findChildByName("footer"));
            this.var_3965.prepare(this.var_3967);
            this.var_3966.procedure = this.onWindow;
            this.var_3966.content.setParamFlag(HabboWindowParam.var_844, false);
            this.var_3966.content.setParamFlag(HabboWindowParam.var_840, true);
            this.var_3966.header.setParamFlag(HabboWindowParam.var_839, false);
            this.var_3966.header.setParamFlag(HabboWindowParam.var_835, true);
            this.var_3966.content.setParamFlag(HabboWindowParam.var_839, false);
            this.var_3966.content.setParamFlag(HabboWindowParam.var_835, true);
            this.var_3966.findChildByName("open_edit_ctgs_but").procedure = this.onEditCategoriesButtonClick;
            this.var_3969 = ITextWindow(this.var_3966.findChildByName("info_text"));
            this.var_3969.text = "";
            this._friendList.refreshButton(this.var_3966, "open_edit_ctgs", true, null, 0);
            this.var_3966.title.color = 0xFFFAC200;
            this.var_3966.title.textColor = 4287851525;
            this.refresh("prepare");
            this.var_3966.height = 350;
            this.var_3966.width = 230;
        }

        private function onWindowClose(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("Close window");
            this.var_3966.visible = false;
            this._friendList.trackFriendListEvent(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_CLOSED);
        }

        private function onWindow(param1:WindowEvent, param2:IWindow):void
        {
            if (((!(param1.type == WindowEvent.var_589)) || (!(param2 == this.var_3966))))
            {
                return;
            };
            if (this.var_3972)
            {
                return;
            };
            var _loc3_:int = ((this.var_3970 == -1) ? 0 : (this.var_3966.height - this.var_3970));
            var _loc4_:int = ((this.var_3971 == -1) ? 0 : (this.var_3966.width - this.var_3971));
            this._friendList.tabs.tabContentHeight = Math.max(100, (this._friendList.tabs.tabContentHeight + _loc3_));
            this._friendList.tabs.windowWidth = Math.max(147, (this._friendList.tabs.windowWidth + _loc4_));
            this.refresh(("resize: " + _loc3_));
        }

        private function refreshWindowSize():void
        {
            this.var_3972 = true;
            this.var_3968.visible = false;
            this.var_3968.y = Util.getLowestPoint(this.var_3966.content);
            this.var_3968.width = this._friendList.tabs.windowWidth;
            this.var_3968.visible = true;
            this.var_3966.content.height = Util.getLowestPoint(this.var_3966.content);
            this.var_3966.content.width = (this._friendList.tabs.windowWidth - 10);
            this.var_3966.header.width = (this._friendList.tabs.windowWidth - 10);
            this.var_3966.height = (this.var_3966.content.height + 30);
            this.var_3966.width = this._friendList.tabs.windowWidth;
            this.var_3972 = false;
            this.var_3966.scaler.setParamFlag(HabboWindowParam.var_862, false);
            this.var_3966.scaler.setParamFlag(HabboWindowParam.var_859, (!(this._friendList.tabs.findSelectedTab() == null)));
            this.var_3966.scaler.setParamFlag(HabboWindowParam.var_839, false);
            this.var_3966.scaler.setParamFlag(HabboWindowParam.var_844, false);
            this.var_3966.scaler.x = (this.var_3966.width - this.var_3966.scaler.width);
            this.var_3966.scaler.y = (this.var_3966.height - this.var_3966.scaler.height);
            this.var_3970 = this.var_3966.height;
            this.var_3971 = this.var_3966.width;
            Logger.log(("RESIZED: " + this._friendList.tabs.windowWidth));
        }

        private function onEditCategoriesButtonClick(param1:WindowEvent, param2:IWindow):void
        {
            this._friendList.view.showInfo(param1, "${friendlist.tip.preferences}");
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("Edit categories clicked");
            var _loc3_:WindowMouseEvent = (param1 as WindowMouseEvent);
            this._friendList.openHabboWebPage("link.format.friendlist.pref", new Dictionary(), _loc3_.stageX, _loc3_.stageY);
        }

        public function get mainWindow():IWindowContainer
        {
            return (this.var_3966);
        }


    }
}