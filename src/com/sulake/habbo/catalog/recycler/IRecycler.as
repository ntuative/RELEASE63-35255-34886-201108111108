package com.sulake.habbo.catalog.recycler
{
    public interface IRecycler 
    {

        function init(param1:IRecyclerVisualization=null):void;
        function cancel():void;
        function getSlotContent(param1:int):FurniSlotItem;
        function placeObjectAtSlot(param1:int, param2:int, param3:int, param4:int, param5:String):void;
        function releaseSlot(param1:int):void;
        function executeRecycler():void;
        function isReadyToRecycle():Boolean;
        function getPrizeTable():Array;

    }
}