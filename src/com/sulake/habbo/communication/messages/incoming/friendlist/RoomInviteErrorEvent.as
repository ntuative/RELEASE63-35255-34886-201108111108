package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteErrorMessageParser;

    public class RoomInviteErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomInviteErrorEvent(param1:Function)
        {
            super(param1, RoomInviteErrorMessageParser);
        }

        public function getParser():RoomInviteErrorMessageParser
        {
            return (this.var_334 as RoomInviteErrorMessageParser);
        }


    }
}