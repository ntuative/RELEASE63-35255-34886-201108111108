package com.sulake.habbo.avatar.animation
{
    public interface ISpriteDataContainer 
    {

        function get animation():IAnimation;
        function get id():String;
        function get ink():int;
        function get member():String;
        function get hasDirections():Boolean;
        function getDirectionOffsetX(param1:int):int;
        function getDirectionOffsetY(param1:int):int;
        function getDirectionOffsetZ(param1:int):int;

    }
}