package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindow;
    import flash.text.TextFormat;
    import com.sulake.core.window.utils.IMargins;
    import com.sulake.core.window.utils.TextStyle;
    import flash.geom.Rectangle;
    import flash.display.DisplayObject;
    import flash.text.TextLineMetrics;

    public interface ITextWindow extends IWindow, IScrollableWindow 
    {

        function get antiAliasType():String;
        function get autoSize():String;
        function get bold():Boolean;
        function get border():Boolean;
        function get borderColor():uint;
        function get bottomScrollV():int;
        function get defaultTextFormat():TextFormat;
        function get embedFonts():Boolean;
        function get fontFace():String;
        function get fontSize():uint;
        function get gridFitType():String;
        function get htmlText():String;
        function get italic():Boolean;
        function get kerning():Boolean;
        function get length():int;
        function get margins():IMargins;
        function get maxChars():int;
        function get multiline():Boolean;
        function get numLines():int;
        function get sharpness():Number;
        function get spacing():Number;
        function get text():String;
        function get textColor():uint;
        function get textBackground():Boolean;
        function get textBackgroundColor():uint;
        function get textHeight():Number;
        function get textWidth():Number;
        function get textStyle():TextStyle;
        function get thickness():Number;
        function get underline():Boolean;
        function get wordWrap():Boolean;
        function get immediateClickMode():Boolean;
        function set antiAliasType(param1:String):void;
        function set autoSize(param1:String):void;
        function set bold(param1:Boolean):void;
        function set border(param1:Boolean):void;
        function set borderColor(param1:uint):void;
        function set defaultTextFormat(param1:TextFormat):void;
        function set embedFonts(param1:Boolean):void;
        function set fontFace(param1:String):void;
        function set fontSize(param1:uint):void;
        function set gridFitType(param1:String):void;
        function set htmlText(param1:String):void;
        function set italic(param1:Boolean):void;
        function set kerning(param1:Boolean):void;
        function set maxChars(param1:int):void;
        function set multiline(param1:Boolean):void;
        function set sharpness(param1:Number):void;
        function set spacing(param1:Number):void;
        function set text(param1:String):void;
        function set textColor(param1:uint):void;
        function set textBackground(param1:Boolean):void;
        function set textBackgroundColor(param1:uint):void;
        function set textStyle(param1:TextStyle):void;
        function set thickness(param1:Number):void;
        function set underline(param1:Boolean):void;
        function set wordWrap(param1:Boolean):void;
        function set immediateClickMode(param1:Boolean):void;
        function appendText(param1:String):void;
        function getCharBoundaries(param1:int):Rectangle;
        function getCharIndexAtPoint(param1:Number, param2:Number):int;
        function getFirstCharInParagraph(param1:int):int;
        function getImageReference(param1:String):DisplayObject;
        function getLineIndexAtPoint(param1:Number, param2:Number):int;
        function getLineIndexOfChar(param1:int):int;
        function getLineLength(param1:int):int;
        function getLineMetrics(param1:int):TextLineMetrics;
        function getLineOffset(param1:int):int;
        function getLineText(param1:int):String;
        function getParagraphLength(param1:int):int;
        function getTextFormat(param1:int=-1, param2:int=-1):TextFormat;
        function replaceText(param1:int, param2:int, param3:String):void;
        function setTextFormat(param1:TextFormat, param2:int=-1, param3:int=-1):void;

    }
}