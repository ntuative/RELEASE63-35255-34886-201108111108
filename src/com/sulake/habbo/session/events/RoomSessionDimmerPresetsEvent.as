package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionDimmerPresetsEvent extends RoomSessionEvent 
    {

        public static const var_373:String = "RSDPE_PRESETS";

        private var _selectedPresetId:int = 0;
        private var _presets:Array = new Array();

        public function RoomSessionDimmerPresetsEvent(param1:String, param2:IRoomSession, param3:Boolean=false, param4:Boolean=false)
        {
            super(param1, param2, param3, param4);
        }

        public function get selectedPresetId():int
        {
            return (this._selectedPresetId);
        }

        public function get presetCount():int
        {
            return (this._presets.length);
        }

        public function set selectedPresetId(param1:int):void
        {
            this._selectedPresetId = param1;
        }

        public function storePreset(param1:int, param2:int, param3:int, param4:int):void
        {
            var _loc5_:RoomSessionDimmerPresetsEventPresetItem = new RoomSessionDimmerPresetsEventPresetItem(param1, param2, param3, param4);
            this._presets[(param1 - 1)] = _loc5_;
        }

        public function getPreset(param1:int):RoomSessionDimmerPresetsEventPresetItem
        {
            if (((param1 < 0) || (param1 >= this._presets.count)))
            {
                return (null);
            };
            return (this._presets[param1]);
        }


    }
}