package com.sulake.room.utils
{
    import flash.geom.Point;

    public class PointMath 
    {


        public static function sum(param1:Point, param2:Point):Point
        {
            return (new Point((param1.x + param2.x), (param1.y + param2.y)));
        }

        public static function sub(param1:Point, param2:Point):Point
        {
            return (new Point((param1.x - param2.x), (param1.y - param2.y)));
        }

        public static function mul(param1:Point, param2:Number):Point
        {
            return (new Point((param1.x * param2), (param1.y * param2)));
        }


    }
}