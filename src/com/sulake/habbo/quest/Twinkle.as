package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Point;
    import flash.display.BitmapData;

    public class Twinkle implements AnimationObject, IDisposable 
    {

        private static const var_1423:int = 100;
        private static const var_1421:Array = [1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1];
        private static const var_1422:int = -1;
        private static const var_1420:int = -2;
        private static const APPEAR_AREA:Point = new Point(44, 44);

        private var _twinkleImages:TwinkleImages;
        private var var_4477:int;
        private var var_4478:Point;

        public function Twinkle(param1:TwinkleImages, param2:int)
        {
            this._twinkleImages = param1;
            this.var_4477 = param2;
        }

        public function dispose():void
        {
            this._twinkleImages = null;
            this.var_4478 = null;
        }

        public function get disposed():Boolean
        {
            return (this._twinkleImages == null);
        }

        public function onAnimationStart():void
        {
            this.var_4478 = new Point(Math.round((Math.random() * APPEAR_AREA.x)), Math.round((Math.random() * APPEAR_AREA.y)));
        }

        public function getPosition(param1:int):Point
        {
            return (this.var_4478);
        }

        public function isFinished(param1:int):Boolean
        {
            return (this.getFrame(param1) == var_1420);
        }

        public function getBitmap(param1:int):BitmapData
        {
            var _loc2_:int = this.getFrame(param1);
            return (this._twinkleImages.getImage(var_1421[_loc2_]));
        }

        private function getFrame(param1:int):int
        {
            var _loc2_:int = (param1 - this.var_4477);
            if (_loc2_ < 0)
            {
                return (var_1422);
            };
            var _loc3_:int = int(Math.floor((_loc2_ / var_1423)));
            if (_loc3_ >= var_1421.length)
            {
                return (var_1420);
            };
            return (_loc3_);
        }


    }
}