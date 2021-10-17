package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.UnseenItemsParser;

    public class UnseenItemsEvent extends MessageEvent implements IMessageEvent 
    {

        public function UnseenItemsEvent(param1:Function)
        {
            super(param1, UnseenItemsParser);
        }

        public function getParser():UnseenItemsParser
        {
            return (var_334 as UnseenItemsParser);
        }


    }
}