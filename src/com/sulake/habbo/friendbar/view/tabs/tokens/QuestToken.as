package com.sulake.habbo.friendbar.view.tabs.tokens
{
    import com.sulake.habbo.friendbar.data.IFriendEntity;
    import com.sulake.habbo.friendbar.data.FriendNotification;
    import com.sulake.habbo.localization.IHabboLocalizationManager;

    public class QuestToken extends Token 
    {

        public function QuestToken(param1:IFriendEntity, param2:FriendNotification, param3:Boolean, param4:IHabboLocalizationManager)
        {
            super(param2);
            var _loc5_:* = (("${quests." + param2.message) + ".name}");
            prepare("${friendbar.notify.quest}", _loc5_, "message_piece_xml", "event_notification_icon_png", "small_ach_notification_icon_png", param3);
        }

    }
}