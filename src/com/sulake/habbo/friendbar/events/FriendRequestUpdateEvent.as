package com.sulake.habbo.friendbar.events
{
    import flash.events.Event;

    public class FriendRequestUpdateEvent extends Event 
    {

        public static const var_1307:String = "FBE_REQUESTS";

        public function FriendRequestUpdateEvent()
        {
            super(var_1307, false, false);
        }

    }
}