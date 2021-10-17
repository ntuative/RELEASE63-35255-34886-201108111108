package com.sulake.habbo.room.object.visualization.furniture
{
    import flash.geom.Vector3D;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;

    public class FurnitureParticleSystemParticle 
    {

        private var _x:Number;
        private var var_2960:Number;
        private var var_2961:Number;
        private var var_4658:Number;
        private var var_4659:Number;
        private var var_4660:Number;
        private var var_4661:Boolean = false;
        private var _direction:Vector3D;
        private var var_3841:int = 0;
        private var var_4662:int;
        private var var_4663:Boolean = false;
        private var var_4664:Boolean = false;
        private var var_4665:Number;
        private var _alphaMultiplier:Number = 1;
        private var _frames:Array;


        public function get fade():Boolean
        {
            return (this.var_4664);
        }

        public function get alphaMultiplier():Number
        {
            return (this._alphaMultiplier);
        }

        public function get direction():Vector3D
        {
            return (this._direction);
        }

        public function get age():int
        {
            return (this.var_3841);
        }

        public function init(param1:Number, param2:Number, param3:Number, param4:Vector3D, param5:Number, param6:Number, param7:int, param8:Boolean=false, param9:Array=null, param10:Boolean=false):void
        {
            this._x = param1;
            this.var_2960 = param2;
            this.var_2961 = param3;
            this._direction = new Vector3D(param4.x, param4.y, param4.z);
            this._direction.scaleBy(param5);
            this.var_4658 = (this._x - (this._direction.x * param6));
            this.var_4659 = (this.var_2960 - (this._direction.y * param6));
            this.var_4660 = (this.var_2961 - (this._direction.z * param6));
            this.var_3841 = 0;
            this.var_4661 = false;
            this.var_4662 = param7;
            this.var_4663 = param8;
            this._frames = param9;
            this.var_4664 = param10;
            this._alphaMultiplier = 1;
            this.var_4665 = (0.5 + (Math.random() * 0.5));
        }

        public function update():void
        {
            this.var_3841++;
            if (this.var_3841 == this.var_4662)
            {
                this.ignite();
            };
            if (this.var_4664)
            {
                if ((this.var_3841 / this.var_4662) > this.var_4665)
                {
                    this._alphaMultiplier = ((this.var_4662 - this.var_3841) / (this.var_4662 * (1 - this.var_4665)));
                };
            };
        }

        public function getAsset():IGraphicAsset
        {
            if (((this._frames) && (this._frames.length > 0)))
            {
                return (this._frames[(this.var_3841 % this._frames.length)]);
            };
            return (null);
        }

        protected function ignite():void
        {
        }

        public function get isEmitter():Boolean
        {
            return (this.var_4663);
        }

        public function get isAlive():Boolean
        {
            return (this.var_3841 <= this.var_4662);
        }

        public function dispose():void
        {
            this._direction = null;
        }

        public function get x():Number
        {
            return (this._x);
        }

        public function get y():Number
        {
            return (this.var_2960);
        }

        public function get z():Number
        {
            return (this.var_2961);
        }

        public function set x(param1:Number):void
        {
            this._x = param1;
        }

        public function set y(param1:Number):void
        {
            this.var_2960 = param1;
        }

        public function set z(param1:Number):void
        {
            this.var_2961 = param1;
        }

        public function get lastX():Number
        {
            return (this.var_4658);
        }

        public function set lastX(param1:Number):void
        {
            this.var_4661 = true;
            this.var_4658 = param1;
        }

        public function get lastY():Number
        {
            return (this.var_4659);
        }

        public function set lastY(param1:Number):void
        {
            this.var_4661 = true;
            this.var_4659 = param1;
        }

        public function get lastZ():Number
        {
            return (this.var_4660);
        }

        public function set lastZ(param1:Number):void
        {
            this.var_4661 = true;
            this.var_4660 = param1;
        }

        public function get hasMoved():Boolean
        {
            return (this.var_4661);
        }

        public function toString():String
        {
            return ([this._x, this.var_2960, this.var_2961].toString());
        }


    }
}