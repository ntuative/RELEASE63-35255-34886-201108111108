package com.sulake.core.window.utils
{
    public class DefaultAttStruct 
    {

        public static var var_1093:Boolean = false;

        public var color:uint = 0xFFFFFF;
        public var background:Boolean = false;
        public var blend:Number = 1;
        public var var_1190:uint = 10;
        public var width_min:int = -2147483648;
        public var width_max:int = 2147483647;
        public var height_min:int = -2147483648;
        public var height_max:int = 2147483647;


        public function hasRectLimits():Boolean
        {
            return ((var_1093) && ((((this.width_min > int.MIN_VALUE) || (this.height_min > int.MIN_VALUE)) || (this.width_max < int.MAX_VALUE)) || (this.height_max < int.MAX_VALUE)));
        }


    }
}