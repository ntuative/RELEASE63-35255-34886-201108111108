package com.sulake.habbo.ui
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.ui.widget.IRoomWidget;

    public interface IRoomWidgetFactory extends IUnknown 
    {

        function createWidget(param1:String, param2:IRoomWidgetHandler):IRoomWidget;

    }
}