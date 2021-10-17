package com.sulake.habbo.help.cfh.data
{
    import com.sulake.core.utils.Map;

    public class UserRegistry 
    {

        private static const var_1391:int = 80;

        private var var_3991:Map = new Map();
        private var var_3463:String = "";
        private var var_3992:Array = new Array();


        public function getRegistry():Map
        {
            return (this.var_3991);
        }

        public function registerRoom(param1:String):void
        {
            this.var_3463 = param1;
            if (this.var_3463 != "")
            {
                this.addRoomNameForMissing();
            };
        }

        public function unregisterRoom():void
        {
            this.var_3463 = "";
        }

        public function registerUser(param1:int, param2:String, param3:Boolean=true):void
        {
            var _loc4_:UserRegistryItem;
            if (this.var_3991.getValue(param1) != null)
            {
                this.var_3991.remove(param1);
            };
            if (param3)
            {
                _loc4_ = new UserRegistryItem(param1, param2, this.var_3463);
            }
            else
            {
                _loc4_ = new UserRegistryItem(param1, param2);
            };
            if (((param3) && (this.var_3463 == "")))
            {
                this.var_3992.push(param1);
            };
            this.var_3991.add(param1, _loc4_);
            this.purgeUserIndex();
        }

        private function purgeUserIndex():void
        {
            var _loc1_:int;
            while (this.var_3991.length > var_1391)
            {
                _loc1_ = this.var_3991.getKey(0);
                this.var_3991.remove(_loc1_);
            };
        }

        private function addRoomNameForMissing():void
        {
            var _loc1_:UserRegistryItem;
            while (this.var_3992.length > 0)
            {
                _loc1_ = this.var_3991.getValue(this.var_3992.shift());
                if (_loc1_ != null)
                {
                    _loc1_.roomName = this.var_3463;
                };
            };
        }


    }
}