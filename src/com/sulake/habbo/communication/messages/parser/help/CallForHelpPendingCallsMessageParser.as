package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CallForHelpPendingCallsMessageParser implements IMessageParser 
    {

        private var var_3694:Array = new Array();


        public function get callArray():Array
        {
            return (this.var_3694);
        }

        public function get callCount():int
        {
            return (this.var_3694.length);
        }

        public function flush():Boolean
        {
            this.var_3694 = new Array();
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc3_:int;
            var _loc4_:Object;
            this.var_3694 = new Array();
            var _loc2_:int = param1.readInteger();
            while (_loc3_ < _loc2_)
            {
                _loc4_ = new Object();
                _loc4_.callId = param1.readString();
                _loc4_.timeStamp = param1.readString();
                _loc4_.message = param1.readString();
                this.var_3694.push(_loc4_);
                _loc3_++;
            };
            return (true);
        }


    }
}