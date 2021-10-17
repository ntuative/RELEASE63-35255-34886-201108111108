package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.ISelectorWindow;

    public class MoveToDirection implements ActionType 
    {


        public function get code():int
        {
            return (ActionTypeCodes.var_2461);
        }

        public function get allowDelaying():Boolean
        {
            return (false);
        }

        public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.var_647);
        }

        public function get hasStateSnapshot():Boolean
        {
            return (false);
        }

        public function onInit(param1:IWindowContainer, param2:HabboUserDefinedRoomEvents):void
        {
            param2.refreshButton(param1, "move_0", true, null, 0);
            param2.refreshButton(param1, "move_2", true, null, 0);
            param2.refreshButton(param1, "move_4", true, null, 0);
            param2.refreshButton(param1, "move_6", true, null, 0);
        }

        public function onEditStart(param1:IWindowContainer, param2:Triggerable):void
        {
            var _loc3_:int = param2.intParams[0];
            var _loc4_:int = param2.intParams[1];
            this.getStartDirSelector(param1).setSelected(this.getStartDirRadio(param1, _loc3_));
            this.getTurnSelector(param1).setSelected(this.getTurnRadio(param1, _loc4_));
        }

        public function readIntParamsFromForm(param1:IWindowContainer):Array
        {
            var _loc2_:Array = new Array();
            _loc2_.push(this.getStartDirSelector(param1).getSelected().id);
            _loc2_.push(this.getTurnSelector(param1).getSelected().id);
            return (_loc2_);
        }

        public function readStringParamFromForm(param1:IWindowContainer):String
        {
            return ("");
        }

        public function get hasSpecialInputs():Boolean
        {
            return (true);
        }

        private function getStartDirRadio(param1:IWindowContainer, param2:int):IRadioButtonWindow
        {
            return (IRadioButtonWindow(param1.findChildByName((("startdir_" + param2) + "_radio"))));
        }

        private function getTurnRadio(param1:IWindowContainer, param2:int):IRadioButtonWindow
        {
            return (IRadioButtonWindow(param1.findChildByName((("turn_" + param2) + "_radio"))));
        }

        private function getStartDirSelector(param1:IWindowContainer):ISelectorWindow
        {
            return (ISelectorWindow(param1.findChildByName("startdir_selector")));
        }

        private function getTurnSelector(param1:IWindowContainer):ISelectorWindow
        {
            return (ISelectorWindow(param1.findChildByName("turn_selector")));
        }


    }
}