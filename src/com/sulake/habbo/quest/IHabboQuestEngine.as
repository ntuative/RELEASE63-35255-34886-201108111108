package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IUnknown;

    public interface IHabboQuestEngine extends IUnknown 
    {

        function isTrackerVisible():Boolean;
        function showAchievements():void;
        function showQuests():void;

    }
}