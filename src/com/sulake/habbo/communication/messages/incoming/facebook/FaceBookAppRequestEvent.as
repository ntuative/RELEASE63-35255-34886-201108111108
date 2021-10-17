package com.sulake.habbo.communication.messages.incoming.facebook
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.facebook.FaceBookAppRequestMessageParser;

    public class FaceBookAppRequestEvent extends MessageEvent implements IMessageEvent 
    {

        public function FaceBookAppRequestEvent(param1:Function)
        {
            super(param1, FaceBookAppRequestMessageParser);
        }

        public function getParser():FaceBookAppRequestMessageParser
        {
            return (var_334 as FaceBookAppRequestMessageParser);
        }


    }
}