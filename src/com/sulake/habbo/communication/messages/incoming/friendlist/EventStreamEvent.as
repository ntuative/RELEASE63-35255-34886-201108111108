package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.EventStreamMessageParser;
    import __AS3__.vec.Vector;

    public class EventStreamEvent extends MessageEvent implements IMessageEvent 
    {

        public function EventStreamEvent(param1:Function)
        {
            super(param1, EventStreamMessageParser);
        }

        public function get events():Vector.<EventStreamData>
        {
            return (EventStreamMessageParser(var_334).events);
        }


    }
}