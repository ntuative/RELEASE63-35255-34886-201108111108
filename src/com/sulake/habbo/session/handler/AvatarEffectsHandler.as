package com.sulake.habbo.session.handler
{
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectsMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectsMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class AvatarEffectsHandler extends BaseHandler 
    {

        public function AvatarEffectsHandler(param1:IConnection, param2:IRoomHandlerListener)
        {
            super(param1, param2);
            if (param1 == null)
            {
                return;
            };
        }

        private function onAvatarEffects(param1:IMessageEvent):void
        {
            var _loc2_:AvatarEffectsMessageEvent = (param1 as AvatarEffectsMessageEvent);
            var _loc3_:AvatarEffectsMessageParser = (_loc2_.getParser() as AvatarEffectsMessageParser);
            Logger.log(("Received active avatar effects: " + _loc3_.effects));
            if (((listener) && (listener.events)))
            {
            };
        }


    }
}