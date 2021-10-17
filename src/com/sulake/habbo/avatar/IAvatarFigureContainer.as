package com.sulake.habbo.avatar
{
    public interface IAvatarFigureContainer 
    {

        function getPartTypeIds():Array;
        function hasPartType(param1:String):Boolean;
        function getPartSetId(param1:String):int;
        function getPartColorIds(param1:String):Array;
        function updatePart(param1:String, param2:int, param3:Array):void;
        function removePart(param1:String):void;
        function getFigureString():String;

    }
}