package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GamePlayerValueMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _userId:int = 0;
        private var var_2605:int = 0;


        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function get userId():int
        {
            return (this._userId);
        }

        public function get value():int
        {
            return (this.var_2605);
        }

        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._userId = param1.readInteger();
            this.var_2605 = param1.readInteger();
            return (true);
        }


    }
}