package com.sulake.habbo.localization
{
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.runtime.IUnknown;
    import flash.utils.Dictionary;

    public interface IHabboLocalizationManager extends ICoreLocalizationManager, IUnknown 
    {

        function getKeyWithParams(param1:String, param2:Dictionary=null, param3:String=""):String;
        function getAchievementName(param1:String):String;
        function getAchievementDesc(param1:String, param2:int):String;
        function getBadgeBaseName(param1:String):String;
        function getBadgeName(param1:String):String;
        function getBadgeDesc(param1:String):String;
        function getAchievementDescForFacebook(param1:String, param2:String, param3:String, param4:int):String;
        function getAchievementNameForFacebook(param1:String, param2:String, param3:String, param4:int):String;
        function setBadgePointLimit(param1:String, param2:int):void;
        function getPreviousLevelBadgeId(param1:String):String;

    }
}