package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ObjectDataParser 
    {


        public static function parseObjectData(param1:IMessageDataWrapper):ObjectMessageData
        {
            if (param1 == null)
            {
                return (null);
            };
            var _loc2_:int = param1.readInteger();
            var _loc3_:ObjectMessageData = new ObjectMessageData(_loc2_);
            var _loc4_:int = param1.readInteger();
            _loc3_.type = _loc4_;
            _loc3_.x = param1.readInteger();
            _loc3_.y = param1.readInteger();
            _loc3_.dir = ((param1.readInteger() % 8) * 45);
            _loc3_.z = Number(param1.readString());
            _loc3_.extra = param1.readInteger();
            _loc3_.data = param1.readString();
            var _loc5_:Number = parseFloat(_loc3_.data);
            if (!isNaN(_loc5_))
            {
                _loc3_.state = int(_loc3_.data);
            };
            _loc3_.expiryTime = param1.readInteger();
            _loc3_.knownAsUsable = param1.readBoolean();
            if (_loc4_ < 0)
            {
                _loc3_.staticClass = param1.readString();
            };
            return (_loc3_);
        }


    }
}