package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ObjectRemoveMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _id:int;
        private var var_3810:Boolean;


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

        public function get isExpired():Boolean
        {
            return (this.var_3810);
        }

        public function flush():Boolean
        {
            this._id = 0;
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            this._id = int(param1.readString());
            this.var_3810 = (param1.readInteger() == 1);
            return (true);
        }


    }
}