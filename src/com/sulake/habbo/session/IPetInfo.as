package com.sulake.habbo.session
{
    public interface IPetInfo 
    {

        function get petId():int;
        function get level():int;
        function get levelMax():int;
        function get experience():int;
        function get experienceMax():int;
        function get energy():int;
        function get energyMax():int;
        function get nutrition():int;
        function get nutritionMax():int;
        function get ownerId():int;
        function get ownerName():String;
        function get respect():int;
        function get age():int;

    }
}