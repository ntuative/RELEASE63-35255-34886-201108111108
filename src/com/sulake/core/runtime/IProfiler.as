package com.sulake.core.runtime
{
    import com.sulake.core.utils.profiler.ProfilerAgent;

    public interface IProfiler 
    {

        function getProfilerAgentForReceiver(param1:IUpdateReceiver):ProfilerAgent;
        function getProfilerAgentsInArray():Array;
        function addStartEventListener(param1:Function):void;
        function addStopEventListener(param1:Function):void;
        function removeStartEventListener(param1:Function):void;
        function removeStopEventListener(param1:Function):void;
        function gc():void;
        function get numAssetLibraryInstances():uint;
        function get numBitmapAssetInstances():uint;
        function get numAllocatedBitmapDataBytes():uint;
        function get numTrackedBitmapDataInstances():uint;
        function get numTrackedBitmapDataBytes():uint;

    }
}