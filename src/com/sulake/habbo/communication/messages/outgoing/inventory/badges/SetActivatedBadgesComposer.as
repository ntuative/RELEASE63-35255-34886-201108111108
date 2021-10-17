package com.sulake.habbo.communication.messages.outgoing.inventory.badges
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class SetActivatedBadgesComposer implements IMessageComposer 
    {

        private const var_3597:int = 5;

        private var var_3596:Array;

        public function SetActivatedBadgesComposer()
        {
            this.var_3596 = new Array();
        }

        public function addActivatedBadge(param1:String):void
        {
            if (this.var_3596.length >= this.var_3597)
            {
                return;
            };
            this.var_3596.push(param1);
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            var _loc1_:Array = new Array();
            var _loc2_:int = 1;
            while (_loc2_ <= this.var_3597)
            {
                if (_loc2_ <= this.var_3596.length)
                {
                    _loc1_.push(_loc2_);
                    _loc1_.push(this.var_3596[(_loc2_ - 1)]);
                }
                else
                {
                    _loc1_.push(_loc2_);
                    _loc1_.push("");
                };
                _loc2_++;
            };
            return (_loc1_);
        }


    }
}