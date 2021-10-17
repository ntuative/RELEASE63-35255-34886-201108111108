package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectExpiredMessageParser;

    public class AvatarEffectExpiredMessageEvent extends MessageEvent 
    {

        public function AvatarEffectExpiredMessageEvent(param1:Function)
        {
            super(param1, AvatarEffectExpiredMessageParser);
        }

        public function getParser():AvatarEffectExpiredMessageParser
        {
            return (var_334 as AvatarEffectExpiredMessageParser);
        }


    }
}