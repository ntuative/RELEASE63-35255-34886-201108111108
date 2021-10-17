package com.sulake.habbo.friendbar.view.tabs.tokens
{
    import com.sulake.habbo.friendbar.data.IFriendEntity;
    import com.sulake.habbo.friendbar.data.FriendNotification;

    public class RoomEventToken extends Token 
    {

        public function RoomEventToken(param1:IFriendEntity, param2:FriendNotification, param3:Boolean)
        {
            super(param2);
            prepare("${friendbar.notify.event}", param2.message, "message_piece_xml", "event_notification_icon_png", "small_event_notification_icon_png", param3);
        }

    }
}