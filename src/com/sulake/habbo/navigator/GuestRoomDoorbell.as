package com.sulake.habbo.navigator
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.core.window.components.ITextWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindow;

    public class GuestRoomDoorbell 
    {

        private var _navigator:HabboNavigator;
        private var _window:IFrameWindow;
        private var var_4358:GuestRoomData;
        private var var_4359:Boolean;

        public function GuestRoomDoorbell(param1:HabboNavigator)
        {
            this._navigator = param1;
        }

        public function show(param1:GuestRoomData, param2:Point=null, param3:Boolean=false):void
        {
            if (param1 == null)
            {
                return;
            };
            this.var_4358 = param1;
            this.var_4359 = param3;
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
            var _loc4_:ITextWindow = (this._window.findChildByName("room_name") as ITextWindow);
            if (_loc4_ != null)
            {
                _loc4_.text = param1.roomName;
            };
            if (this.var_4359)
            {
                this.setText("info", "${navigator.doorbell.waiting}");
                this.setText("cancel", "${navigator.doorbell.button.cancel.entering}");
                this.showButton("ring", false);
            }
            else
            {
                this.setText("info", "${navigator.doorbell.info}");
                this.setText("cancel", "${generic.cancel}");
                this.showButton("ring", true);
            };
        }

        public function showWaiting():void
        {
            this.show(this.var_4358, null, true);
        }

        public function showNoAnswer():void
        {
            if (this._window == null)
            {
                return;
            };
            this._window.visible = true;
            this._window.activate();
            this.setText("info", "${navigator.doorbell.no.answer}");
            this.showButton("ring", false);
        }

        private function showButton(param1:String, param2:Boolean):void
        {
            var _loc3_:IButtonWindow = (this._window.findChildByName(param1) as IButtonWindow);
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.visible = param2;
        }

        private function createWindow():void
        {
            if (this._window != null)
            {
                return;
            };
            var _loc1_:XmlAsset = (this._navigator.assets.getAssetByName("doorbell_xml") as XmlAsset);
            this._window = (this._navigator.windowManager.buildFromXML((_loc1_.content as XML), 2) as IFrameWindow);
            if (this._window == null)
            {
                return;
            };
            var _loc2_:IButtonWindow = (this._window.findChildByName("ring") as IButtonWindow);
            if (_loc2_ != null)
            {
                _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.ringDoorbell);
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

        private function setText(param1:String, param2:String):void
        {
            if (this._window == null)
            {
                return;
            };
            var _loc3_:IWindow = this._window.findChildByName(param1);
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.caption = param2;
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

        private function ringDoorbell(param1:WindowMouseEvent):void
        {
            this._navigator.goToRoom(this.var_4358.flatId, true);
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

        public function hide():void
        {
            if (this._window == null)
            {
                return;
            };
            this._window.visible = false;
        }


    }
}