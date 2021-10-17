package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class CatalogWidgetColourIndexEvent extends Event 
    {

        private var _index:int = 0;

        public function CatalogWidgetColourIndexEvent(param1:int, param2:Boolean=false, param3:Boolean=false)
        {
            super(WidgetEvent.CWE_COLOUR_INDEX, param2, param3);
            this._index = param1;
        }

        public function get index():int
        {
            return (this._index);
        }


    }
}