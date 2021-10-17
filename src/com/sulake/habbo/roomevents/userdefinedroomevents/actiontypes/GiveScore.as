package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.roomevents.userdefinedroomevents.common.SliderWindowController;
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public class GiveScore implements ActionType 
    {

        private var var_4942:HabboUserDefinedRoomEvents;
        private var _slider:SliderWindowController;
        private var var_4943:SliderWindowController;


        public function get code():int
        {
            return (ActionTypeCodes.var_2454);
        }

        public function get allowDelaying():Boolean
        {
            return (false);
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
            var _loc2_:Array = new Array();
            _loc2_.push(this._slider.getValue());
            _loc2_.push(this.var_4943.getValue());
            return (_loc2_);
        }

        public function readStringParamFromForm(param1:IWindowContainer):String
        {
            return ("");
        }

        public function onInit(param1:IWindowContainer, param2:HabboUserDefinedRoomEvents):void
        {
            this.var_4942 = param2;
            this._slider = new SliderWindowController(param2, this.getInput(param1), param2.assets, 1, 100, 1);
            this._slider.addEventListener(Event.CHANGE, this.onSliderChange);
            this._slider.setValue(1);
            this.var_4943 = new SliderWindowController(param2, this.getCounterInput(param1), param2.assets, 1, 10, 1);
            this.var_4943.addEventListener(Event.CHANGE, this.onCounterSliderChange);
            this.var_4943.setValue(1);
        }

        public function onEditStart(param1:IWindowContainer, param2:Triggerable):void
        {
            var _loc3_:int = param2.intParams[0];
            var _loc4_:int = param2.intParams[1];
            this._slider.setValue(_loc3_);
            this.var_4943.setValue(_loc4_);
        }

        public function get hasSpecialInputs():Boolean
        {
            return (true);
        }

        private function getInput(param1:IWindowContainer):IWindowContainer
        {
            return (param1.findChildByName("slider_container") as IWindowContainer);
        }

        private function getCounterInput(param1:IWindowContainer):IWindowContainer
        {
            return (param1.findChildByName("counter_slider_container") as IWindowContainer);
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
                    this.var_4942.localization.registerParameter("wiredfurni.params.setpoints", "points", ("" + _loc4_));
                };
            };
        }

        private function onCounterSliderChange(param1:Event):void
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
                    this.var_4942.localization.registerParameter("wiredfurni.params.settimesingame", "times", ("" + _loc4_));
                };
            };
        }


    }
}