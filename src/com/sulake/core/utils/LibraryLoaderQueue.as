package com.sulake.core.utils
{
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.core.runtime.IDisposable;

    public class LibraryLoaderQueue extends EventDispatcher implements IDisposable 
    {

        protected static const var_270:int = 4;

        private var _debug:Boolean = false;
        private var var_2580:Array = new Array();
        private var var_2619:Array = new Array();

        public function LibraryLoaderQueue(param1:Boolean=false)
        {
            this._debug = param1;
            super();
        }

        public function get length():int
        {
            return (this.var_2580.length + this.var_2619.length);
        }

        override public function dispose():void
        {
            var _loc1_:LibraryLoader;
            if (!disposed)
            {
                for each (_loc1_ in this.var_2619)
                {
                    _loc1_.dispose();
                };
                for each (_loc1_ in this.var_2580)
                {
                    _loc1_.dispose();
                };
                this.var_2619 = null;
                this.var_2580 = null;
                super.dispose();
            };
        }

        public function push(param1:LibraryLoader):void
        {
            if ((((!(disposed)) && (!(this.isUrlInQueue(param1.url)))) && (!(this.findLibraryLoaderByURL(param1.url)))))
            {
                if (param1.paused)
                {
                    this.var_2580.push(param1);
                }
                else
                {
                    this.var_2619.push(param1);
                };
                param1.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.libraryLoadedHandler);
                param1.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_PROGRESS, this.loadProgressHandler);
                param1.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_DISPOSE, this.loaderDisposeHandler);
                param1.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.loadErrorHandler);
                this.next();
            };
        }

        private function next():void
        {
            var _loc1_:LibraryLoader;
            if (!disposed)
            {
                while (((this.var_2619.length < var_270) && (this.var_2580.length > 0)))
                {
                    _loc1_ = this.var_2580.shift();
                    this.var_2619.push(_loc1_);
                    _loc1_.final();
                };
            };
        }

        private function libraryLoadedHandler(param1:LibraryLoaderEvent):void
        {
            var _loc2_:LibraryLoader = (param1.target as LibraryLoader);
            if (_loc2_)
            {
                this.removeLoader(_loc2_);
            };
            this.next();
        }

        private function loadProgressHandler(param1:LibraryLoaderEvent):void
        {
            var _loc2_:LibraryLoader = (param1.target as LibraryLoader);
        }

        private function loaderDisposeHandler(param1:LibraryLoaderEvent):void
        {
            var _loc2_:LibraryLoader = (param1.target as LibraryLoader);
            this.removeLoader(_loc2_);
            this.next();
        }

        private function loadErrorHandler(param1:LibraryLoaderEvent):void
        {
            var _loc2_:LibraryLoader = (param1.target as LibraryLoader);
            if (_loc2_)
            {
                Logger.log(("Failed to download  specified file: " + _loc2_.url));
                this.removeLoader(_loc2_);
            };
            this.next();
        }

        private function removeLoader(loader:LibraryLoader):void
        {
            var index:int;
            loader.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.libraryLoadedHandler);
            loader.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_PROGRESS, this.loadProgressHandler);
            loader.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_DISPOSE, this.loaderDisposeHandler);
            loader.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.loadErrorHandler);
            try
            {
                index = this.var_2580.indexOf(loader);
                if (index > -1)
                {
                    this.var_2580.splice(index, 1);
                };
                index = this.var_2619.indexOf(loader);
                if (index > -1)
                {
                    this.var_2619.splice(index, 1);
                };
            }
            catch(e:Error)
            {
                Logger.log("LibraryLoaderQueue was propably disposed!");
            };
        }

        private function isUrlInQueue(param1:String, param2:Boolean=true):Boolean
        {
            var _loc3_:LibraryLoader;
            if (!disposed)
            {
                if (((param2) && (param1.indexOf("?") > -1)))
                {
                    param1 = param1.slice(0, param1.indexOf("?"));
                };
                for each (_loc3_ in this.var_2580)
                {
                    if (param2)
                    {
                        if (_loc3_.url.indexOf(param1) == 0)
                        {
                            return (true);
                        };
                    }
                    else
                    {
                        if (_loc3_.url == param1)
                        {
                            return (true);
                        };
                    };
                };
            };
            return (false);
        }

        public function findLibraryLoaderByURL(param1:String, param2:Boolean=true):LibraryLoader
        {
            var _loc3_:LibraryLoader;
            if (!disposed)
            {
                if (((param2) && (param1.indexOf("?") > -1)))
                {
                    param1 = param1.slice(0, param1.indexOf("?"));
                };
                for each (_loc3_ in this.var_2619)
                {
                    if (param2)
                    {
                        if (_loc3_.url.indexOf(param1) == 0)
                        {
                            return (_loc3_);
                        };
                    }
                    else
                    {
                        if (_loc3_.url == param1)
                        {
                            return (_loc3_);
                        };
                    };
                };
            };
            return (null);
        }


    }
}