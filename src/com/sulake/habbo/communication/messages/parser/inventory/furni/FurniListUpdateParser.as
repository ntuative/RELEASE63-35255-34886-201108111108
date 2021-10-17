package com.sulake.habbo.communication.messages.parser.inventory.furni
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FurniListUpdateParser implements IMessageParser 
    {


        public function parse(param1:IMessageDataWrapper):Boolean
        {
            return (true);
        }

        public function flush():Boolean
        {
            return (true);
        }


    }
}