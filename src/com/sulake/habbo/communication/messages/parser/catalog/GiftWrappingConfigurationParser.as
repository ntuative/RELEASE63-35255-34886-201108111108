package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GiftWrappingConfigurationParser implements IMessageParser 
    {

        private var var_3643:Boolean;
        private var var_3644:int;
        private var var_3147:Array;
        private var var_3148:Array;
        private var var_3149:Array;


        public function get isWrappingEnabled():Boolean
        {
            return (this.var_3643);
        }

        public function get wrappingPrice():int
        {
            return (this.var_3644);
        }

        public function get stuffTypes():Array
        {
            return (this.var_3147);
        }

        public function get boxTypes():Array
        {
            return (this.var_3148);
        }

        public function get ribbonTypes():Array
        {
            return (this.var_3149);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc2_:int;
            this.var_3147 = [];
            this.var_3148 = [];
            this.var_3149 = [];
            this.var_3643 = param1.readBoolean();
            this.var_3644 = param1.readInteger();
            var _loc3_:int = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < _loc3_)
            {
                this.var_3147.push(param1.readInteger());
                _loc2_++;
            };
            _loc3_ = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < _loc3_)
            {
                this.var_3148.push(param1.readInteger());
                _loc2_++;
            };
            _loc3_ = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < _loc3_)
            {
                this.var_3149.push(param1.readInteger());
                _loc2_++;
            };
            return (true);
        }


    }
}