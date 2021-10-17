package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class DiceValueMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _id:int;
        private var var_2605:int;


        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get value():int
        {
            return (this.var_2605);
        }

        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._id = -1;
            this.var_2605 = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            this._id = param1.readInteger();
            this.var_2605 = param1.readInteger();
            return (true);
        }


    }
}