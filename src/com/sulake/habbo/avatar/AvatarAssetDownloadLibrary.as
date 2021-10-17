package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.AssetLibraryCollection;
    import flash.net.URLRequest;
    import com.sulake.core.utils.LibraryLoader;
    import com.sulake.core.utils.LibraryLoaderEvent;
    import com.sulake.core.Core;
    import flash.events.Event;

    public class AvatarAssetDownloadLibrary extends EventDispatcher 
    {

        private static var var_1860:int = 0;
        private static var var_1941:int = 1;
        private static var var_1304:int = 2;

        private var _state:int;
        private var var_3001:String;
        private var _revision:String;
        private var var_3002:String;
        private var _assets:IAssetLibrary;

        public function AvatarAssetDownloadLibrary(param1:String, param2:String, param3:String, param4:IAssetLibrary)
        {
            this._state = var_1860;
            this._assets = param4;
            this.var_3001 = String(param1);
            this._revision = String(param2);
            this.var_3002 = ((param3 + this.var_3001) + ".swf");
            this.var_3002 = this.var_3002.replace("%revision%", this._revision);
            var _loc5_:AssetLibraryCollection = (this._assets as AssetLibraryCollection);
            var _loc6_:IAssetLibrary = _loc5_.getAssetLibraryByUrl((this.var_3001 + ".swf"));
            if (_loc6_ != null)
            {
                Logger.log(("[AvatarAssetDownloadLibrary] Already Downloaded by Core: " + this.var_3001));
                this._state = var_1304;
            };
        }

        override public function dispose():void
        {
            super.dispose();
        }

        public function startDownloading():void
        {
            this._state = var_1941;
            var _loc1_:URLRequest = new URLRequest(this.var_3002);
            var _loc2_:LibraryLoader = new LibraryLoader();
            this._assets.loadFromFile(_loc2_, true);
            _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.onLoaderComplete);
            _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.onLoaderError);
            _loc2_.load(_loc1_);
        }

        private function onLoaderError(param1:Event):void
        {
            Core.error(((("Could not load avatar asset library " + this.var_3001) + " from URL ") + this.var_3002), false, Core.var_76);
        }

        private function onLoaderComplete(param1:Event):void
        {
            var _loc2_:LibraryLoader = (param1.target as LibraryLoader);
            _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.onLoaderComplete);
            _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.onLoaderError);
            this._state = var_1304;
            dispatchEvent(new Event(Event.COMPLETE));
        }

        public function get libraryName():String
        {
            return (this.var_3001);
        }

        public function get isReady():Boolean
        {
            return (this._state == var_1304);
        }

        public function toString():String
        {
            var _loc1_:String = this.var_3001;
            return (_loc1_ + ((this.isReady) ? "[x]" : "[ ]"));
        }


    }
}