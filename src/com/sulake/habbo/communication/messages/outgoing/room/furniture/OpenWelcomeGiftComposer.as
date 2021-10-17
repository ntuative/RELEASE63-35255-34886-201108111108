package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class OpenWelcomeGiftComposer implements IMessageComposer 
    {

        private var _furniId:int;

        public function OpenWelcomeGiftComposer(param1:int)
        {
            this._furniId = param1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this._furniId]);
        }


    }
}