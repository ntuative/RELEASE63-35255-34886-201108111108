package com.sulake.habbo.communication.messages.parser.facebook
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FaceBookErrorMessageParser implements IMessageParser 
    {


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            return (true);
        }


    }
}