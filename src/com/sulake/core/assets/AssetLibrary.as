package com.sulake.core.assets
{
    import com.sulake.core.runtime.events.EventDispatcher;
    import flash.utils.Dictionary;
    import com.sulake.core.utils.LibraryLoader;
    import com.sulake.core.assets.loaders.BinaryFileLoader;
    import com.sulake.core.assets.loaders.BitmapFileLoader;
    import com.sulake.core.assets.loaders.ZipFileLoader;
    import com.sulake.core.assets.loaders.SoundFileLoader;
    import flash.utils.getTimer;
    import flash.events.Event;
    import com.sulake.core.utils.LibraryLoaderEvent;
    import com.sulake.core.assets.loaders.IAssetLoader;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.net.URLRequest;
    import flash.events.ProgressEvent;
    import flash.utils.getQualifiedClassName;
    import com.sulake.core.assets.loaders.*;

    public class AssetLibrary extends EventDispatcher implements IAssetLibrary 
    {

        public static const var_307:String = "AssetLibraryReady";
        public static const var_308:String = "AssetLibraryLoaded";
        public static const var_309:String = "AssetLibraryUnloaded";
        public static const var_310:String = "AssetLibraryLoadError";
        private static const var_316:String = "name";
        private static const var_315:String = "asset";
        private static const var_317:String = "param";
        private static const TYPE:String = "mimeType";
        private static const var_314:String = "library";
        private static var var_311:Dictionary;
        private static var var_318:LazyAssetProcessor = new LazyAssetProcessor();
        private static var var_312:uint = 0;
        private static var var_313:Array = new Array();

        private var _name:String;
        private var var_2555:String;
        private var _manifest:XML;
        private var var_2556:Boolean;
        private var var_2557:uint;
        private var var_2551:LibraryLoader;
        private var var_2559:Class;
        private var var_2560:Dictionary;
        private var var_2561:Dictionary;
        private var var_2562:Boolean = true;
        private var var_2563:Dictionary;
        private var var_2558:Array;
        private var var_2564:Dictionary;

        public function AssetLibrary(param1:String)
        {
            this._name = param1;
            this._manifest = new XML();
            this.var_2557 = 0;
            this.var_2558 = new Array();
            if (var_311 == null)
            {
                var_311 = new Dictionary(false);
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("application/octet-stream", UnknownAsset, BinaryFileLoader));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("application/x-shockwave-flash", DisplayAsset, BitmapFileLoader, "swf"));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("application/x-font-truetype", FontAsset, BinaryFileLoader, "ttf", "otf"));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("application/zip", UnknownAsset, ZipFileLoader, "zip"));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("text/xml", XmlAsset, BinaryFileLoader, "xml"));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("text/html", XmlAsset, BinaryFileLoader, "htm", "html"));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("text/plain", TextAsset, BinaryFileLoader, "txt"));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("image/jpeg", BitmapDataAsset, BitmapFileLoader, "jpg", "jpeg"));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("image/gif", BitmapDataAsset, BitmapFileLoader, "gif"));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("image/png", BitmapDataAsset, BitmapFileLoader, "png"));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("image/tiff", BitmapDataAsset, BitmapFileLoader, "tif", "tiff"));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("sound/mp3", SoundAsset, SoundFileLoader, "mp3"));
            };
            var_312++;
            this.var_2564 = new Dictionary(false);
            this.var_2563 = new Dictionary(false);
            this.var_2560 = new Dictionary(false);
            this.var_2561 = new Dictionary(false);
            var_313.push(this);
        }

        public static function get numAssetLibraryInstances():uint
        {
            return (var_312);
        }

        public static function get assetLibraryRefArray():Array
        {
            return (var_313);
        }

        private static function fetchLibraryContents(param1:AssetLibrary, param2:XML, param3:Class):Boolean
        {
            var _loc6_:XML;
            var _loc7_:String;
            var _loc8_:String;
            var _loc9_:AssetTypeDeclaration;
            var _loc10_:IAsset;
            var _loc11_:XMLList;
            var _loc12_:int;
            var _loc13_:AssetTypeDeclaration;
            var _loc14_:String;
            var _loc15_:uint;
            var _loc4_:int = getTimer();
            if (param3 == null)
            {
                throw (new Error((("Library " + param1.var_2555) + " doesn't contain valid resource class!")));
            };
            var _loc5_:XMLList = param2.child(var_314);
            if (_loc5_ == null)
            {
                throw (Error("Provided manifest doesn't contain library node!"));
            };
            _loc5_ = _loc5_[0].assets;
            if (_loc5_ != null)
            {
                _loc5_ = _loc5_.child(var_315);
                _loc12_ = _loc5_.length();
                _loc14_ = null;
                _loc15_ = 0;
                while (_loc15_ < _loc12_)
                {
                    _loc6_ = _loc5_[_loc15_];
                    _loc7_ = _loc6_.attribute(var_316);
                    _loc8_ = _loc6_.attribute(TYPE);
                    if (_loc8_ == _loc14_)
                    {
                        _loc9_ = _loc13_;
                    }
                    else
                    {
                        _loc9_ = param1.getAssetTypeDeclarationByMimeType(_loc8_);
                        _loc14_ = _loc8_;
                        _loc13_ = _loc9_;
                    };
                    if (_loc9_ != null)
                    {
                        _loc10_ = (new (_loc9_.assetClass)(_loc9_) as IAsset);
                        _loc10_.setUnknownContent(param3[_loc7_]);
                        _loc11_ = _loc6_.child(var_317);
                        if (_loc11_.length())
                        {
                            _loc10_.setParamsDesc(_loc11_);
                        };
                        param1.setAsset(_loc7_, _loc10_);
                    }
                    else
                    {
                        Logger.log((((("Failed to extract asset " + _loc7_) + " from Library ") + param1.var_2555) + "!"));
                    };
                    _loc15_++;
                };
            };
            _loc4_ = (getTimer() - _loc4_);
            return (true);
        }


        public function get url():String
        {
            return (this.var_2555);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get isReady():Boolean
        {
            return (this.var_2556);
        }

        public function get manifest():XML
        {
            return (this._manifest);
        }

        public function get numAssets():uint
        {
            return (this.var_2557);
        }

        public function get nameArray():Array
        {
            return (this.var_2558);
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                this.unload();
                super.dispose();
                var_313.splice(var_313.indexOf(this), 1);
                var_312--;
                this.var_2563 = null;
                this.var_2560 = null;
                this.var_2561 = null;
                this.var_2558 = null;
                this._manifest = null;
                this.var_2557 = 0;
                this.var_2556 = false;
                this._name = null;
            };
        }

        public function loadFromFile(param1:LibraryLoader, param2:Boolean=true):void
        {
            if (((this.var_2555 == param1.url) && (this.var_2556)))
            {
                if (((!(this.var_2562)) && (param2)))
                {
                    AssetLibrary.fetchLibraryContents(this, this._manifest, this.var_2559);
                };
                this.var_2562 = param2;
                dispatchEvent(new Event(AssetLibrary.var_307));
            }
            else
            {
                if (((this.var_2551 == null) || (this.var_2551.disposed)))
                {
                    this.var_2551 = param1;
                    this.var_2551.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.libraryLoadedHandler);
                    this.var_2551.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.loadErrorHandler);
                };
                this.var_2562 = param2;
                this.var_2555 = this.var_2551.url;
            };
        }

        public function loadFromResource(param1:XML, param2:Class):Boolean
        {
            return (AssetLibrary.fetchLibraryContents(this, param1, param2));
        }

        public function unload():void
        {
            var _loc1_:String;
            var _loc2_:AssetLoaderStruct;
            for (_loc1_ in this.var_2563)
            {
                _loc2_ = this.var_2563[_loc1_];
                _loc2_.assetLoader.dispose();
                delete this.var_2563[_loc1_];
            };
            for (_loc1_ in this.var_2561)
            {
                delete this.var_2561[_loc1_];
            };
            for (_loc1_ in this.var_2560)
            {
                delete this.var_2560[_loc1_];
            };
            if (this.var_2551 != null)
            {
                this.var_2551.dispose();
                this.var_2551 = null;
            };
            this.var_2557 = 0;
            this.var_2556 = false;
            this.var_2555 = null;
            dispatchEvent(new Event(AssetLibrary.var_309));
        }

        public function getClass(param1:String):Class
        {
            var _loc2_:Class = this.var_2560[param1];
            if (_loc2_ != null)
            {
                return (_loc2_);
            };
            if (this.var_2551 != null)
            {
                if (this.var_2551.hasDefinition(param1))
                {
                    _loc2_ = (this.var_2551.getDefinition(param1) as Class);
                    if (_loc2_ != null)
                    {
                        this.var_2560[param1] = _loc2_;
                        return (_loc2_);
                    };
                };
            };
            return (null);
        }

        public function loadAssetFromFile(param1:String, param2:URLRequest, param3:String=null):AssetLoaderStruct
        {
            var _loc5_:AssetTypeDeclaration;
            if (this.getAssetByName(param1) != null)
            {
                throw (new Error((("Asset with name " + param1) + " already exists!")));
            };
            var _loc4_:AssetLoaderStruct = this.var_2563[param2.url];
            if (_loc4_ != null)
            {
                if (_loc4_.assetName == param1)
                {
                    return (_loc4_);
                };
            };
            if (param3 == null)
            {
                _loc5_ = this.solveAssetTypeDeclarationFromUrl(param2.url);
                if (_loc5_ == null)
                {
                    throw (new Error((("Couldn't solve asset type for file " + param2.url) + "!")));
                };
            }
            else
            {
                _loc5_ = this.getAssetTypeDeclarationByMimeType(param3, true);
                if (_loc5_ == null)
                {
                    throw (new Error((("Asset type declaration for mime type " + param3) + "not found!")));
                };
            };
            var _loc6_:IAssetLoader = new (_loc5_.loaderClass)(_loc5_.mimeType, param2);
            if (_loc6_ == null)
            {
                throw (new Error((("Invalid file loader class defined for mime type " + param3) + "!")));
            };
            _loc6_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.assetLoadEventHandler);
            _loc6_.addEventListener(AssetLoaderEvent.var_34, this.assetLoadEventHandler);
            _loc6_.addEventListener(AssetLoaderEvent.var_89, this.assetLoadEventHandler);
            _loc6_.addEventListener(AssetLoaderEvent.var_88, this.assetLoadEventHandler);
            _loc6_.addEventListener(AssetLoaderEvent.var_90, this.assetLoadEventHandler);
            _loc6_.addEventListener(AssetLoaderEvent.var_91, this.assetLoadEventHandler);
            _loc4_ = new AssetLoaderStruct(param1, _loc6_);
            this.var_2563[param2.url] = _loc4_;
            return (_loc4_);
        }

        private function assetLoadEventHandler(e:AssetLoaderEvent):void
        {
            var loader:IAssetLoader;
            var type:String;
            var decl:AssetTypeDeclaration;
            var asset:IAsset;
            var remove:Boolean;
            loader = (e.target as IAssetLoader);
            if (loader == null)
            {
                throw (new Error("Failed to downcast object to asset loader!"));
            };
            var struct:AssetLoaderStruct = this.var_2563[loader.url];
            if (struct == null)
            {
                throw (new Error(("Asset loader structure was lost! " + ((loader) ? loader.url : ""))));
            };
            switch (e.type)
            {
                case AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE:
                    type = loader.mimeType;
                    decl = this.getAssetTypeDeclarationByMimeType(type);
                    remove = true;
                    if (decl != null)
                    {
                        asset = new (decl.assetClass)(decl, loader.url);
                        try
                        {
                            asset.setUnknownContent(loader.content);
                        }
                        catch(error:Error)
                        {
                            asset.dispose();
                            Logger.log(((((((('Failed to build asset from loaded file "' + loader.url) + '" type: ') + type) + " error: ") + error.name) + " / ") + error.message));
                            e = new AssetLoaderEvent(AssetLoaderEvent.var_34, e.status);
                            break;
                        };
                        if (this.var_2561[struct.assetName] == null)
                        {
                            this.var_2557++;
                            this.var_2558.push(struct.assetName);
                        };
                        this.var_2561[struct.assetName] = asset;
                    }
                    else
                    {
                        Logger.log(((('Failed to resolve asset type declaration: "' + loader.url) + '" type: ') + type));
                        e = new AssetLoaderEvent(AssetLoaderEvent.var_34, e.status);
                    };
                    break;
                case AssetLoaderEvent.var_34:
                    remove = true;
                    Logger.log(((('Failed to download file "' + loader.url) + '" error: ') + loader.errorCode));
                    break;
            };
            struct.dispatchEvent(new AssetLoaderEvent(e.type, e.status));
            if (remove)
            {
                if (((!(_disposed)) && (loader)))
                {
                    delete this.var_2563[loader.url];
                };
                if (struct)
                {
                    struct.dispose();
                };
            };
        }

        public function getAssetByName(param1:String):IAsset
        {
            var _loc2_:IAsset = this.var_2561[param1];
            if (_loc2_ != null)
            {
                return (_loc2_);
            };
            if (this.var_2562)
            {
                return (null);
            };
            return (this.fetchAssetFromResource(param1));
        }

        public function getAssetByIndex(param1:uint):IAsset
        {
            return ((param1 < this.var_2558.length) ? this.getAssetByName(this.var_2558[param1]) : null);
        }

        public function getAssetByContent(param1:Object):IAsset
        {
            var _loc2_:String;
            var _loc3_:IAsset;
            for (_loc2_ in this.var_2561)
            {
                _loc3_ = this.var_2561[_loc2_];
                if (_loc3_.content === param1)
                {
                    return (_loc3_);
                };
            };
            return (null);
        }

        public function getAssetIndex(param1:IAsset):int
        {
            var _loc2_:String;
            for (_loc2_ in this.var_2561)
            {
                if (this.var_2561[_loc2_] == param1)
                {
                    return (this.var_2558.indexOf(_loc2_));
                };
            };
            return (-1);
        }

        public function hasAsset(param1:String):Boolean
        {
            return ((!(this.var_2561[param1] == null)) || ((this.var_2559 != null) ? (!(this.var_2559[param1] == null)) : false));
        }

        public function setAsset(param1:String, param2:IAsset, param3:Boolean=true):Boolean
        {
            var _loc4_:* = (this.var_2561[param1] == null);
            if ((((param3) || (_loc4_)) && (param2)))
            {
                if (_loc4_)
                {
                    this.var_2557++;
                    this.var_2558.push(param1);
                };
                this.var_2561[param1] = param2;
                if ((param2 is ILazyAsset))
                {
                    var_318.push((param2 as ILazyAsset));
                };
                return (true);
            };
            return (false);
        }

        public function createAsset(param1:String, param2:AssetTypeDeclaration):IAsset
        {
            if (((this.hasAsset(param1)) || (!(param2))))
            {
                return (null);
            };
            var _loc3_:IAsset = new (param2.assetClass)(param2);
            if (!this.setAsset(param1, _loc3_))
            {
                _loc3_.dispose();
                _loc3_ = null;
            };
            return (_loc3_);
        }

        public function removeAsset(param1:IAsset):IAsset
        {
            var _loc2_:String;
            if (param1)
            {
                for (_loc2_ in this.var_2561)
                {
                    if (this.var_2561[_loc2_] == param1)
                    {
                        this.var_2558.splice(this.var_2558.indexOf(_loc2_), 1);
                        delete this.var_2561[_loc2_];
                        this.var_2557--;
                        return (param1);
                    };
                };
            };
            return (null);
        }

        public function registerAssetTypeDeclaration(param1:AssetTypeDeclaration, param2:Boolean=true):Boolean
        {
            if (param2)
            {
                if (var_311.hasOwnProperty(param1.mimeType))
                {
                    throw (new Error((("Asset type " + param1.mimeType) + " already registered!")));
                };
                var_311[param1.mimeType] = param1;
            }
            else
            {
                if (this.var_2564.hasOwnProperty(param1.mimeType))
                {
                    throw (new Error((("Asset type " + param1.mimeType) + " already registered!")));
                };
                this.var_2564[param1.mimeType] = param1;
            };
            return (true);
        }

        public function getAssetTypeDeclarationByMimeType(param1:String, param2:Boolean=true):AssetTypeDeclaration
        {
            var _loc3_:AssetTypeDeclaration;
            if (param2)
            {
                _loc3_ = AssetTypeDeclaration(var_311[param1]);
                if (_loc3_ != null)
                {
                    return (_loc3_);
                };
            };
            return (AssetTypeDeclaration(this.var_2564[param1]));
        }

        public function getAssetTypeDeclarationByClass(param1:Class, param2:Boolean=true):AssetTypeDeclaration
        {
            var _loc3_:AssetTypeDeclaration;
            var _loc4_:String;
            if (param2)
            {
                for (_loc4_ in var_311)
                {
                    _loc3_ = AssetTypeDeclaration(var_311[_loc4_]);
                    if (_loc3_ != null)
                    {
                        if (_loc3_.assetClass == param1)
                        {
                            return (_loc3_);
                        };
                    };
                };
            };
            for (_loc4_ in this.var_2564)
            {
                _loc3_ = AssetTypeDeclaration(this.var_2564[_loc4_]);
                if (_loc3_ != null)
                {
                    if (_loc3_.assetClass == param1)
                    {
                        return (_loc3_);
                    };
                };
            };
            return (null);
        }

        public function getAssetTypeDeclarationByFileName(param1:String, param2:Boolean=true):AssetTypeDeclaration
        {
            var _loc4_:AssetTypeDeclaration;
            var _loc5_:String;
            var _loc3_:String = param1.substr((param1.lastIndexOf(".") + 1), param1.length);
            if (_loc3_.indexOf("?"))
            {
                _loc3_ = _loc3_.substr(0, (_loc3_.indexOf("?") - 1));
            };
            if (param2)
            {
                for (_loc5_ in var_311)
                {
                    _loc4_ = AssetTypeDeclaration(var_311[_loc5_]);
                    if (_loc4_ != null)
                    {
                        if (_loc4_.fileTypes.indexOf(_loc3_))
                        {
                            return (_loc4_);
                        };
                    };
                };
            };
            for (_loc5_ in this.var_2564)
            {
                _loc4_ = AssetTypeDeclaration(this.var_2564[_loc5_]);
                if (_loc4_ != null)
                {
                    if (_loc4_.fileTypes.indexOf(_loc3_))
                    {
                        return (_loc4_);
                    };
                };
            };
            return (null);
        }

        private function libraryLoadedHandler(param1:LibraryLoaderEvent):void
        {
            var _loc2_:LibraryLoader = (param1.target as LibraryLoader);
            if (_loc2_.manifest == null)
            {
                throw (new Error("loader.manifest was null, which would have caused error 1009 anyway. See HL-22347."));
            };
            this._manifest = _loc2_.manifest.copy();
            this.var_2559 = _loc2_.resource;
            this.var_2555 = _loc2_.url;
            if (this.var_2562)
            {
                AssetLibrary.fetchLibraryContents(this, this._manifest, this.var_2559);
            };
            this.var_2556 = true;
            dispatchEvent(new Event(AssetLibrary.var_308));
            dispatchEvent(new Event(AssetLibrary.var_307));
            if (this.var_2562)
            {
                this.var_2551.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.libraryLoadedHandler);
                this.var_2551.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.loadErrorHandler);
                this.var_2551.addEventListener(LibraryLoader.LIBRARY_LOADER_FINALIZE, this.finalizeLoaderEventHandler);
                this.var_2551 = null;
                this.var_2559 = null;
            };
        }

        private function finalizeLoaderEventHandler(param1:Event):void
        {
            var _loc2_:LibraryLoader = (param1.target as LibraryLoader);
            if (((_loc2_) && (!(_loc2_.disposed))))
            {
                if (!_loc2_.hasEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE))
                {
                    _loc2_.removeEventListener(LibraryLoader.LIBRARY_LOADER_FINALIZE, this.finalizeLoaderEventHandler);
                    _loc2_.dispose();
                };
            };
        }

        private function onLoadProgress(param1:ProgressEvent):void
        {
            dispatchEvent(param1.clone());
        }

        private function loadErrorHandler(param1:LibraryLoaderEvent):void
        {
            this.var_2556 = false;
            var _loc2_:LibraryLoader = (param1.target as LibraryLoader);
            var _loc3_:String = ((_loc2_) ? _loc2_.name : "unknown");
            Logger.log(((("Cannot load the specified file: " + _loc3_) + " ") + param1.status));
            dispatchEvent(new Event(AssetLibrary.var_310));
            this.var_2551 = null;
        }

        private function solveAssetTypeDeclarationFromUrl(param1:String):AssetTypeDeclaration
        {
            var _loc2_:int;
            var _loc3_:AssetTypeDeclaration;
            var _loc4_:Array;
            var _loc5_:String;
            _loc2_ = param1.indexOf("?", 0);
            if (_loc2_ > 0)
            {
                param1 = param1.slice(0, _loc2_);
            };
            _loc2_ = param1.lastIndexOf(".");
            if (_loc2_ == -1)
            {
                return (null);
            };
            param1 = param1.slice((_loc2_ + 1), param1.length);
            for (_loc5_ in this.var_2564)
            {
                _loc3_ = this.var_2564[_loc5_];
                _loc4_ = _loc3_.fileTypes;
                if (_loc4_ != null)
                {
                    if (_loc4_.indexOf(param1, 0) > -1)
                    {
                        return (_loc3_);
                    };
                };
            };
            for (_loc5_ in var_311)
            {
                _loc3_ = var_311[_loc5_];
                _loc4_ = _loc3_.fileTypes;
                if (_loc4_ != null)
                {
                    if (_loc4_.indexOf(param1, 0) > -1)
                    {
                        return (_loc3_);
                    };
                };
            };
            return (null);
        }

        private function fetchAssetFromResource(param1:String):IAsset
        {
            var _loc3_:XML;
            var _loc4_:AssetTypeDeclaration;
            var _loc5_:IAsset;
            var _loc6_:XMLList;
            var _loc7_:int;
            var _loc8_:uint;
            if (!this.var_2559)
            {
                return (null);
            };
            var _loc2_:XMLList = this._manifest.child(var_314);
            if (_loc2_ == null)
            {
                throw (new Error("Provided manifest doesn't contain library node!"));
            };
            if (_loc2_.length() == 0)
            {
                return (null);
            };
            _loc2_ = _loc2_[0].assets;
            if (_loc2_ != null)
            {
                _loc2_ = _loc2_.child(var_315);
                if (_loc2_ != null)
                {
                    _loc5_ = null;
                    _loc7_ = _loc2_.length();
                    _loc8_ = 0;
                    while (_loc8_ < _loc7_)
                    {
                        _loc3_ = _loc2_[_loc8_];
                        if (((_loc3_.attribute(var_316)) && (_loc3_.attribute(var_316).toString() == param1)))
                        {
                            _loc4_ = this.getAssetTypeDeclarationByMimeType(_loc3_.attribute(TYPE));
                            if (_loc4_ == null)
                            {
                                throw (new Error((((("Failed to extract asset " + param1) + " from Library ") + this.var_2555) + "!")));
                            };
                            _loc5_ = (new (_loc4_.assetClass)(_loc4_) as IAsset);
                            _loc5_.setUnknownContent(this.var_2559[param1]);
                            _loc6_ = _loc3_.child(var_317);
                            if (((_loc6_) && (_loc6_.length())))
                            {
                                _loc5_.setParamsDesc(_loc6_);
                            };
                            this.setAsset(param1, _loc5_);
                            return (_loc5_);
                        };
                        _loc8_++;
                    };
                };
            };
            return (null);
        }

        public function toString():String
        {
            return ((getQualifiedClassName(this) + ": ") + this._name);
        }


    }
}