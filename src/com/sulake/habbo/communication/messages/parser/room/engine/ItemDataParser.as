package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ItemDataParser 
    {


        public static function parseItemData(param1:IMessageDataWrapper):ItemMessageData
        {
            var _loc12_:String;
            var _loc13_:String;
            var _loc14_:int;
            var _loc15_:int;
            var _loc16_:int;
            var _loc17_:int;
            var _loc18_:String;
            var _loc19_:Array;
            var _loc20_:Number;
            var _loc21_:Number;
            var _loc22_:Number;
            var _loc2_:int = int(param1.readString());
            var _loc3_:int = param1.readInteger();
            var _loc4_:String = param1.readString();
            var _loc5_:String = param1.readString();
            var _loc6_:Boolean = param1.readBoolean();
            var _loc7_:int;
            var _loc8_:Number = parseFloat(_loc5_);
            if (!isNaN(_loc8_))
            {
                _loc7_ = int(_loc5_);
            };
            Logger.log("\n\n PARSING WALL ITEM: ");
            Logger.log(("wallItemId: " + _loc2_));
            Logger.log(("wallItemTypeId: " + _loc3_));
            Logger.log(("location: " + _loc4_));
            Logger.log(("dataStr: " + _loc5_));
            Logger.log(("state: " + _loc7_));
            var _loc9_:ItemMessageData;
            var _loc10_:Array;
            var _loc11_:String;
            if (_loc4_.indexOf(":") == 0)
            {
                _loc9_ = new ItemMessageData(_loc2_, _loc3_, false);
                _loc10_ = _loc4_.split(" ");
                if (_loc10_.length >= 3)
                {
                    _loc12_ = String(_loc10_[0]);
                    _loc13_ = String(_loc10_[1]);
                    _loc11_ = String(_loc10_[2]);
                    if (((_loc12_.length > 3) && (_loc13_.length > 2)))
                    {
                        _loc12_ = _loc12_.substr(3);
                        _loc13_ = _loc13_.substr(2);
                        _loc10_ = _loc12_.split(",");
                        if (_loc10_.length >= 2)
                        {
                            _loc14_ = int(_loc10_[0]);
                            _loc15_ = int(_loc10_[1]);
                            _loc10_ = _loc13_.split(",");
                            if (_loc10_.length >= 2)
                            {
                                _loc16_ = int(_loc10_[0]);
                                _loc17_ = int(_loc10_[1]);
                                _loc9_.wallX = _loc14_;
                                _loc9_.wallY = _loc15_;
                                _loc9_.localX = _loc16_;
                                _loc9_.localY = _loc17_;
                                _loc9_.dir = _loc11_;
                                _loc9_.data = _loc5_;
                                _loc9_.state = _loc7_;
                            };
                        };
                    };
                };
            }
            else
            {
                _loc9_ = new ItemMessageData(_loc2_, _loc3_, true);
                _loc10_ = _loc4_.split(" ");
                if (_loc10_.length >= 2)
                {
                    _loc11_ = String(_loc10_[0]);
                    if (((_loc11_ == "rightwall") || (_loc11_ == "frontwall")))
                    {
                        _loc11_ = "r";
                    }
                    else
                    {
                        _loc11_ = "l";
                    };
                    _loc18_ = String(_loc10_[1]);
                    _loc19_ = _loc18_.split(",");
                    if (_loc19_.length >= 3)
                    {
                        _loc20_ = 0;
                        _loc21_ = parseFloat(_loc19_[0]);
                        _loc22_ = parseFloat(_loc19_[1]);
                        _loc9_.y = _loc21_;
                        _loc9_.z = _loc22_;
                        _loc9_.dir = _loc11_;
                        _loc9_.data = _loc5_;
                        _loc9_.state = _loc7_;
                    };
                };
            };
            _loc9_.knownAsUsable = _loc6_;
            return (_loc9_);
        }


    }
}