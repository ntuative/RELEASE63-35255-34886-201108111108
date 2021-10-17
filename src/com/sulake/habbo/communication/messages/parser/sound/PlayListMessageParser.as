package com.sulake.habbo.communication.messages.parser.sound
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.sound.PlayListEntry;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PlayListMessageParser implements IMessageParser 
    {

        private var var_3855:int;
        private var var_3856:Array;


        public function get synchronizationCount():int
        {
            return (this.var_3855);
        }

        public function get playList():Array
        {
            return (this.var_3856);
        }

        public function flush():Boolean
        {
            this.var_3855 = -1;
            this.var_3856 = [];
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc4_:int;
            var _loc5_:int;
            var _loc6_:String;
            var _loc7_:String;
            this.var_3855 = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                _loc4_ = param1.readInteger();
                _loc5_ = param1.readInteger();
                _loc6_ = param1.readString();
                _loc7_ = param1.readString();
                this.var_3856.push(new PlayListEntry(_loc4_, _loc5_, _loc6_, _loc7_));
                _loc3_++;
            };
            return (true);
        }


    }
}