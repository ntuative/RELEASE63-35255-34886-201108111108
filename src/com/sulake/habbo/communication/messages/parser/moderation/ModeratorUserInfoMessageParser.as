﻿package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorUserInfoData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ModeratorUserInfoMessageParser implements IMessageParser 
    {

        private var _data:ModeratorUserInfoData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._data = new ModeratorUserInfoData(param1);
            return (true);
        }

        public function get data():ModeratorUserInfoData
        {
            return (this._data);
        }


    }
}