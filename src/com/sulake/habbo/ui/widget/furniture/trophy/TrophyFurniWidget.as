package com.sulake.habbo.ui.widget.furniture.trophy
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.ui.widget.events.RoomWidgetTrophyDataUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class TrophyFurniWidget extends RoomWidgetBase 
    {

        private static const var_1676:Array = new Array("trophy_bg_gold", "trophy_bg_silver", "trophy_bg_bronze");
        private static const var_1675:Array = new Array(4293707079, 4291411404, 4290279476);

        private var _window:IWindowContainer;
        private var _name:String;
        private var var_3680:String;
        private var _message:String = null;
        private var _color:Number;

        public function TrophyFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
        }

        override public function dispose():void
        {
            this.disposeInterface();
            super.dispose();
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.addEventListener(RoomWidgetTrophyDataUpdateEvent.var_1674, this.onObjectUpdate);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetTrophyDataUpdateEvent.var_1674, this.onObjectUpdate);
        }

        private function onObjectUpdate(param1:RoomWidgetTrophyDataUpdateEvent):void
        {
            this.disposeInterface();
            this._name = param1.name;
            this.var_3680 = param1.date;
            this._message = param1.message;
            this._color = (param1.color - 1);
            if (((this._color > 2) || (this._color < 0)))
            {
                this._color = 0;
            };
            this.showInterface();
        }

        private function showInterface():void
        {
            var _loc3_:IWindow;
            var _loc4_:IWindowContainer;
            var _loc5_:ITextWindow;
            var _loc6_:ITextWindow;
            var _loc7_:ITextWindow;
            var _loc8_:BitmapDataAsset;
            var _loc9_:BitmapData;
            var _loc10_:IBitmapWrapperWindow;
            var _loc1_:IAsset = assets.getAssetByName("trophy");
            var _loc2_:XmlAsset = XmlAsset(_loc1_);
            if (_loc2_ == null)
            {
                return;
            };
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
            this._window = (windowManager.buildFromXML((_loc2_.content as XML)) as IWindowContainer);
            this._window.center();
            _loc3_ = this._window.findChildByName("close");
            if (_loc3_ != null)
            {
                _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
            };
            _loc4_ = (this._window.findChildByName("title_bg") as IWindowContainer);
            if (_loc4_ != null)
            {
                _loc4_.color = var_1675[this._color];
            };
            _loc5_ = (this._window.findChildByName("greeting") as ITextWindow);
            if (_loc5_ != null)
            {
                this._message = this._message.replace(/\\r/g, "\n");
                _loc5_.text = this._message;
            };
            _loc6_ = (this._window.findChildByName("date") as ITextWindow);
            if (_loc6_ != null)
            {
                _loc6_.text = this.var_3680;
            };
            _loc7_ = (this._window.findChildByName("name") as ITextWindow);
            if (_loc7_ != null)
            {
                _loc7_.text = this._name;
            };
            _loc8_ = (assets.getAssetByName(var_1676[this._color]) as BitmapDataAsset);
            _loc10_ = (this._window.findChildByName("trophy_bg") as IBitmapWrapperWindow);
            if (_loc8_ != null)
            {
                _loc9_ = (_loc8_.content as BitmapData);
                _loc10_.bitmap = _loc9_.clone();
            };
        }

        private function disposeInterface():void
        {
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
        }

        private function onMouseEvent(param1:WindowMouseEvent):void
        {
            var _loc2_:IWindow = (param1.target as IWindow);
            var _loc3_:String = _loc2_.name;
            this.disposeInterface();
        }


    }
}