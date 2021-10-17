package com.sulake.habbo.session
{
    public interface IUserDataManager 
    {

        function setUserData(param1:IUserData):void;
        function getUserData(param1:int):IUserData;
        function getUserDataByType(param1:int, param2:int):IUserData;
        function getUserDataByIndex(param1:int):IUserData;
        function getUserBadges(param1:int):Array;
        function removeUserDataByIndex(param1:int):void;
        function setUserBadges(param1:int, param2:Array):void;
        function updateFigure(param1:int, param2:String, param3:String):void;
        function updateCustom(param1:int, param2:String):void;
        function updateAchievementScore(param1:int, param2:int):void;
        function updateNameByIndex(param1:int, param2:String):void;
        function getPetUserData(param1:int):IUserData;
        function requestPetInfo(param1:int):void;

    }
}