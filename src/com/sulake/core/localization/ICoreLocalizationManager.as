package com.sulake.core.localization
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.utils.Map;

    public interface ICoreLocalizationManager extends IUnknown 
    {

        function registerListener(param1:String, param2:ILocalizable):Boolean;
        function removeListener(param1:String, param2:ILocalizable):Boolean;
        function loadLocalizationFromURL(param1:String):void;
        function hasKey(param1:String):Boolean;
        function getKey(param1:String, param2:String=""):String;
        function getRawValue(param1:String, param2:String=""):String;
        function updateKey(param1:String, param2:String):void;
        function registerParameter(param1:String, param2:String, param3:String, param4:String="%"):String;
        function getLocalization(param1:String):ILocalization;
        function getKeys():Array;
        function registerLocalizationDefinition(param1:String, param2:String, param3:String):void;
        function activateLocalization(param1:String):Boolean;
        function getLocalizationDefinitions():Map;
        function getLocalizationDefinition(param1:String):ILocalizationDefinition;
        function getActiveLocalizationDefinition():ILocalizationDefinition;
        function printNonExistingKeys():void;

    }
}