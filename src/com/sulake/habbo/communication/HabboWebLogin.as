package com.sulake.habbo.communication
{
    import flash.events.EventDispatcher;
    import flash.net.URLLoader;
    import flash.events.IEventDispatcher;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    import flash.net.URLRequestMethod;
    import flash.events.Event;
    import com.sulake.habbo.communication.enum.HabboWeb;
    import flash.events.SecurityErrorEvent;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;

    public class HabboWebLogin extends EventDispatcher implements IHabboWebLogin 
    {

        private var var_2551:URLLoader;
        private var _name:String;
        private var _password:String;
        private var var_3884:String;
        private var var_3885:String;
        private var var_3886:String;

        public function HabboWebLogin(param1:String, param2:String, param3:String, param4:IEventDispatcher=null)
        {
            super(param4);
            this._name = param1;
            this._password = param2;
            this.var_3884 = (("https://" + param3) + "/account/submit");
            this.var_3885 = (("https://" + param3) + "/security_check");
            this.var_3886 = (("https://" + param3) + "/account/reauthenticate");
        }

        public function init():void
        {
            this.requestCredentials();
        }

        private function requestCredentials():void
        {
            var _loc1_:String = ((("credentials.username=" + this._name) + "&credentials.password=") + this._password);
            var _loc2_:URLRequest = new URLRequest(this.var_3884);
            _loc2_.data = new URLVariables(_loc1_);
            _loc2_.method = URLRequestMethod.POST;
            this.var_2551 = new URLLoader();
            this.var_2551.addEventListener(Event.COMPLETE, this.credentialsComplete);
            this.configureListeners(this.var_2551);
            this.var_2551.load(_loc2_);
        }

        private function credentialsComplete(param1:Event=null):void
        {
            var _loc4_:String;
            var _loc5_:URLRequest;
            var _loc2_:URLLoader = URLLoader(param1.target);
            var _loc3_:String = _loc2_.data;
            if (((_loc3_.indexOf("Redirecting") > -1) && (!(_loc3_.indexOf("/useOrCreateAvatar/") == -1))))
            {
                _loc4_ = /<meta http-equiv="Refresh" content="0;URL=(.*?)">/.exec(_loc3_)[1];
                _loc5_ = new URLRequest(_loc4_);
                this.var_2551.load(_loc5_);
                return;
            };
            this.var_2551.removeEventListener(Event.COMPLETE, this.credentialsComplete);
            this.removeListeners(this.var_2551);
            if (_loc3_.indexOf("Redirecting") > -1)
            {
                this.requestSecurityCheck();
            }
            else
            {
                if (_loc3_.indexOf("Habbo ~ Me") > -1)
                {
                    dispatchEvent(new Event(HabboWeb.var_1417));
                }
                else
                {
                    if (_loc3_.indexOf("Habbo ~ Home") > -1)
                    {
                        dispatchEvent(new Event(HabboWeb.var_1417));
                    }
                    else
                    {
                        if (_loc3_.indexOf("Habbo: Home") > -1)
                        {
                            dispatchEvent(new Event(HabboWeb.var_1417));
                        }
                        else
                        {
                            if (_loc3_.indexOf("document.habboLoggedIn = true") > -1)
                            {
                                dispatchEvent(new Event(HabboWeb.var_1417));
                            };
                        };
                    };
                };
            };
        }

        private function requestSecurityCheck():void
        {
            var _loc1_:URLRequest = new URLRequest(this.var_3885);
            this.var_2551 = new URLLoader();
            this.var_2551.addEventListener(Event.COMPLETE, this.securityCheckComplete);
            this.configureListeners(this.var_2551);
            this.var_2551.load(_loc1_);
        }

        private function securityCheckComplete(param1:Event=null):void
        {
            var _loc2_:URLLoader = URLLoader(param1.target);
            this.var_2551.removeEventListener(Event.COMPLETE, this.securityCheckComplete);
            this.removeListeners(this.var_2551);
            var _loc3_:String = _loc2_.data;
            if (_loc3_.indexOf("Redirecting") > -1)
            {
                dispatchEvent(new Event(HabboWeb.var_1417));
            };
        }

        public function requestReAuthenticate():void
        {
            var _loc1_:String = ("page=%2Fclient&credentials.password=" + this._password);
            var _loc2_:URLRequest = new URLRequest(this.var_3886);
            _loc2_.data = new URLVariables(_loc1_);
            _loc2_.method = URLRequestMethod.POST;
            this.var_2551 = new URLLoader();
            this.var_2551.addEventListener(Event.COMPLETE, this.reauthenticateComplete);
            this.configureListeners(this.var_2551);
            this.var_2551.load(_loc2_);
        }

        private function reauthenticateComplete(param1:Event=null):void
        {
            var _loc2_:URLLoader = URLLoader(param1.target);
            this.var_2551.removeEventListener(Event.COMPLETE, this.reauthenticateComplete);
            this.removeListeners(this.var_2551);
            var _loc3_:String = _loc2_.data;
            if (_loc3_.indexOf("Redirecting") > -1)
            {
                dispatchEvent(new Event(HabboWeb.var_1417));
            }
            else
            {
                Logger.log("[HabboWebLogin] Reauthenticate completed but couldn't find 'Redirecting' string. Something failed.");
                if (_loc3_.indexOf("You need to use secure log"))
                {
                    Logger.log("[HabboWebLogin] Reason for failure: You need to use secure login in HK.");
                };
            };
        }

        private function configureListeners(param1:IEventDispatcher):void
        {
            param1.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
            param1.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.httpStatusHandler);
            param1.addEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
        }

        private function removeListeners(param1:IEventDispatcher):void
        {
            param1.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
            param1.removeEventListener(HTTPStatusEvent.HTTP_STATUS, this.httpStatusHandler);
            param1.removeEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
        }

        private function ioErrorHandler(param1:IOErrorEvent):void
        {
            Logger.log(((("[LoginToWeb] IOError: " + param1.text) + " ") + param1.type));
        }

        private function httpStatusHandler(param1:HTTPStatusEvent):void
        {
            Logger.log(((("[LoginToWeb] HTTPStatus: " + param1.status) + " ") + param1.type));
        }

        private function securityErrorHandler(param1:SecurityErrorEvent):void
        {
            Logger.log(("[LoginToWeb] SecurityError: " + param1.text));
        }


    }
}