package com.sulake.habbo.ui.widget.doorbell
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class DoorbellView 
    {

        private var var_4365:DoorbellWidget;
        private var _frame:IFrameWindow;
        private var var_2632:IItemListWindow;

        public function DoorbellView(param1:DoorbellWidget)
        {
            this.var_4365 = param1;
            this.createMainWindow();
        }

        public function dispose():void
        {
            this.var_4365 = null;
            if (this._frame)
            {
                this._frame.dispose();
                this._frame = null;
            };
        }

        public function update():void
        {
            var _loc1_:int;
            if (this.var_4365.users.length == 0)
            {
                this.hide();
                return;
            };
            if (this._frame != null)
            {
                this._frame.visible = true;
            };
            if (this.var_2632 != null)
            {
                this.var_2632.destroyListItems();
                _loc1_ = 0;
                while (_loc1_ < this.var_4365.users.length)
                {
                    this.var_2632.addListItem(this.createListItem((this.var_4365.users[_loc1_] as String), _loc1_));
                    _loc1_++;
                };
            };
        }

        private function createListItem(param1:String, param2:int):IWindow
        {
            var _loc6_:IWindow;
            var _loc3_:XmlAsset = (this.var_4365.assets.getAssetByName("doorbell_list_entry") as XmlAsset);
            var _loc4_:IWindowContainer = (this.var_4365.windowManager.buildFromXML((_loc3_.content as XML)) as IWindowContainer);
            if (_loc4_ == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            var _loc5_:ITextWindow = (_loc4_.findChildByName("user_name") as ITextWindow);
            if (_loc5_ != null)
            {
                _loc5_.caption = param1;
            };
            _loc4_.name = param1;
            if ((param2 % 2) == 0)
            {
                _loc4_.color = 0xFFFFFFFF;
            };
            _loc6_ = _loc4_.findChildByName("accept");
            if (_loc6_ != null)
            {
                _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClicked);
            };
            _loc6_ = _loc4_.findChildByName("deny");
            if (_loc6_ != null)
            {
                _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClicked);
            };
            return (_loc4_);
        }

        private function hide():void
        {
            if (this._frame == null)
            {
                return;
            };
            this._frame.visible = false;
        }

        public function get mainWindow():IWindow
        {
            return (this._frame);
        }

        public function createMainWindow():void
        {
            if (this._frame != null)
            {
                return;
            };
            var _loc1_:XmlAsset = (this.var_4365.assets.getAssetByName("doorbell") as XmlAsset);
            this._frame = (this.var_4365.windowManager.buildFromXML((_loc1_.content as XML)) as IFrameWindow);
            if (this._frame == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            this.var_2632 = (this._frame.findChildByName("user_list") as IItemListWindow);
            this._frame.visible = false;
            var _loc2_:IWindow = this._frame.findChildByTag("close");
            if (_loc2_ != null)
            {
                _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
            };
        }

        private function onClose(param1:WindowMouseEvent):void
        {
            this.var_4365.denyAll();
        }

        private function onButtonClicked(param1:WindowMouseEvent):void
        {
            var _loc2_:String = param1.window.parent.name;
            switch (param1.window.name)
            {
                case "accept":
                    this.var_4365.accept(_loc2_);
                    return;
                case "deny":
                    this.var_4365.deny(_loc2_);
                    return;
            };
        }


    }
}