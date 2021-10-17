package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IUnknown;

    public interface IHabboModeration extends IUnknown 
    {

        function userSelected(param1:int, param2:String):void;

    }
}