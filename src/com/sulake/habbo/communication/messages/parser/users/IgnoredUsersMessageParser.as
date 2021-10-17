package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IgnoredUsersMessageParser implements IMessageParser 
    {

        protected var _ignoredUsers:Array = null;

        public function IgnoredUsersMessageParser()
        {
            this._ignoredUsers = [];
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._ignoredUsers = [];
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this._ignoredUsers.push(param1.readString());
                _loc3_++;
            };
            return (true);
        }

        public function get ignoredUsers():Array
        {
            return (this._ignoredUsers.slice());
        }


    }
}