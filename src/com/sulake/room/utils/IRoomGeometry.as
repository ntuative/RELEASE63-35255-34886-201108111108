package com.sulake.room.utils
{
    import flash.geom.Point;

    public interface IRoomGeometry 
    {

        function get scale():Number;
        function get directionAxis():IVector3d;
        function get direction():IVector3d;
        function getCoordinatePosition(param1:IVector3d):IVector3d;
        function getScreenPoint(param1:IVector3d):Point;
        function getScreenPosition(param1:IVector3d):IVector3d;
        function getPlanePosition(param1:Point, param2:IVector3d, param3:IVector3d, param4:IVector3d):Point;
        function setDisplacement(param1:IVector3d, param2:IVector3d):void;
        function adjustLocation(param1:IVector3d, param2:Number):void;
        function performZoom():void;
        function performZoomOut():void;
        function performZoomIn():void;
        function isZoomedIn():Boolean;
        function get updateId():int;
        function set z_scale(param1:Number):void;

    }
}