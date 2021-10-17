package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ItemUpdateMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var var_3808:ItemMessageData = null;


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
            this.var_3808 = null;
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }

        public function get data():ItemMessageData
        {
            var _loc1_:ItemMessageData = this.var_3808;
            if (_loc1_ != null)
            {
                _loc1_.setReadOnly();
            };
            return (_loc1_);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            this.var_3808 = ItemDataParser.parseItemData(param1);
            return (true);
        }


    }
}