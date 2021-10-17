package com.sulake.habbo.help
{
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;

    public interface INameChangeUI 
    {

        function get localization():IHabboLocalizationManager;
        function get assets():IAssetLibrary;
        function get myName():String;
        function buildXmlWindow(param1:String, param2:uint=1):IWindow;
        function checkName(param1:String):void;
        function changeName(param1:String):void;
        function showView(param1:String):void;

    }
}