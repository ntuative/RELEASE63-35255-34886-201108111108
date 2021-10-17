package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.MessengerErrorMessageParser;

    public class MessengerErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function MessengerErrorEvent(param1:Function)
        {
            super(param1, MessengerErrorMessageParser);
        }

        public function getParser():MessengerErrorMessageParser
        {
            return (this.var_334 as MessengerErrorMessageParser);
        }


    }
}