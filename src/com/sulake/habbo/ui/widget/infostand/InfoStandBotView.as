package com.sulake.habbo.ui.widget.infostand
{
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class InfoStandBotView extends InfoStandUserView 
    {

        public function InfoStandBotView(param1:InfostandWidget, param2:String)
        {
            super(param1, param2);
        }

        override protected function createWindow(param1:String, param2:Boolean):void
        {
            var _loc3_:ITextWindow;
            super.createWindow(param1, true);
            _loc3_ = (var_2394.getListItemByName("score_spacer") as ITextWindow);
            var_2394.removeListItem(_loc3_);
            _loc3_ = (var_2394.getListItemByName("score_text") as ITextWindow);
            var_2394.removeListItem(_loc3_);
            _loc3_ = (var_2394.getListItemByName("score_value") as ITextWindow);
            var_2394.removeListItem(_loc3_);
        }

        override public function update(param1:RoomWidgetUserInfoUpdateEvent):void
        {
            clearBadges();
            setTags([]);
            this.updateButtons(param1);
            updateInfo(param1);
            updateWindow();
        }

        override protected function updateButtons(param1:RoomWidgetUserInfoUpdateEvent):void
        {
            showButton("friend", false);
            showButton("respect", false);
            showButton("ignore", false);
            showButton("unignore", false);
            showButton("kick", param1.canBeKicked);
            showButton("ban", false);
            showButton("whisper", false);
            updateRightsButton(false, false);
            showButton("trade", false);
            showButton("report", false);
            showButton("give_badge", false);
            var_2395.visible = param1.canBeKicked;
        }

        override protected function onButtonClicked(param1:WindowMouseEvent):void
        {
            var _loc3_:int;
            var _loc2_:IWindow = (param1.target as IWindow);
            if (_loc2_.name == "kick")
            {
                _loc3_ = _widget.userData.userRoomId;
                _widget.messageListener.processWidgetMessage(new RoomWidgetUserActionMessage(RoomWidgetUserActionMessage.var_2304, _loc3_));
            };
        }


    }
}