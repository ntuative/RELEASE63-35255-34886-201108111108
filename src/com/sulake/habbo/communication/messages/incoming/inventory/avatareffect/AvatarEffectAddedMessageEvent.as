package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectAddedMessageParser;

    public class AvatarEffectAddedMessageEvent extends MessageEvent 
    {

        public function AvatarEffectAddedMessageEvent(param1:Function)
        {
            super(param1, AvatarEffectAddedMessageParser);
        }

        public function getParser():AvatarEffectAddedMessageParser
        {
            return (var_334 as AvatarEffectAddedMessageParser);
        }


    }
}