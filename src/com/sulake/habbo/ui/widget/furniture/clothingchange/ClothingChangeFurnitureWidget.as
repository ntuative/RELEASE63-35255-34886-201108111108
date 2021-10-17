package com.sulake.habbo.ui.widget.furniture.clothingchange
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.widget.events.RoomWidgetClothingChangeUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetClothingChangeMessage;

    public class ClothingChangeFurnitureWidget extends RoomWidgetBase 
    {

        private static const var_1670:String = "Boy";
        private static const var_1671:String = "Girl";

        private var var_5280:IWindowContainer;
        private var var_1678:int = 0;
        private var var_2823:int = 0;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function ClothingChangeFurnitureWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary=null, param4:IHabboLocalizationManager=null)
        {
            super(param1, param2, param3, param4);
        }

        override public function dispose():void
        {
            this.hideGenderSelectionInterface();
            super.dispose();
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.addEventListener(RoomWidgetClothingChangeUpdateEvent.var_1668, this.onUpdate);
            param1.addEventListener(RoomWidgetClothingChangeUpdateEvent.var_1669, this.onUpdate);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetClothingChangeUpdateEvent.var_1668, this.onUpdate);
            param1.removeEventListener(RoomWidgetClothingChangeUpdateEvent.var_1669, this.onUpdate);
        }

        private function onUpdate(param1:RoomWidgetClothingChangeUpdateEvent):void
        {
            switch (param1.type)
            {
                case RoomWidgetClothingChangeUpdateEvent.var_1668:
                    this.showGenderSelectionInterface(param1);
                    return;
            };
        }

        private function showGenderSelectionInterface(param1:RoomWidgetClothingChangeUpdateEvent):void
        {
            this.hideGenderSelectionInterface();
            this.var_1678 = param1.objectId;
            this.var_2823 = param1.objectCategory;
            this._roomId = param1.roomId;
            this._roomCategory = param1.roomCategory;
            var _loc2_:IAsset = assets.getAssetByName("boygirl");
            var _loc3_:XmlAsset = XmlAsset(_loc2_);
            if (_loc3_ == null)
            {
                return;
            };
            this.var_5280 = (windowManager.createWindow("clothing change gender selection", "", HabboWindowType.var_218, HabboWindowStyle.var_157, (((HabboWindowParam.var_855 | HabboWindowParam.var_864) | HabboWindowParam.var_829) | HabboWindowParam.var_158), new Rectangle(100, 100, 200, 200), null, 0) as IWindowContainer);
            this.var_5280.buildFromXML(XML(_loc3_.content));
            this.var_5280.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onGenderSelectionMouseEvent);
            this.var_5280.center();
            var _loc4_:IWindow = this.var_5280.findChildByTag("close");
            if (_loc4_ != null)
            {
                _loc4_.procedure = this.onGenderSelectionWindowClose;
            };
            _loc4_ = this.var_5280.findChildByName(var_1670);
            if (_loc4_ != null)
            {
                _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onGenderSelectionMouseEvent);
            };
            _loc4_ = this.var_5280.findChildByName(var_1671);
            if (_loc4_ != null)
            {
                _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onGenderSelectionMouseEvent);
            };
        }

        private function hideGenderSelectionInterface():void
        {
            if (this.var_5280 != null)
            {
                this.var_5280.dispose();
                this.var_5280 = null;
            };
        }

        private function onGenderSelectionWindowClose(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this.hideGenderSelectionInterface();
        }

        private function onGenderSelectionMouseEvent(param1:WindowMouseEvent):void
        {
            var _loc2_:IWindow = (param1.target as IWindow);
            var _loc3_:String = _loc2_.name;
            switch (_loc3_)
            {
                case var_1670:
                    this.requestBoyEditor();
                    this.hideGenderSelectionInterface();
                    return;
                case var_1671:
                    this.requestGirlEditor();
                    this.hideGenderSelectionInterface();
                    return;
                case "close":
                case "close_btn":
                    this.hideGenderSelectionInterface();
                    return;
            };
        }

        private function requestBoyEditor():void
        {
            this.requestEditor(FigureData.var_1672);
        }

        private function requestGirlEditor():void
        {
            this.requestEditor(FigureData.FEMALE);
        }

        private function requestEditor(param1:String):void
        {
            var _loc2_:RoomWidgetClothingChangeMessage = new RoomWidgetClothingChangeMessage(RoomWidgetClothingChangeMessage.var_1673, param1, this.var_1678, this.var_2823, this._roomId, this._roomCategory);
            messageListener.processWidgetMessage(_loc2_);
        }


    }
}