package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs
{
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.roomevents.userdefinedroomevents.common.SliderWindowController;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public class TriggerOnce implements TriggerConf 
    {

        private var var_4942:HabboUserDefinedRoomEvents;
        private var _slider:SliderWindowController;


        public static function preparePulseSelection(param1:IWindowContainer, param2:IDropMenuWindow):void
        {
            var _loc3_:Array = new Array();
            var _loc4_:int = 10;
            var _loc5_:int;
            while (_loc5_ <= _loc4_)
            {
                if (_loc5_ != 0)
                {
                    _loc3_.push((("at " + _loc5_) + " secs"));
                };
                _loc3_.push((("at " + _loc5_) + ".5 secs"));
                _loc5_++;
            };
            if (param2)
            {
                param2.populate(_loc3_);
                param2.selection = 0;
            };
        }

        public static function getSecsFromPulses(param1:int):String
        {
            var _loc2_:int = int(Math.floor((param1 / 2)));
            if ((param1 % 2) == 0)
            {
                return ("" + _loc2_);
            };
            return (_loc2_ + ".5");
        }


        public function get code():int
        {
            return (TriggerConfCodes.var_1864);
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
            return (_loc2_);
        }

        public function readStringParamFromForm(param1:IWindowContainer):String
        {
            return ("");
        }

        public function onInit(param1:IWindowContainer, param2:HabboUserDefinedRoomEvents):void
        {
            this.var_4942 = param2;
            this._slider = new SliderWindowController(param2, this.getInput(param1), param2.assets, 1, 1200, 1);
            this._slider.setValue(1);
            this._slider.addEventListener(Event.CHANGE, this.onSliderChange);
        }

        public function onEditStart(param1:IWindowContainer, param2:Triggerable):void
        {
            var _loc3_:int = param2.intParams[0];
            this._slider.setValue(_loc3_);
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
            var _loc5_:String;
            if (param1.type == Event.CHANGE)
            {
                _loc2_ = (param1.target as SliderWindowController);
                if (_loc2_)
                {
                    _loc3_ = _loc2_.getValue();
                    _loc4_ = int(_loc3_);
                    _loc5_ = TriggerOnce.getSecsFromPulses(_loc4_);
                    this.var_4942.localization.registerParameter("wiredfurni.params.settime", "seconds", _loc5_);
                };
            };
        }


    }
}