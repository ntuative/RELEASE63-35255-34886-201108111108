package com.sulake.habbo.advertisement
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;

    public interface IAdManager extends IUnknown 
    {

        function get events():IEventDispatcher;
        function showInterstitial():Boolean;
        function showRoomAd(param1:int, param2:int):void;
        function loadRoomAdImage(param1:int, param2:int, param3:int, param4:int, param5:String, param6:String):void;

    }
}