package com.sulake.habbo.sound
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;

    public interface IHabboSoundManager extends IUnknown 
    {

        function set volume(param1:Number):void;
        function set previewVolume(param1:Number):void;
        function get volume():Number;
        function get musicController():IHabboMusicController;
        function playSound(param1:String):void;
        function loadTraxSong(param1:int, param2:String):IHabboSound;
        function get events():IEventDispatcher;

    }
}