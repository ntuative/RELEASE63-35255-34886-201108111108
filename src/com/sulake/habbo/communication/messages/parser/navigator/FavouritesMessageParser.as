package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FavouritesMessageParser implements IMessageParser 
    {

        private var var_3706:int;
        private var var_3763:Array;


        public function flush():Boolean
        {
            this.var_3763 = new Array();
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3706 = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_3763.push(param1.readInteger());
                _loc3_++;
            };
            return (true);
        }

        public function get limit():int
        {
            return (this.var_3706);
        }

        public function get favouriteRoomIds():Array
        {
            return (this.var_3763);
        }


    }
}