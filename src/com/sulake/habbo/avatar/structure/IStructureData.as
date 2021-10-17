package com.sulake.habbo.avatar.structure
{
    public interface IStructureData 
    {

        function parse(param1:XML):Boolean;
        function appendXML(param1:XML):Boolean;

    }
}