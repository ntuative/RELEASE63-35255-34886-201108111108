package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import flash.utils.Dictionary;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ActivityPointsMessageParser implements IMessageParser 
    {

        private var var_3514:Dictionary;


        public function flush():Boolean
        {
            this.var_3514 = new Dictionary();
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc4_:int;
            var _loc5_:int;
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                _loc4_ = param1.readInteger();
                _loc5_ = param1.readInteger();
                this.var_3514[_loc4_] = _loc5_;
                _loc3_++;
            };
            return (true);
        }

        public function get points():Dictionary
        {
            return (this.var_3514);
        }


    }
}