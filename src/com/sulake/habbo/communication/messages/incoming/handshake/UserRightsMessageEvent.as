package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.UserRightsMessageParser;

    public class UserRightsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserRightsMessageEvent(param1:Function)
        {
            super(param1, UserRightsMessageParser);
        }

        public function get clubLevel():int
        {
            return ((this.var_334 as UserRightsMessageParser).clubLevel);
        }

        public function get securityLevel():int
        {
            return ((this.var_334 as UserRightsMessageParser).securityLevel);
        }


    }
}