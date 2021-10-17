package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public class StuffCaught implements TriggerConf 
    {


        public function get code():int
        {
            return (TriggerConfCodes.var_2443);
        }

        public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_NONE);
        }

        public function get hasStateSnapshot():Boolean
        {
            return (false);
        }

        public function readIntParamsFromForm(param1:IWindowContainer):Array
        {
            return (new Array());
        }

        public function readStringParamFromForm(param1:IWindowContainer):String
        {
            return ("");
        }

        public function onInit(param1:IWindowContainer, param2:HabboUserDefinedRoomEvents):void
        {
        }

        public function onEditStart(param1:IWindowContainer, param2:Triggerable):void
        {
        }

        public function get hasSpecialInputs():Boolean
        {
            return (false);
        }


    }
}