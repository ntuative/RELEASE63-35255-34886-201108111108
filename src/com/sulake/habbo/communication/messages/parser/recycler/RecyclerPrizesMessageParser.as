package com.sulake.habbo.communication.messages.parser.recycler
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.recycler.PrizeLevelMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RecyclerPrizesMessageParser implements IMessageParser 
    {

        private var var_3792:Array;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc2_:int = param1.readInteger();
            this.var_3792 = new Array();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_3792.push(new PrizeLevelMessageData(param1));
                _loc3_++;
            };
            return (true);
        }

        public function get prizeLevels():Array
        {
            return (this.var_3792);
        }


    }
}