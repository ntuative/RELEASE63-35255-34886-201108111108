package com.sulake.habbo.session
{
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.utils.Map;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.communication.messages.incoming.users.UserTagsMessageEvent;
    import com.sulake.habbo.session.events.UserTagsReceivedEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.outgoing.users.GetUserTagsMessageComposer;

    public class UserTagManager 
    {

        private var _communication:IHabboCommunicationManager;
        private var var_5024:Map;
        private var _events:IEventDispatcher;

        public function UserTagManager(param1:IEventDispatcher)
        {
            this.var_5024 = new Map();
            this._events = param1;
        }

        public function set communication(param1:IHabboCommunicationManager):void
        {
            this._communication = param1;
            this._communication.addHabboConnectionMessageEvent(new UserTagsMessageEvent(this.onUserTags));
        }

        private function onUserTags(param1:IMessageEvent):void
        {
            var _loc2_:UserTagsMessageEvent = (param1 as UserTagsMessageEvent);
            var _loc3_:int = _loc2_.userId;
            var _loc4_:Array = _loc2_.tags;
            this.var_5024.add(_loc3_, _loc4_);
            this._events.dispatchEvent(new UserTagsReceivedEvent(_loc3_, _loc4_.slice()));
        }

        public function getTags(param1:int):Array
        {
            var _loc2_:Array = (this.var_5024.getValue(param1) as Array);
            if (_loc2_ != null)
            {
                return (_loc2_.slice());
            };
            if (this._communication == null)
            {
                Logger.log("oops! communication interface not ready");
            };
            var _loc3_:IConnection = this._communication.getHabboMainConnection(null);
            _loc3_.send(new GetUserTagsMessageComposer(param1));
            return (null);
        }


    }
}