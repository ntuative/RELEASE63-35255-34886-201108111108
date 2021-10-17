package com.sulake.habbo.avatar.structure.figure
{
    public interface IFigurePartSet 
    {

        function getPart(param1:String, param2:int):IFigurePart;
        function get type():String;
        function get id():int;
        function get gender():String;
        function get clubLevel():int;
        function get isColorable():Boolean;
        function get isSelectable():Boolean;
        function get parts():Array;
        function get hiddenLayers():Array;

    }
}