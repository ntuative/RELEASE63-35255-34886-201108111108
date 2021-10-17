package com.sulake.core.window.utils
{
    public interface IChildEntityArray extends IChildEntityArrayReader 
    {

        function addChild(param1:IChildEntity):IChildEntity;
        function addChildAt(param1:IChildEntity, param2:int):IChildEntity;
        function removeChild(param1:IChildEntity):IChildEntity;
        function removeChildAt(param1:int):IChildEntity;
        function setChildIndex(param1:IChildEntity, param2:int):void;
        function swapChildren(param1:IChildEntity, param2:IChildEntity):void;
        function swapChildrenAt(param1:int, param2:int):void;

    }
}