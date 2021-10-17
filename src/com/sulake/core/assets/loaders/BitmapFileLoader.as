package com.sulake.core.assets.loaders
{
    import flash.display.Loader;
    import flash.system.LoaderContext;
    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;

    public class BitmapFileLoader extends AssetLoaderEventBroker implements IAssetLoader
    {

        protected var var_2552:String;
        protected var _type:String;
        protected var var_2551:Loader;
        protected var var_2553:LoaderContext;

        public function BitmapFileLoader(param1:String, param2:URLRequest=null)
        {
            this.var_2552 = ((param2 == null) ? "" : param2.url);
            this._type = param1;
            this.var_2551 = new Loader();
            this.var_2553 = new LoaderContext();
            this.var_2553.checkPolicyFile = true;
            this.var_2551.contentLoaderInfo.addEventListener(Event.COMPLETE, loadEventHandler);
            this.var_2551.contentLoaderInfo.addEventListener(Event.UNLOAD, loadEventHandler);
            this.var_2551.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, loadEventHandler);
            this.var_2551.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadEventHandler);
            this.var_2551.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadEventHandler);
            this.var_2551.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadEventHandler);
            if (((!(param2 == null)) && (!(param2.url == null))))
            {
                this.var_2551.load(param2, this.var_2553);
            };
        }

        public function get url():String
        {
            return (this.var_2552);
        }

        public function get ready():Boolean
        {
            return ((this.bytesTotal > 0) ? (this.bytesTotal == this.bytesLoaded) : false);
        }

        public function get content():Object
        {
            return ((this.var_2551) ? this.var_2551.content : null);
        }

        public function get mimeType():String
        {
            return (this._type);
        }

        public function get bytesLoaded():uint
        {
            return ((this.var_2551) ? this.var_2551.contentLoaderInfo.bytesLoaded : 0);
        }

        public function get bytesTotal():uint
        {
            return ((this.var_2551) ? this.var_2551.contentLoaderInfo.bytesTotal : 0);
        }

        public function get loaderContext():LoaderContext
        {
            return (this.var_2553);
        }

        public function load(param1:URLRequest):void
        {
            this.var_2552 = param1.url;
            var_1520 = 0;
            this.var_2551.load(param1, this.var_2553);
        }

        override protected function retry():Boolean
        {
            if (!_disposed)
            {
                if (++var_1520 < var_1521)
                {
                    try
                    {
                        this.var_2551.close();
                        this.var_2551.unload();
                    }
                    catch(e:Error)
                    {
                    };
                    this.var_2551.load(new URLRequest((((this.var_2552 + ((this.var_2552.indexOf("?") == -1) ? "?" : "&")) + "retry=") + var_1520)), this.var_2553);
                    return (true);
                };
            };
            return (false);
        }

        override public function dispose():void
        {
            if (!_disposed)
            {
                super.dispose();
                this.var_2551.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadEventHandler);
                this.var_2551.contentLoaderInfo.removeEventListener(Event.UNLOAD, loadEventHandler);
                this.var_2551.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, loadEventHandler);
                this.var_2551.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, loadEventHandler);
                this.var_2551.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loadEventHandler);
                this.var_2551.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loadEventHandler);
                try
                {
                    this.var_2551.close();
                }
                catch(e: Error)
                {
                };
                this.var_2551.unload();
                this.var_2551 = null;
                this._type = null;
                this.var_2552 = null;
            };
        }


    }
}
