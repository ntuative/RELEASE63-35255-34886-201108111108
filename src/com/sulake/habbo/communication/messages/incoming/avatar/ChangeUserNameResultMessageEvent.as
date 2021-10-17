package com.sulake.habbo.communication.messages.incoming.avatar
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.avatar.ChangeUserNameResultMessageParser;

    public class ChangeUserNameResultMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public static var var_445:int = 0;
        public static var var_1744:int = 1;
        public static var var_1745:int = 2;
        public static var var_1746:int = 3;
        public static var var_1747:int = 4;
        public static var var_1748:int = 5;
        public static var var_1749:int = 6;
        public static var var_1750:int = 7;

        public function ChangeUserNameResultMessageEvent(param1:Function)
        {
            super(param1, ChangeUserNameResultMessageParser);
        }

        public function getParser():ChangeUserNameResultMessageParser
        {
            return (var_334 as ChangeUserNameResultMessageParser);
        }


    }
}