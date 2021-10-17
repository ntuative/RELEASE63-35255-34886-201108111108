package com.sulake.habbo.communication.messages.parser.room.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetPlacingErrorParser implements IMessageParser 
    {

        private var var_2550:int;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;


        public function get errorCode():int
        {
            return (this.var_2550);
        }

        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function flush():Boolean
        {
            this.var_2550 = -1;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            this.var_2550 = param1.readInteger();
            return (true);
        }


    }
}