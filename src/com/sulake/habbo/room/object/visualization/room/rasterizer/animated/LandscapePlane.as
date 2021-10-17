package com.sulake.habbo.room.object.visualization.room.rasterizer.animated
{
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.Plane;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneVisualization;
    import flash.display.BitmapData;
    import com.sulake.room.utils.Vector3d;
    import flash.geom.Point;
    import com.sulake.room.utils.IVector3d;

    public class LandscapePlane extends Plane 
    {

        public static const var_1446:uint = 0xFFFFFF;
        public static const var_2228:Number = 45;
        public static const var_2229:Number = 30;

        private var var_2731:int = 0;
        private var _height:int = 0;


        override public function isStatic(param1:int):Boolean
        {
            var _loc2_:PlaneVisualization = getPlaneVisualization(param1);
            if (_loc2_ != null)
            {
                return (!(_loc2_.hasAnimationLayers));
            };
            return (super.isStatic(param1));
        }

        public function initializeDimensions(param1:int, param2:int):void
        {
            if (param1 < 0)
            {
                param1 = 0;
            };
            if (param2 < 0)
            {
                param2 = 0;
            };
            if (((!(param1 == this.var_2731)) || (!(param2 == this._height))))
            {
                this.var_2731 = param1;
                this._height = param2;
            };
        }

        public function render(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:IVector3d, param6:Boolean, param7:Number, param8:Number, param9:Number, param10:Number, param11:int):BitmapData
        {
            var _loc16_:int;
            var _loc17_:int;
            var _loc18_:int;
            var _loc19_:int;
            var _loc20_:BitmapData;
            var _loc12_:PlaneVisualization = getPlaneVisualization(param4);
            if (((_loc12_ == null) || (_loc12_.geometry == null)))
            {
                return (null);
            };
            var _loc13_:Point = _loc12_.geometry.getScreenPoint(new Vector3d(0, 0, 0));
            var _loc14_:Point = _loc12_.geometry.getScreenPoint(new Vector3d(0, 0, 1));
            var _loc15_:Point = _loc12_.geometry.getScreenPoint(new Vector3d(0, 1, 0));
            if ((((!(_loc13_ == null)) && (!(_loc14_ == null))) && (!(_loc15_ == null))))
            {
                param2 = Math.round(Math.abs((((_loc13_.x - _loc15_.x) * param2) / _loc12_.geometry.scale)));
                param3 = Math.round(Math.abs((((_loc13_.y - _loc14_.y) * param3) / _loc12_.geometry.scale)));
                _loc16_ = (param7 * Math.abs((_loc13_.x - _loc15_.x)));
                _loc17_ = (param8 * Math.abs((_loc13_.y - _loc14_.y)));
                _loc18_ = (param9 * Math.abs((_loc13_.x - _loc15_.x)));
                _loc19_ = (param10 * Math.abs((_loc13_.y - _loc14_.y)));
                return (_loc12_.render(param1, param2, param3, param5, param6, _loc16_, _loc17_, _loc18_, _loc19_, param9, param10, param11));
            };
            return (null);
        }


    }
}