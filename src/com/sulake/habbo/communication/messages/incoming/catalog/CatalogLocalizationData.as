package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CatalogLocalizationData 
    {

        private var _images:Array;
        private var var_3300:Array;

        public function CatalogLocalizationData(param1:IMessageDataWrapper)
        {
            this._images = new Array();
            this.var_3300 = new Array();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this._images.push(param1.readString());
                _loc3_++;
            };
            var _loc4_:int = param1.readInteger();
            var _loc5_:int;
            while (_loc5_ < _loc4_)
            {
                this.var_3300.push(param1.readString());
                _loc5_++;
            };
        }

        public function get images():Array
        {
            return (this._images);
        }

        public function get texts():Array
        {
            return (this.var_3300);
        }


    }
}