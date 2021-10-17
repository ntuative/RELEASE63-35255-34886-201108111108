package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class CatalogWidgetsInitializedEvent extends Event 
    {

        public function CatalogWidgetsInitializedEvent(param1:Boolean=false, param2:Boolean=false)
        {
            super(WidgetEvent.CWE_WIDGETS_INITIALIZED, param1, param2);
        }

    }
}