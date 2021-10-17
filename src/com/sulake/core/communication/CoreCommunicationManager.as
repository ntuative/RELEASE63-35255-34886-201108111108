package com.sulake.core.communication
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IUpdateReceiver;
    import flash.utils.Dictionary;
    import com.sulake.core.communication.connection.IConnectionStateListener;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.core.communication.connection.SocketConnection;
    import com.sulake.core.communication.enum.ConnectionType;
    import com.sulake.core.communication.protocol.IProtocol;
    import com.sulake.iid.*;

    public class CoreCommunicationManager extends Component implements ICoreCommunicationManager, IUpdateReceiver 
    {

        private var _connections:Dictionary;
        private var var_2596:Dictionary;
        private var var_2597:Dictionary;
        private var var_2598:Array;
        private var var_2599:IConnectionStateListener;

        public function CoreCommunicationManager(param1:IContext, param2:uint=0)
        {
            super(param1, param2);
            this._connections = new Dictionary();
            this.var_2596 = new Dictionary();
            this.var_2597 = new Dictionary();
            this.var_2598 = new Array();
            registerUpdateReceiver(this, 1);
        }

        public function set connectionStateListener(param1:IConnectionStateListener):void
        {
            this.var_2599 = param1;
        }

        override public function dispose():void
        {
            var _loc1_:IConnection;
            var _loc2_:Array;
            var _loc3_:IMessageParser;
            var _loc4_:IMessageEvent;
            removeUpdateReceiver(this);
            for each (_loc1_ in this._connections)
            {
                _loc1_.dispose();
            };
            this._connections = null;
            this.var_2596 = null;
            this.var_2599 = null;
            for each (_loc2_ in this.var_2597)
            {
                while (true)
                {
                    _loc4_ = (_loc2_.pop() as IMessageEvent);
                    if (!_loc4_) break;
                    _loc4_.dispose();
                };
            };
            this.var_2597 = null;
            for each (_loc3_ in this.var_2598)
            {
            };
            (this.var_2596 = null);
            super.dispose();
        }

        public function createConnection(param1:String, param2:uint=0):IConnection
        {
            var _loc3_:IConnection;
            switch (param2)
            {
                case ConnectionType.var_283:
                    (_loc3_ = new SocketConnection(param1, this, this.var_2599));
                    break;
                default:
                    Logger.log(("[CoreCommunicationManager] Unknown connectionType, can not create connection: " + param2));
            };
            (this._connections[param1] = _loc3_);
            return (_loc3_);
        }

        public function queueConnection(param1:String, param2:Function):IConnection
        {
            if (((param1 == null) || (this._connections == null)))
            {
                return (null);
            };
            return (this._connections[param1] as IConnection);
        }

        public function registerProtocolType(param1:String, param2:Class):Boolean
        {
            var _loc3_:Object = new (param2)();
            if ((_loc3_ is IProtocol))
            {
                (this.var_2596[param1] = param2);
                return (true);
            };
            throw (new Error((("[CoreCommunicationManager] Invalid Protocol class defined for protocol type " + param1) + "!")));
        }

        public function getProtocolInstanceOfType(param1:String):IProtocol
        {
            var _loc2_:Class = this.var_2596[param1];
            var _loc3_:IProtocol;
            if (_loc2_ != null)
            {
                (_loc3_ = (new (_loc2_)() as IProtocol));
            }
            else
            {
                throw (new Error((("[CoreCommunicationManager] Could not instantiate Protocol class defined for protocol type " + param1) + "!")));
            };
            return (_loc3_);
        }

        public function addConnectionMessageEvent(param1:String, param2:IMessageEvent):void
        {
            var _loc3_:Array = this.var_2597[param1];
            if (_loc3_ == null)
            {
                (_loc3_ = new Array());
                (this.var_2597[param1] = _loc3_);
            };
            _loc3_.push(param2);
        }

        public function removeConnectionMessageEvent(param1:String, param2:IMessageEvent):void
        {
            var _loc4_:int;
            var _loc3_:Array = this.var_2597[param1];
            if (_loc3_ != null)
            {
                _loc4_ = _loc3_.indexOf(param2);
                if (_loc4_ >= 0)
                {
                    _loc3_.splice(_loc4_, 1);
                };
            };
        }

        public function getMessageEvents(param1:IConnection, param2:Class):Array
        {
            var _loc4_:String;
            var _loc7_:IMessageEvent;
            var _loc3_:String = "";
            for (var _loc10_:* in this._connections)
            {
                _loc4_ = _loc10_;
                _loc10_;
                if (this._connections[_loc4_] == param1)
                {
                    (_loc3_ = _loc4_);
                    break;
                };
            };
            if (_loc3_ == "")
            {
                throw (new Error((("[CoreCommunicationManager] Could not find registered events for connection " + param1) + "!")));
            };
            var _loc5_:Array = this.var_2597[_loc3_];
            var _loc6_:Array = new Array();
            for each (_loc10_ in _loc5_)
            {
                _loc7_ = _loc10_;
                _loc10_;
                if ((_loc7_ is param2))
                {
                    _loc6_.push(_loc7_);
                };
            };
            return (_loc6_);
        }

        public function getMessageParser(param1:Class):IMessageParser
        {
            var _loc2_:IMessageParser;
            var _loc3_:IMessageParser;
            for each (var _loc6_:* in this.var_2598)
            {
                _loc3_ = _loc6_;
                _loc6_;
                if ((_loc3_ is param1))
                {
                    (_loc2_ = _loc3_);
                    break;
                };
            };
            if (_loc2_ == null)
            {
                (_loc2_ = (new (param1)() as IMessageParser));
                if (_loc2_ == null)
                {
                    throw (new Error((("[CoreCommunicationManager] Could not create parser-instance from class: " + param1) + "!")));
                };
                this.var_2598.push(_loc2_);
            };
            return (_loc2_);
        }

        public function update(param1:uint):void
        {
            var _loc2_:IConnection;
            for each (var _loc5_:* in this._connections)
            {
                _loc2_ = _loc5_;
                _loc5_;
                _loc2_.processReceivedData();
            };
        }


    }
}