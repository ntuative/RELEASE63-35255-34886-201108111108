package com.sulake.habbo.communication.messages.parser.room.action
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class DanceMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _userId:int = 0;
        private var _danceStyle:int = 0;


        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function get userId():int
        {
            return (this._userId);
        }

        public function get danceStyle():int
        {
            return (this._danceStyle);
        }

        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._userId = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            this._userId = param1.readInteger();
            this._danceStyle = param1.readInteger();
            return (true);
        }


    }
}