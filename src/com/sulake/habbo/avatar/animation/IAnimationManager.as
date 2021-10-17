package com.sulake.habbo.avatar.animation
{
    import flash.utils.Dictionary;

    public interface IAnimationManager 
    {

        function get animations():Dictionary;
        function getAnimation(param1:String):IAnimation;
        function getLayerData(param1:String, param2:int, param3:String):IAnimationLayerData;

    }
}