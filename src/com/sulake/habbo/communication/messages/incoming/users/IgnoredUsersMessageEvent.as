package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.IgnoredUsersMessageParser;

    public class IgnoredUsersMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function IgnoredUsersMessageEvent(param1:Function)
        {
            super(param1, IgnoredUsersMessageParser);
        }

        public function get ignoredUsers():Array
        {
            return ((var_334 as IgnoredUsersMessageParser).ignoredUsers);
        }


    }
}