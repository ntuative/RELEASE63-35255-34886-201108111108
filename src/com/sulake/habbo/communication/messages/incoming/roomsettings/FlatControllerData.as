﻿package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatControllerData 
    {

        private var _userId:int;
        private var _userName:String;
        private var _selected:Boolean;

        public function FlatControllerData(param1:IMessageDataWrapper)
        {
            this._userId = param1.readInteger();
            this._userName = param1.readString();
        }

        public function get userId():int
        {
            return (this._userId);
        }

        public function get userName():String
        {
            return (this._userName);
        }

        public function get selected():Boolean
        {
            return (this._selected);
        }

        public function set selected(param1:Boolean):void
        {
            this._selected = param1;
        }


    }
}