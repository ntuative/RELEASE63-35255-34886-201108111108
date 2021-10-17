package com.sulake.habbo.avatar.animation
{
    public interface IAnimation 
    {

        function hasSpriteData():Boolean;
        function hasAvatarData():Boolean;
        function hasCanvasData():Boolean;
        function hasDirectionData():Boolean;
        function hasShadowData():Boolean;
        function hasRemoveData():Boolean;
        function hasAddData():Boolean;
        function get id():String;
        function get description():String;
        function get spriteData():Array;
        function get canvasData():Array;
        function get removeData():Array;
        function get addData():Array;

    }
}