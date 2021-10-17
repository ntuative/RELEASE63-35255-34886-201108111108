package com.sulake.habbo.communication.messages.incoming.room.action
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.action.UseObjectMessageParser;

    public class UseObjectMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UseObjectMessageEvent(param1:Function)
        {
            super(param1, UseObjectMessageParser);
        }

        public function getParser():UseObjectMessageParser
        {
            return (var_334 as UseObjectMessageParser);
        }


    }
}