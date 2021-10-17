package com.sulake.habbo.toolbar.events
{
    import flash.events.Event;

    public class HabboToolbarEvent extends Event 
    {

        public static const var_48:String = "HTE_TOOLBAR_CLICK";

        private var var_3139:String;
        private var var_5087:String;

        public function HabboToolbarEvent(param1:String, param2:Boolean=false, param3:Boolean=false)
        {
            super(param1, param2, param3);
        }

        public function set iconId(param1:String):void
        {
            this.var_3139 = param1;
        }

        public function get iconId():String
        {
            return (this.var_3139);
        }

        public function set iconName(param1:String):void
        {
            this.var_5087 = param1;
        }

        public function get iconName():String
        {
            return (this.var_5087);
        }


    }
}