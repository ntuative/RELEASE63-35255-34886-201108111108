package com.sulake.room.object.visualization
{
    import flash.display.BitmapData;

    public interface IRoomObjectSprite 
    {

        function get asset():BitmapData;
        function set asset(param1:BitmapData):void;
        function get assetName():String;
        function set assetName(param1:String):void;
        function get visible():Boolean;
        function set visible(param1:Boolean):void;
        function get tag():String;
        function set tag(param1:String):void;
        function get alpha():int;
        function set alpha(param1:int):void;
        function get color():int;
        function set color(param1:int):void;
        function get blendMode():String;
        function set blendMode(param1:String):void;
        function get filters():Array;
        function set filters(param1:Array):void;
        function get flipH():Boolean;
        function set flipH(param1:Boolean):void;
        function get flipV():Boolean;
        function set flipV(param1:Boolean):void;
        function get offsetX():int;
        function set offsetX(param1:int):void;
        function get offsetY():int;
        function set offsetY(param1:int):void;
        function get width():int;
        function get height():int;
        function get relativeDepth():Number;
        function set relativeDepth(param1:Number):void;
        function get varyingDepth():Boolean;
        function set varyingDepth(param1:Boolean):void;
        function get capturesMouse():Boolean;
        function set capturesMouse(param1:Boolean):void;
        function get clickHandling():Boolean;
        function set clickHandling(param1:Boolean):void;
        function get instanceId():int;
        function get updateId():int;

    }
}