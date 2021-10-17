package com.sulake.habbo.room.utils
{
    import com.sulake.core.utils.Map;

    public class PublicRoomData 
    {

        private var _type:String = "";
        private var var_4850:Map = null;

        public function PublicRoomData(param1:String)
        {
            this._type = param1;
            this.var_4850 = new Map();
        }

        public function get type():String
        {
            return (this._type);
        }

        public function addWorld(param1:String, param2:Number, param3:Number):Boolean
        {
            if (this.var_4850.getValue(param1) != null)
            {
                return (false);
            };
            var _loc4_:PublicRoomWorldData = new PublicRoomWorldData(param1, param2, param3);
            this.var_4850.add(param1, _loc4_);
            return (true);
        }

        public function hasWorldType(param1:String):Boolean
        {
            if (this.var_4850.getValue(param1) != null)
            {
                return (true);
            };
            return (false);
        }

        public function getWorldScale(param1:String):Number
        {
            var _loc2_:PublicRoomWorldData = (this.var_4850.getValue(param1) as PublicRoomWorldData);
            if (_loc2_ != null)
            {
                return (_loc2_.scale);
            };
            return (1);
        }

        public function getWorldHeightScale(param1:String):Number
        {
            var _loc2_:PublicRoomWorldData = (this.var_4850.getValue(param1) as PublicRoomWorldData);
            if (_loc2_ != null)
            {
                return (_loc2_.heightScale);
            };
            return (1);
        }


    }
}