package com.sulake.habbo.room.utils
{
    import com.sulake.core.utils.Map;

    public class RoomInstanceData 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var var_4868:TileHeightMap = null;
        private var var_4869:LegacyWallGeometry = null;
        private var var_4870:RoomCamera = null;
        private var var_4871:SelectedRoomObjectData = null;
        private var var_4872:SelectedRoomObjectData = null;
        private var _worldType:String = null;
        private var var_4873:Map = new Map();
        private var var_4874:Map = new Map();

        public function RoomInstanceData(param1:int, param2:int)
        {
            this._roomId = param1;
            this._roomCategory = param2;
            this.var_4869 = new LegacyWallGeometry();
            this.var_4870 = new RoomCamera();
        }

        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function get tileHeightMap():TileHeightMap
        {
            return (this.var_4868);
        }

        public function set tileHeightMap(param1:TileHeightMap):void
        {
            if (this.var_4868 != null)
            {
                this.var_4868.dispose();
            };
            this.var_4868 = param1;
        }

        public function get legacyGeometry():LegacyWallGeometry
        {
            return (this.var_4869);
        }

        public function get roomCamera():RoomCamera
        {
            return (this.var_4870);
        }

        public function get worldType():String
        {
            return (this._worldType);
        }

        public function set worldType(param1:String):void
        {
            this._worldType = param1;
        }

        public function get selectedObject():SelectedRoomObjectData
        {
            return (this.var_4871);
        }

        public function set selectedObject(param1:SelectedRoomObjectData):void
        {
            if (this.var_4871 != null)
            {
                this.var_4871.dispose();
            };
            this.var_4871 = param1;
        }

        public function get placedObject():SelectedRoomObjectData
        {
            return (this.var_4872);
        }

        public function set placedObject(param1:SelectedRoomObjectData):void
        {
            if (this.var_4872 != null)
            {
                this.var_4872.dispose();
            };
            this.var_4872 = param1;
        }

        public function dispose():void
        {
            if (this.var_4868 != null)
            {
                this.var_4868.dispose();
                this.var_4868 = null;
            };
            if (this.var_4869 != null)
            {
                this.var_4869.dispose();
                this.var_4869 = null;
            };
            if (this.var_4870 != null)
            {
                this.var_4870.dispose();
                this.var_4870 = null;
            };
            if (this.var_4871 != null)
            {
                this.var_4871.dispose();
                this.var_4871 = null;
            };
            if (this.var_4872 != null)
            {
                this.var_4872.dispose();
                this.var_4872 = null;
            };
            if (this.var_4873 != null)
            {
                this.var_4873.dispose();
                this.var_4873 = null;
            };
            if (this.var_4874 != null)
            {
                this.var_4874.dispose();
                this.var_4874 = null;
            };
        }

        public function addFurnitureData(param1:FurnitureData):void
        {
            if (param1 != null)
            {
                this.var_4873.remove(param1.id);
                this.var_4873.add(param1.id, param1);
            };
        }

        public function getFurnitureData():FurnitureData
        {
            if (this.var_4873.length > 0)
            {
                return (this.getFurnitureDataWithId(this.var_4873.getKey(0)));
            };
            return (null);
        }

        public function getFurnitureDataWithId(param1:int):FurnitureData
        {
            return (this.var_4873.remove(param1));
        }

        public function addWallItemData(param1:FurnitureData):void
        {
            if (param1 != null)
            {
                this.var_4874.remove(param1.id);
                this.var_4874.add(param1.id, param1);
            };
        }

        public function getWallItemData():FurnitureData
        {
            if (this.var_4874.length > 0)
            {
                return (this.getWallItemDataWithId(this.var_4874.getKey(0)));
            };
            return (null);
        }

        public function getWallItemDataWithId(param1:int):FurnitureData
        {
            return (this.var_4874.remove(param1));
        }


    }
}