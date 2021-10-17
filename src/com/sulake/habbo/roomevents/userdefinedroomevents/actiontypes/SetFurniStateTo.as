package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.ICheckBoxWindow;

    public class SetFurniStateTo implements ActionType 
    {


        public function get code():int
        {
            return (ActionTypeCodes.var_2456);
        }

        public function get allowDelaying():Boolean
        {
            return (true);
        }

        public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_BY_ID);
        }

        public function get hasStateSnapshot():Boolean
        {
            return (true);
        }

        public function onInit(param1:IWindowContainer, param2:HabboUserDefinedRoomEvents):void
        {
        }

        public function onEditStart(param1:IWindowContainer, param2:Triggerable):void
        {
            this.select(this.getStateInput(param1), param2.getBoolean(0));
            this.select(this.getRotationInput(param1), param2.getBoolean(1));
            this.select(this.getLocationInput(param1), param2.getBoolean(2));
        }

        private function select(param1:ICheckBoxWindow, param2:Boolean):void
        {
            if (param2)
            {
                param1.select();
            }
            else
            {
                param1.unselect();
            };
        }

        public function readIntParamsFromForm(param1:IWindowContainer):Array
        {
            var _loc2_:Array = new Array();
            _loc2_.push(this.getIntState(this.getStateInput(param1)));
            _loc2_.push(this.getIntState(this.getRotationInput(param1)));
            _loc2_.push(this.getIntState(this.getLocationInput(param1)));
            return (_loc2_);
        }

        public function readStringParamFromForm(param1:IWindowContainer):String
        {
            return ("");
        }

        private function getIntState(param1:ICheckBoxWindow):int
        {
            return ((param1.isSelected) ? 1 : 0);
        }

        public function get hasSpecialInputs():Boolean
        {
            return (true);
        }

        private function getStateInput(param1:IWindowContainer):ICheckBoxWindow
        {
            return (ICheckBoxWindow(param1.findChildByName("include_state_checkbox")));
        }

        private function getRotationInput(param1:IWindowContainer):ICheckBoxWindow
        {
            return (ICheckBoxWindow(param1.findChildByName("include_rotation_checkbox")));
        }

        private function getLocationInput(param1:IWindowContainer):ICheckBoxWindow
        {
            return (ICheckBoxWindow(param1.findChildByName("include_location_checkbox")));
        }


    }
}