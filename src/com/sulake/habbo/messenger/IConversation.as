package com.sulake.habbo.messenger
{
    public interface IConversation 
    {

        function get id():int;
        function get name():String;
        function get selected():Boolean;
        function get messages():Array;
        function get newMessageArrived():Boolean;
        function get figure():String;
        function get followingAllowed():Boolean;
        function get disposed():Boolean;

    }
}