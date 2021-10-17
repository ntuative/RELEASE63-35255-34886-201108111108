package com.sulake.habbo.communication
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.communication.connection.IConnectionStateListener;
    import com.sulake.core.communication.ICoreCommunicationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.communication.messages.IMessageConfiguration;
    import flash.utils.Timer;
    import com.sulake.iid.IIDCoreCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import flash.events.Event;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.communication.messages.outgoing.handshake.DisconnectMessageComposer;
    import com.sulake.core.communication.protocol.IProtocol;
    import com.sulake.habbo.communication.enum.HabboProtocolType;
    import com.sulake.habbo.communication.protocol.WedgieProtocol;
    import com.sulake.habbo.communication.enum.HabboConnectionType;
    import com.sulake.core.communication.enum.ConnectionType;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.Core;
    import com.sulake.core.utils.ErrorReportStorage;
    import flash.events.TimerEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.tracking.HabboErrorVariableEnum;
    import com.sulake.iid.*;

    public class HabboCommunicationManager extends Component implements IHabboCommunicationManager, IConnectionStateListener 
    {

        private const var_3875:int = 2;

        private var var_2588:ICoreCommunicationManager;
        private var var_3344:IHabboConfigurationManager;
        private var _connection:IConnection;
        private var var_3048:int = 0;
        private var var_3777:IMessageConfiguration = new HabboMessages();
        private var var_2783:String = "";
        private var var_3876:Array = [];
        private var var_3877:int = -1;
        private var var_3878:Timer = new Timer(100, 1);
        private var var_3879:int = 1;
        private var var_3880:String = "";
        private var var_3881:Boolean = false;
        private var var_3882:Boolean = false;
        private var var_3883:Boolean = false;
        private var _a4:Array = [65191, 65178, 65178, 65177, 65185];

        public function HabboCommunicationManager(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            lock();
            this.queueInterface(new IIDCoreCommunicationManager(), this.onCoreCommunicationManagerInit);
            this.queueInterface(new IIDHabboConfigurationManager(), this.onHabboConfigurationInit);
            param1.events.addEventListener(Event.UNLOAD, this.unloading);
        }

        public function get mode():int
        {
            return (this.var_3048);
        }

        public function set mode(param1:int):void
        {
            this.var_3048 = param1;
        }

        public function get port():int
        {
            if ((((this.var_3876.length == 0) || (this.var_3877 < 0)) || (this.var_3877 >= this.var_3876.length)))
            {
                return (0);
            };
            return (this.var_3876[this.var_3877]);
        }

        private function unloading(param1:Event):void
        {
            if (this._connection)
            {
                this._connection.send(new DisconnectMessageComposer());
                this._connection.dispose();
                this._connection = null;
            };
        }

        override public function dispose():void
        {
            if (this._connection)
            {
                this._connection.dispose();
                this._connection = null;
            };
            if (this.var_2588)
            {
                this.var_2588.release(new IIDCoreCommunicationManager());
                this.var_2588 = null;
            };
            if (this.var_3344)
            {
                this.var_3344.release(new IIDHabboConfigurationManager());
                this.var_3344 = null;
            };
            super.dispose();
        }

        private function onCoreCommunicationManagerInit(param1:IID=null, param2:IUnknown=null):void
        {
            var _loc3_:IProtocol;
            Logger.log(("Habbo Communication Manager: Core Communication Manager found:: " + [param1, param2]));
            if (param2 != null)
            {
                this.var_2588 = (param2 as ICoreCommunicationManager);
                this.var_2588.connectionStateListener = this;
                this.var_2588.registerProtocolType(HabboProtocolType.var_281, WedgieProtocol);
                this._connection = this.var_2588.createConnection(HabboConnectionType.var_282, ConnectionType.var_283);
                _loc3_ = this.var_2588.getProtocolInstanceOfType(HabboProtocolType.var_281);
                this._connection.registerMessageClasses(this.var_3777);
                this._connection.protocol = _loc3_;
                this._connection.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
                this._connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
                this._connection.addEventListener(Event.CONNECT, this.onConnect);
                this.tryUnlock();
            };
        }

        private function onHabboConfigurationInit(param1:IID=null, param2:IUnknown=null):void
        {
            var _loc3_:Array;
            var _loc4_:Array;
            var _loc5_:Array;
            var _loc6_:Array;
            var _loc7_:String;
            var _loc8_:String;
            var _loc9_:Array;
            var _loc10_:String;
            var _loc11_:Array;
            var _loc12_:int;
            if (param2 != null)
            {
                this.var_3344 = (param2 as IHabboConfigurationManager);
                _loc3_ = [65162, 65162, 65158, 65155];
                _loc4_ = [65234, 65174, 65168, 65175, 65165, 65229];
                _loc5_ = [65170, 65162, 65157, 65155];
                _loc6_ = [65186, 65168, 65178, 65171, 65171];
                _loc8_ = this.var_3344.getKey("connection.info.host", null);
                _loc7_ = this.var_3344.getKey("connection.info.port", null);
                
                if (_loc7_ == null)
                {
                    Core.crash(this.getKey([this._a4, _loc6_, _loc4_, _loc3_], 0), Core.var_86);
                    return;
                };

                this.var_3876 = [];
                _loc9_ = _loc7_.split(",");
                for each (_loc10_ in _loc9_)
                {
                    this.var_3876.push(parseInt(_loc10_.replace(" ", "")));
                };
                this.var_2783 = _loc8_;
                this.var_3882 = true;
                if (this.var_3883)
                {
                    this.nextPort();
                };
                this.tryUnlock();
            };
        }

        private function getKey(param1:Array, param2:int):String
        {
            var _loc4_:Array;
            var _loc5_:int;
            var _loc3_:String = "";
            for each (_loc4_ in param1)
            {
                for each (_loc5_ in _loc4_)
                {
                    _loc3_ = (_loc3_ + String.fromCharCode(((65290 - _loc5_) + param2--)));
                };
            };
            return (_loc3_);
        }

        private function tryUnlock():void
        {
            if (((this.var_3344) && (this.var_2588)))
            {
                unlock();
            };
        }

        public function initConnection(param1:String):void
        {
            switch (param1)
            {
                case HabboConnectionType.var_282:
                    if (this.var_3344 == null)
                    {
                        Core.crash("Tried to connect to proxy but configuration was null", Core.var_86);
                        return;
                    };
                    if (this._connection == null)
                    {
                        Core.crash("Tried to connect to proxy but connection was null", Core.var_86);
                        return;
                    };
                    this.var_3883 = true;
                    if (this.var_3882)
                    {
                        this.nextPort();
                    };
                    return;
                default:
                    Logger.log(("Unknown Habbo Connection Type: " + param1));
            };
        }

        private function nextPort():void
        {
            var _loc1_:int;
            if (this._connection.connected)
            {
                Logger.log("Warning: Already connected so will not try to connect again!");
                return;
            };
            this.var_3877++;
            if (this.var_3877 >= this.var_3876.length)
            {
                ErrorReportStorage.addDebugData("ConnectionRetry", ("Connection attempt " + this.var_3879));
                this.var_3879++;
                _loc1_ = this.var_3875;
                if (this.var_3876.length == 1)
                {
                    _loc1_++;
                };
                if (this.var_3879 <= _loc1_)
                {
                    this.var_3877 = 0;
                }
                else
                {
                    if (this.var_3881)
                    {
                        return;
                    };
                    this.var_3881 = true;
                    Core.error("Connection failed to host and ports", true, Core.var_86);
                    return;
                };
            };
            this._connection.timeout = (this.var_3879 * 10000);
            
            if (false == false)
            {
                this._connection.init(this.var_2783, this.var_3876[this.var_3877]);
            };
        }

        private function onIOError(param1:IOErrorEvent):void
        {
            Logger.log(("[HabboCommunicationManager] IO Error: " + param1.text));
            switch (param1.type)
            {
                case IOErrorEvent.IO_ERROR:
                    break;
                case IOErrorEvent.DISK_ERROR:
                    break;
                case IOErrorEvent.NETWORK_ERROR:
                    break;
                case IOErrorEvent.VERIFY_ERROR:
                    break;
            };
            ErrorReportStorage.addDebugData("Communication IO Error", ((((("IOError " + param1.type) + " on connect: ") + param1.text) + ". Port was ") + this.var_3876[this.var_3877]));
            this.tryNextPort();
        }

        private function onConnect(param1:Event):void
        {
            ErrorReportStorage.addDebugData("Connection", (("Connected with " + this.var_3879) + " attempts"));
        }

        private function tryNextPort():void
        {
            this.var_3878.addEventListener(TimerEvent.TIMER, this.onTryNextPort);
            this.var_3878.start();
        }

        private function onTryNextPort(param1:TimerEvent):void
        {
            this.var_3878.stop();
            this.nextPort();
        }

        private function onSecurityError(param1:SecurityErrorEvent):void
        {
            Logger.log(("[HabboCommunicationManager] Security Error: " + param1.text));
            ErrorReportStorage.addDebugData("Communication Security Error", ((("SecurityError on connect: " + param1.text) + ". Port was ") + this.var_3876[this.var_3877]));
            this.tryNextPort();
        }

        public function getHabboMainConnection(param1:Function):IConnection
        {
            return ((this.var_2588) ? this.var_2588.queueConnection(HabboConnectionType.var_282, param1) : null);
        }

        public function addHabboConnectionMessageEvent(param1:IMessageEvent):void
        {
            if (this.var_2588)
            {
                this.var_2588.addConnectionMessageEvent(HabboConnectionType.var_282, param1);
            };
        }

        public function habboWebLogin(param1:String, param2:String):IHabboWebLogin
        {
            var _loc3_:String = "";
            _loc3_ = this.var_3344.getKey("url.prefix", _loc3_);
            _loc3_ = _loc3_.replace("http://", "");
            _loc3_ = _loc3_.replace("https://", "");
            return (new HabboWebLogin(param1, param2, _loc3_));
        }

        public function connectionInit(param1:String, param2:int):void
        {
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_284, param1);
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_285, String(param2));
        }

        public function messageReceived(param1:String, param2:String):void
        {
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_286, String(new Date().getTime()));
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_287, ((param1 + " ") + param2));
            if (this.var_3880.length > 0)
            {
                this.var_3880 = (this.var_3880 + (",R:" + param1));
            }
            else
            {
                this.var_3880 = ("R:" + param1);
            };
            if (this.var_3880.length > 150)
            {
                this.var_3880 = this.var_3880.substring((this.var_3880.length - 150));
            };
            ErrorReportStorage.addDebugData("MESSAGE_QUEUE", this.var_3880);
        }

        public function messageSent(param1:String, param2:String):void
        {
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_288, String(new Date().getTime()));
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_289, ((param1 + " ") + param2));
            if (this.var_3880.length > 0)
            {
                this.var_3880 = (this.var_3880 + (",S:" + param1));
            }
            else
            {
                this.var_3880 = ("S:" + param1);
            };
            if (this.var_3880.length > 150)
            {
                this.var_3880 = this.var_3880.substring((this.var_3880.length - 150));
            };
            ErrorReportStorage.addDebugData("MESSAGE_QUEUE", this.var_3880);
        }


    }
}