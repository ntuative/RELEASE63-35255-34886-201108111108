package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomDimmerPresetsMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomDimmerPresetsMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _selectedPresetId:int = 0;
        private var _presets:Array = [];


        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function get presetCount():int
        {
            return (this._presets.length);
        }

        public function get selectedPresetId():int
        {
            return (this._selectedPresetId);
        }

        public function getPreset(param1:int):RoomDimmerPresetsMessageData
        {
            if (((param1 < 0) || (param1 >= this.presetCount)))
            {
                return (null);
            };
            return (this._presets[param1]);
        }

        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._presets = [];
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc4_:int;
            var _loc5_:int;
            var _loc6_:String;
            var _loc7_:int;
            var _loc8_:int;
            var _loc9_:RoomDimmerPresetsMessageData;
            var _loc2_:int = param1.readInteger();
            this._selectedPresetId = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                _loc4_ = param1.readInteger();
                _loc5_ = param1.readInteger();
                _loc6_ = param1.readString();
                _loc7_ = parseInt(_loc6_.substr(1), 16);
                _loc8_ = param1.readInteger();
                _loc9_ = new RoomDimmerPresetsMessageData(_loc4_);
                _loc9_.type = _loc5_;
                _loc9_.color = _loc7_;
                _loc9_.light = _loc8_;
                _loc9_.setReadOnly();
                this._presets.push(_loc9_);
                _loc3_++;
            };
            return (true);
        }


    }
}