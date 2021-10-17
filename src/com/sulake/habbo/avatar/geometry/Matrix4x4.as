package com.sulake.habbo.avatar.geometry
{
    public class Matrix4x4 
    {

        public static const var_2491:Matrix4x4 = new Matrix4x4(1, 0, 0, 0, 1, 0, 0, 0, 1);
        private static const var_2956:Number = 1E-18;

        private var _data:Array;

        public function Matrix4x4(param1:Number=0, param2:Number=0, param3:Number=0, param4:Number=0, param5:Number=0, param6:Number=0, param7:Number=0, param8:Number=0, param9:Number=0)
        {
            this._data = [param1, param2, param3, param4, param5, param6, param7, param8, param9];
        }

        public static function getXRotationMatrix(param1:Number):Matrix4x4
        {
            var _loc2_:Number = ((param1 * Math.PI) / 180);
            var _loc3_:Number = Math.cos(_loc2_);
            var _loc4_:Number = Math.sin(_loc2_);
            return (new Matrix4x4(1, 0, 0, 0, _loc3_, -(_loc4_), 0, _loc4_, _loc3_));
        }

        public static function getYRotationMatrix(param1:Number):Matrix4x4
        {
            var _loc2_:Number = ((param1 * Math.PI) / 180);
            var _loc3_:Number = Math.cos(_loc2_);
            var _loc4_:Number = Math.sin(_loc2_);
            return (new Matrix4x4(_loc3_, 0, _loc4_, 0, 1, 0, -(_loc4_), 0, _loc3_));
        }

        public static function getZRotationMatrix(param1:Number):Matrix4x4
        {
            var _loc2_:Number = ((param1 * Math.PI) / 180);
            var _loc3_:Number = Math.cos(_loc2_);
            var _loc4_:Number = Math.sin(_loc2_);
            return (new Matrix4x4(_loc3_, -(_loc4_), 0, _loc4_, _loc3_, 0, 0, 0, 1));
        }


        public function identity():Matrix4x4
        {
            this._data = [1, 0, 0, 0, 1, 0, 0, 0, 1];
            return (this);
        }

        public function vectorMultiplication(param1:Vector3D):Vector3D
        {
            var _loc2_:Number = (((param1.x * this._data[0]) + (param1.y * this._data[3])) + (param1.z * this._data[6]));
            var _loc3_:Number = (((param1.x * this._data[1]) + (param1.y * this._data[4])) + (param1.z * this._data[7]));
            var _loc4_:Number = (((param1.x * this._data[2]) + (param1.y * this._data[5])) + (param1.z * this._data[8]));
            return (new Vector3D(_loc2_, _loc3_, _loc4_));
        }

        public function multiply(param1:Matrix4x4):Matrix4x4
        {
            var _loc2_:Number = (((this._data[0] * param1.data[0]) + (this._data[1] * param1.data[3])) + (this._data[2] * param1.data[6]));
            var _loc3_:Number = (((this._data[0] * param1.data[1]) + (this._data[1] * param1.data[4])) + (this._data[2] * param1.data[7]));
            var _loc4_:Number = (((this._data[0] * param1.data[2]) + (this._data[1] * param1.data[5])) + (this._data[2] * param1.data[8]));
            var _loc5_:Number = (((this._data[3] * param1.data[0]) + (this._data[4] * param1.data[3])) + (this._data[5] * param1.data[6]));
            var _loc6_:Number = (((this._data[3] * param1.data[1]) + (this._data[4] * param1.data[4])) + (this._data[5] * param1.data[7]));
            var _loc7_:Number = (((this._data[3] * param1.data[2]) + (this._data[4] * param1.data[5])) + (this._data[5] * param1.data[8]));
            var _loc8_:Number = (((this._data[6] * param1.data[0]) + (this._data[7] * param1.data[3])) + (this._data[8] * param1.data[6]));
            var _loc9_:Number = (((this._data[6] * param1.data[1]) + (this._data[7] * param1.data[4])) + (this._data[8] * param1.data[7]));
            var _loc10_:Number = (((this._data[6] * param1.data[2]) + (this._data[7] * param1.data[5])) + (this._data[8] * param1.data[8]));
            return (new Matrix4x4(_loc2_, _loc3_, _loc4_, _loc5_, _loc6_, _loc7_, _loc8_, _loc9_, _loc10_));
        }

        public function scalarMultiply(param1:Number):void
        {
            var _loc2_:int;
            while (_loc2_ < this._data.length)
            {
                this._data[_loc2_] = (this._data[_loc2_] * param1);
                _loc2_++;
            };
        }

        public function rotateX(param1:Number):Matrix4x4
        {
            var _loc2_:Number = ((param1 * Math.PI) / 180);
            var _loc3_:Number = Math.cos(_loc2_);
            var _loc4_:Number = Math.sin(_loc2_);
            var _loc5_:Matrix4x4 = new Matrix4x4(1, 0, 0, 0, _loc3_, -(_loc4_), 0, _loc4_, _loc3_);
            return (_loc5_.multiply(this));
        }

        public function rotateY(param1:Number):Matrix4x4
        {
            var _loc2_:Number = ((param1 * Math.PI) / 180);
            var _loc3_:Number = Math.cos(_loc2_);
            var _loc4_:Number = Math.sin(_loc2_);
            var _loc5_:Matrix4x4 = new Matrix4x4(_loc3_, 0, _loc4_, 0, 1, 0, -(_loc4_), 0, _loc3_);
            return (_loc5_.multiply(this));
        }

        public function rotateZ(param1:Number):Matrix4x4
        {
            var _loc2_:Number = ((param1 * Math.PI) / 180);
            var _loc3_:Number = Math.cos(_loc2_);
            var _loc4_:Number = Math.sin(_loc2_);
            var _loc5_:Matrix4x4 = new Matrix4x4(_loc3_, -(_loc4_), 0, _loc4_, _loc3_, 0, 0, 0, 1);
            return (_loc5_.multiply(this));
        }

        public function skew():void
        {
        }

        public function transpose():Matrix4x4
        {
            return (new Matrix4x4(this._data[0], this._data[3], this._data[6], this._data[1], this._data[4], this._data[7], this._data[2], this._data[5], this._data[8]));
        }

        public function equals(param1:Matrix4x4):Boolean
        {
            return (false);
        }

        public function get data():Array
        {
            return (this._data);
        }


    }
}