package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import com.sulake.room.utils.XMLValidator;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
    import com.sulake.room.utils.IVector3d;

    public class WallRasterizer extends PlaneRasterizer 
    {


        override protected function initializePlanes():void
        {
            if (data == null)
            {
                return;
            };
            var _loc1_:XMLList = data.walls;
            if (_loc1_.length() > 0)
            {
                this.parseWalls(_loc1_[0]);
            };
        }

        protected function parseWalls(param1:XML):void
        {
            var _loc4_:XML;
            var _loc5_:String;
            var _loc6_:XMLList;
            var _loc7_:WallPlane;
            if (param1 == null)
            {
                return;
            };
            var _loc2_:XMLList = param1.wall;
            var _loc3_:int;
            while (_loc3_ < _loc2_.length())
            {
                _loc4_ = _loc2_[_loc3_];
                if (XMLValidator.checkRequiredAttributes(_loc4_, ["id"]))
                {
                    _loc5_ = _loc4_.@id;
                    _loc6_ = _loc4_.visualization;
                    _loc7_ = new WallPlane();
                    parseVisualizations(_loc7_, _loc6_);
                    if (!addPlane(_loc5_, _loc7_))
                    {
                        _loc7_.dispose();
                    };
                };
                _loc3_++;
            };
        }

        override public function render(param1:BitmapData, param2:String, param3:Number, param4:Number, param5:Number, param6:IVector3d, param7:Boolean, param8:Number=0, param9:Number=0, param10:Number=0, param11:Number=0, param12:int=0):PlaneBitmapData
        {
            var _loc13_:WallPlane = (getPlane(param2) as WallPlane);
            if (_loc13_ == null)
            {
                _loc13_ = (getPlane(var_2232) as WallPlane);
            };
            if (_loc13_ == null)
            {
                return (null);
            };
            if (param1 != null)
            {
                param1.fillRect(param1.rect, 0xFFFFFF);
            };
            var _loc14_:BitmapData = _loc13_.render(param1, param3, param4, param5, param6, param7);
            if (((!(_loc14_ == null)) && (!(_loc14_ == param1))))
            {
                _loc14_ = _loc14_.clone();
            };
            return (new PlaneBitmapData(_loc14_, -1));
        }

        override public function getTextureIdentifier(param1:Number, param2:IVector3d):String
        {
            if (param2 != null)
            {
                return (String(((((((param1 + "_") + param2.x) + "_") + param2.y) + "_") + param2.z)));
            };
            return (super.getTextureIdentifier(param1, param2));
        }


    }
}