package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectActivatedMessageParser;

    public class AvatarEffectActivatedMessageEvent extends MessageEvent 
    {

        public function AvatarEffectActivatedMessageEvent(param1:Function)
        {
            super(param1, AvatarEffectActivatedMessageParser);
        }

        public function getParser():AvatarEffectActivatedMessageParser
        {
            return (var_334 as AvatarEffectActivatedMessageParser);
        }


    }
}