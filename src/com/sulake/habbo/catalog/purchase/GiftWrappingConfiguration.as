package com.sulake.habbo.catalog.purchase
{
    import com.sulake.habbo.communication.messages.parser.catalog.GiftWrappingConfigurationParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.GiftWrappingConfigurationEvent;

    public class GiftWrappingConfiguration 
    {

        private var var_2996:Boolean = false;
        private var var_3084:int;
        private var var_3147:Array;
        private var var_3148:Array;
        private var var_3149:Array;

        public function GiftWrappingConfiguration(param1:GiftWrappingConfigurationEvent)
        {
            if (param1 == null)
            {
                return;
            };
            var _loc2_:GiftWrappingConfigurationParser = param1.getParser();
            if (_loc2_ == null)
            {
                return;
            };
            this.var_2996 = _loc2_.isWrappingEnabled;
            this.var_3084 = _loc2_.wrappingPrice;
            this.var_3147 = _loc2_.stuffTypes;
            this.var_3148 = _loc2_.boxTypes;
            this.var_3149 = _loc2_.ribbonTypes;
        }

        public function get isEnabled():Boolean
        {
            return (this.var_2996);
        }

        public function get price():int
        {
            return (this.var_3084);
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


    }
}