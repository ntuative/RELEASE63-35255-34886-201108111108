package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.InstantMessageErrorMessageParser;

    public class InstantMessageErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function InstantMessageErrorEvent(param1:Function)
        {
            super(param1, InstantMessageErrorMessageParser);
        }

        public function getParser():InstantMessageErrorMessageParser
        {
            return (this.var_334 as InstantMessageErrorMessageParser);
        }


    }
}