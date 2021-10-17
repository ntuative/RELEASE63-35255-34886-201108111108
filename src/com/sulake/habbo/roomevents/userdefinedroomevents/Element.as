package com.sulake.habbo.roomevents.userdefinedroomevents
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public interface Element 
    {

        function get code():int;
        function get requiresFurni():int;
        function onInit(param1:IWindowContainer, param2:HabboUserDefinedRoomEvents):void;
        function onEditStart(param1:IWindowContainer, param2:Triggerable):void;
        function readIntParamsFromForm(param1:IWindowContainer):Array;
        function readStringParamFromForm(param1:IWindowContainer):String;
        function get hasSpecialInputs():Boolean;
        function get hasStateSnapshot():Boolean;

    }
}