package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.ISelectorWindow;

    public class MoveFurni implements ActionType 
    {


        public function get code():int
        {
            return (ActionTypeCodes.var_2453);
        }

        public function get allowDelaying():Boolean
        {
            return (true);
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
            param2.refreshButton(param1, "move_diag", true, null, 0);
            param2.refreshButton(param1, "move_rnd", true, null, 0);
            param2.refreshButton(param1, "move_vrt", true, null, 0);
            param2.refreshButton(param1, "rotate_ccw", true, null, 0);
            param2.refreshButton(param1, "rotate_cw", true, null, 0);
        }

        public function onEditStart(param1:IWindowContainer, param2:Triggerable):void
        {
            var _loc3_:int = param2.intParams[0];
            var _loc4_:int = param2.intParams[1];
            this.getMoveSelector(param1).setSelected(this.getMoveRadio(param1, _loc3_));
            this.getRotateSelector(param1).setSelected(this.getRotateRadio(param1, _loc4_));
        }

        public function readIntParamsFromForm(param1:IWindowContainer):Array
        {
            var _loc2_:Array = new Array();
            var _loc3_:int = this.getMoveSelector(param1).getSelected().id;
            var _loc4_:int = this.getRotateSelector(param1).getSelected().id;
            _loc2_.push(_loc3_);
            _loc2_.push(_loc4_);
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

        private function getMoveRadio(param1:IWindowContainer, param2:int):IRadioButtonWindow
        {
            return (IRadioButtonWindow(param1.findChildByName((("move_" + param2) + "_radio"))));
        }

        private function getRotateRadio(param1:IWindowContainer, param2:int):IRadioButtonWindow
        {
            return (IRadioButtonWindow(param1.findChildByName((("rotate_" + param2) + "_radio"))));
        }

        private function getMoveSelector(param1:IWindowContainer):ISelectorWindow
        {
            return (ISelectorWindow(param1.findChildByName("move_selector")));
        }

        private function getRotateSelector(param1:IWindowContainer):ISelectorWindow
        {
            return (ISelectorWindow(param1.findChildByName("rotate_selector")));
        }


    }
}