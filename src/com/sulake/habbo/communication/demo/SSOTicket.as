package com.sulake.habbo.communication.demo
{
    import flash.events.EventDispatcher;
    import flash.net.URLLoader;
    import com.sulake.habbo.communication.IHabboWebLogin;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.communication.enum.HabboWeb;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.events.Event;

    public class SSOTicket extends EventDispatcher 
    {

        public static const var_1769:String = "success";
        public static const var_1770:String = "failure";

        private var var_2551:URLLoader;
        private var var_3366:String;
        private var var_3365:IHabboWebLogin;
        private var var_3367:String;
        private var var_3368:String;
        private var var_3350:String;
        private var _assets:IAssetLibrary;
        private var var_3369:Boolean;

        public function SSOTicket(param1:IAssetLibrary, param2:IHabboWebLogin, param3:String, param4:Boolean=true)
        {
            this._assets = param1;
            this.var_3365 = param2;
            this.var_3366 = (("http://" + param3) + "/client");
            if (!param4)
            {
                this.var_3365.init();
                this.var_3365.addEventListener(HabboWeb.var_1417, this.requestClientURL);
            }
            else
            {
                this.requestClientURL();
            };
        }

        public function get ticket():String
        {
            return (this.var_3368);
        }

        public function get isFacebookUser():Boolean
        {
            return (this.var_3369);
        }

        public function get flashClientUrl():String
        {
            return (this.var_3350);
        }

        private function requestClientURL(param1:Event=null):void
        {
            var _loc2_:String = this.var_3366;
            if (this._assets.hasAsset(_loc2_))
            {
                Logger.log(("[CoreLocalizationManager] reload localization for url: " + this.var_3366));
            };
            var _loc3_:URLRequest = new URLRequest(this.var_3366);
            if (this._assets.hasAsset(_loc2_))
            {
                this._assets.removeAsset(this._assets.getAssetByName(_loc2_));
            };
            var _loc4_:AssetLoaderStruct = this._assets.loadAssetFromFile(_loc2_, _loc3_, "text/plain");
            _loc4_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.var_3370);
        }

        private function var_3370(event:Event=null):void
        {
            var facebookData:Object;
            var loaderStruct:AssetLoaderStruct = (event.target as AssetLoaderStruct);
            if (loaderStruct == null)
            {
                return;
            };
            var data:String = (loaderStruct.assetLoader.content as String);
            if (data.indexOf('account/reauthenticate"') > -1)
            {
                this.var_3365.requestReAuthenticate();
            }
            else
            {
                try
                {
                    this.var_3368 = /\"sso.ticket\" : \"(.*?)\"/.exec(data)[1];
                    this.var_3350 = /\"flash.client.url\" : \"(.*?)\"/.exec(data)[1];
                    facebookData = /\"facebook.user\" : \"(.*?)\"/.exec(data);
                    if (facebookData)
                    {
                        this.var_3369 = Boolean(facebookData[1]);
                    };
                    if (this.var_3368.length > 0)
                    {
                        dispatchEvent(new Event(var_1769));
                    }
                    else
                    {
                        dispatchEvent(new Event(var_1770));
                    };
                }
                catch(e:Error)
                {
                    dispatchEvent(new Event(var_1770));
                };
            };
        }


    }
}