package com.sulake.habbo.room.object.visualization.room.publicroom
{
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.utils.IRoomGeometry;

    public class PublicRoomParkVisualization extends PublicRoomVisualization 
    {

        private var var_4765:Boolean;

        public function PublicRoomParkVisualization()
        {
            this.var_4765 = false;
        }

        override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean):void
        {
            var _loc9_:String;
            var _loc10_:int;
            super.update(param1, param2, param3, param4);
            var _loc5_:IRoomObject = object;
            if (_loc5_ == null)
            {
                return;
            };
            if (param1 == null)
            {
                return;
            };
            var _loc6_:IRoomObjectModel = object.getModel();
            var _loc7_:int = _loc6_.getNumber(RoomObjectVariableEnum.var_794);
            var _loc8_:Boolean = Boolean(_loc7_);
            if (data != null)
            {
                if (this.var_4765 != _loc8_)
                {
                    _loc9_ = "";
                    if (_loc8_)
                    {
                        data.layoutRasterizer.changeElementAlpha("bus", 0);
                        data.layoutRasterizer.changeElementAlpha("bus_oviopen_hidden", 0xFF);
                    }
                    else
                    {
                        data.layoutRasterizer.changeElementAlpha("bus", 0xFF);
                        data.layoutRasterizer.changeElementAlpha("bus_oviopen_hidden", 0);
                    };
                    this.var_4765 = _loc8_;
                };
                if (data.layoutRasterizer.graphicsChanged)
                {
                    _loc10_ = 0;
                    while (_loc10_ < data.layoutRasterizer.elementCount())
                    {
                        data.layoutRasterizer.setElementToSprite(_loc10_, getSprite((_loc10_ + var_1514)));
                        _loc10_++;
                    };
                };
            };
        }


    }
}