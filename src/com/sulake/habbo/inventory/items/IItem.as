package com.sulake.habbo.inventory.items
{
    public interface IItem 
    {

        function get id():int;
        function get ref():int;
        function get type():int;
        function get stuffData():String;
        function get extra():Number;
        function get category():int;
        function get recyclable():Boolean;
        function get tradeable():Boolean;
        function get groupable():Boolean;
        function get sellable():Boolean;
        function get locked():Boolean;
        function set locked(param1:Boolean):void;

    }
}