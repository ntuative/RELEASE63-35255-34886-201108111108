package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomPropertyMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _floorType:String = null;
        private var var_3192:String = null;
        private var var_3193:String = null;
        private var var_3814:String = null;


        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function get floorType():String
        {
            return (this._floorType);
        }

        public function get wallType():String
        {
            return (this.var_3192);
        }

        public function get landscapeType():String
        {
            return (this.var_3193);
        }

        public function get animatedLandskapeType():String
        {
            return (this.var_3814);
        }

        public function flush():Boolean
        {
            this._floorType = null;
            this.var_3192 = null;
            this.var_3193 = null;
            this.var_3814 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc2_:String = param1.readString();
            var _loc3_:String = param1.readString();
            switch (_loc2_)
            {
                case "floor":
                    this._floorType = _loc3_;
                    break;
                case "wallpaper":
                    this.var_3192 = _loc3_;
                    break;
                case "landscape":
                    this.var_3193 = _loc3_;
                    break;
                case "landscapeanim":
                    this.var_3814 = _loc3_;
                    break;
            };
            return (true);
        }


    }
}