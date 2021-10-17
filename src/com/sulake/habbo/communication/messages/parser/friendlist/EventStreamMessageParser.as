package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.friendlist.EventStreamData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import __AS3__.vec.*;

    public class EventStreamMessageParser implements IMessageParser 
    {

        private var _events:Vector.<EventStreamData>;


        public function get events():Vector.<EventStreamData>
        {
            return (this._events);
        }

        public function flush():Boolean
        {
            this._events = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc2_:int = param1.readInteger();
            this._events = new Vector.<EventStreamData>();
            while (_loc2_-- > 0)
            {
                this._events.push(new EventStreamData(param1.readInteger(), param1.readInteger(), param1.readString(), param1.readString(), param1.readString(), param1.readString(), param1.readInteger(), param1.readInteger(), param1.readInteger(), param1.readBoolean(), param1));
            };
            return (true);
        }


    }
}