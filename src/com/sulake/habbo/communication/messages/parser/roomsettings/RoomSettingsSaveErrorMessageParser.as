package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomSettingsSaveErrorMessageParser implements IMessageParser 
    {

        public static const var_1923:int = 1;
        public static const var_1924:int = 2;
        public static const var_1925:int = 3;
        public static const var_1926:int = 4;
        public static const var_1922:int = 5;
        public static const var_1927:int = 6;
        public static const var_1917:int = 7;
        public static const var_1918:int = 8;
        public static const var_1928:int = 9;
        public static const var_1919:int = 10;
        public static const var_1920:int = 11;
        public static const var_1921:int = 12;

        private var _roomId:int;
        private var var_2550:int;
        private var var_3146:String;


        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._roomId = param1.readInteger();
            this.var_2550 = param1.readInteger();
            this.var_3146 = param1.readString();
            return (true);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get errorCode():int
        {
            return (this.var_2550);
        }

        public function get info():String
        {
            return (this.var_3146);
        }


    }
}