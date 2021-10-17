package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.IEventDispatcher;

    public interface IHabboAvatarEditor extends IUnknown 
    {

        function openEditor(param1:uint, param2:IHabboAvatarEditorDataSaver, param3:Array=null, param4:Boolean=false, param5:String=null):IFrameWindow;
        function embedEditorToContext(param1:uint, param2:IWindowContainer, param3:IHabboAvatarEditorDataSaver=null, param4:Array=null, param5:Boolean=false):Boolean;
        function loadAvatarInEditor(param1:uint, param2:String, param3:String, param4:int=0):void;
        function loadOwnAvatarInEditor(param1:uint):void;
        function get events():IEventDispatcher;
        function close(param1:uint):void;

    }
}