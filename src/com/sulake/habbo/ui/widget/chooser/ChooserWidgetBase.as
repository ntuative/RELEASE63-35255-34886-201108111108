package com.sulake.habbo.ui.widget.chooser
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;

    public class ChooserWidgetBase extends RoomWidgetBase 
    {

        public function ChooserWidgetBase(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary=null, param4:IHabboLocalizationManager=null)
        {
            super(param1, param2, param3, param4);
        }

        public function choose(param1:int, param2:int):void
        {
            var _loc3_:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.var_1571, param1, param2);
            messageListener.processWidgetMessage(_loc3_);
        }


    }
}