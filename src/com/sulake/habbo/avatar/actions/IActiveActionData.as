package com.sulake.habbo.avatar.actions
{
    public interface IActiveActionData 
    {

        function get id():String;
        function get actionType():String;
        function get actionParameter():String;
        function set actionParameter(param1:String):void;
        function get startFrame():int;
        function get definition():IActionDefinition;
        function set definition(param1:IActionDefinition):void;
        function get overridingAction():String;
        function set overridingAction(param1:String):void;

    }
}