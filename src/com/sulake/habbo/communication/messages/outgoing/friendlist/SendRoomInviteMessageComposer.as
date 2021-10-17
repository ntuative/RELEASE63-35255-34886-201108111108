package com.sulake.habbo.communication.messages.outgoing.friendlist
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class SendRoomInviteMessageComposer implements IMessageComposer, IDisposable 
    {

        private var var_3588:Array = new Array();
        private var var_3453:String;

        public function SendRoomInviteMessageComposer(param1:String)
        {
            this.var_3453 = param1;
        }

        public function getMessageArray():Array
        {
            var _loc1_:Array = new Array();
            _loc1_.push(this.var_3588.length);
            var _loc2_:int;
            while (_loc2_ < this.var_3588.length)
            {
                _loc1_.push(this.var_3588[_loc2_]);
                _loc2_++;
            };
            _loc1_.push(this.var_3453);
            return (_loc1_);
        }

        public function addInvitedFriend(param1:int):void
        {
            this.var_3588.push(param1);
        }

        public function dispose():void
        {
            this.var_3588 = null;
        }

        public function get disposed():Boolean
        {
            return (false);
        }


    }
}