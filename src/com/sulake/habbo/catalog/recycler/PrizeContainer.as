package com.sulake.habbo.catalog.recycler
{
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.room.IRoomEngine;

    public class PrizeContainer extends PrizeGridItem 
    {

        private var var_3176:String;
        private var var_3177:int;
        private var var_3178:int;
        private var _furnitureData:IFurnitureData;
        private var var_3179:PrizeGridItem;

        public function PrizeContainer(param1:String, param2:int, param3:IFurnitureData, param4:int)
        {
            this.var_3176 = param1;
            this.var_3177 = param2;
            this._furnitureData = param3;
            this.var_3178 = param4;
        }

        public function setIcon(param1:IRoomEngine):void
        {
            if (((param1 == null) || (this._furnitureData == null)))
            {
                return;
            };
            initProductIcon(param1, this._furnitureData.type, this.var_3177);
        }

        public function get productItemType():String
        {
            return (this.var_3176);
        }

        public function get productItemTypeId():int
        {
            return (this.var_3177);
        }

        public function get gridItem():PrizeGridItem
        {
            return (this.var_3179);
        }

        public function get oddsLevelId():int
        {
            return (this.var_3178);
        }

        public function get title():String
        {
            if (this._furnitureData == null)
            {
                return ("");
            };
            return (this._furnitureData.title);
        }


    }
}