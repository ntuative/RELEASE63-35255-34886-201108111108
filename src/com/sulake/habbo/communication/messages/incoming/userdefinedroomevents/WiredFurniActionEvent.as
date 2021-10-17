package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniActionMessageParser;

    public class WiredFurniActionEvent extends MessageEvent implements IMessageEvent 
    {

        public function WiredFurniActionEvent(param1:Function)
        {
            super(param1, WiredFurniActionMessageParser);
        }

        public function getParser():WiredFurniActionMessageParser
        {
            return (this.var_334 as WiredFurniActionMessageParser);
        }


    }
}