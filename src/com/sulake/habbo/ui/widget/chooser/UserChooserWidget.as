package com.sulake.habbo.ui.widget.chooser
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChooserContentEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import flash.events.IEventDispatcher;

    public class UserChooserWidget extends ChooserWidgetBase 
    {

        private const var_5229:int = 0;
        private const var_5230:int = 1;

        private var var_5231:ChooserView;

        public function UserChooserWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary=null, param4:IHabboLocalizationManager=null)
        {
            super(param1, param2, param3, param4);
        }

        override public function get state():int
        {
            if (((!(this.var_5231 == null)) && (this.var_5231.isOpen())))
            {
                return (this.var_5230);
            };
            return (this.var_5229);
        }

        override public function initialize(param1:int=0):void
        {
            var _loc2_:RoomWidgetRequestWidgetMessage;
            super.initialize(param1);
            if (param1 == this.var_5230)
            {
                _loc2_ = new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.var_1574);
                messageListener.processWidgetMessage(_loc2_);
            };
        }

        override public function dispose():void
        {
            if (this.var_5231 != null)
            {
                this.var_5231.dispose();
                this.var_5231 = null;
            };
            super.dispose();
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.addEventListener(RoomWidgetChooserContentEvent.var_1575, this.onChooserContent);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1543, this.onUpdateUserChooser);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1541, this.onUpdateUserChooser);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetChooserContentEvent.var_1575, this.onChooserContent);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1543, this.onUpdateUserChooser);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1541, this.onUpdateUserChooser);
        }

        private function onChooserContent(param1:RoomWidgetChooserContentEvent):void
        {
            if (((param1 == null) || (param1.items == null)))
            {
                return;
            };
            if (this.var_5231 == null)
            {
                this.var_5231 = new ChooserView(this, "${widget.chooser.user.title}");
            };
            this.var_5231.populate(param1.items, false);
        }

        private function onUpdateUserChooser(param1:RoomWidgetRoomObjectUpdateEvent):void
        {
            if (((this.var_5231 == null) || (!(this.var_5231.isOpen()))))
            {
                return;
            };
            var _loc2_:RoomWidgetRequestWidgetMessage = new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.var_1574);
            messageListener.processWidgetMessage(_loc2_);
        }


    }
}