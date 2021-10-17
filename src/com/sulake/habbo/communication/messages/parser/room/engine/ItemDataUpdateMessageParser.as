package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ItemDataUpdateMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _id:int = 0;
        private var var_3809:String;


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

        public function get itemData():String
        {
            return (this.var_3809);
        }

        public function flush():Boolean
        {
            this._id = 0;
            this.var_3809 = "";
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
            var _loc2_:String = param1.readString();
            this._id = int(_loc2_);
            this.var_3809 = param1.readString();
            return (true);
        }


    }
}