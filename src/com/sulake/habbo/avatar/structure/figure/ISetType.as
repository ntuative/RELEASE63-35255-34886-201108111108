package com.sulake.habbo.avatar.structure.figure
{
    import com.sulake.core.utils.Map;

    public interface ISetType 
    {

        function getPartSet(param1:int):IFigurePartSet;
        function isMandatory(param1:String, param2:int):Boolean;
        function get type():String;
        function get paletteID():int;
        function get partSets():Map;

    }
}