package com.sulake.core.runtime
{
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.Event;
    import com.sulake.core.runtime.events.WarningEvent;
    import com.sulake.core.runtime.events.ErrorEvent;
    import com.sulake.core.utils.LibraryLoader;
    import com.sulake.core.utils.LibraryLoaderEvent;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    import com.sulake.core.Core;
    import flash.utils.ByteArray;
    import com.sulake.core.assets.AssetTypeDeclaration;
    import com.sulake.core.assets.IAsset;
    import flash.system.ApplicationDomain;
    import com.sulake.core.assets.AssetLibrary;
    import flash.utils.getDefinitionByName;
    import com.sulake.core.runtime.exceptions.InvalidComponentException;
    import flash.utils.getQualifiedClassName;
    import com.sulake.core.runtime.events.LockEvent;

    public class ComponentContext extends Component implements IContext 
    {

        protected var _components:Array;
        protected var _queuees:Array;
        protected var var_2619:Array;
        protected var _debug:Boolean = false;
        protected var var_430:DisplayObjectContainer;

        public function ComponentContext(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, (param2 | Component.COMPONENT_FLAG_CONTEXT), param3);
            this.var_430 = new Sprite();
            this._components = new Array();
            this._queuees = new Array();
        }

        public function get root():IContext
        {
            if (((!(context)) || (context == this)))
            {
                return (this);
            };
            return (context.root);
        }

        public function get displayObjectContainer():DisplayObjectContainer
        {
            return (this.var_430);
        }

        public function debug(param1:String):void
        {
            var_258 = param1;
            if (((this._debug) && (events)))
            {
                events.dispatchEvent(new Event(Component.COMPONENT_EVENT_DEBUG));
            };
        }

        public function getLastDebugMessage():String
        {
            return (var_258);
        }

        public function warning(param1:String):void
        {
            _lastWarning = param1;
            if (events == null)
            {
                Logger.log(("Failed to dispatch warning because events was null.\nMessage: " + param1));
            }
            else
            {
                events.dispatchEvent(new WarningEvent(Component.COMPONENT_EVENT_WARNING, param1));
            };
        }

        public function getLastWarningMessage():String
        {
            return (_lastWarning);
        }

        public function error(param1:String, param2:Boolean, param3:int=-1, param4:Error=null):void
        {
            var_259 = param1;
            if (events == null)
            {
                Logger.log(("Failed to dispatch an error because events was null.\nMessage: " + param1));
            }
            else
            {
                events.dispatchEvent(new ErrorEvent(Component.COMPONENT_EVENT_ERROR, param1, param2, ((param4) ? param4.getStackTrace() : null)));
            };
        }

        public function getLastErrorMessage():String
        {
            return (var_259);
        }

        final public function loadFromFile(param1:URLRequest, param2:LoaderContext):LibraryLoader
        {
            if (this.var_2619 == null)
            {
                this.var_2619 = new Array();
            };
            var _loc3_:uint;
            while (_loc3_ < this.var_2619.length)
            {
                if (this.var_2619[_loc3_].url == param1.url)
                {
                    return (this.var_2619[_loc3_].loadFromFile(param1));
                };
                _loc3_++;
            };
            var _loc4_:LibraryLoader = new LibraryLoader(param2, this._debug);
            _loc4_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.loadReadyHandler, false);
            _loc4_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.loadErrorHandler, false);
            _loc4_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_DEBUG, this.loadDebugHandler, false);
            _loc4_.load(param1);
            this.var_2619.push(_loc4_);
            return (_loc4_);
        }

        final protected function loadReadyHandler(param1:LibraryLoaderEvent):void
        {
            var _loc2_:LibraryLoader = (param1.target as LibraryLoader);
            this.removeLibraryLoader(_loc2_);
            this.prepareComponent(_loc2_.resource, Component.COMPONENT_FLAG_NULL, _loc2_.domain);
        }

        protected function loadErrorHandler(param1:LibraryLoaderEvent):void
        {
            var _loc2_:LibraryLoader = (param1.target as LibraryLoader);
            var _loc3_:String = _loc2_.getLastErrorMessage();
            this.removeLibraryLoader(_loc2_);
            this.error((((('Failed to download component resource "' + _loc2_.url) + '"!') + "\r") + _loc3_), true, Core.var_79);
        }

        protected function loadDebugHandler(param1:LibraryLoaderEvent):void
        {
            var _loc2_:LibraryLoader = (param1.target as LibraryLoader);
            var _loc3_:String = _loc2_.getLastDebugMessage();
            this.debug(_loc3_);
        }

        protected function removeLibraryLoader(param1:LibraryLoader):void
        {
            param1.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.loadReadyHandler, false);
            param1.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.loadReadyHandler, false);
            param1.dispose();
            var _loc2_:uint;
            while (_loc2_ < this.var_2619.length)
            {
                if (this.var_2619[_loc2_] == param1)
                {
                    this.var_2619.splice(_loc2_, 1);
                    return;
                };
                _loc2_++;
            };
        }

        public function prepareAssetLibrary(param1:XML, param2:Class):Boolean
        {
            return (assets.loadFromResource(param1, param2));
        }

        final public function prepareComponent(resource:Class, flags:uint=0, domain:ApplicationDomain=null):IUnknown
        {
            var manifest:XML;
            var component:Component;
            var componentClass:Class;
            var componentString:String;
            var interfaceList:XMLList;
            var iid:IID;
            var iidList:Array;
            var iidClass:Class;
            var iidString:String;
            var item:XML;
            var version:String;
            var unknown:IUnknown;
            var source:Object;
            var bytes:ByteArray;
            var assetList:XMLList;
            var assetNode:XML;
            var assetName:String;
            var assetType:AssetTypeDeclaration;
            var asset:IAsset;
            var assetCount:uint;
            var assetLibrary:IAssetLibrary;
            var k:uint;
            var j:uint;
            if (domain == null)
            {
                domain = ApplicationDomain.currentDomain;
            };
            try
            {
                source = (resource as Object).manifest;
                if ((source is XML))
                {
                    manifest = (source as XML);
                }
                else
                {
                    if ((source is Class))
                    {
                        bytes = (new ((source as Class))() as ByteArray);
                        manifest = new XML(bytes.readUTFBytes(bytes.length));
                    };
                };
            }
            catch(e:Error)
            {
                manifest = null;
            };
            if (manifest == null)
            {
                Logger.log((("Failed to find embedded manifest.xml in " + resource) + "!"));
                return (null);
            };
            var componentList:XMLList = manifest.child("component");
            var i:uint;
            while (i < componentList.length())
            {
                item = componentList[i];
                version = item.attribute("version");
                assetList = item.child("assets");
                assetCount = assetList.length();
                assetLibrary = null;
                if (assetCount > 0)
                {
                    assetList = assetList.child("asset");
                    assetCount = assetList.length();
                    assetLibrary = new AssetLibrary(("_assets@" + componentString));
                    k = 0;
                    while (k < assetCount)
                    {
                        assetNode = assetList[k];
                        assetName = assetNode.attribute("name");
                        assetType = assetLibrary.getAssetTypeDeclarationByMimeType(assetNode.attribute("mimeType"));
                        asset = new (assetType.assetClass)(assetType);
                        asset.setUnknownContent(resource[assetName]);
                        if (!assetLibrary.setAsset(assetName, asset))
                        {
                            this.error((((("Manifest for component " + componentString) + ' contains broken asset "') + assetName) + '"!'), true, Core.var_78);
                        };
                        k++;
                    };
                };
                componentString = item.attribute("class");
                componentClass = (domain.getDefinition(componentString) as Class);
                if (componentClass == null)
                {
                    componentClass = (getDefinitionByName(componentString) as Class);
                };
                if (componentClass == null)
                {
                    this.error((("Invalid component class " + componentString) + "!"), true, Core.var_78);
                    return (null);
                };
                component = ((assetLibrary == null) ? new (componentClass)(this, flags) : new (componentClass)(this, flags, assetLibrary));
                if (component != null)
                {
                    if (assetLibrary != null)
                    {
                        if (component.assets != assetLibrary)
                        {
                            assetLibrary.dispose();
                            this.error((('Component "' + componentString) + '" did not save provided asset library!'), true, Core.var_78);
                        };
                    };
                    interfaceList = item.child("interface");
                    iidList = new Array();
                    j = 0;
                    while (j < interfaceList.length())
                    {
                        iidString = interfaceList[j].attribute("iid");
                        iidClass = (domain.getDefinition(iidString) as Class);
                        if (iidClass == null)
                        {
                            iidClass = (getDefinitionByName(iidString) as Class);
                        };
                        if (iidClass == null)
                        {
                            throw (new InvalidComponentException(("Identifier class defined in manifest not found: " + iidString)));
                        };
                        iid = new (iidClass)();
                        unknown = (component as IUnknown);
                        getInterfaceStructList(component).insert(new InterfaceStruct(iid, component));
                        iidList.push(iid);
                        j++;
                    };
                    this.attachComponent(component, iidList);
                };
                i++;
            };
            return (component as IUnknown);
        }

        final public function attachComponent(param1:Component, param2:Array):void
        {
            var _loc3_:uint;
            var _loc5_:IID;
            var _loc6_:IID;
            if (this._components.indexOf(param1) > -1)
            {
                this.error((("Component " + param1) + " already attached to context!"), false);
                return;
            };
            this._components.push(param1);
            if (param1.locked)
            {
                param1.events.addEventListener(var_39, this.lockEventHandler);
            };
            var _loc4_:uint = param2.length;
            _loc3_ = 0;
            while (_loc3_ < _loc4_)
            {
                _loc5_ = param2[_loc3_];
                if (getInterfaceStructList(param1).find(_loc5_) == null)
                {
                    getInterfaceStructList(param1).insert(new InterfaceStruct(_loc5_, param1));
                };
                getInterfaceStructList(this).insert(new InterfaceStruct(_loc5_, param1));
                _loc3_++;
            };
            if (!param1.locked)
            {
                _loc3_ = 0;
                while (_loc3_ < _loc4_)
                {
                    _loc6_ = param2[_loc3_];
                    if (this.hasQueueForInterface(_loc6_))
                    {
                        this.announceInterfaceAvailability(_loc6_, param1);
                    };
                    _loc3_++;
                };
            };
        }

        final public function detachComponent(param1:Component):void
        {
            var _loc3_:InterfaceStruct;
            var _loc2_:InterfaceStructList = getInterfaceStructList(this);
            var _loc4_:int = _loc2_.getIndexByImplementor(param1);
            while (_loc4_ > -1)
            {
                _loc3_ = _loc2_.remove(_loc4_);
                _loc4_ = _loc2_.getIndexByImplementor(param1);
            };
            var _loc5_:uint;
            while (_loc5_ < this._components.length)
            {
                if (this._components[_loc5_] == param1)
                {
                    this._components.splice(_loc5_, 1);
                    param1.events.removeEventListener(var_39, this.lockEventHandler);
                    return;
                };
                _loc5_++;
            };
        }

        override public function queueInterface(param1:IID, param2:Function=null):IUnknown
        {
            var _loc4_:IUnknown;
            var _loc3_:InterfaceStruct = getInterfaceStructList(this).getStructByInterface(param1);
            if (_loc3_ != null)
            {
                _loc4_ = _loc3_.unknown.queueInterface(param1, param2);
                if (_loc4_)
                {
                    return (_loc4_);
                };
            };
            if (param2 != null)
            {
                this.addQueueeForInterface(param1, param2);
                if (((context) && (!(context == this))))
                {
                    context.queueInterface(param1, this.announceInterfaceAvailability);
                };
            };
            return (null);
        }

        final protected function addQueueeForInterface(param1:IID, param2:Function):void
        {
            var _loc3_:ComponentInterfaceQueue;
            if (this.hasQueueForInterface(param1))
            {
                _loc3_ = this.getQueueForInterface(param1);
            }
            else
            {
                _loc3_ = new ComponentInterfaceQueue(param1);
                this._queuees.push(_loc3_);
            };
            _loc3_.receivers.unshift(param2);
        }

        final protected function hasQueueForInterface(param1:IID):Boolean
        {
            var _loc2_:String = getQualifiedClassName(param1);
            var _loc3_:uint = this._queuees.length;
            var _loc4_:uint;
            while (_loc4_ < _loc3_)
            {
                if (getQualifiedClassName(this._queuees[_loc4_].identifier) == _loc2_)
                {
                    return (true);
                };
                _loc4_++;
            };
            return (false);
        }

        final protected function getQueueForInterface(param1:IID):ComponentInterfaceQueue
        {
            var _loc3_:ComponentInterfaceQueue;
            var _loc2_:String = getQualifiedClassName(param1);
            var _loc4_:uint = this._queuees.length;
            var _loc5_:uint;
            while (_loc5_ < _loc4_)
            {
                _loc3_ = this._queuees[_loc5_];
                if (getQualifiedClassName(_loc3_.identifier) == _loc2_)
                {
                    return (_loc3_);
                };
                _loc5_++;
            };
            return (null);
        }

        final protected function announceInterfaceAvailability(param1:IID, param2:Component):void
        {
            var _loc4_:IUnknown;
            var _loc3_:ComponentInterfaceQueue = this.getQueueForInterface(param1);
            if (_loc3_ == null)
            {
                return;
            };
            var _loc5_:uint = _loc3_.receivers.length;
            var _loc6_:uint;
            while (_loc6_ < _loc5_)
            {
                _loc4_ = param2.queueInterface(param1);
                if (_loc4_ == null)
                {
                    this.error((("Interface " + param1) + " still unavailabe!"), true, Core.var_80);
                };
                (_loc3_.receivers.pop()(param1, _loc4_));
                _loc6_++;
            };
        }

        override public function dispose():void
        {
            var _loc1_:uint;
            var _loc2_:LibraryLoader;
            if (!disposed)
            {
                super.dispose();
                if (this._components != null)
                {
                    _loc1_ = this._components.length;
                    while (_loc1_-- > 0)
                    {
                        IUnknown(this._components.pop()).dispose();
                    };
                    this._components = null;
                };
                if (this._queuees != null)
                {
                    _loc1_ = this._queuees.length;
                    while (_loc1_-- > 0)
                    {
                        IDisposable(this._queuees.pop()).dispose();
                    };
                    this._queuees = null;
                };
                if (this.var_2619 != null)
                {
                    _loc1_ = this.var_2619.length;
                    while (_loc1_-- > 0)
                    {
                        _loc2_ = this.var_2619[0];
                        this.removeLibraryLoader(_loc2_);
                        _loc2_.dispose();
                    };
                    this.var_2619 = null;
                };
            };
        }

        private function lockEventHandler(param1:LockEvent):void
        {
            var _loc2_:Component;
            var _loc3_:Array;
            var _loc4_:InterfaceStruct;
            if (param1.type == var_39)
            {
                _loc2_ = (param1.unknown as Component);
                _loc2_.events.removeEventListener(var_39, this.lockEventHandler);
                if (!disposed)
                {
                    _loc3_ = new Array();
                    getInterfaceStructList(this).mapStructsByImplementor(_loc2_, _loc3_);
                    while ((((_loc3_.length) && (!(_loc2_.disposed))) && (!(disposed))))
                    {
                        _loc4_ = _loc3_.pop();
                        this.announceInterfaceAvailability(_loc4_.iid, _loc2_);
                    };
                };
            };
        }

        override public function toXMLString(param1:uint=0):String
        {
            var _loc6_:InterfaceStruct;
            var _loc10_:Component;
            var _loc2_:String = "";
            var _loc3_:uint;
            while (_loc3_ < param1)
            {
                _loc2_ = (_loc2_ + "\t");
                _loc3_++;
            };
            var _loc4_:String = getQualifiedClassName(this);
            var _loc5_:String = "";
            _loc5_ = (_loc5_ + (((_loc2_ + '<context class="') + _loc4_) + '" >\n'));
            var _loc7_:Array = new Array();
            var _loc8_:uint = getInterfaceStructList(this).mapStructsByImplementor(this, _loc7_);
            var _loc9_:uint;
            while (_loc9_ < _loc8_)
            {
                _loc6_ = _loc7_[_loc9_];
                _loc5_ = (_loc5_ + (((((_loc2_ + '\t<interface iid="') + _loc6_.iis) + '" refs="') + _loc6_.references) + '"/>\n'));
                _loc9_++;
            };
            var _loc11_:uint;
            while (_loc11_ < this._components.length)
            {
                _loc10_ = (this._components[_loc11_] as Component);
                if (_loc10_ != this)
                {
                    _loc5_ = (_loc5_ + _loc10_.toXMLString((param1 + 1)));
                };
                _loc11_++;
            };
            return (_loc5_ + (_loc2_ + "</context>\n"));
        }


    }
}