package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class ViralTeaserFoundMessageComposer implements IMessageComposer 
    {

        private var _roomId:int;
        private var _roomCategory:int;

        public function ViralTeaserFoundMessageComposer(param1:int=0, param2:int=0)
        {
            this._roomId = param1;
            this._roomCategory = param2;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([]);
        }


    }
}