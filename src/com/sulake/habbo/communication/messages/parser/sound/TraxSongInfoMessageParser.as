package com.sulake.habbo.communication.messages.parser.sound
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.sound.SongInfoEntry;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class TraxSongInfoMessageParser implements IMessageParser 
    {

        private var var_3859:Array;


        public function get songs():Array
        {
            return (this.var_3859);
        }

        public function flush():Boolean
        {
            this.var_3859 = new Array();
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc2_:int;
            var _loc3_:String;
            var _loc4_:String;
            var _loc5_:int;
            var _loc6_:String;
            var _loc9_:SongInfoEntry;
            var _loc7_:int = param1.readInteger();
            var _loc8_:int;
            while (_loc8_ < _loc7_)
            {
                _loc2_ = param1.readInteger();
                _loc3_ = param1.readString();
                _loc4_ = param1.readString();
                _loc5_ = param1.readInteger();
                _loc6_ = param1.readString();
                _loc9_ = new SongInfoEntry(_loc2_, _loc5_, _loc3_, _loc6_, _loc4_);
                this.var_3859.push(_loc9_);
                _loc8_++;
            };
            return (true);
        }


    }
}