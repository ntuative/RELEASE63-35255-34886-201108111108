package com.sulake.core.assets.loaders
{
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;
    import flash.net.URLLoaderDataFormat;
    import flash.utils.Timer;
    import flash.events.TimerEvent;

    public class BinaryFileLoader extends AssetLoaderEventBroker implements IAssetLoader 
    {

        protected var var_2552:String;
        protected var _type:String;
        protected var _data:String;
        protected var var_2551:URLLoader;

        public function BinaryFileLoader(param1:String, param2:URLRequest=null)
        {
            this.var_2552 = ((param2 == null) ? "" : param2.url);
            this._type = param1;
            this.var_2551 = new URLLoader();
            this.var_2551.addEventListener(Event.COMPLETE, loadEventHandler);
            this.var_2551.addEventListener(Event.UNLOAD, loadEventHandler);
            this.var_2551.addEventListener(HTTPStatusEvent.HTTP_STATUS, loadEventHandler);
            this.var_2551.addEventListener(ProgressEvent.PROGRESS, loadEventHandler);
            this.var_2551.addEventListener(IOErrorEvent.IO_ERROR, loadEventHandler);
            this.var_2551.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadEventHandler);
            if (param2 != null)
            {
                this.load(param2);
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
            return ((this._data) ? this._data : ((this.var_2551) ? this.var_2551.data : null));
        }

        public function get mimeType():String
        {
            return (this._type);
        }

        public function get bytesLoaded():uint
        {
            return ((this.var_2551) ? this.var_2551.bytesLoaded : 0);
        }

        public function get bytesTotal():uint
        {
            return ((this.var_2551) ? this.var_2551.bytesTotal : 0);
        }

        public function load(param1:URLRequest):void
        {
            this.var_2552 = param1.url;
            this._data = null;
            var_1520 = 0;
            this.var_2551.dataFormat = ((this._type == "application/octet-stream") ? URLLoaderDataFormat.BINARY : URLLoaderDataFormat.TEXT);
            this.var_2551.load(param1);
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
                    }
                    catch(e:Error)
                    {
                    };
                    this.var_2551.load(new URLRequest((((this.var_2552 + ((this.var_2552.indexOf("?") == -1) ? "?" : "&")) + "retry=") + var_1520)));
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
                this.var_2551.removeEventListener(Event.COMPLETE, loadEventHandler);
                this.var_2551.removeEventListener(Event.UNLOAD, loadEventHandler);
                this.var_2551.removeEventListener(HTTPStatusEvent.HTTP_STATUS, loadEventHandler);
                this.var_2551.removeEventListener(ProgressEvent.PROGRESS, loadEventHandler);
                this.var_2551.removeEventListener(IOErrorEvent.IO_ERROR, loadEventHandler);
                this.var_2551.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loadEventHandler);
                try
                {
                    this.var_2551.close();
                }
                catch(e:Error)
                {
                };
                this.var_2551 = null;
                this._type = null;
                this._data = null;
                this.var_2552 = null;
            };
        }

        private function timerEventHandler(param1:TimerEvent):void
        {
            var _loc2_:Timer = (param1.target as Timer);
            if (_loc2_)
            {
                _loc2_.stop();
                _loc2_.removeEventListener(TimerEvent.TIMER, this.timerEventHandler);
            };
            if (!_disposed)
            {
                loadEventHandler(new Event(Event.COMPLETE));
            };
        }


    }
}