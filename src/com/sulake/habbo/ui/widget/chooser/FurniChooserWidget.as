package com.sulake.habbo.ui.widget.chooser
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChooserContentEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;

    public class FurniChooserWidget extends ChooserWidgetBase 
    {

        private var var_5228:ChooserView;

        public function FurniChooserWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary=null, param4:IHabboLocalizationManager=null)
        {
            super(param1, param2, param3, param4);
        }

        override public function dispose():void
        {
            if (this.var_5228 != null)
            {
                this.var_5228.dispose();
                this.var_5228 = null;
            };
            super.dispose();
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.addEventListener(RoomWidgetChooserContentEvent.var_1572, this.onChooserContent);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1542, this.onUpdateFurniChooser);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1540, this.onUpdateFurniChooser);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetChooserContentEvent.var_1572, this.onChooserContent);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1542, this.onUpdateFurniChooser);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1540, this.onUpdateFurniChooser);
        }

        private function onChooserContent(param1:RoomWidgetChooserContentEvent):void
        {
            if (((param1 == null) || (param1.items == null)))
            {
                return;
            };
            if (this.var_5228 == null)
            {
                this.var_5228 = new ChooserView(this, "${widget.chooser.furni.title}");
            };
            this.var_5228.populate(param1.items, param1.isAnyRoomController);
        }

        private function onUpdateFurniChooser(param1:RoomWidgetRoomObjectUpdateEvent):void
        {
            if (((this.var_5228 == null) || (!(this.var_5228.isOpen()))))
            {
                return;
            };
            var _loc2_:RoomWidgetRequestWidgetMessage = new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.var_1573);
            messageListener.processWidgetMessage(_loc2_);
        }


    }
}