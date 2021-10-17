package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Point;
    import flash.display.BitmapData;

    public interface AnimationObject extends IDisposable 
    {

        function getPosition(param1:int):Point;
        function getBitmap(param1:int):BitmapData;
        function isFinished(param1:int):Boolean;
        function onAnimationStart():void;

    }
}