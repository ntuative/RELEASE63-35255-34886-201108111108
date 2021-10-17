package com.sulake.habbo.configuration
{
    import com.sulake.core.runtime.IUnknown;
    import flash.utils.Dictionary;

    public interface IHabboConfigurationManager extends IUnknown 
    {

        function keyExists(param1:String):Boolean;
        function getKey(param1:String, param2:String="", param3:Dictionary=null):String;
        function getBoolean(param1:String, param2:Boolean):Boolean;
        function setKey(param1:String, param2:String, param3:Boolean=false, param4:Boolean=false):void;

    }
}