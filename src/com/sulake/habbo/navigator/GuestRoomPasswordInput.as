package com.sulake.habbo.navigator
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IPasswordFieldWindow;
    import flash.geom.Point;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindow;

    public class GuestRoomPasswordInput 
    {

        private var _navigator:HabboNavigator;
        private var _window:IFrameWindow;
        private var var_4358:GuestRoomData;

        public function GuestRoomPasswordInput(param1:HabboNavigator)
        {
            this._navigator = param1;
        }

        public function show(param1:GuestRoomData, param2:Point=null):void
        {
            this.var_4358 = param1;
            if (this.var_4358 == null)
            {
                return;
            };
            this.createWindow();
            if (this._window == null)
            {
                return;
            };
            if (param2 != null)
            {
                param2.offset((-(this._window.width) / 2), (-(this._window.height) / 2));
                this._window.setGlobalPosition(param2);
            };
            this._window.visible = true;
            this._window.activate();
            var _loc3_:ITextWindow = (this._window.findChildByName("room_name") as ITextWindow);
            if (((!(_loc3_ == null)) && (!(param1 == null))))
            {
                _loc3_.text = param1.roomName;
            };
            var _loc4_:IPasswordFieldWindow = (this._window.findChildByName("password_input") as IPasswordFieldWindow);
            if (_loc4_ != null)
            {
                _loc4_.text = "";
            };
            this.setInfoText("${navigator.password.info}");
        }

        private function createWindow():void
        {
            if (this._window != null)
            {
                return;
            };
            var _loc1_:XmlAsset = (this._navigator.assets.getAssetByName("password_input_xml") as XmlAsset);
            this._window = (this._navigator.windowManager.buildFromXML((_loc1_.content as XML), 2) as IFrameWindow);
            if (this._window == null)
            {
                return;
            };
            var _loc2_:IButtonWindow = (this._window.findChildByName("try") as IButtonWindow);
            if (_loc2_ != null)
            {
                _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onTry);
            };
            var _loc3_:IWindow = this._window.findChildByName("cancel_region");
            if (_loc3_ != null)
            {
                _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.close);
            };
            var _loc4_:IWindow = this._window.findChildByTag("close");
            if (_loc4_ != null)
            {
                _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.close);
            };
        }

        public function showRetry():void
        {
            this.show(this.var_4358);
            this.setInfoText("${navigator.password.retryinfo}");
        }

        private function setInfoText(param1:String):void
        {
            if (this._window == null)
            {
                return;
            };
            var _loc2_:ITextWindow = (this._window.findChildByName("info") as ITextWindow);
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.caption = param1;
        }

        public function dispose():void
        {
            if (this._window != null)
            {
                this._window.dispose();
            };
            this._window = null;
            this._navigator = null;
            this.var_4358 = null;
        }

        private function onTry(param1:WindowMouseEvent):void
        {
            var _loc2_:IPasswordFieldWindow = (this._window.findChildByName("password_input") as IPasswordFieldWindow);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:String = _loc2_.text;
            this._navigator.goToRoom(this.var_4358.flatId, true, _loc3_);
            this.hide();
        }

        private function close(param1:WindowMouseEvent):void
        {
            if (this._window == null)
            {
                return;
            };
            this._window.dispose();
            this._window = null;
        }

        private function hide(param1:WindowMouseEvent=null):void
        {
            if (this._window == null)
            {
                return;
            };
            this._window.visible = false;
        }


    }
}