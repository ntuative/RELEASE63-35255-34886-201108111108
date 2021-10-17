package com.sulake.core.runtime
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IID;

    internal class ComponentInterfaceQueue implements IDisposable 
    {

        private var var_2620:IID;
        private var var_1023:Boolean;
        private var var_2621:Array;

        public function ComponentInterfaceQueue(param1:IID)
        {
            this.var_2620 = param1;
            this.var_2621 = new Array();
            this.var_1023 = false;
        }

        public function get identifier():IID
        {
            return (this.var_2620);
        }

        public function get disposed():Boolean
        {
            return (this.var_1023);
        }

        public function get receivers():Array
        {
            return (this.var_2621);
        }

        public function dispose():void
        {
            if (!this.var_1023)
            {
                this.var_1023 = true;
                this.var_2620 = null;
                while (this.var_2621.length > 0)
                {
                    this.var_2621.pop();
                };
                this.var_2621 = null;
            };
        }


    }
}