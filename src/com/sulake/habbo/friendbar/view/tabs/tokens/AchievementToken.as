package com.sulake.habbo.friendbar.view.tabs.tokens
{
    import com.sulake.habbo.friendbar.data.IFriendEntity;
    import com.sulake.habbo.friendbar.data.FriendNotification;
    import com.sulake.habbo.localization.IHabboLocalizationManager;

    public class AchievementToken extends Token 
    {

        public function AchievementToken(param1:IFriendEntity, param2:FriendNotification, param3:Boolean, param4:IHabboLocalizationManager)
        {
            super(param2);
            var _loc5_:String = param4.getBadgeName(param2.message);
            prepare("${friendbar.notify.achievement}", _loc5_, "message_piece_xml", "event_notification_icon_png", "small_ach_notification_icon_png", param3);
        }

    }
}