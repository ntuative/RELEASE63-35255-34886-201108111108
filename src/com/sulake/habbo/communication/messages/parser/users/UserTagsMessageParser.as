package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserTagsMessageParser implements IMessageParser 
    {

        protected var var_1209:Array = [];
        protected var _userId:int = 0;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_1209 = [];
            this._userId = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_1209.push(param1.readString());
                _loc3_++;
            };
            return (true);
        }

        public function get tags():Array
        {
            return (this.var_1209.slice());
        }

        public function get userId():int
        {
            return (this._userId);
        }


    }
}