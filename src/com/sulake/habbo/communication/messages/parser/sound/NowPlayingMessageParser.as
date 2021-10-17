package com.sulake.habbo.communication.messages.parser.sound
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class NowPlayingMessageParser implements IMessageParser 
    {

        private var var_3851:int;
        private var _currentPosition:int;
        private var var_3852:int;
        private var var_3853:int;
        private var var_3854:int;


        public function get currentSongId():int
        {
            return (this.var_3851);
        }

        public function get currentPosition():int
        {
            return (this._currentPosition);
        }

        public function get nextSongId():int
        {
            return (this.var_3852);
        }

        public function get nextPosition():int
        {
            return (this.var_3853);
        }

        public function get syncCount():int
        {
            return (this.var_3854);
        }

        public function flush():Boolean
        {
            this.var_3851 = -1;
            this._currentPosition = -1;
            this.var_3852 = -1;
            this.var_3853 = -1;
            this.var_3854 = -1;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3851 = param1.readInteger();
            this._currentPosition = param1.readInteger();
            this.var_3852 = param1.readInteger();
            this.var_3853 = param1.readInteger();
            this.var_3854 = param1.readInteger();
            return (true);
        }


    }
}