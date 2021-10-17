package com.sulake.core.assets.loaders
{
    import flash.events.Event;

    public class AssetLoaderEvent extends Event 
    {

        public static const ASSET_LOADER_EVENT_COMPLETE:String = "AssetLoaderEventComplete";
        public static const var_88:String = "AssetLoaderEventProgress";
        public static const var_89:String = "AssetLoaderEventUnload";
        public static const var_90:String = "AssetLoaderEventStatus";
        public static const var_34:String = "AssetLoaderEventError";
        public static const var_91:String = "AssetLoaderEventOpen";

        private var var_2549:int;

        public function AssetLoaderEvent(param1:String, param2:int)
        {
            this.var_2549 = param2;
            super(param1, false, false);
        }

        public function get status():int
        {
            return (this.var_2549);
        }

        override public function clone():Event
        {
            return (new AssetLoaderEvent(type, this.var_2549));
        }

        override public function toString():String
        {
            return (formatToString("AssetLoaderEvent", "type", "status"));
        }


    }
}