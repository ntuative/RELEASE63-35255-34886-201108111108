package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.SecretKeyMessageParser;

    public class SecretKeyEvent extends MessageEvent implements IMessageEvent 
    {

        public function SecretKeyEvent(param1:Function)
        {
            super(param1, SecretKeyMessageParser);
        }

        public function get serverPublicKey():String
        {
            return ((this.var_334 as SecretKeyMessageParser).serverPublicKey);
        }


    }
}