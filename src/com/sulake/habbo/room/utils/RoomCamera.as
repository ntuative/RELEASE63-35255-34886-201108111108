package com.sulake.habbo.room.utils
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

    public class RoomCamera 
    {

        private static const var_1823:Number = 12;

        private var var_4852:int = -1;
        private var var_4853:int = -2;
        private var var_4042:Vector3d = null;
        private var var_4854:Number = 0;
        private var var_4855:Number = 0;
        private var var_4856:Boolean = false;
        private var var_4506:Vector3d = null;
        private var var_4857:Vector3d = new Vector3d();
        private var var_4858:Boolean = false;
        private var var_4859:Boolean = false;
        private var var_4860:Boolean = false;
        private var var_4861:Boolean = false;
        private var var_4862:int = 0;
        private var var_4863:int = 0;
        private var _scale:int = 0;
        private var var_4864:int = 0;
        private var var_4865:int = 0;
        private var var_4574:int = -1;
        private var var_4866:int = 0;
        private var var_4867:Boolean = false;


        public function get location():IVector3d
        {
            return (this.var_4506);
        }

        public function get targetId():int
        {
            return (this.var_4852);
        }

        public function get targetCategory():int
        {
            return (this.var_4853);
        }

        public function get targetObjectLoc():IVector3d
        {
            return (this.var_4857);
        }

        public function get limitedLocationX():Boolean
        {
            return (this.var_4858);
        }

        public function get limitedLocationY():Boolean
        {
            return (this.var_4859);
        }

        public function get centeredLocX():Boolean
        {
            return (this.var_4860);
        }

        public function get centeredLocY():Boolean
        {
            return (this.var_4861);
        }

        public function get screenWd():int
        {
            return (this.var_4862);
        }

        public function get screenHt():int
        {
            return (this.var_4863);
        }

        public function get scale():int
        {
            return (this._scale);
        }

        public function get roomWd():int
        {
            return (this.var_4864);
        }

        public function get roomHt():int
        {
            return (this.var_4865);
        }

        public function get geometryUpdateId():int
        {
            return (this.var_4574);
        }

        public function get isMoving():Boolean
        {
            if (((!(this.var_4042 == null)) && (!(this.var_4506 == null))))
            {
                return (true);
            };
            return (false);
        }

        public function set targetId(param1:int):void
        {
            this.var_4852 = param1;
        }

        public function set targetObjectLoc(param1:IVector3d):void
        {
            this.var_4857.assign(param1);
        }

        public function set targetCategory(param1:int):void
        {
            this.var_4853 = param1;
        }

        public function set limitedLocationX(param1:Boolean):void
        {
            this.var_4858 = param1;
        }

        public function set limitedLocationY(param1:Boolean):void
        {
            this.var_4859 = param1;
        }

        public function set centeredLocX(param1:Boolean):void
        {
            this.var_4860 = param1;
        }

        public function set centeredLocY(param1:Boolean):void
        {
            this.var_4861 = param1;
        }

        public function set screenWd(param1:int):void
        {
            this.var_4862 = param1;
        }

        public function set screenHt(param1:int):void
        {
            this.var_4863 = param1;
        }

        public function set scale(param1:int):void
        {
            if (this._scale != param1)
            {
                this._scale = param1;
                this.var_4867 = true;
            };
        }

        public function set roomWd(param1:int):void
        {
            this.var_4864 = param1;
        }

        public function set roomHt(param1:int):void
        {
            this.var_4865 = param1;
        }

        public function set geometryUpdateId(param1:int):void
        {
            this.var_4574 = param1;
        }

        public function set target(param1:IVector3d):void
        {
            var _loc2_:Vector3d;
            if (this.var_4042 == null)
            {
                this.var_4042 = new Vector3d();
            };
            if ((((!(this.var_4042.x == param1.x)) || (!(this.var_4042.y == param1.y))) || (!(this.var_4042.z == param1.z))))
            {
                this.var_4042.assign(param1);
                this.var_4866 = 0;
                _loc2_ = Vector3d.dif(this.var_4042, this.var_4506);
                this.var_4854 = _loc2_.length;
                this.var_4856 = true;
            };
        }

        public function dispose():void
        {
            this.var_4042 = null;
            this.var_4506 = null;
        }

        public function initializeLocation(param1:IVector3d):void
        {
            if (this.var_4506 != null)
            {
                return;
            };
            this.var_4506 = new Vector3d();
            this.var_4506.assign(param1);
        }

        public function resetLocation(param1:IVector3d):void
        {
            if (this.var_4506 == null)
            {
                this.var_4506 = new Vector3d();
            };
            this.var_4506.assign(param1);
        }

        public function update(param1:uint, param2:Number):void
        {
            var _loc3_:Vector3d;
            var _loc4_:Number;
            var _loc5_:Number;
            var _loc6_:Number;
            var _loc7_:Number;
            if (((!(this.var_4042 == null)) && (!(this.var_4506 == null))))
            {
                this.var_4866++;
                if (this.var_4867)
                {
                    this.var_4867 = false;
                    this.var_4506 = this.var_4042;
                    this.var_4042 = null;
                    return;
                };
                _loc3_ = Vector3d.dif(this.var_4042, this.var_4506);
                if (_loc3_.length > this.var_4854)
                {
                    this.var_4854 = _loc3_.length;
                };
                if (_loc3_.length <= param2)
                {
                    this.var_4506 = this.var_4042;
                    this.var_4042 = null;
                    this.var_4855 = 0;
                }
                else
                {
                    _loc4_ = Math.sin(((Math.PI * _loc3_.length) / this.var_4854));
                    _loc5_ = (param2 * 0.5);
                    _loc6_ = (this.var_4854 / var_1823);
                    _loc7_ = (_loc5_ + ((_loc6_ - _loc5_) * _loc4_));
                    if (this.var_4856)
                    {
                        if (_loc7_ < this.var_4855)
                        {
                            _loc7_ = this.var_4855;
                            if (_loc7_ > _loc3_.length)
                            {
                                _loc7_ = _loc3_.length;
                            };
                        }
                        else
                        {
                            this.var_4856 = false;
                        };
                    };
                    this.var_4855 = _loc7_;
                    _loc3_.div(_loc3_.length);
                    _loc3_.mul(_loc7_);
                    this.var_4506 = Vector3d.sum(this.var_4506, _loc3_);
                };
            };
        }

        public function reset():void
        {
            this.var_4574 = -1;
        }


    }
}