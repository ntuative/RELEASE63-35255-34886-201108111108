package com.sulake.habbo.communication.messages.incoming.room.action
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.action.AvatarEffectMessageParser;

    public class AvatarEffectMessageEvent extends MessageEvent 
    {

        public function AvatarEffectMessageEvent(param1:Function)
        {
            super(param1, AvatarEffectMessageParser);
        }

        public function getParser():AvatarEffectMessageParser
        {
            return (var_334 as AvatarEffectMessageParser);
        }


    }
}