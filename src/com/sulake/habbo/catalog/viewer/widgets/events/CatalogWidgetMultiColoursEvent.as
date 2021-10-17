package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class CatalogWidgetMultiColoursEvent extends Event 
    {

        private var var_3187:Array;
        private var var_3188:String;
        private var var_3189:String;
        private var var_3190:String;

        public function CatalogWidgetMultiColoursEvent(param1:Array, param2:String, param3:String, param4:String, param5:Boolean=false, param6:Boolean=false)
        {
            super(WidgetEvent.CWE_MULTI_COLOUR_ARRAY, param5, param6);
            this.var_3187 = param1;
            this.var_3188 = param2;
            this.var_3189 = param3;
            this.var_3190 = param4;
        }

        public function get colours():Array
        {
            return (this.var_3187);
        }

        public function get backgroundAssetName():String
        {
            return (this.var_3188);
        }

        public function get colourAssetName():String
        {
            return (this.var_3189);
        }

        public function get chosenColourAssetName():String
        {
            return (this.var_3190);
        }


    }
}