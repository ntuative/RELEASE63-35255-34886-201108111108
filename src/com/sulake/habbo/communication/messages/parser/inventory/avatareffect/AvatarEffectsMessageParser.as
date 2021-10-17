package com.sulake.habbo.communication.messages.parser.inventory.avatareffect
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffect;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AvatarEffectsMessageParser implements IMessageParser 
    {

        private var var_3705:Array;


        public function flush():Boolean
        {
            this.var_3705 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc4_:AvatarEffect;
            this.var_3705 = new Array();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                _loc4_ = new AvatarEffect();
                _loc4_.type = param1.readInteger();
                _loc4_.duration = param1.readInteger();
                _loc4_.inactiveEffectsInInventory = param1.readInteger();
                _loc4_.secondsLeftIfActive = param1.readInteger();
                this.var_3705.push(_loc4_);
                _loc3_++;
            };
            return (true);
        }

        public function get effects():Array
        {
            return (this.var_3705);
        }


    }
}