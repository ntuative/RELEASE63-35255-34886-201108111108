package com.sulake.room.object.visualization
{
    public interface IRoomObjectSpriteVisualization extends IRoomObjectGraphicVisualization 
    {

        function get spriteCount():int;
        function getSprite(param1:int):IRoomObjectSprite;

    }
}