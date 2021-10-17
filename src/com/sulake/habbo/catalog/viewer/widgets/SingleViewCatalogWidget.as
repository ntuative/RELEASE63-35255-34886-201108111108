package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetsInitializedEvent;

    public class SingleViewCatalogWidget extends ProductViewCatalogWidget implements ICatalogWidget 
    {

        public function SingleViewCatalogWidget(param1:IWindowContainer)
        {
            super(param1);
        }

        override public function dispose():void
        {
            super.dispose();
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            events.addEventListener(WidgetEvent.CWE_WIDGETS_INITIALIZED, this.onWidgetsInitialized);
            return (true);
        }

        public function onWidgetsInitialized(param1:CatalogWidgetsInitializedEvent):void
        {
            if (page.offers.length == 0)
            {
                return;
            };
            var _loc2_:Offer = page.offers[0];
            events.dispatchEvent(new SelectProductEvent(_loc2_));
        }


    }
}