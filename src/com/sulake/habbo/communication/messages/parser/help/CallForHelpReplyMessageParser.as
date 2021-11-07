﻿package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CallForHelpReplyMessageParser implements IMessageParser 
    {

        private var _message:String;


        public function get message():String
        {
            return (this._message);
        }

        public function flush():Boolean
        {
            this._message = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._message = param1.readString();
            return (true);
        }


    }
}