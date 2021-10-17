package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.UserChangeMessageParser;

    public class UserChangeMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserChangeMessageEvent(param1:Function)
        {
            super(param1, UserChangeMessageParser);
        }

        public function get roomId():int
        {
            return ((var_334 as UserChangeMessageParser).roomId);
        }

        public function get roomCategory():int
        {
            return ((var_334 as UserChangeMessageParser).roomCategory);
        }

        public function get id():int
        {
            return ((var_334 as UserChangeMessageParser).id);
        }

        public function get figure():String
        {
            return ((var_334 as UserChangeMessageParser).figure);
        }

        public function get sex():String
        {
            return ((var_334 as UserChangeMessageParser).sex);
        }

        public function get customInfo():String
        {
            return ((var_334 as UserChangeMessageParser).customInfo);
        }

        public function get achievementScore():int
        {
            return ((var_334 as UserChangeMessageParser).achievementScore);
        }


    }
}