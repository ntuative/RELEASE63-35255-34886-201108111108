package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.FindFriendsProcessResultMessageParser;

    public class FindFriendsProcessResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function FindFriendsProcessResultEvent(param1:Function)
        {
            super(param1, FindFriendsProcessResultMessageParser);
        }

        public function get success():Boolean
        {
            return (FindFriendsProcessResultMessageParser(var_334).success);
        }


    }
}