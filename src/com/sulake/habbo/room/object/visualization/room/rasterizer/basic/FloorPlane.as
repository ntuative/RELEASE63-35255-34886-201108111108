package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import com.sulake.room.utils.Vector3d;
    import flash.geom.Point;
    import flash.display.BitmapData;
    import com.sulake.room.utils.IVector3d;

    public class FloorPlane extends Plane 
    {

        public static const var_1446:uint = 0xFFFFFF;
        public static const var_2228:Number = 45;
        public static const var_2229:Number = 30;


        public function render(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:IVector3d, param6:Boolean):BitmapData
        {
            var _loc7_:PlaneVisualization = getPlaneVisualization(param4);
            if (((_loc7_ == null) || (_loc7_.geometry == null)))
            {
                return (null);
            };
            var _loc8_:Point = _loc7_.geometry.getScreenPoint(new Vector3d(0, 0, 0));
            var _loc9_:Point = _loc7_.geometry.getScreenPoint(new Vector3d(0, (param3 / _loc7_.geometry.scale), 0));
            var _loc10_:Point = _loc7_.geometry.getScreenPoint(new Vector3d((param2 / _loc7_.geometry.scale), 0, 0));
            if ((((!(_loc8_ == null)) && (!(_loc9_ == null))) && (!(_loc10_ == null))))
            {
                param2 = Math.round(Math.abs((_loc8_.x - _loc10_.x)));
                param3 = Math.round(Math.abs((_loc8_.x - _loc9_.x)));
            };
            return (_loc7_.render(param1, param2, param3, param5, param6));
        }


    }
}