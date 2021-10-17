package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;

    public class SpecialInfoWidget extends CatalogWidget implements ICatalogWidget 
    {

        public function SpecialInfoWidget(param1:IWindowContainer)
        {
            super(param1);
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT, this.onPreviewProduct);
            return (true);
        }

        private function onPreviewProduct(param1:SelectProductEvent):void
        {
            if (param1 == null)
            {
                return;
            };
            _window.visible = false;
        }


    }
}