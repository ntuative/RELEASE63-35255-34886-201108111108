package com.sulake.habbo.friendbar.events
{
    import flash.events.Event;
    import com.sulake.habbo.friendbar.data.FriendNotification;

    public class NotificationEvent extends Event 
    {

        public static const var_1309:String = "FBE_NOTIFICATION_EVENT";

        public var friendId:int;
        public var notification:FriendNotification;

        public function NotificationEvent(param1:int, param2:FriendNotification)
        {
            super(var_1309);
            this.friendId = param1;
            this.notification = param2;
        }

    }
}