package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.ModMessageParser;

    public class ModMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ModMessageEvent(param1:Function)
        {
            super(param1, ModMessageParser);
        }

        public function getParser():ModMessageParser
        {
            return (var_334 as ModMessageParser);
        }


    }
}