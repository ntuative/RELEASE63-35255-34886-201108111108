package com.sulake.core.assets.loaders
{
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.core.runtime.IDisposable;
    import flash.events.HTTPStatusEvent;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;

    internal class AssetLoaderEventBroker extends EventDispatcher implements IDisposable 
    {

        public static const NONE:uint = 0;
        public static const IO_ERROR:uint = 1;
        public static const SECURITY_ERROR:uint = 2;

        protected var var_2549:int = 0;
        protected var var_1520:int = 0;
        protected var var_1521:int = 2;
        protected var var_2550:uint = 0;


        public function get errorCode():uint
        {
            return (this.var_2550);
        }

        protected function loadEventHandler(param1:Event):void
        {
            switch (param1.type)
            {
                case HTTPStatusEvent.HTTP_STATUS:
                    this.var_2549 = HTTPStatusEvent(param1).status;
                    dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.var_90, this.var_2549));
                    return;
                case Event.COMPLETE:
                    dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.var_2549));
                    return;
                case Event.UNLOAD:
                    dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.var_89, this.var_2549));
                    return;
                case Event.OPEN:
                    dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.var_91, this.var_2549));
                    return;
                case ProgressEvent.PROGRESS:
                    dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.var_88, this.var_2549));
                    return;
                case IOErrorEvent.IO_ERROR:
                    this.var_2550 = IO_ERROR;
                    if (!this.retry())
                    {
                        dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.var_34, this.var_2549));
                    };
                    return;
                case SecurityErrorEvent.SECURITY_ERROR:
                    this.var_2550 = SECURITY_ERROR;
                    if (!this.retry())
                    {
                        dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.var_34, this.var_2549));
                    };
                    return;
                default:
                    Logger.log((("Unknown asset loader event! AssetLoaderEventBroker::loadEventHandler(" + param1) + ")"));
            };
        }

        protected function retry():Boolean
        {
            return (false);
        }


    }
}