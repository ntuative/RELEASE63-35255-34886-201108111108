package com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class AvatarEffectSelectedComposer implements IMessageComposer 
    {

        private var _type:int;

        public function AvatarEffectSelectedComposer(param1:int)
        {
            this._type = param1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            var _loc1_:Array = new Array();
            _loc1_.push(this._type);
            return (_loc1_);
        }


    }
}