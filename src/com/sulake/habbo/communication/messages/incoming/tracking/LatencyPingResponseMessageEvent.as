package com.sulake.habbo.communication.messages.incoming.tracking
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.tracking.LatencyPingResponseMessageParser;

    public class LatencyPingResponseMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function LatencyPingResponseMessageEvent(param1:Function)
        {
            super(param1, LatencyPingResponseMessageParser);
        }

        public function getParser():LatencyPingResponseMessageParser
        {
            return (var_334 as LatencyPingResponseMessageParser);
        }


    }
}