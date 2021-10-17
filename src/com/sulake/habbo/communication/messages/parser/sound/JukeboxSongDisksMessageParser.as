package com.sulake.habbo.communication.messages.parser.sound
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class JukeboxSongDisksMessageParser implements IMessageParser 
    {

        private var var_3849:Map;
        private var var_3850:int;

        public function JukeboxSongDisksMessageParser()
        {
            this.var_3849 = new Map();
        }

        public function get songDisks():Map
        {
            return (this.var_3849);
        }

        public function get maxLength():int
        {
            return (this.var_3850);
        }

        public function flush():Boolean
        {
            this.var_3849.reset();
            this.var_3850 = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3850 = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int = -1;
            var _loc4_:int = -1;
            var _loc5_:int;
            while (_loc5_ < _loc2_)
            {
                _loc3_ = param1.readInteger();
                _loc4_ = param1.readInteger();
                this.var_3849.add(_loc3_, _loc4_);
                _loc5_++;
            };
            return (true);
        }


    }
}