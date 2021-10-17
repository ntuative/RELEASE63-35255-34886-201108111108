package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.IdentityAccountsMessageParser;

    public class IdentityAccountsEvent extends MessageEvent implements IMessageEvent 
    {

        public function IdentityAccountsEvent(param1:Function)
        {
            super(param1, IdentityAccountsMessageParser);
        }

        public function getParser():IdentityAccountsMessageParser
        {
            return (this.var_334 as IdentityAccountsMessageParser);
        }


    }
}