﻿package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class GetHabboGroupBadgesMessageComposer implements IMessageComposer, IDisposable 
    {


        public function getMessageArray():Array
        {
            return ([]);
        }

        public function dispose():void
        {
        }

        public function get disposed():Boolean
        {
            return (false);
        }


    }
}