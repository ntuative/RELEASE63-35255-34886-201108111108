package com.sulake.habbo.avatar.geometry
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.structure.AvatarCanvas;

    public class AvatarModelGeometry 
    {

        private var var_2947:AvatarSet;
        private var var_2945:Dictionary;
        private var var_2946:Dictionary;
        private var var_2948:Matrix4x4;
        private var var_2943:Vector3D = new Vector3D(0, 0, 10);
        private var var_2944:Dictionary;

        public function AvatarModelGeometry(param1:XML)
        {
            var _loc3_:XML;
            var _loc4_:XML;
            var _loc5_:AvatarCanvas;
            var _loc6_:XML;
            var _loc7_:Dictionary;
            var _loc8_:Dictionary;
            var _loc9_:XML;
            var _loc10_:GeometryBodyPart;
            var _loc11_:Number;
            var _loc12_:Number;
            var _loc13_:Number;
            var _loc14_:String;
            var _loc15_:Dictionary;
            var _loc16_:String;
            super();
            this.var_2948 = new Matrix4x4();
            this.var_2945 = new Dictionary();
            this.var_2946 = new Dictionary();
            this.var_2947 = new AvatarSet(param1.avatarset[0]);
            this.var_2944 = new Dictionary();
            var _loc2_:XML = param1.camera[0];
            if (_loc2_ != null)
            {
                _loc11_ = parseFloat(_loc2_.x.text());
                _loc12_ = parseFloat(_loc2_.y.text());
                _loc13_ = parseFloat(_loc2_.z.text());
                this.var_2943.x = _loc11_;
                this.var_2943.y = _loc12_;
                this.var_2943.z = _loc13_;
            };
            for each (_loc3_ in param1.canvas)
            {
                _loc14_ = String(_loc3_.@scale);
                _loc15_ = new Dictionary();
                for each (_loc4_ in _loc3_.geometry)
                {
                    _loc5_ = new AvatarCanvas(_loc4_);
                    _loc15_[String(_loc4_.@id)] = _loc5_;
                };
                this.var_2944[_loc14_] = _loc15_;
            };
            for each (_loc6_ in param1.type)
            {
                _loc7_ = new Dictionary();
                _loc8_ = new Dictionary();
                for each (_loc9_ in _loc6_.bodypart)
                {
                    _loc10_ = new GeometryBodyPart(_loc9_);
                    _loc7_[String(_loc9_.@id)] = _loc10_;
                    for each (_loc16_ in _loc10_.getPartIds())
                    {
                        _loc8_[_loc16_] = _loc10_;
                    };
                };
                this.var_2945[String(_loc6_.@id)] = _loc7_;
                this.var_2946[String(_loc6_.@id)] = _loc8_;
            };
        }

        public function removeDynamicItems():void
        {
            var _loc1_:Dictionary;
            var _loc2_:GeometryBodyPart;
            for each (_loc1_ in this.var_2945)
            {
                for each (_loc2_ in _loc1_)
                {
                    _loc2_.removeDynamicParts();
                };
            };
        }

        public function getBodyPartIdsInAvatarSet(param1:String):Array
        {
            var _loc2_:Array = [];
            var _loc3_:AvatarSet = this.var_2947.findAvatarSet(param1);
            if (_loc3_ != null)
            {
                _loc2_ = _loc3_.getBodyParts();
            };
            return (_loc2_);
        }

        public function isMainAvatarSet(param1:String):Boolean
        {
            var _loc2_:AvatarSet = this.var_2947.findAvatarSet(param1);
            if (_loc2_ != null)
            {
                return (_loc2_.isMain);
            };
            return (false);
        }

        public function getCanvas(param1:String, param2:String):AvatarCanvas
        {
            var _loc4_:AvatarCanvas;
            var _loc3_:Dictionary = this.var_2944[param1];
            if (_loc3_ != null)
            {
                _loc4_ = (_loc3_[param2] as AvatarCanvas);
            };
            return (_loc4_);
        }

        private function typeExists(param1:String):Boolean
        {
            return (!(this.var_2945[param1] == null));
        }

        private function hasBodyPart(param1:String, param2:String):Boolean
        {
            var _loc3_:Dictionary;
            if (this.typeExists(param1))
            {
                _loc3_ = (this.var_2945[param1] as Dictionary);
                return (!(_loc3_[param2] == null));
            };
            return (false);
        }

        private function getBodyPartIDs(param1:String):Array
        {
            var _loc4_:String;
            var _loc2_:Dictionary = this.getBodyPartsOfType(param1);
            var _loc3_:Array = new Array();
            for (_loc4_ in this.var_2945)
            {
                _loc3_.push(_loc4_);
            };
            return (_loc3_);
        }

        private function getBodyPartsOfType(param1:String):Dictionary
        {
            if (this.typeExists(param1))
            {
                return (this.var_2945[param1] as Dictionary);
            };
            return (new Dictionary());
        }

        public function getBodyPart(param1:String, param2:String):GeometryBodyPart
        {
            var _loc3_:Dictionary = this.getBodyPartsOfType(param1);
            return (_loc3_[param2]);
        }

        public function getBodyPartOfItem(param1:String, param2:String):GeometryBodyPart
        {
            var _loc4_:GeometryBodyPart;
            var _loc5_:Dictionary;
            var _loc3_:Dictionary = this.var_2946[param1];
            if (_loc3_ != null)
            {
                _loc4_ = _loc3_[param2];
                if (_loc4_ != null)
                {
                    return (_loc4_);
                };
                _loc5_ = this.getBodyPartsOfType(param1);
                for each (_loc4_ in _loc5_)
                {
                    if (_loc4_.hasPart(param2))
                    {
                        return (_loc4_);
                    };
                };
            };
            return (null);
        }

        private function getBodyPartsInAvatarSet(param1:Dictionary, param2:String):Array
        {
            var _loc5_:GeometryBodyPart;
            var _loc6_:String;
            var _loc3_:Array = [];
            var _loc4_:Array = this.getBodyPartIdsInAvatarSet(param2);
            for each (_loc6_ in _loc4_)
            {
                _loc5_ = param1[_loc6_];
                if (_loc5_ != null)
                {
                    _loc3_.push(_loc5_);
                };
            };
            return (_loc3_);
        }

        public function getBodyPartsAtAngle(param1:String, param2:uint, param3:String):Array
        {
            var _loc7_:GeometryBodyPart;
            var _loc9_:Number;
            var _loc10_:Array;
            if (param3 == null)
            {
                Logger.log("[AvatarModelGeometry] ERROR: Geometry ID not found for action: ");
                return ([]);
            };
            var _loc4_:Dictionary = this.getBodyPartsOfType(param3);
            var _loc5_:Array = this.getBodyPartsInAvatarSet(_loc4_, param1);
            var _loc6_:Array = new Array();
            var _loc8_:Array = new Array();
            this.var_2948 = Matrix4x4.getYRotationMatrix(param2);
            for each (_loc7_ in _loc5_)
            {
                _loc7_.applyTransform(this.var_2948);
                _loc9_ = _loc7_.getDistance(this.var_2943);
                _loc6_.push([_loc9_, _loc7_]);
            };
            _loc6_.sort(this.orderByDistance);
            for each (_loc10_ in _loc6_)
            {
                _loc7_ = (_loc10_[1] as GeometryBodyPart);
                _loc8_.push(_loc7_.id);
            };
            return (_loc8_);
        }

        public function getParts(param1:String, param2:String, param3:uint, param4:Array):Array
        {
            var _loc5_:GeometryBodyPart;
            if (this.hasBodyPart(param1, param2))
            {
                _loc5_ = (this.getBodyPartsOfType(param1)[param2] as GeometryBodyPart);
                this.var_2948 = Matrix4x4.getYRotationMatrix(param3);
                return (_loc5_.getParts(this.var_2948, this.var_2943, param4));
            };
            return ([]);
        }

        private function orderByDistance(param1:Array, param2:Array):Number
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


    }
}