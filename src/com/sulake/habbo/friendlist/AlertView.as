package com.sulake.habbo.friendlist
{
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.Dictionary;
    import com.sulake.core.window.components.IFrameWindow;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class AlertView implements IDisposable 
    {

        private static var var_1837:Dictionary = new Dictionary();

        private var _friendList:HabboFriendList;
        private var _alert:IFrameWindow;
        private var var_3964:String;
        private var _title:String;
        private var _disposed:Boolean;

        public function AlertView(param1:HabboFriendList, param2:String, param3:String=null)
        {
            this._friendList = param1;
            this.var_3964 = param2;
            this._title = param3;
        }

        public function show():void
        {
            var _loc1_:IFrameWindow = IFrameWindow(var_1837[this.var_3964]);
            if (_loc1_ != null)
            {
                _loc1_.dispose();
            };
            this._alert = this.getAlert();
            if (this._title != null)
            {
                this._alert.caption = this._title;
            };
            this.setupContent(this._alert.content);
            var _loc2_:Rectangle = Util.getLocationRelativeTo(this._friendList.view.mainWindow, this._alert.width, this._alert.height);
            this._alert.x = _loc2_.x;
            this._alert.y = _loc2_.y;
            var_1837[this.var_3964] = this._alert;
        }

        public function dispose():void
        {
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
            if (this._alert != null)
            {
                this._alert.destroy();
                this._alert = null;
            };
            this._friendList = null;
        }

        internal function setupContent(param1:IWindowContainer):void
        {
        }

        internal function onClose(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this.dispose();
        }

        private function getAlert():IFrameWindow
        {
            var _loc1_:IFrameWindow = IFrameWindow(this._friendList.getXmlWindow(this.var_3964));
            var _loc2_:IWindow = _loc1_.findChildByTag("close");
            _loc2_.procedure = this.onClose;
            return (_loc1_);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get friendList():HabboFriendList
        {
            return (this._friendList);
        }


    }
}