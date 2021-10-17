package com.sulake.habbo.avatar.pets
{
    import com.sulake.core.utils.Map;

    public interface IPetDataManager 
    {

        function getPetData(param1:int, param2:IPetDataListener=null):IPetData;
        function get species():Map;
        function removeListener(param1:IPetDataListener=null):void;

    }
}