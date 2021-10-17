package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserUpdateMessageData;
    import com.sulake.habbo.communication.messages.incoming.room.engine.AvatarActionMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserUpdateMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _users:Array = [];


        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function get userUpdateCount():int
        {
            return (this._users.length);
        }

        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._users = [];
            return (true);
        }

        public function getUserUpdateData(param1:int):UserUpdateMessageData
        {
            if (((param1 < 0) || (param1 >= this.userUpdateCount)))
            {
                return (null);
            };
            return (this._users[param1]);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc4_:int;
            var _loc5_:Number;
            var _loc6_:Number;
            var _loc7_:Number;
            var _loc8_:Number;
            var _loc9_:int;
            var _loc10_:int;
            var _loc11_:String;
            var _loc12_:int;
            var _loc13_:int;
            var _loc14_:Array;
            var _loc15_:Number;
            var _loc16_:Number;
            var _loc17_:Number;
            var _loc18_:Boolean;
            var _loc19_:Array;
            var _loc20_:int;
            var _loc21_:UserUpdateMessageData;
            var _loc22_:String;
            var _loc23_:Array;
            var _loc24_:String;
            var _loc25_:String;
            var _loc26_:Array;
            var _loc27_:Number;
            var _loc28_:Number;
            if (param1 == null)
            {
                return (false);
            };
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                _loc4_ = param1.readInteger();
                _loc5_ = param1.readInteger();
                _loc6_ = param1.readInteger();
                _loc7_ = Number(param1.readString());
                _loc8_ = 0;
                _loc9_ = param1.readInteger();
                _loc10_ = param1.readInteger();
                _loc11_ = param1.readString();
                _loc12_ = ((_loc9_ % 8) * 45);
                _loc13_ = ((_loc10_ % 8) * 45);
                _loc14_ = [];
                _loc15_ = 0;
                _loc16_ = 0;
                _loc17_ = 0;
                _loc18_ = false;
                _loc19_ = _loc11_.split("/");
                _loc20_ = 0;
                while (_loc20_ < _loc19_.length)
                {
                    _loc22_ = (_loc19_[_loc20_] as String);
                    _loc23_ = _loc22_.split(" ");
                    _loc24_ = String(_loc23_[0]);
                    _loc25_ = "";
                    if (_loc24_ != "")
                    {
                        if (_loc23_.length >= 2)
                        {
                            _loc25_ = String(_loc23_[1]);
                            switch (_loc24_)
                            {
                                case "mv":
                                    _loc26_ = _loc25_.split(",");
                                    if (_loc26_.length >= 3)
                                    {
                                        _loc15_ = int(_loc26_[0]);
                                        _loc16_ = int(_loc26_[1]);
                                        _loc17_ = Number(_loc26_[2]);
                                        _loc18_ = true;
                                    };
                                    break;
                                case "sit":
                                    _loc27_ = Number(_loc25_);
                                    _loc8_ = _loc27_;
                                    break;
                                case "lay":
                                    _loc28_ = Number(_loc25_);
                                    if (_loc28_ < 0)
                                    {
                                    };
                                    _loc8_ = Math.abs(_loc28_);
                                    break;
                            };
                        };
                        _loc14_.push(new AvatarActionMessageData(_loc24_, _loc25_));
                    };
                    _loc20_++;
                };
                _loc21_ = new UserUpdateMessageData(_loc4_, _loc5_, _loc6_, _loc7_, _loc8_, _loc13_, _loc12_, _loc15_, _loc16_, _loc17_, _loc18_, _loc14_);
                this._users.push(_loc21_);
                _loc3_++;
            };
            return (true);
        }


    }
}