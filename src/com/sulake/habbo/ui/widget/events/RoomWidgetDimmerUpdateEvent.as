package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetDimmerUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1683:String = "RWDUE_PRESETS";
        public static const var_1684:String = "RWDUE_HIDE";

        private var _selectedPresetId:int = 0;
        private var _presets:Array = new Array();

        public function RoomWidgetDimmerUpdateEvent(param1:String, param2:Boolean=false, param3:Boolean=false)
        {
            super(param1, param2, param3);
        }

        public function get selectedPresetId():int
        {
            return (this._selectedPresetId);
        }

        public function get presetCount():int
        {
            return (this._presets.length);
        }

        public function get presets():Array
        {
            return (this._presets);
        }

        public function set selectedPresetId(param1:int):void
        {
            this._selectedPresetId = param1;
        }

        public function storePreset(param1:int, param2:int, param3:int, param4:int):void
        {
            var _loc5_:RoomWidgetDimmerUpdateEventPresetItem = new RoomWidgetDimmerUpdateEventPresetItem(param1, param2, param3, param4);
            this._presets[(param1 - 1)] = _loc5_;
        }

        public function getPreset(param1:int):RoomWidgetDimmerUpdateEventPresetItem
        {
            if (((param1 < 0) || (param1 >= this._presets.count)))
            {
                return (null);
            };
            return (this._presets[param1]);
        }


    }
}