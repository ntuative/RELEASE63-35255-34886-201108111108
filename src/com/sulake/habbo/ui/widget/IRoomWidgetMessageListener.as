﻿package com.sulake.habbo.ui.widget
{
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;

    public interface IRoomWidgetMessageListener 
    {

        function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent;

    }
}