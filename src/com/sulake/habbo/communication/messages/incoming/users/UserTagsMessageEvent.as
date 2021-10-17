package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.UserTagsMessageParser;

    public class UserTagsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserTagsMessageEvent(param1:Function)
        {
            super(param1, UserTagsMessageParser);
        }

        public function get tags():Array
        {
            return ((var_334 as UserTagsMessageParser).tags);
        }

        public function get userId():int
        {
            return ((var_334 as UserTagsMessageParser).userId);
        }


    }
}