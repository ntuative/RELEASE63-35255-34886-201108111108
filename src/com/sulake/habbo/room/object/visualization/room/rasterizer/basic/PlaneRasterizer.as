package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import com.sulake.habbo.room.object.visualization.room.rasterizer.IPlaneRasterizer;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.RoomGeometry;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.room.utils.XMLValidator;
    import com.sulake.room.utils.Rasterizer;
    import flash.geom.Point;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;

    public class PlaneRasterizer implements IPlaneRasterizer 
    {

        protected static const var_2232:String = "default";//"com.sulake.habbo.communication.messages.outgoing.help"

        private var var_4749:IGraphicAssetCollection = null;
        private var var_4784:Map = null;
        private var var_4680:Map = null;
        private var var_4628:Map = null;
        private var var_4785:Map = null;
        private var _data:XML = null;

        public function PlaneRasterizer()
        {
            this.var_4680 = new Map();
            this.var_4784 = new Map();
            this.var_4628 = new Map();
            this.var_4785 = new Map();
        }

        protected function get data():XML
        {
            return (this._data);
        }

        protected function get assetCollection():IGraphicAssetCollection
        {
            return (this.var_4749);
        }

        public function initializeDimensions(param1:int, param2:int):Boolean
        {
            return (true);
        }

        public function dispose():void
        {
            var _loc2_:Plane;
            var _loc3_:RoomGeometry;
            var _loc1_:int;
            if (this.var_4628 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_4628.length)
                {
                    _loc2_ = (this.var_4628.getWithIndex(_loc1_) as Plane);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    };
                    _loc1_++;
                };
                this.var_4628.dispose();
                this.var_4628 = null;
            };
            if (this.var_4784 != null)
            {
                this.resetMaterials();
                this.var_4784.dispose();
                this.var_4784 = null;
            };
            if (this.var_4680 != null)
            {
                this.resetTextures();
                this.var_4680.dispose();
                this.var_4680 = null;
            };
            if (this.var_4785 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_4785.length)
                {
                    _loc3_ = this.var_4785.getWithIndex(_loc1_);
                    if (_loc3_ != null)
                    {
                        _loc3_.dispose();
                    };
                    _loc1_++;
                };
                this.var_4785.dispose();
                this.var_4785 = null;
            };
            this._data = null;
            this.var_4749 = null;
        }

        public function clearCache():void
        {
            var _loc2_:Plane;
            var _loc3_:PlaneMaterial;
            var _loc1_:int;
            _loc1_ = 0;
            while (_loc1_ < this.var_4628.length)
            {
                _loc2_ = (this.var_4628.getWithIndex(_loc1_) as Plane);
                if (_loc2_ != null)
                {
                    _loc2_.clearCache();
                };
                _loc1_++;
            };
            _loc1_ = 0;
            while (_loc1_ < this.var_4784.length)
            {
                _loc3_ = (this.var_4784.getWithIndex(_loc1_) as PlaneMaterial);
                if (_loc3_ != null)
                {
                    _loc3_.clearCache();
                };
                _loc1_++;
            };
        }

        public function initialize(param1:XML):void
        {
            this._data = param1;
        }

        public function reinitialize():void
        {
            this.resetTextures();
            this.resetMaterials();
            this.initializeAll();
        }

        private function resetMaterials():void
        {
            var _loc2_:PlaneMaterial;
            var _loc1_:int;
            while (_loc1_ < this.var_4784.length)
            {
                _loc2_ = (this.var_4784.getWithIndex(_loc1_) as PlaneMaterial);
                if (_loc2_ != null)
                {
                    _loc2_.dispose();
                };
                _loc1_++;
            };
            this.var_4784.reset();
        }

        private function resetTextures():void
        {
            var _loc2_:PlaneTexture;
            var _loc1_:int;
            while (_loc1_ < this.var_4680.length)
            {
                _loc2_ = (this.var_4680.getWithIndex(_loc1_) as PlaneTexture);
                if (_loc2_ != null)
                {
                    _loc2_.dispose();
                };
                _loc1_++;
            };
            this.var_4680.reset();
        }

        protected function getTexture(param1:String):PlaneTexture
        {
            return (this.var_4680.getValue(param1) as PlaneTexture);
        }

        protected function getMaterial(param1:String):PlaneMaterial
        {
            return (this.var_4784.getValue(param1) as PlaneMaterial);
        }

        protected function getPlane(param1:String):Plane
        {
            return (this.var_4628.getValue(param1));
        }

        protected function addPlane(param1:String, param2:Plane):Boolean
        {
            if (param2 == null)
            {
                return (false);
            };
            if (this.var_4628.getValue(param1) == null)
            {
                this.var_4628.add(param1, param2);
                return (true);
            };
            return (false);
        }

        public function initializeAssetCollection(param1:IGraphicAssetCollection):void
        {
            if (this.data == null)
            {
                return;
            };
            this.var_4749 = param1;
            this.initializeAll();
        }

        private function initializeAll():void
        {
            if (this.data == null)
            {
                return;
            };
            this.initializeTexturesAndMaterials();
            this.initializePlanes();
        }

        private function initializeTexturesAndMaterials():void
        {
            var _loc1_:XMLList = this.data.textures;
            if (_loc1_.length() > 0)
            {
                this.parseTextures(_loc1_[0], this.assetCollection);
            };
            var _loc2_:XMLList = this.data.materials;
            if (_loc2_.length() > 0)
            {
                this.parsePlaneMaterials(_loc2_[0]);
            };
        }

        protected function initializePlanes():void
        {
        }

        private function parseTextures(param1:XML, param2:IGraphicAssetCollection):void
        {
            var _loc5_:XML;
            var _loc6_:String;
            var _loc7_:PlaneTexture;
            var _loc8_:XMLList;
            var _loc9_:int;
            var _loc10_:XML;
            var _loc11_:Number;
            var _loc12_:Number;
            var _loc13_:Number;
            var _loc14_:Number;
            var _loc15_:String;
            var _loc16_:IGraphicAsset;
            var _loc17_:BitmapDataAsset;
            var _loc18_:BitmapData;
            if (((param1 == null) || (param2 == null)))
            {
                return;
            };
            var _loc3_:XMLList = param1.texture;
            var _loc4_:int;
            while (_loc4_ < _loc3_.length())
            {
                _loc5_ = _loc3_[_loc4_];
                if (XMLValidator.checkRequiredAttributes(_loc5_, ["id"]))
                {
                    _loc6_ = _loc5_.@id;
                    if (this.var_4680.getValue(_loc6_) == null)
                    {
                        _loc7_ = new PlaneTexture();
                        _loc8_ = _loc5_.bitmap;
                        _loc9_ = 0;
                        while (_loc9_ < _loc8_.length())
                        {
                            _loc10_ = _loc8_[_loc9_];
                            if (XMLValidator.checkRequiredAttributes(_loc10_, ["assetName"]))
                            {
                                _loc11_ = PlaneTexture.var_2218;
                                _loc12_ = PlaneTexture.MAX_NORMAL_COORDINATE_VALUE;
                                _loc13_ = PlaneTexture.var_2218;
                                _loc14_ = PlaneTexture.MAX_NORMAL_COORDINATE_VALUE;
                                if (String(_loc10_.@normalMinX) != "")
                                {
                                    _loc11_ = parseFloat(_loc10_.@normalMinX);
                                };
                                if (String(_loc10_.@normalMaxX) != "")
                                {
                                    _loc12_ = parseFloat(_loc10_.@normalMaxX);
                                };
                                if (String(_loc10_.@normalMinY) != "")
                                {
                                    _loc13_ = parseFloat(_loc10_.@normalMinY);
                                };
                                if (String(_loc10_.@normalMaxY) != "")
                                {
                                    _loc14_ = parseFloat(_loc10_.@normalMaxY);
                                };
                                _loc15_ = _loc10_.@assetName;
                                _loc16_ = param2.getAsset(_loc15_);
                                if (_loc16_ != null)
                                {
                                    _loc17_ = (_loc16_.asset as BitmapDataAsset);
                                    if (_loc17_ != null)
                                    {
                                        _loc18_ = (_loc17_.content as BitmapData);
                                        if (_loc18_ != null)
                                        {
                                            if (_loc16_.flipH)
                                            {
                                                _loc18_ = Rasterizer.getFlipHBitmapData(_loc18_);
                                            }
                                            else
                                            {
                                                _loc18_ = _loc18_.clone();
                                            };
                                            _loc7_.addBitmap(_loc18_, _loc11_, _loc12_, _loc13_, _loc14_);
                                        };
                                    };
                                };
                            };
                            _loc9_++;
                        };
                        this.var_4680.add(_loc6_, _loc7_);
                    };
                };
                _loc4_++;
            };
        }

        private function parsePlaneMaterials(param1:XML):void
        {
            var _loc4_:XML;
            var _loc5_:String;
            var _loc6_:PlaneMaterial;
            var _loc7_:XMLList;
            var _loc8_:int;
            var _loc9_:XML;
            var _loc10_:String;
            var _loc11_:String;
            var _loc12_:int;
            var _loc13_:int;
            var _loc14_:Number;
            var _loc15_:Number;
            var _loc16_:Number;
            var _loc17_:Number;
            var _loc18_:XMLList;
            var _loc19_:PlaneMaterialCellMatrix;
            var _loc20_:int;
            var _loc21_:XML;
            if (param1 == null)
            {
                return;
            };
            var _loc2_:XMLList = param1.material;
            var _loc3_:int;
            while (_loc3_ < _loc2_.length())
            {
                _loc4_ = _loc2_[_loc3_];
                if (XMLValidator.checkRequiredAttributes(_loc4_, ["id"]))
                {
                    _loc5_ = _loc4_.@id;
                    _loc6_ = new PlaneMaterial();
                    _loc7_ = _loc4_.materialCellMatrix;
                    _loc8_ = 0;
                    while (_loc8_ < _loc7_.length())
                    {
                        _loc9_ = _loc7_[_loc8_];
                        _loc10_ = _loc9_.@repeatMode;
                        _loc11_ = _loc9_.@align;
                        _loc12_ = PlaneMaterialCellMatrix.var_2219;
                        switch (_loc10_)
                        {
                            case "borders":
                                _loc12_ = PlaneMaterialCellMatrix.var_2220;
                                break;
                            case "center":
                                _loc12_ = PlaneMaterialCellMatrix.var_2221;
                                break;
                            case "first":
                                _loc12_ = PlaneMaterialCellMatrix.var_2222;
                                break;
                            case "last":
                                _loc12_ = PlaneMaterialCellMatrix.var_2223;
                                break;
                            case "random":
                                _loc12_ = PlaneMaterialCellMatrix.var_2224;
                                break;
                        };
                        _loc13_ = PlaneMaterialCellMatrix.ALIGN_DEFAULT;
                        switch (_loc11_)
                        {
                            case "top":
                                _loc13_ = PlaneMaterialCellMatrix.var_2225;
                                break;
                            case "bottom":
                                _loc13_ = PlaneMaterialCellMatrix.var_2111;
                                break;
                        };
                        _loc14_ = PlaneMaterialCellMatrix.var_2218;
                        _loc15_ = PlaneMaterialCellMatrix.MAX_NORMAL_COORDINATE_VALUE;
                        _loc16_ = PlaneMaterialCellMatrix.var_2218;
                        _loc17_ = PlaneMaterialCellMatrix.MAX_NORMAL_COORDINATE_VALUE;
                        if (String(_loc9_.@normalMinX) != "")
                        {
                            _loc14_ = parseFloat(_loc9_.@normalMinX);
                        };
                        if (String(_loc9_.@normalMaxX) != "")
                        {
                            _loc15_ = parseFloat(_loc9_.@normalMaxX);
                        };
                        if (String(_loc9_.@normalMinY) != "")
                        {
                            _loc16_ = parseFloat(_loc9_.@normalMinY);
                        };
                        if (String(_loc9_.@normalMaxY) != "")
                        {
                            _loc17_ = parseFloat(_loc9_.@normalMaxY);
                        };
                        _loc18_ = _loc9_.materialCellColumn;
                        if (_loc18_.length() > 0)
                        {
                            _loc19_ = null;
                            _loc19_ = _loc6_.addMaterialCellMatrix(_loc18_.length(), _loc12_, _loc13_, _loc14_, _loc15_, _loc16_, _loc17_);
                            _loc20_ = 0;
                            while (_loc20_ < _loc18_.length())
                            {
                                _loc21_ = _loc18_[_loc20_];
                                this.parsePlaneMaterialCellColumn(_loc21_, _loc19_, _loc20_);
                                _loc20_++;
                            };
                        };
                        this.var_4784.add(_loc5_, _loc6_);
                        _loc8_++;
                    };
                };
                _loc3_++;
            };
        }

        private function parsePlaneMaterialCellColumn(param1:XML, param2:PlaneMaterialCellMatrix, param3:int):void
        {
            if (((param1 == null) || (param2 == null)))
            {
                return;
            };
            var _loc4_:String = param1.@repeatMode;
            var _loc5_:int = parseInt(param1.@width);
            var _loc6_:int = PlaneMaterialCellColumn.var_2226;
            switch (_loc4_)
            {
                case "borders":
                    _loc6_ = PlaneMaterialCellColumn.var_2220;
                    break;
                case "center":
                    _loc6_ = PlaneMaterialCellColumn.var_2221;
                    break;
                case "first":
                    _loc6_ = PlaneMaterialCellColumn.var_2222;
                    break;
                case "last":
                    _loc6_ = PlaneMaterialCellColumn.var_2223;
                    break;
                case "none":
                    _loc6_ = PlaneMaterialCellColumn.var_2227;
            };
            var _loc7_:Array = this.parsePlaneMaterialCells(param1);
            param2.createColumn(param3, _loc5_, _loc7_, _loc6_);
        }

        private function parsePlaneMaterialCells(param1:XML):Array
        {
            var _loc5_:XML;
            var _loc6_:String;
            var _loc7_:Array;
            var _loc8_:Array;
            var _loc9_:Array;
            var _loc10_:int;
            var _loc11_:XMLList;
            var _loc12_:PlaneTexture;
            var _loc13_:PlaneMaterialCell;
            var _loc14_:XML;
            var _loc15_:XMLList;
            var _loc16_:XMLList;
            var _loc17_:XML;
            var _loc18_:XML;
            var _loc19_:int;
            var _loc20_:String;
            var _loc21_:IGraphicAsset;
            if (param1 == null)
            {
                return (null);
            };
            var _loc2_:Array = [];
            var _loc3_:XMLList = param1.materialCell;
            var _loc4_:int;
            while (_loc4_ < _loc3_.length())
            {
                _loc5_ = _loc3_[_loc4_];
                _loc6_ = _loc5_.@textureId;
                _loc7_ = null;
                _loc8_ = null;
                _loc9_ = null;
                _loc10_ = 0;
                _loc11_ = _loc5_.extraItemData;
                if (_loc11_.length() > 0)
                {
                    _loc14_ = _loc11_[0];
                    _loc15_ = _loc14_.extraItemTypes;
                    _loc16_ = _loc14_.offsets;
                    if (((_loc15_.length() > 0) && (_loc16_.length() > 0)))
                    {
                        _loc17_ = _loc15_[0];
                        _loc18_ = _loc16_[0];
                        _loc7_ = this.parseExtraItemTypes(_loc17_);
                        _loc9_ = this.parseExtraItemOffsets(_loc18_);
                        _loc10_ = _loc9_.length;
                        if (String(_loc14_.@limitMax) != "")
                        {
                            _loc10_ = parseInt(_loc14_.@limitMax);
                        };
                    };
                };
                if (_loc7_ != null)
                {
                    _loc8_ = [];
                    _loc19_ = 0;
                    while (_loc19_ < _loc7_.length)
                    {
                        _loc20_ = _loc7_[_loc4_];
                        _loc21_ = this.var_4749.getAsset(_loc20_);
                        if (_loc21_ != null)
                        {
                            _loc8_.push(_loc21_);
                        };
                        _loc19_++;
                    };
                };
                _loc12_ = this.getTexture(_loc6_);
                _loc13_ = new PlaneMaterialCell(_loc12_, _loc8_, _loc9_, _loc10_);
                _loc2_.push(_loc13_);
                _loc4_++;
            };
            if (_loc2_.length == 0)
            {
                _loc2_ = null;
            };
            return (_loc2_);
        }

        private function parseExtraItemTypes(param1:XML):Array
        {
            var _loc4_:XMLList;
            var _loc5_:int;
            var _loc6_:XML;
            var _loc7_:String;
            var _loc2_:Array = [];
            var _loc3_:Array = ["assetName"];
            if (param1 != null)
            {
                _loc4_ = param1.extraItemType;
                _loc5_ = 0;
                while (_loc5_ < _loc4_.length())
                {
                    _loc6_ = _loc4_[_loc5_];
                    if (XMLValidator.checkRequiredAttributes(_loc6_, _loc3_))
                    {
                        _loc7_ = _loc6_.@assetName;
                        _loc2_.push(_loc7_);
                    };
                    _loc5_++;
                };
            };
            return (_loc2_);
        }

        private function parseExtraItemOffsets(param1:XML):Array
        {
            var _loc4_:XMLList;
            var _loc5_:int;
            var _loc6_:XML;
            var _loc7_:int;
            var _loc8_:int;
            var _loc2_:Array = [];
            var _loc3_:Array = ["x", "y"];
            if (param1 != null)
            {
                _loc4_ = param1.offset;
                _loc5_ = 0;
                while (_loc5_ < _loc4_.length())
                {
                    _loc6_ = _loc4_[_loc5_];
                    if (XMLValidator.checkRequiredAttributes(_loc6_, _loc3_))
                    {
                        _loc7_ = parseInt(_loc6_.@x);
                        _loc8_ = parseInt(_loc6_.@y);
                        _loc2_.push(new Point(_loc7_, _loc8_));
                    };
                    _loc5_++;
                };
            };
            return (_loc2_);
        }

        protected function getGeometry(param1:int, param2:Number, param3:Number):IRoomGeometry
        {
            param2 = Math.abs(param2);
            if (param2 > 90)
            {
                param2 = 90;
            };
            param3 = Math.abs(param3);
            if (param3 > 90)
            {
                param3 = 90;
            };
            var _loc4_:String = ((((param1 + "_") + Math.round(param2)) + "_") + Math.round(param3));
            var _loc5_:IRoomGeometry = this.var_4785.getValue(_loc4_);
            if (_loc5_ == null)
            {
                _loc5_ = new RoomGeometry(param1, new Vector3d(param2, param3), new Vector3d(-10, 0, 0));
                this.var_4785.add(_loc4_, _loc5_);
            };
            return (_loc5_);
        }

        protected function parseVisualizations(param1:Plane, param2:XMLList):void
        {
            var _loc4_:XML;
            var _loc5_:int;
            var _loc6_:String;
            var _loc7_:String;
            var _loc8_:Number;
            var _loc9_:Number;
            var _loc10_:XMLList;
            var _loc11_:PlaneVisualization;
            var _loc12_:int;
            var _loc13_:XML;
            var _loc14_:PlaneMaterial;
            var _loc15_:int;
            var _loc16_:String;
            var _loc17_:int;
            var _loc18_:String;
            var _loc19_:uint;
            var _loc20_:String;
            var _loc21_:String;
            if (((param1 == null) || (param2 == null)))
            {
                return;
            };
            var _loc3_:int;
            while (_loc3_ < param2.length())
            {
                _loc4_ = param2[_loc3_];
                if (XMLValidator.checkRequiredAttributes(_loc4_, ["size"]))
                {
                    _loc5_ = parseInt(_loc4_.@size);
                    _loc6_ = _loc4_.@horizontalAngle;
                    _loc7_ = _loc4_.@verticalAngle;
                    _loc8_ = FloorPlane.var_2228;
                    if (_loc6_ != "")
                    {
                        _loc8_ = parseFloat(_loc6_);
                    };
                    _loc9_ = FloorPlane.var_2229;
                    if (_loc7_ != "")
                    {
                        _loc9_ = parseFloat(_loc7_);
                    };
                    _loc10_ = _loc4_.visualizationLayer;
                    _loc11_ = param1.createPlaneVisualization(_loc5_, _loc10_.length(), this.getGeometry(_loc5_, _loc8_, _loc9_));
                    if (_loc11_ != null)
                    {
                        _loc12_ = 0;
                        while (_loc12_ < _loc10_.length())
                        {
                            _loc13_ = _loc10_[_loc12_];
                            _loc14_ = null;
                            _loc15_ = PlaneVisualizationLayer.ALIGN_DEFAULT;
                            if (XMLValidator.checkRequiredAttributes(_loc13_, ["materialId"]))
                            {
                                _loc21_ = _loc13_.@materialId;
                                _loc14_ = this.getMaterial(_loc21_);
                            };
                            _loc16_ = _loc13_.@offset;
                            _loc17_ = PlaneVisualizationLayer.var_2230;
                            if (_loc16_.length > 0)
                            {
                                _loc17_ = parseInt(_loc16_);
                            };
                            _loc18_ = _loc13_.@color;
                            _loc19_ = FloorPlane.var_1446;
                            if (_loc18_.length > 0)
                            {
                                _loc19_ = parseInt(_loc18_);
                            };
                            _loc20_ = _loc13_.@align;
                            if (_loc20_ == "bottom")
                            {
                                _loc15_ = PlaneVisualizationLayer.var_2111;
                            }
                            else
                            {
                                if (_loc20_ == "top")
                                {
                                    _loc15_ = PlaneVisualizationLayer.var_2225;
                                };
                            };
                            _loc11_.var_2231(_loc12_, _loc14_, _loc19_, _loc15_, _loc17_);
                            _loc12_++;
                        };
                    };
                };
                _loc3_++;
            };
        }

        public function render(param1:BitmapData, param2:String, param3:Number, param4:Number, param5:Number, param6:IVector3d, param7:Boolean, param8:Number=0, param9:Number=0, param10:Number=0, param11:Number=0, param12:int=0):PlaneBitmapData
        {
            return (null);
        }

        public function getTextureIdentifier(param1:Number, param2:IVector3d):String
        {
            return (String(param1));
        }


    }
}