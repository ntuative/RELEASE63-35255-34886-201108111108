package com.sulake.room.object
{
    public interface IRoomObjectModelController extends IRoomObjectModel 
    {

        function setNumber(param1:String, param2:Number, param3:Boolean=false):void;
        function setString(param1:String, param2:String, param3:Boolean=false):void;
        function setNumberArray(param1:String, param2:Array, param3:Boolean=false):void;
        function setStringArray(param1:String, param2:Array, param3:Boolean=false):void;

    }
}