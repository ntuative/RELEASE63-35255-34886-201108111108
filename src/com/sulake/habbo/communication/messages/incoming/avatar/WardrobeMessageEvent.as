package com.sulake.habbo.communication.messages.incoming.avatar
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.avatar.WardrobeMessageParser;

    public class WardrobeMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public static const var_2166:int = 0;
        public static const var_2167:int = 1;

        public function WardrobeMessageEvent(param1:Function)
        {
            super(param1, WardrobeMessageParser);
        }

        private function getParser():WardrobeMessageParser
        {
            return (this.var_334 as WardrobeMessageParser);
        }

        public function get outfits():Array
        {
            return (this.getParser().outfits);
        }

        public function get state():int
        {
            return (this.getParser().state);
        }


    }
}