package com.sulake.habbo.roomevents.userdefinedroomevents.conditions
{
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.roomevents.userdefinedroomevents.common.SliderWindowController;
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs.*;

    public class StuffsInFormation implements ConditionType 
    {

        private var var_4942:HabboUserDefinedRoomEvents;
        private var _slider:SliderWindowController;


        public function get code():int
        {
            return (ConditionCodes.var_2472);
        }

        public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_BY_ID);
        }

        public function get hasStateSnapshot():Boolean
        {
            return (false);
        }

        public function readIntParamsFromForm(param1:IWindowContainer):Array
        {
            var _loc2_:Array = new Array();
            _loc2_.push(int(this._slider.getValue()));
            _loc2_.push(this.getFormationSelector(param1).getSelected().id);
            return (_loc2_);
        }

        public function readStringParamFromForm(param1:IWindowContainer):String
        {
            return ("");
        }

        public function onInit(param1:IWindowContainer, param2:HabboUserDefinedRoomEvents):void
        {
            this.var_4942 = param2;
            this._slider = new SliderWindowController(param2, this.getInput(param1), param2.assets, 2, 10, 1);
            this._slider.setValue(3);
            this._slider.addEventListener(Event.CHANGE, this.onSliderChange);
            param2.refreshButton(param1, "move_diag", true, null, 0);
            param2.refreshButton(param1, "move_vrt", true, null, 0);
        }

        public function onEditStart(param1:IWindowContainer, param2:Triggerable):void
        {
            this._slider.setValue(param2.intParams[0]);
            var _loc3_:int = param2.intParams[1];
            this.getFormationSelector(param1).setSelected(this.getFormationRadio(param1, _loc3_));
        }

        public function get hasSpecialInputs():Boolean
        {
            return (true);
        }

        private function getInput(param1:IWindowContainer):IWindowContainer
        {
            return (param1.findChildByName("slider_container") as IWindowContainer);
        }

        private function onSliderChange(param1:Event):void
        {
            var _loc2_:SliderWindowController;
            var _loc3_:Number;
            var _loc4_:int;
            if (param1.type == Event.CHANGE)
            {
                _loc2_ = (param1.target as SliderWindowController);
                if (_loc2_)
                {
                    _loc3_ = _loc2_.getValue();
                    _loc4_ = int(_loc3_);
                    this.var_4942.localization.registerParameter("wiredfurni.params.requiredformationsize", "furnis", ("" + _loc4_));
                };
            };
        }

        private function getFormationRadio(param1:IWindowContainer, param2:int):IRadioButtonWindow
        {
            return (IRadioButtonWindow(param1.findChildByName((("formation_" + param2) + "_radio"))));
        }

        private function getFormationSelector(param1:IWindowContainer):ISelectorWindow
        {
            return (ISelectorWindow(param1.findChildByName("formation_selector")));
        }


    }
}