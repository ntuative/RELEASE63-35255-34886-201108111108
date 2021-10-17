package com.sulake.room.renderer.cache
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IRoomGeometry;

    public class RoomObjectLocationCacheItem 
    {

        private var _roomObjectVariableAccurateZ:String = "";
        private var var_4574:int = -1;
        private var var_5533:int = -1;
        private var var_5534:Vector3d = new Vector3d();
        private var var_5535:Vector3d = null;
        private var var_5536:Boolean = false;

        public function RoomObjectLocationCacheItem(param1:String)
        {
            this._roomObjectVariableAccurateZ = param1;
            this.var_5535 = new Vector3d();
        }

        public function get locationChanged():Boolean
        {
            return (this.var_5536);
        }

        public function dispose():void
        {
            this.var_5535 = null;
        }

        public function getScreenLocation(param1:IRoomObject, param2:IRoomGeometry):IVector3d
        {
            var _loc5_:IVector3d;
            var _loc6_:Number;
            var _loc7_:Vector3d;
            var _loc8_:IVector3d;
            if (((param1 == null) || (param2 == null)))
            {
                return (null);
            };
            var _loc3_:Boolean;
            var _loc4_:IVector3d = param1.getLocation();
            if (((!(param2.updateId == this.var_4574)) || (!(param1.getUpdateID() == this.var_5533))))
            {
                this.var_5533 = param1.getUpdateID();
                if (((((!(param2.updateId == this.var_4574)) || (!(_loc4_.x == this.var_5534.x))) || (!(_loc4_.y == this.var_5534.y))) || (!(_loc4_.z == this.var_5534.z))))
                {
                    this.var_4574 = param2.updateId;
                    this.var_5534.assign(_loc4_);
                    _loc3_ = true;
                };
            };
            this.var_5536 = _loc3_;
            if (_loc3_)
            {
                _loc5_ = param2.getScreenPosition(_loc4_);
                if (_loc5_ == null)
                {
                    return (null);
                };
                _loc6_ = param1.getModel().getNumber(this._roomObjectVariableAccurateZ);
                if (((isNaN(_loc6_)) || (_loc6_ == 0)))
                {
                    _loc7_ = new Vector3d(Math.round(_loc4_.x), Math.round(_loc4_.y), _loc4_.z);
                    if (((!(_loc7_.x == _loc4_.x)) || (!(_loc7_.y == _loc4_.y))))
                    {
                        _loc8_ = param2.getScreenPosition(_loc7_);
                        this.var_5535.assign(_loc5_);
                        if (_loc8_ != null)
                        {
                            this.var_5535.z = _loc8_.z;
                        };
                    }
                    else
                    {
                        this.var_5535.assign(_loc5_);
                    };
                }
                else
                {
                    this.var_5535.assign(_loc5_);
                };
                this.var_5535.x = Math.round(this.var_5535.x);
                this.var_5535.y = Math.round(this.var_5535.y);
            };
            return (this.var_5535);
        }


    }
}