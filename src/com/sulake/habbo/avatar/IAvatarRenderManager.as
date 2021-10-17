package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.avatar.structure.IFigureData;
    import com.sulake.core.assets.IAsset;
    import com.sulake.habbo.avatar.pets.IPetDataManager;
    import com.sulake.habbo.avatar.animation.IAnimationManager;
    import flash.events.IEventDispatcher;

    public interface IAvatarRenderManager extends IUnknown 
    {

        function createAvatarImage(param1:String, param2:String, param3:String=null, param4:IAvatarImageListener=null):IAvatarImage;
        function createPetImageFromFigure(param1:String, param2:String, param3:IPetImageListener=null):IAvatarImage;
        function createPetImage(param1:int, param2:int, param3:uint, param4:String, param5:IPetImageListener=null):IAvatarImage;
        function getPetFigureString(param1:String):String;
        function get assets():IAssetLibrary;
        function getFigureData(param1:String):IFigureData;
        function getMandatoryAvatarPartSetIds(param1:String, param2:int):Array;
        function getAssetByName(param1:String):IAsset;
        function get petDataManager():IPetDataManager;
        function get mode():String;
        function set mode(param1:String):void;
        function injectFigureData(param1:String, param2:XML):void;
        function createFigureContainer(param1:String):IAvatarFigureContainer;
        function isFigureReady(param1:IAvatarFigureContainer):Boolean;
        function downloadFigure(param1:IAvatarFigureContainer, param2:IAvatarImageListener):void;
        function getAnimationManager(param1:String):IAnimationManager;
        function get events():IEventDispatcher;
        function resetAssetManager():void;
        function removePetImageListener(param1:IPetImageListener):void;

    }
}