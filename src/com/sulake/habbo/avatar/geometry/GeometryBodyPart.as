package com.sulake.habbo.avatar.geometry
{
    import flash.utils.Dictionary;

    public class GeometryBodyPart extends Node3D 
    {

        private var _id:String;
        private var _parts:Dictionary;
        private var var_2952:Number;
        private var var_2953:Boolean = false;

        public function GeometryBodyPart(param1:XML)
        {
            var _loc2_:XML;
            var _loc3_:GeometryItem;
            super(parseFloat(param1.@x), parseFloat(param1.@y), parseFloat(param1.@z));
            this.var_2952 = parseFloat(param1.@radius);
            this._id = String(param1.@id);
            this._parts = new Dictionary();
            for each (_loc2_ in param1..item)
            {
                _loc3_ = new GeometryItem(_loc2_);
                this._parts[String(_loc2_.@id)] = _loc3_;
            };
        }

        public function getDynamicParts():Array
        {
            var _loc2_:GeometryItem;
            var _loc1_:Array = [];
            if (this.var_2953)
            {
                for each (_loc2_ in this._parts)
                {
                    if (_loc2_ != null)
                    {
                        if (_loc2_.isDynamic)
                        {
                            _loc1_.push(_loc2_);
                        };
                    };
                };
            };
            return (_loc1_);
        }

        public function getPartIds():Array
        {
            var _loc2_:GeometryItem;
            var _loc1_:Array = [];
            for each (_loc2_ in this._parts)
            {
                if (_loc2_ != null)
                {
                    _loc1_.push(_loc2_.id);
                };
            };
            return (_loc1_);
        }

        public function removeDynamicParts():Boolean
        {
            var _loc1_:GeometryItem;
            if (this.var_2953)
            {
                this.var_2953 = false;
                for each (_loc1_ in this._parts)
                {
                    if (_loc1_ != null)
                    {
                        if (_loc1_.isDynamic)
                        {
                            this._parts[_loc1_.id] = null;
                            _loc1_ = null;
                        };
                    };
                };
            };
            return (true);
        }

        public function addPart(param1:XML):Boolean
        {
            var _loc3_:GeometryItem;
            var _loc2_:String = String(param1.@id);
            if (!this.hasPart(_loc2_))
            {
                _loc3_ = new GeometryItem(param1, true);
                this._parts[_loc2_] = _loc3_;
                this.var_2953 = true;
                return (true);
            };
            return (false);
        }

        public function hasPart(param1:String):Boolean
        {
            var _loc2_:GeometryItem = this._parts[param1];
            return (!(_loc2_ == null));
        }

        public function getParts(param1:Matrix4x4, param2:Vector3D, param3:Array):Array
        {
            var _loc4_:GeometryItem;
            var _loc7_:Array;
            var _loc8_:Number;
            var _loc5_:Array = new Array();
            var _loc6_:Array = new Array();
            for each (_loc4_ in this._parts)
            {
                if (_loc4_ != null)
                {
                    if (param3.indexOf(_loc4_.id) == -1)
                    {
                    };
                    _loc4_.applyTransform(param1);
                    _loc8_ = _loc4_.getDistance(param2);
                    _loc5_.push([_loc8_, _loc4_]);
                };
            };
            _loc5_.sort(this.orderParts);
            for each (_loc7_ in _loc5_)
            {
                _loc4_ = (_loc7_[1] as GeometryItem);
                _loc6_.push(_loc4_.id);
            };
            return (_loc6_);
        }

        public function getDistance(param1:Vector3D):Number
        {
            var _loc2_:Number = Math.abs(((param1.z - this.transformedLocation.z) - this.var_2952));
            var _loc3_:Number = Math.abs(((param1.z - this.transformedLocation.z) + this.var_2952));
            return (Math.min(_loc2_, _loc3_));
        }

        public function get id():String
        {
            return (this._id);
        }

        private function orderParts(param1:Array, param2:Array):Number
        {
            var _loc3_:Number = (param1[0] as Number);
            var _loc4_:Number = (param2[0] as Number);
            if (_loc3_ < _loc4_)
            {
                return (-1);
            };
            if (_loc3_ > _loc4_)
            {
                return (1);
            };
            return (0);
        }

        public function get radius():Number
        {
            return (this.var_2952);
        }


    }
}