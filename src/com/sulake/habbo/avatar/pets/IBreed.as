package com.sulake.habbo.avatar.pets
{
    public interface IBreed 
    {

        function get id():int;
        function get patternId():int;
        function get avatarFigureString():String;
        function get localizationKey():String;
        function get isSellable():Boolean;

    }
}