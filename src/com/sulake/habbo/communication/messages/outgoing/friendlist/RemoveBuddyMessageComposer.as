package com.sulake.habbo.communication.messages.outgoing.friendlist
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class RemoveBuddyMessageComposer implements IMessageComposer, IDisposable 
    {

        private var var_3587:Array = new Array();


        public function getMessageArray():Array
        {
            var _loc1_:Array = new Array();
            _loc1_.push(this.var_3587.length);
            var _loc2_:int;
            while (_loc2_ < this.var_3587.length)
            {
                _loc1_.push(this.var_3587[_loc2_]);
                _loc2_++;
            };
            return (_loc1_);
        }

        public function addRemovedFriend(param1:int):void
        {
            this.var_3587.push(param1);
        }

        public function dispose():void
        {
            this.var_3587 = null;
        }

        public function get disposed():Boolean
        {
            return (false);
        }


    }
}