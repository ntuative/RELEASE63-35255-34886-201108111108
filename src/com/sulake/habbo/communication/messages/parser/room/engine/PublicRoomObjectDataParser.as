package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.habbo.communication.messages.incoming.room.engine.PublicRoomObjectMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PublicRoomObjectDataParser 
    {


        public static function parseObjectData(param1:IMessageDataWrapper):PublicRoomObjectMessageData
        {
            if (param1 == null)
            {
                return (null);
            };
            var _loc2_:Boolean = Boolean(param1.readInteger());
            var _loc3_:PublicRoomObjectMessageData = new PublicRoomObjectMessageData();
            var _loc4_:String = param1.readString();
            _loc3_.name = _loc4_;
            var _loc5_:String = param1.readString();
            _loc3_.type = _loc5_;
            _loc3_.x = param1.readInteger();
            _loc3_.y = param1.readInteger();
            _loc3_.z = param1.readInteger();
            if (!_loc2_)
            {
                _loc3_.dir = ((param1.readInteger() % 8) * 45);
            }
            else
            {
                _loc3_.sizeX = param1.readInteger();
                _loc3_.sizeY = param1.readInteger();
            };
            return (_loc3_);
        }


    }
}