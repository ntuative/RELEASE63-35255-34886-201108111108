package com.sulake.habbo.sound
{
    import flash.events.IEventDispatcher;

    public interface IHabboMusicController 
    {

        function getRoomItemPlaylist(param1:int=-1):IPlayListController;
        function getSongDiskInventorySize():int;
        function getSongDiskInventoryDiskId(param1:int):int;
        function getSongDiskInventorySongId(param1:int):int;
        function getSongInfo(param1:int):ISongInfo;
        function getSongIdPlayingAtPriority(param1:int):int;
        function playSong(param1:int, param2:int, param3:Number=0, param4:Number=0, param5:Number=0.5, param6:Number=0.5):Boolean;
        function stop(param1:int):void;
        function addSongInfoRequest(param1:int):void;
        function requestSongInfoWithoutSamples(param1:int):void;
        function requestUserSongDisks():void;
        function onSongLoaded(param1:int):void;
        function updateVolume(param1:Number):void;
        function samplesUnloaded(param1:Array):void;
        function get samplesIdsInUse():Array;
        function get events():IEventDispatcher;
        function dispose():void;

    }
}