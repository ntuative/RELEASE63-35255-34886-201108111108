package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomVisualizationSettingsParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var var_3815:Boolean = false;
        private var var_3816:Number = 1;
        private var var_3817:Number = 1;


        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function get wallsHidden():Boolean
        {
            return (this.var_3815);
        }

        public function get wallThicknessMultiplier():Number
        {
            return (this.var_3816);
        }

        public function get floorThicknessMultiplier():Number
        {
            return (this.var_3817);
        }

        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this.var_3815 = false;
            this.var_3816 = 1;
            this.var_3817 = 1;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            this.var_3815 = param1.readBoolean();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int = param1.readInteger();
            if (_loc2_ < -2)
            {
                _loc2_ = -2;
            }
            else
            {
                if (_loc2_ > 1)
                {
                    _loc2_ = 1;
                };
            };
            if (_loc3_ < -2)
            {
                _loc3_ = -2;
            }
            else
            {
                if (_loc3_ > 1)
                {
                    _loc3_ = 1;
                };
            };
            this.var_3816 = Math.pow(2, _loc2_);
            this.var_3817 = Math.pow(2, _loc3_);
            return (true);
        }


    }
}