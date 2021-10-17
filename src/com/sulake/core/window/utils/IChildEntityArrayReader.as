package com.sulake.core.window.utils
{
    public interface IChildEntityArrayReader 
    {

        function get numChildren():int;
        function getChildAt(param1:int):IChildEntity;
        function getChildByID(param1:uint):IChildEntity;
        function getChildByTag(param1:String):IChildEntity;
        function getChildByName(param1:String):IChildEntity;
        function getChildIndex(param1:IChildEntity):int;
        function groupChildrenWithID(param1:uint, param2:Array):uint;
        function groupChildrenWithTag(param1:String, param2:Array):uint;

    }
}