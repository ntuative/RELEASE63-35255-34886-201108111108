package com.sulake.habbo.friendbar.view.tabs.tokens
{
    import com.sulake.habbo.friendbar.data.IFriendEntity;
    import com.sulake.habbo.friendbar.data.FriendNotification;

    public class MessengerToken extends Token 
    {

        public function MessengerToken(param1:IFriendEntity, param2:FriendNotification, param3:Boolean)
        {
            super(param2);
            prepare("${friendbar.notify.messenger}", param2.message, "message_piece_xml", "imnew_notification_icon_png", "small_imnew_notification_icon_png", param3);
        }

    }
}