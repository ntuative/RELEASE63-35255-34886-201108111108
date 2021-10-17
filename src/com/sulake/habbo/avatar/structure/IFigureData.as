package com.sulake.habbo.avatar.structure
{
    import com.sulake.habbo.avatar.structure.figure.ISetType;
    import com.sulake.habbo.avatar.structure.figure.IPalette;

    public interface IFigureData 
    {

        function getSetType(param1:String):ISetType;
        function getPalette(param1:int):IPalette;

    }
}