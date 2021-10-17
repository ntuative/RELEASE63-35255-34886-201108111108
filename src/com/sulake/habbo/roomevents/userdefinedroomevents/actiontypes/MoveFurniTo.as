package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.roomevents.userdefinedroomevents.common.SliderWindowController;
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.ISelectorWindow;

    public class MoveFurniTo implements ActionType 
    {

        private var var_4942:HabboUserDefinedRoomEvents;
        private var _slider:SliderWindowController;


        public function get code():int
        {
            return (ActionTypeCodes.var_2463);
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

        public function readIntParamsFromForm(param1:IWindowContainer):Array
        {
            var _loc2_:Array = new Array();
            _loc2_.push(this.getDirectionSelector(param1).getSelected().id);
            _loc2_.push(int(this._slider.getValue()));
            return (_loc2_);
        }

        public function readStringParamFromForm(param1:IWindowContainer):String
        {
            return ("");
        }

        public function onInit(param1:IWindowContainer, param2:HabboUserDefinedRoomEvents):void
        {
            this.var_4942 = param2;
            this._slider = new SliderWindowController(param2, this.getInput(param1), param2.assets, 1, 5, 1);
            this._slider.setValue(1);
            this._slider.addEventListener(Event.CHANGE, this.onSliderChange);
            param2.refreshButton(param1, "move_0", true, null, 0);
            param2.refreshButton(param1, "move_2", true, null, 0);
            param2.refreshButton(param1, "move_4", true, null, 0);
            param2.refreshButton(param1, "move_6", true, null, 0);
        }

        public function onEditStart(param1:IWindowContainer, param2:Triggerable):void
        {
            var _loc3_:int = param2.intParams[0];
            this.getDirectionSelector(param1).setSelected(this.getDirectionRadio(param1, _loc3_));
            this._slider.setValue(param2.intParams[1]);
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
                    this.var_4942.localization.registerParameter("wiredfurni.params.emptytiles", "tiles", ("" + _loc4_));
                };
            };
        }

        private function getDirectionRadio(param1:IWindowContainer, param2:int):IRadioButtonWindow
        {
            return (IRadioButtonWindow(param1.findChildByName((("direction_" + param2) + "_radio"))));
        }

        private function getDirectionSelector(param1:IWindowContainer):ISelectorWindow
        {
            return (ISelectorWindow(param1.findChildByName("direction_selector")));
        }


    }
}