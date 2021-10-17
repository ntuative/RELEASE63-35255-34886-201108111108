package com.sulake.habbo.friendbar.data
{
    public class FriendNotification 
    {

        public static const var_1385:int = -1;
        public static const var_2104:int = 0;
        public static const TYPE_ACHIEVEMENT:int = 1;
        public static const var_2105:int = 2;

        public var typeCode:int = -1;
        public var message:String;
        public var viewOnce:Boolean;

        public function FriendNotification(param1:int, param2:String, param3:Boolean)
        {
            this.typeCode = param1;
            this.message = param2;
            this.viewOnce = param3;
        }

        public static function typeCodeToString(param1:int):String
        {
            switch (param1)
            {
                case var_1385:
                    return ("instant_message");
                case var_2104:
                    return ("room_event");
                case TYPE_ACHIEVEMENT:
                    return ("achievement");
                case var_2105:
                    return ("quest");
            };
            return ("unknown");
        }


    }
}