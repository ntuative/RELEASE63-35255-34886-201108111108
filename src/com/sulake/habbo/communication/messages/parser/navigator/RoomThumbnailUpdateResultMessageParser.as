package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomThumbnailUpdateResultMessageParser implements IMessageParser 
    {

        private var var_3465:int;
        private var var_3640:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3465 = param1.readInteger();
            this.var_3640 = param1.readInteger();
            return (true);
        }

        public function get flatId():int
        {
            return (this.var_3465);
        }

        public function get resultCode():int
        {
            return (this.var_3640);
        }


    }
}