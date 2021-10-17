package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboBroadcastMessageParser;

    public class HabboBroadcastMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboBroadcastMessageEvent(param1:Function)
        {
            super(param1, HabboBroadcastMessageParser);
        }

        public function get messageText():String
        {
            return ((var_334 as HabboBroadcastMessageParser).messageText);
        }

        public function getParser():HabboBroadcastMessageParser
        {
            return (var_334 as HabboBroadcastMessageParser);
        }


    }
}