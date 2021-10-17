package com.sulake.habbo.roomevents.userdefinedroomevents
{
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public interface ElementTypeHolder 
    {

        function getElementByCode(param1:int):Element;
        function getKey():String;
        function acceptTriggerable(param1:Triggerable):Boolean;

    }
}