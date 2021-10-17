package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectSelectedMessageParser;

    public class AvatarEffectSelectedMessageEvent extends MessageEvent 
    {

        public function AvatarEffectSelectedMessageEvent(param1:Function)
        {
            super(param1, AvatarEffectSelectedMessageParser);
        }

        public function getParser():AvatarEffectSelectedMessageParser
        {
            return (var_334 as AvatarEffectSelectedMessageParser);
        }


    }
}