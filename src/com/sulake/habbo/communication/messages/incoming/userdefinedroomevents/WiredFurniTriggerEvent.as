package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniTriggerMessageParser;

    public class WiredFurniTriggerEvent extends MessageEvent implements IMessageEvent 
    {

        public function WiredFurniTriggerEvent(param1:Function)
        {
            super(param1, WiredFurniTriggerMessageParser);
        }

        public function getParser():WiredFurniTriggerMessageParser
        {
            return (this.var_334 as WiredFurniTriggerMessageParser);
        }


    }
}