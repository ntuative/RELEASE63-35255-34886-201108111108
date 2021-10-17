package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PresentOpenedMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var var_3428:String;
        private var var_3429:int;
        private var var_3083:String;


        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function get itemType():String
        {
            return (this.var_3428);
        }

        public function get classId():int
        {
            return (this.var_3429);
        }

        public function get productCode():String
        {
            return (this.var_3083);
        }

        public function flush():Boolean
        {
            this.var_3428 = "";
            this.var_3429 = 0;
            this.var_3083 = "";
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            this.var_3428 = param1.readString();
            this.var_3429 = param1.readInteger();
            this.var_3083 = param1.readString();
            return (true);
        }


    }
}