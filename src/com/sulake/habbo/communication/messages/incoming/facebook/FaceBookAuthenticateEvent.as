package com.sulake.habbo.communication.messages.incoming.facebook
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.facebook.FaceBookAuthenticateMessageParser;

    public class FaceBookAuthenticateEvent extends MessageEvent implements IMessageEvent 
    {

        public function FaceBookAuthenticateEvent(param1:Function)
        {
            super(param1, FaceBookAuthenticateMessageParser);
        }

        public function getParser():FaceBookAuthenticateMessageParser
        {
            return (var_334 as FaceBookAuthenticateMessageParser);
        }


    }
}