package com.sulake.core.communication.connection
{
    import flash.events.EventDispatcher;
    import com.sulake.core.runtime.IDisposable;
    import flash.net.Socket;
    import flash.utils.ByteArray;
    import com.sulake.core.communication.encryption.IEncryption;
    import com.sulake.core.communication.protocol.IProtocol;
    import com.sulake.core.communication.messages.IMessageClassManager;
    import com.sulake.core.communication.ICoreCommunicationManager;
    import flash.utils.Timer;
    import com.sulake.core.communication.messages.MessageClassManager;
    import flash.events.TimerEvent;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.IOErrorEvent;
    import flash.system.Security;
    import flash.utils.getTimer;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.communication.messages.IMessageConfiguration;
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.core.communication.messages.MessageDataWrapper;
    import com.sulake.core.utils.ErrorReportStorage;
    import flash.events.*;

    public class SocketConnection extends EventDispatcher implements IConnection, IDisposable 
    {

        public static const var_1740:int = 10000;

        private var _disposed:Boolean = false;
        private var var_2583:Socket;
        private var var_2584:ByteArray;
        private var var_2585:IEncryption;
        private var var_2586:IProtocol;
        private var _id:String;
        private var var_2587:IMessageClassManager;
        private var var_2588:ICoreCommunicationManager;
        private var var_2589:IConnectionStateListener;
        private var var_2582:Timer;
        private var var_2590:int;
        private var var_2591:Boolean = false;

        public function SocketConnection(param1:String, param2:ICoreCommunicationManager, param3:IConnectionStateListener)
        {
            this._id = param1;
            this.var_2588 = param2;
            this.var_2584 = new ByteArray();
            this.var_2587 = new MessageClassManager();
            this.var_2583 = new Socket();
            this.var_2582 = new Timer(var_1740, 1);
            this.var_2582.addEventListener(TimerEvent.TIMER, this.onTimeOutTimer);
            this.var_2583.addEventListener(Event.CONNECT, this.onConnect);
            this.var_2583.addEventListener(Event.COMPLETE, this.onComplete);
            this.var_2583.addEventListener(Event.CLOSE, this.onClose);
            this.var_2583.addEventListener(ProgressEvent.SOCKET_DATA, this.onRead);
            this.var_2583.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this.var_2583.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this.var_2589 = param3;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function set protocol(param1:IProtocol):void
        {
            this.var_2586 = param1;
        }

        public function get protocol():IProtocol
        {
            return (this.var_2586);
        }

        public function dispose():void
        {
            if (this.disposed)
            {
                return;
            };
            this._disposed = true;
            if (this.var_2583)
            {
                this.var_2583.removeEventListener(Event.CONNECT, this.onConnect);
                this.var_2583.removeEventListener(Event.COMPLETE, this.onComplete);
                this.var_2583.removeEventListener(Event.CLOSE, this.onClose);
                this.var_2583.removeEventListener(ProgressEvent.SOCKET_DATA, this.onRead);
                this.var_2583.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
                this.var_2583.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
                if (this.var_2591)
                {
                    this.var_2583.close();
                };
            };
            this.var_2583 = null;
            if (this.var_2582)
            {
                this.var_2582.stop();
                this.var_2582.removeEventListener(TimerEvent.TIMER, this.onTimeOutTimer);
            };
            this.var_2582 = null;
            this.var_2584 = null;
            this.var_2589 = null;
            this.var_2585 = null;
            this.var_2586 = null;
            this._id = null;
            this.var_2587 = null;
            this.var_2588 = null;
            this.var_2589 = null;
        }

        public function init(param1:String, param2:uint=0):Boolean
        {
            this.logConnection(((("Connecting to " + param1) + ":") + param2));
            if (this.var_2589)
            {
                this.var_2589.connectionInit(param1, param2);
            };
            Security.loadPolicyFile(((("xmlsocket://" + param1) + ":") + param2));
            this.var_2582.start();
            this.var_2590 = getTimer();
            this.var_2583.connect(param1, param2);
            return (true);
        }

        public function set timeout(param1:int):void
        {
            this.var_2582.delay = param1;
        }

        public function addMessageEvent(param1:IMessageEvent):void
        {
            if (this.disposed)
            {
                return;
            };
            this.var_2588.addConnectionMessageEvent(this._id, param1);
        }

        public function removeMessageEvent(param1:IMessageEvent):void
        {
            if (this.disposed)
            {
                return;
            };
            this.var_2588.removeConnectionMessageEvent(this._id, param1);
        }

        public function send(param1:IMessageComposer, param2:int=-1):Boolean
        {
            if (this.disposed)
            {
                return (false);
            };
            var _loc3_:ByteArray = new ByteArray();
            var _loc4_:int = this.var_2587.getMessageComposerID(param1);
            if (_loc4_ < 0)
            {
                this.logConnection(("Could not find registered message composer for " + param1));
                return (false);
            };
            var _loc5_:Array = param1.getMessageArray();
            var _loc6_:ByteArray = this.var_2586.encoder.encode(_loc4_, _loc5_, param2);
            if (this.var_2589)
            {
                this.var_2589.messageSent(String(_loc4_), _loc6_.toString());
            };
            if (this.var_2585 != null)
            {
                _loc3_ = this.var_2585.encipher(_loc6_);
            }
            else
            {
                _loc3_ = _loc6_;
            };
            if (this.var_2583.connected)
            {
                this.var_2583.writeBytes(_loc3_);
                this.var_2583.flush();
            }
            else
            {
                this.logConnection("[SOCKET] Not connected.");
                return (false);
            };
            return (true);
        }

        public function setEncryption(param1:IEncryption):void
        {
            this.var_2585 = param1;
        }

        public function registerMessageClasses(param1:IMessageConfiguration):void
        {
            this.var_2587.registerMessages(param1);
        }

        override public function toString():String
        {
            var _loc1_:String = "";
            _loc1_ = (_loc1_ + "Socket Connection: \n");
            _loc1_ = (_loc1_ + (("Protocol Encoder: " + this.var_2586.encoder) + "\n"));
            _loc1_ = (_loc1_ + (("Protocol Decoder: " + this.var_2586.decoder) + "\n"));
            return (_loc1_ + (("Encryption: " + this.var_2585) + "\n"));
        }

        public function processReceivedData():void
        {
            var id:int;
            var message:Array;
            var data:ByteArray;
            var eventClasses:Array;
            var events:Array;
            var eventClass:Class;
            var eventsForClass:Array;
            var parserInstance:IMessageParser;
            var parserClassCurrent:Class;
            var dataClone:ByteArray;
            var messageEventInstance:IMessageEvent;
            var parserClass:Class;
            var dataWrapper:IMessageDataWrapper;
            var wasParsed:Boolean;
            var temp:ByteArray;
            if (this.disposed)
            {
                return;
            };
            var receivedMessages:Array = new Array();
            var offset:uint = this.var_2586.getMessages(this.var_2584, receivedMessages);
            try
            {
                for each (message in receivedMessages)
                {
                    id = (message[0] as int);
                    data = (message[1] as ByteArray);
                    if (this.var_2589)
                    {
                        this.var_2589.messageReceived(String(id), data.toString());
                    };
                    eventClasses = this.var_2587.getMessageEventClasses(id);
                    events = new Array();
                    for each (eventClass in eventClasses)
                    {
                        eventsForClass = this.var_2588.getMessageEvents(this, eventClass);
                        events = events.concat(eventsForClass);
                    };
                    parserInstance = null;
                    parserClassCurrent = null;
                    for each (messageEventInstance in events)
                    {
                        parserClass = messageEventInstance.parserClass;
                        if (parserClass != null)
                        {
                            wasParsed = false;
                            if (parserClass != parserClassCurrent)
                            {
                                dataClone = new ByteArray();
                                dataClone.writeBytes(data);
                                dataClone.position = data.position;
                                dataWrapper = new MessageDataWrapper(dataClone, this.protocol.decoder);
                                parserInstance = this.var_2588.getMessageParser(parserClass);
                                if (!parserInstance.flush())
                                {
                                    this.logConnection((">>[SocketConnection] Message Event Parser wasn't flushed: " + [id, parserClass, parserInstance]));
                                }
                                else
                                {
                                    if (parserInstance.parse(dataWrapper))
                                    {
                                        parserClassCurrent = parserClass;
                                        wasParsed = true;
                                    };
                                };
                            }
                            else
                            {
                                wasParsed = true;
                            };
                            if (wasParsed)
                            {
                                messageEventInstance.connection = this;
                                messageEventInstance.parser = parserInstance;
                                messageEventInstance.callback.call(null, messageEventInstance);
                            }
                            else
                            {
                                parserClassCurrent = null;
                                parserInstance = null;
                            };
                        };
                    };
                };
                if (offset == this.var_2584.length)
                {
                    this.var_2584 = new ByteArray();
                }
                else
                {
                    if (offset > 0)
                    {
                        temp = new ByteArray();
                        temp.writeBytes(this.var_2584, offset);
                        this.var_2584 = temp;
                        this.logConnection(((("[SOCKET REST] offset: " + offset) + " rest: ") + this.var_2584.toString()));
                    };
                };
            }
            catch(e:Error)
            {
                if (!disposed)
                {
                    ErrorReportStorage.addDebugData("SocketConnection", (('Crashed while processing incoming message with id="' + id) + '"!'));
                    throw (e);
                };
            };
        }

        public function get connected():Boolean
        {
            if (this.var_2583 == null)
            {
                return (false);
            };
            return (this.var_2583.connected);
        }

        private function onRead(param1:ProgressEvent):void
        {
            if (this.var_2583 == null)
            {
                return;
            };
            while (this.var_2583.bytesAvailable > 0)
            {
                this.var_2584.writeByte(this.var_2583.readUnsignedByte());
            };
        }

        private function onConnect(param1:Event):void
        {
            this.logConnection("[SocketConnection] Connected");
            this.var_2582.stop();
            this.var_2591 = true;
            ErrorReportStorage.addDebugData("ConnectionTimer", ("Connected in " + (getTimer() - this.var_2590)));
            dispatchEvent(param1);
        }

        private function onClose(param1:Event):void
        {
            this.var_2582.stop();
            this.logConnection("[SocketConnection] Closed");
            this.var_2591 = false;
            ErrorReportStorage.addDebugData("ConnectionTimer", ("Closed in " + (getTimer() - this.var_2590)));
            dispatchEvent(param1);
        }

        private function onComplete(param1:Event):void
        {
            this.var_2582.stop();
            this.logConnection("[SocketConnection] Complete");
            ErrorReportStorage.addDebugData("ConnectionTimer", ("Completed in " + (getTimer() - this.var_2590)));
            dispatchEvent(param1);
        }

        private function onSecurityError(param1:SecurityErrorEvent):void
        {
            this.var_2582.stop();
            this.logConnection(("[SocketConnection] Security Error: " + param1.text));
            ErrorReportStorage.addDebugData("ConnectionTimer", ("SecurityError in " + (getTimer() - this.var_2590)));
            dispatchEvent(param1);
        }

        private function onIOError(param1:IOErrorEvent):void
        {
            this.var_2582.stop();
            this.logConnection(("[SocketConnection] IO Error: " + param1.text));
            ErrorReportStorage.addDebugData("ConnectionTimer", ("IOError in " + (getTimer() - this.var_2590)));
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
            dispatchEvent(param1);
        }

        private function onTimeOutTimer(param1:TimerEvent):void
        {
            this.var_2582.stop();
            this.logConnection("[SocketConnection] TimeOut Error");
            ErrorReportStorage.addDebugData("ConnectionTimer", ("TimeOut in " + (getTimer() - this.var_2590)));
            var _loc2_:IOErrorEvent = new IOErrorEvent(IOErrorEvent.IO_ERROR);
            _loc2_.text = (("Socket Timeout (" + this.var_2582.delay) + " ms). Possible Firewall.");
            dispatchEvent(_loc2_);
        }

        private function logConnection(param1:String):void
        {
        }


    }
}