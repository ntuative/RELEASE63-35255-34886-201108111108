package com.sulake.habbo.communication.messages.parser.room.permissions
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class YouAreNotControllerMessageParser implements IMessageParser 
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