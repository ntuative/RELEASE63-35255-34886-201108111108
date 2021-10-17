package com.sulake.habbo.localization
{
    public class BadgeBaseAndLevel 
    {

        private var _base:String = "";
        private var var_3416:int = 1;

        public function BadgeBaseAndLevel(param1:String)
        {
            var _loc2_:int = (param1.length - 1);
            while (((_loc2_ > 0) && (this.isNumber(param1.charAt(_loc2_)))))
            {
                _loc2_--;
            };
            this._base = param1.substring(0, (_loc2_ + 1));
            var _loc3_:String = param1.substring((_loc2_ + 1), param1.length);
            if (((!(_loc3_ == null)) && (!(_loc3_ == ""))))
            {
                this.var_3416 = int(_loc3_);
            };
            Logger.log(((((("Split badgeId " + param1) + " into ") + this._base) + " and ") + this.var_3416));
        }

        private function isNumber(param1:String):Boolean
        {
            var _loc2_:int = param1.charCodeAt(0);
            return ((_loc2_ >= 48) && (_loc2_ <= 57));
        }

        public function get base():String
        {
            return (this._base);
        }

        public function get level():int
        {
            return (this.var_3416);
        }

        public function set level(param1:int):void
        {
            this.var_3416 = Math.max(1, param1);
        }

        public function get badgeId():String
        {
            return (this._base + this.var_3416);
        }


    }
}