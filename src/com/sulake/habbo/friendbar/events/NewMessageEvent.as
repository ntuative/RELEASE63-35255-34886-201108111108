package com.sulake.habbo.friendbar.events
{
    import flash.events.Event;

    public class NewMessageEvent extends Event 
    {

        public static const var_1308:String = "FBE_MESSAGE";

        public var notify:Boolean;
        public var senderId:int;

        public function NewMessageEvent(param1:Boolean, param2:int)
        {
            super(var_1308, false, false);
            this.notify = param1;
            this.senderId = param2;
        }

    }
}