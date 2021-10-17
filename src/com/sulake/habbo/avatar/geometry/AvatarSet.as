package com.sulake.habbo.avatar.geometry
{
    import flash.utils.Dictionary;

    public class AvatarSet 
    {

        private var _id:String;
        private var var_2949:Dictionary;
        private var var_2950:Array;
        private var var_2951:Array;
        private var var_2846:Boolean;

        public function AvatarSet(param1:XML)
        {
            var _loc3_:AvatarSet;
            var _loc4_:XML;
            var _loc5_:XML;
            var _loc6_:Array;
            super();
            this._id = String(param1.@id);
            var _loc2_:String = String(param1.@main);
            this.var_2846 = ((_loc2_ == null) ? false : Boolean(parseInt(_loc2_)));
            this.var_2949 = new Dictionary();
            this.var_2950 = new Array();
            for each (_loc4_ in param1.avatarset)
            {
                _loc3_ = new AvatarSet(_loc4_);
                this.var_2949[String(_loc4_.@id)] = _loc3_;
            };
            for each (_loc5_ in param1.bodypart)
            {
                this.var_2950.push(String(_loc5_.@id));
            };
            _loc6_ = this.var_2950.concat();
            for each (_loc3_ in this.var_2949)
            {
                _loc6_ = _loc6_.concat(_loc3_.getBodyParts());
            };
            this.var_2951 = _loc6_;
        }

        public function findAvatarSet(param1:String):AvatarSet
        {
            var _loc2_:AvatarSet;
            if (param1 == this._id)
            {
                return (this);
            };
            for each (_loc2_ in this.var_2949)
            {
                if (_loc2_.findAvatarSet(param1) != null)
                {
                    return (_loc2_);
                };
            };
            return (null);
        }

        public function getBodyParts():Array
        {
            return (this.var_2951.concat());
        }

        public function get id():String
        {
            return (this._id);
        }

        public function get isMain():Boolean
        {
            var _loc1_:AvatarSet;
            if (this.var_2846)
            {
                return (true);
            };
            for each (_loc1_ in this.var_2949)
            {
                if (_loc1_.isMain)
                {
                    return (true);
                };
            };
            return (false);
        }


    }
}