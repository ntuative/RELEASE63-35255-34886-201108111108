package com.sulake.room
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.utils.Map;
    import com.sulake.room.object.IRoomObjectVisualizationFactory;
    import com.sulake.iid.IIDRoomObjectFactory;
    import com.sulake.iid.IIDRoomObjectVisualizationFactory;
    import com.sulake.room.events.RoomContentLoadedEvent;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.room.exceptions.RoomManagerException;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.room.object.visualization.IRoomObjectGraphicVisualization;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.room.object.logic.IRoomObjectEventHandler;
    import flash.utils.getTimer;
    import com.sulake.iid.*;

    public class RoomManager extends Component implements IRoomManager, IRoomInstanceContainer 
    {

        public static const var_260:int = -1;
        public static const var_261:int = 0;
        public static const var_262:int = 1;
        public static const var_263:int = 2;
        public static const var_264:int = 3;
        private static const CONTENT_PROCESSING_TIME_LIMIT_MILLISECONDS:int = 40;

        private var var_3471:Map;
        private var var_5591:IRoomContentLoader;
        private var var_5592:Array;
        private var _updateCategories:Array;
        private var var_4527:int;
        private var var_4981:IRoomManagerListener;
        private var var_5593:IRoomContentLoader;
        private var var_5594:IRoomObjectFactory = null;
        private var var_4886:IRoomObjectVisualizationFactory = null;
        private var _state:int = 0;
        private var var_5595:XML = null;
        private var var_5596:Array = [];
        private var var_5597:Boolean = false;
        private var var_5598:Boolean = true;
        private var _disposed:Boolean = false;

        public function RoomManager(param1:IContext, param2:uint=0)
        {
            super(param1, param2);
            this.var_3471 = new Map();
            queueInterface(new IIDRoomObjectFactory(), this.objectFactoryReady);
            queueInterface(new IIDRoomObjectVisualizationFactory(), this.visualizationFactoryReady);
            this.var_5592 = [];
            this._updateCategories = [];
            events.addEventListener(RoomContentLoadedEvent.var_265, this.onContentLoaded);
            events.addEventListener(RoomContentLoadedEvent.var_266, this.onContentLoaded);
            events.addEventListener(RoomContentLoadedEvent.var_267, this.onContentLoaded);
        }

        override public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function set limitContentProcessing(param1:Boolean):void
        {
            this.var_5598 = param1;
        }

        override public function dispose():void
        {
            var _loc3_:IRoomInstance;
            if (this.disposed)
            {
                return;
            };
            super.dispose();
            var _loc1_:int;
            var _loc2_:int;
            if (this.var_3471 != null)
            {
                _loc1_ = this.var_3471.length;
                _loc2_ = 0;
                while (_loc2_ < _loc1_)
                {
                    _loc3_ = (this.var_3471.getWithIndex(_loc2_) as IRoomInstance);
                    if (_loc3_ != null)
                    {
                        _loc3_.dispose();
                    };
                    _loc2_++;
                };
                this.var_3471.dispose();
                this.var_3471 = null;
            };
            this.var_4981 = null;
            if (this.var_5594 != null)
            {
                release(new IIDRoomObjectFactory());
                this.var_5594 = null;
            };
            if (this.var_4886 != null)
            {
                release(new IIDRoomObjectVisualizationFactory());
                this.var_4886 = null;
            };
            this.var_5592 = null;
            this._updateCategories = null;
            this.var_5591 = null;
            this._disposed = true;
        }

        private function objectFactoryReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (this.disposed)
            {
                return;
            };
            this.var_5594 = (param2 as IRoomObjectFactory);
            this.continueInitializing();
        }

        private function visualizationFactoryReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (this.disposed)
            {
                return;
            };
            this.var_4886 = (param2 as IRoomObjectVisualizationFactory);
            this.continueInitializing();
        }

        private function continueInitializing():void
        {
            var _loc1_:XML;
            if (((this.var_5594 == null) || (this.var_4886 == null)))
            {
                return;
            };
            this._state = var_262;
            if (this.var_5595 != null)
            {
                _loc1_ = this.var_5595;
                this.var_5595 = null;
                this.initialize(_loc1_, this.var_4981);
            };
        }

        public function initialize(param1:XML, param2:IRoomManagerListener):Boolean
        {
            var _loc5_:String;
            if (this._state == var_261)
            {
                if (this.var_5595 != null)
                {
                    return (false);
                };
                this.var_5595 = param1;
                this.var_4981 = param2;
                return (true);
            };
            if (this._state >= var_263)
            {
                return (false);
            };
            if (param1 == null)
            {
                return (false);
            };
            if (this.var_5591 == null)
            {
                return (false);
            };
            this.var_4527 = 50;
            this.var_4981 = param2;
            var _loc3_:Array = this.var_5591.getPlaceHolderTypes();
            var _loc4_:int;
            while (_loc4_ < _loc3_.length)
            {
                _loc5_ = _loc3_[_loc4_];
                if (this.var_5592.indexOf(_loc5_) < 0)
                {
                    this.var_5591.loadObjectContent(_loc5_, events);
                    this.var_5592.push(_loc5_);
                };
                _loc4_++;
            };
            this._state = var_263;
            return (true);
        }

        public function setContentLoader(param1:IRoomContentLoader):void
        {
            if (this.var_5591 != null)
            {
                this.var_5591.dispose();
            };
            this.var_5591 = param1;
        }

        public function addObjectUpdateCategory(param1:int):void
        {
            var _loc4_:RoomInstance;
            var _loc2_:int = this._updateCategories.indexOf(param1);
            if (_loc2_ >= 0)
            {
                return;
            };
            this._updateCategories.push(param1);
            var _loc3_:int = (this.var_3471.length - 1);
            while (_loc3_ >= 0)
            {
                _loc4_ = (this.var_3471.getWithIndex(_loc3_) as RoomInstance);
                if (_loc4_ != null)
                {
                    _loc4_.addObjectUpdateCategory(param1);
                };
                _loc3_--;
            };
        }

        public function removeObjectUpdateCategory(param1:int):void
        {
            var _loc4_:RoomInstance;
            var _loc2_:int = this._updateCategories.indexOf(param1);
            if (_loc2_ < 0)
            {
                return;
            };
            this._updateCategories.splice(_loc2_, 1);
            var _loc3_:int = (this.var_3471.length - 1);
            while (_loc3_ >= 0)
            {
                _loc4_ = (this.var_3471.getWithIndex(_loc3_) as RoomInstance);
                if (_loc4_ != null)
                {
                    _loc4_.removeObjectUpdateCategory(param1);
                };
                _loc3_--;
            };
        }

        public function createRoom(param1:String, param2:XML):IRoomInstance
        {
            var _loc5_:int;
            if (this._state < var_264)
            {
                throw (new RoomManagerException());
            };
            if (this.var_3471.getValue(param1) != null)
            {
                return (null);
            };
            var _loc3_:RoomInstance = new RoomInstance(param1, this);
            this.var_3471.add(String(param1), _loc3_);
            var _loc4_:int = (this._updateCategories.length - 1);
            while (_loc4_ >= 0)
            {
                _loc5_ = this._updateCategories[_loc4_];
                _loc3_.addObjectUpdateCategory(_loc5_);
                _loc4_--;
            };
            return (_loc3_);
        }

        public function getRoom(param1:String):IRoomInstance
        {
            return (this.var_3471.getValue(param1) as IRoomInstance);
        }

        public function getRoomWithIndex(param1:int):IRoomInstance
        {
            return (this.var_3471.getWithIndex(param1));
        }

        public function getRoomCount():int
        {
            return (this.var_3471.length);
        }

        public function disposeRoom(param1:String):Boolean
        {
            var _loc2_:IRoomInstance = (this.var_3471.remove(param1) as IRoomInstance);
            if (_loc2_ != null)
            {
                _loc2_.dispose();
                return (true);
            };
            return (false);
        }

        public function createRoomObject(param1:String, param2:int, param3:String, param4:int):IRoomObject
        {
            if (this._state < var_264)
            {
                throw (new RoomManagerException());
            };
            var _loc5_:IRoomInstance = this.getRoom(param1);
            if (_loc5_ == null)
            {
                return (null);
            };
            if (this.var_5591 == null)
            {
                return (null);
            };
            var _loc6_:RoomInstance = (_loc5_ as RoomInstance);
            if (_loc6_ == null)
            {
                return (null);
            };
            var _loc7_:IGraphicAssetCollection;
            var _loc8_:XML;
            var _loc9_:XML;
            var _loc10_:String;
            var _loc11_:String;
            var _loc12_:String = param3;
            if (!this.var_5591.hasInternalContent(param3))
            {
                _loc7_ = this.var_5591.getGraphicAssetCollection(param3);
                if (_loc7_ == null)
                {
                    this.var_5591.loadObjectContent(param3, events);
                    _loc12_ = this.var_5591.getPlaceHolderType(param3);
                    _loc7_ = this.var_5591.getGraphicAssetCollection(_loc12_);
                };
                _loc8_ = this.var_5591.getVisualizationXML(_loc12_);
                _loc9_ = this.var_5591.getLogicXML(_loc12_);
                if (((_loc8_ == null) || (_loc7_ == null)))
                {
                    return (null);
                };
                _loc10_ = this.var_5591.getVisualizationType(_loc12_);
                _loc11_ = this.var_5591.getLogicType(_loc12_);
            }
            else
            {
                _loc10_ = param3;
                _loc11_ = param3;
            };
            var _loc13_:int = 1;
            var _loc14_:IRoomObject = _loc6_.createObjectInternal(param2, _loc13_, param3, param4);
            var _loc15_:IRoomObjectController = (_loc14_ as IRoomObjectController);
            if (_loc15_ == null)
            {
                return (null);
            };
            var _loc16_:IRoomObjectModelController = _loc15_.getModelController();
            if (_loc16_ == null)
            {
                _loc5_.disposeObject(param2, param4);
                return (null);
            };
            var _loc17_:IRoomObjectGraphicVisualization = this.var_4886.createRoomObjectVisualization(_loc10_);
            if (_loc17_ == null)
            {
                _loc5_.disposeObject(param2, param4);
                return (null);
            };
            _loc17_.assetCollection = _loc7_;
            var _loc18_:IRoomObjectVisualizationData;
            _loc18_ = this.var_4886.getRoomObjectVisualizationData(_loc12_, _loc10_, _loc8_);
            if (!_loc17_.initialize(_loc18_))
            {
                _loc5_.disposeObject(param2, param4);
                return (null);
            };
            _loc15_.setVisualization(_loc17_);
            var _loc19_:IRoomObjectEventHandler = this.var_5594.createRoomObjectLogic(_loc11_);
            _loc15_.setEventHandler(_loc19_);
            if (((!(_loc19_ == null)) && (!(_loc9_ == null))))
            {
                _loc19_.initialize(_loc9_);
            };
            return (_loc15_);
        }

        public function createRoomObjectManager():IRoomObjectManager
        {
            if (this.var_5594 != null)
            {
                return (this.var_5594.createRoomObjectManager());
            };
            return (null);
        }

        public function isContentAvailable(param1:String):Boolean
        {
            if (this.var_5591 != null)
            {
                if (this.var_5591.getGraphicAssetCollection(param1) != null)
                {
                    return (true);
                };
            };
            return (false);
        }

        private function processInitialContentLoad(param1:String):void
        {
            var _loc2_:int;
            if (param1 == null)
            {
                return;
            };
            if (this._state == var_260)
            {
                return;
            };
            if (this.var_5591 == null)
            {
                this._state = var_260;
                return;
            };
            if (this.var_5591.getGraphicAssetCollection(param1) != null)
            {
                _loc2_ = this.var_5592.indexOf(param1);
                if (_loc2_ >= 0)
                {
                    this.var_5592.splice(_loc2_, 1);
                };
                if (this.var_5592.length == 0)
                {
                    this._state = var_264;
                    if (this.var_4981 != null)
                    {
                        this.var_4981.roomManagerInitialized();
                    };
                };
            }
            else
            {
                this._state = var_260;
                this.var_4981.roomManagerInitialized(false);
            };
        }

        private function onContentLoaded(param1:RoomContentLoadedEvent):void
        {
            if (this.var_5591 == null)
            {
                return;
            };
            var _loc2_:String = param1.contentType;
            if (_loc2_ == null)
            {
                if (this.var_4981 != null)
                {
                    this.var_4981.contentLoaded(null, false);
                };
                return;
            };
            if (this.var_5596.indexOf(_loc2_) < 0)
            {
                this.var_5596.push(_loc2_);
            };
        }

        private function processLoadedContentTypes():void
        {
            var _loc2_:String;
            var _loc3_:XML;
            var _loc4_:IGraphicAssetCollection;
            var _loc5_:int;
            if (this.var_5597)
            {
                this.var_5597 = false;
                return;
            };
            var _loc1_:int = getTimer();
            while (this.var_5596.length > 0)
            {
                _loc2_ = this.var_5596[0];
                this.var_5596.splice(0, 1);
                _loc3_ = this.var_5591.getVisualizationXML(_loc2_);
                if (_loc3_ == null)
                {
                    if (this.var_4981 != null)
                    {
                        this.var_4981.contentLoaded(_loc2_, false);
                    };
                    return;
                };
                _loc4_ = this.var_5591.getGraphicAssetCollection(_loc2_);
                if (_loc4_ == null)
                {
                    if (this.var_4981 != null)
                    {
                        this.var_4981.contentLoaded(_loc2_, false);
                    };
                    return;
                };
                this.updateObjectContents(_loc2_);
                if (this.var_4981 != null)
                {
                    this.var_4981.contentLoaded(_loc2_, true);
                };
                if (this.var_5592.length > 0)
                {
                    this.processInitialContentLoad(_loc2_);
                };
                _loc5_ = getTimer();
                if ((((_loc5_ - _loc1_) >= CONTENT_PROCESSING_TIME_LIMIT_MILLISECONDS) && (this.var_5598)))
                {
                    this.var_5597 = true;
                    return;
                };
            };
        }

        private function updateObjectContents(param1:String):void
        {
            var _loc9_:RoomInstance;
            var _loc10_:String;
            var _loc11_:Array;
            var _loc12_:int;
            var _loc13_:int;
            var _loc14_:int;
            var _loc15_:IRoomObjectController;
            var _loc16_:IRoomObjectGraphicVisualization;
            var _loc17_:IRoomObjectEventHandler;
            if (param1 == null)
            {
                return;
            };
            if (((this.var_5591 == null) || (this.var_4886 == null)))
            {
                return;
            };
            var _loc2_:XML = this.var_5591.getVisualizationXML(param1);
            var _loc3_:XML = this.var_5591.getLogicXML(param1);
            var _loc4_:IGraphicAssetCollection = this.var_5591.getGraphicAssetCollection(param1);
            if (((_loc2_ == null) || (_loc4_ == null)))
            {
                return;
            };
            var _loc5_:String = this.var_5591.getVisualizationType(param1);
            var _loc6_:String = this.var_5591.getLogicType(param1);
            var _loc7_:IRoomObjectVisualizationData = this.var_4886.getRoomObjectVisualizationData(param1, _loc5_, _loc2_);
            var _loc8_:int = (this.var_3471.length - 1);
            while (_loc8_ >= 0)
            {
                _loc9_ = (this.var_3471.getWithIndex(_loc8_) as RoomInstance);
                _loc10_ = this.var_3471.getKey(_loc8_);
                if (_loc9_ != null)
                {
                    _loc11_ = _loc9_.getObjectManagerIds();
                    for each (_loc12_ in _loc11_)
                    {
                        _loc13_ = _loc9_.getObjectCountForType(param1, _loc12_);
                        _loc14_ = (_loc13_ - 1);
                        while (_loc14_ >= 0)
                        {
                            _loc15_ = (_loc9_.getObjectWithIndexAndType(_loc14_, param1, _loc12_) as IRoomObjectController);
                            if (_loc15_ != null)
                            {
                                _loc16_ = this.var_4886.createRoomObjectVisualization(_loc5_);
                                if (_loc16_ != null)
                                {
                                    _loc16_.assetCollection = _loc4_;
                                    if (!_loc16_.initialize(_loc7_))
                                    {
                                        _loc9_.disposeObject(_loc15_.getId(), _loc12_);
                                    }
                                    else
                                    {
                                        _loc15_.setVisualization(_loc16_);
                                        _loc17_ = this.var_5594.createRoomObjectLogic(_loc6_);
                                        _loc15_.setEventHandler(_loc17_);
                                        if (_loc17_ != null)
                                        {
                                            _loc17_.initialize(_loc3_);
                                        };
                                        if (this.var_4981 != null)
                                        {
                                            this.var_4981.objectInitialized(_loc10_, _loc15_.getId(), _loc12_);
                                        };
                                    };
                                }
                                else
                                {
                                    _loc9_.disposeObject(_loc15_.getId(), _loc12_);
                                };
                            };
                            _loc14_--;
                        };
                    };
                };
                _loc8_--;
            };
        }

        public function update(param1:uint):void
        {
            var _loc3_:RoomInstance;
            this.processLoadedContentTypes();
            var _loc2_:int = (this.var_3471.length - 1);
            while (_loc2_ >= 0)
            {
                _loc3_ = (this.var_3471.getWithIndex(_loc2_) as RoomInstance);
                if (_loc3_ != null)
                {
                    _loc3_.update();
                };
                _loc2_--;
            };
        }


    }
}