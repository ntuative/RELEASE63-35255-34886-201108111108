package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.TutorialStatusMessageParser;

    public class TutorialStatusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function TutorialStatusMessageEvent(param1:Function)
        {
            super(param1, TutorialStatusMessageParser);
        }

        public function getParser():TutorialStatusMessageParser
        {
            return (var_334 as TutorialStatusMessageParser);
        }


    }
}