package com.sulake.habbo.avatar.common
{
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.core.window.IWindowContainer;

    public interface IAvatarEditorCategoryModel 
    {

        function dispose():void;
        function reset():void;
        function get controller():HabboAvatarEditor;
        function getWindowContainer():IWindowContainer;
        function switchCategory(param1:String):void;
        function getCategoryData(param1:String):CategoryData;
        function var_2932(param1:String, param2:int):void;
        function selectColor(param1:String, param2:int, param3:int):void;
        function hasClubItemsOverLevel(param1:int):Boolean;
        function stripClubItemsOverLevel(param1:int):Boolean;

    }
}