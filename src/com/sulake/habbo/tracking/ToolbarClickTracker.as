package com.sulake.habbo.tracking
{
    import com.sulake.habbo.configuration.IHabboConfigurationManager;

    public class ToolbarClickTracker 
    {

        private var var_5163:IHabboTracking;
        private var var_3776:Boolean = false;
        private var var_5164:int = 0;
        private var var_5165:int = 0;

        public function ToolbarClickTracker(param1:IHabboTracking)
        {
            this.var_5163 = param1;
        }

        public function dispose():void
        {
            this.var_5163 = null;
        }

        public function configure(param1:IHabboConfigurationManager):void
        {
            this.var_3776 = Boolean(parseInt(param1.getKey("toolbar.tracking.enabled", "1")));
            this.var_5164 = parseInt(param1.getKey("toolbar.tracking.max.events", "100"));
        }

        public function track(param1:String):void
        {
            if (!this.var_3776)
            {
                return;
            };
            this.var_5165++;
            if (this.var_5165 <= this.var_5164)
            {
                this.var_5163.trackGoogle("toolbar", param1);
            };
        }


    }
}