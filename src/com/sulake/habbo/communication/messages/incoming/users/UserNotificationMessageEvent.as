package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.UserNotificationParser;

    public class UserNotificationMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserNotificationMessageEvent(param1:Function)
        {
            super(param1, UserNotificationParser);
        }

        public function get title():String
        {
            return (UserNotificationParser(var_334).title);
        }

        public function get message():String
        {
            return (UserNotificationParser(var_334).message);
        }

        public function get parameters():Array
        {
            return (UserNotificationParser(var_334).parameters);
        }


    }
}