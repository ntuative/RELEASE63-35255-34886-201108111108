package com.sulake.habbo.communication.messages.incoming.facebook
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.facebook.FaceBookErrorMessageParser;

    public class FaceBookErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function FaceBookErrorEvent(param1:Function)
        {
            super(param1, FaceBookErrorMessageParser);
        }

        public function getParser():FaceBookErrorMessageParser
        {
            return (var_334 as FaceBookErrorMessageParser);
        }


    }
}