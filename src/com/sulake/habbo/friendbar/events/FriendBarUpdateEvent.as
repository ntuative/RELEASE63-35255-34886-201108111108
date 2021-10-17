package com.sulake.habbo.friendbar.events
{
    import flash.events.Event;

    public class FriendBarUpdateEvent extends Event 
    {

        public static const var_1306:String = "FBE_UPDATED";

        public function FriendBarUpdateEvent()
        {
            super(var_1306, false, false);
        }

    }
}