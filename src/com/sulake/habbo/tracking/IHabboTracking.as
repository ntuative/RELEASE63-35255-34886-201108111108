package com.sulake.habbo.tracking
{
    import com.sulake.core.runtime.IUnknown;

    public interface IHabboTracking extends IUnknown 
    {

        function trackGoogle(param1:String, param2:String, param3:int=-1):void;
        function legacyTrackGoogle(param1:String, param2:String, param3:Array=null):void;
        function logError(param1:String):void;
        function chatLagDetected(param1:int):void;

    }
}