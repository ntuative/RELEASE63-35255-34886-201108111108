package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class EventStreamData 
    {

        public static const var_1349:uint = 0;
        public static const var_1350:uint = 1;
        public static const var_1351:uint = 2;
        public static const var_1352:uint = 3;
        public static const var_1353:uint = 3;
        public static const var_1357:int = 0;
        public static const var_1358:int = 1;
        public static const var_1359:int = 2;
        public static const var_1360:int = 3;
        public static const LINK_TARGET_OPEN_MOTTO_CHANGER:int = 4;
        public static const var_1361:int = 5;

        private var _id:int;
        private var var_3390:int;
        private var var_3391:String;
        private var var_3392:String;
        private var var_3399:String;
        private var var_3393:String;
        private var var_3394:int;
        private var var_3395:int;
        private var var_3396:int;
        private var var_3397:Boolean;
        private var var_3398:Object;

        public function EventStreamData(param1:int, param2:int, param3:String, param4:String, param5:String, param6:String, param7:int, param8:int, param9:int, param10:Boolean, param11:IMessageDataWrapper)
        {
            this._id = param1;
            this.var_3390 = param2;
            this.var_3391 = param3;
            this.var_3392 = param4;
            this.var_3399 = param5;
            this.var_3393 = param6;
            this.var_3394 = param7;
            this.var_3395 = param8;
            this.var_3396 = param9;
            this.var_3397 = param10;
            this.var_3398 = parse(param2, param11);
        }

        protected static function parse(param1:int, param2:IMessageDataWrapper):Object
        {
            var _loc3_:Object = new Object();
            switch (param1)
            {
                case var_1349:
                    _loc3_.friendId = param2.readString();
                    _loc3_.friendName = param2.readString();
                    break;
                case var_1350:
                    _loc3_.roomId = param2.readString();
                    _loc3_.roomName = param2.readString();
                    break;
                case var_1351:
                    _loc3_.achievementCode = param2.readString();
                    break;
                case var_1352:
                    _loc3_.motto = param2.readString();
            };
            return (_loc3_);
        }


        public function get id():int
        {
            return (this._id);
        }

        public function get actionId():int
        {
            return (this.var_3390);
        }

        public function get accountId():String
        {
            return (this.var_3391);
        }

        public function get accountName():String
        {
            return (this.var_3392);
        }

        public function get imageFilePath():String
        {
            return (this.var_3393);
        }

        public function get minutesSinceEvent():int
        {
            return (this.var_3394);
        }

        public function get linkTargetType():int
        {
            return (this.var_3395);
        }

        public function get numberOfLikes():int
        {
            return (this.var_3396);
        }

        public function get isLikable():Boolean
        {
            return (this.var_3397);
        }

        public function get extraDataStruct():Object
        {
            return (this.var_3398);
        }

        public function get accountGender():String
        {
            return (this.var_3399);
        }


    }
}class Struct 
{


}

class FriendMadeStruct extends Struct 
{

    public var friendId:String;
    public var friendName:String;

    public function FriendMadeStruct(param1:String, param2:String)
    {
        this.friendId = param1;
        this.friendName = param2;
    }

}

class RoomLikedStruct extends Struct 
{

    public var roomId:String;
    public var roomName:String;

    public function RoomLikedStruct(param1:String, param2:String)
    {
        this.roomId = param1;
        this.roomName = param2;
    }

}

class AchievementEarnedStruct extends Struct 
{

    public var achievementCode:String;

    public function AchievementEarnedStruct(param1:String)
    {
        this.achievementCode = param1;
    }

}
























