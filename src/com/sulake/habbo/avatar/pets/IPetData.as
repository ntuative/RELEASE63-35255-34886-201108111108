package com.sulake.habbo.avatar.pets
{
    public interface IPetData 
    {

        function get name():String;
        function get species():int;
        function get disableHeadTurn():Boolean;
        function get scale():String;
        function get colors():Array;
        function get breeds():Array;
        function get sellableBreeds():Array;

    }
}