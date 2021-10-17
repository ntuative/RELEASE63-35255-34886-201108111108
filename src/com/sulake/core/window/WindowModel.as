package com.sulake.core.window
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Rectangle;
    import com.sulake.core.window.enum.WindowState;
    import flash.geom.Point;

    public class WindowModel implements IDisposable 
    {

        protected var var_1202:Rectangle;
        protected var var_1197:Rectangle;
        protected var var_1199:Rectangle;
        protected var var_1211:Rectangle;
        protected var var_1212:Rectangle;
        protected var _context:WindowContext;
        protected var var_1200:Boolean = false;
        protected var var_1201:uint = 0xFFFFFF;
        protected var var_1203:uint;
        protected var var_1210:uint = 10;
        protected var var_1208:Boolean = true;
        protected var var_1169:Boolean = true;
        protected var var_1213:Number = 1;
        protected var var_1198:uint;
        protected var _state:uint;
        protected var var_1206:uint;
        protected var _type:uint;
        protected var var_1214:String = "";
        protected var _name:String;
        protected var _id:uint;
        protected var var_1209:Array;
        protected var _disposed:Boolean = false;

        public function WindowModel(param1:uint, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:Array=null)
        {
            this._id = param1;
            this._name = param2;
            this._type = param3;
            this.var_1198 = param5;
            this._state = WindowState.var_1189;
            this.var_1206 = param4;
            this.var_1209 = ((param8 == null) ? [] : param8);
            this._context = param6;
            this.var_1202 = param7.clone();
            this.var_1197 = param7.clone();
            this.var_1199 = param7.clone();
            this.var_1211 = new Rectangle();
            this.var_1212 = null;
        }

        public function get x():int
        {
            return (this.var_1202.x);
        }

        public function get y():int
        {
            return (this.var_1202.y);
        }

        public function get width():int
        {
            return (this.var_1202.width);
        }

        public function get height():int
        {
            return (this.var_1202.height);
        }

        public function get position():Point
        {
            return (this.var_1202.topLeft);
        }

        public function get rectangle():Rectangle
        {
            return (this.var_1202);
        }

        public function get context():IWindowContext
        {
            return (this._context);
        }

        public function get mouseThreshold():uint
        {
            return (this.var_1210);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get background():Boolean
        {
            return (this.var_1200);
        }

        public function get clipping():Boolean
        {
            return (this.var_1208);
        }

        public function get visible():Boolean
        {
            return (this.var_1169);
        }

        public function get color():uint
        {
            return (this.var_1201);
        }

        public function get alpha():uint
        {
            return (this.var_1203 >>> 24);
        }

        public function get blend():Number
        {
            return (this.var_1213);
        }

        public function get param():uint
        {
            return (this.var_1198);
        }

        public function get state():uint
        {
            return (this._state);
        }

        public function get style():uint
        {
            return (this.var_1206);
        }

        public function get type():uint
        {
            return (this._type);
        }

        public function get caption():String
        {
            return (this.var_1214);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get id():uint
        {
            return (this._id);
        }

        public function get tags():Array
        {
            return (this.var_1209);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this._disposed = true;
                this.var_1202 = null;
                this._context = null;
                this._state = WindowState.var_1115;
                this.var_1209 = null;
            };
        }

        public function invalidate(param1:Rectangle=null):void
        {
        }

        public function getInitialWidth():int
        {
            return (this.var_1197.width);
        }

        public function getInitialHeight():int
        {
            return (this.var_1197.height);
        }

        public function getPreviousWidth():int
        {
            return (this.var_1199.width);
        }

        public function getPreviousHeight():int
        {
            return (this.var_1199.height);
        }

        public function getMinimizedWidth():int
        {
            return (this.var_1211.width);
        }

        public function getMinimizedHeight():int
        {
            return (this.var_1211.height);
        }

        public function getMaximizedWidth():int
        {
            return (this.var_1212.width);
        }

        public function getMaximizedHeight():int
        {
            return (this.var_1212.height);
        }

        public function testTypeFlag(param1:uint, param2:uint=0):Boolean
        {
            if (param2 > 0)
            {
                return (((this._type & param2) ^ param1) == 0);
            };
            return ((this._type & param1) == param1);
        }

        public function testStateFlag(param1:uint, param2:uint=0):Boolean
        {
            if (param2 > 0)
            {
                return (((this._state & param2) ^ param1) == 0);
            };
            return ((this._state & param1) == param1);
        }

        public function testStyleFlag(param1:uint, param2:uint=0):Boolean
        {
            if (param2 > 0)
            {
                return (((this.var_1206 & param2) ^ param1) == 0);
            };
            return ((this.var_1206 & param1) == param1);
        }

        public function testParamFlag(param1:uint, param2:uint=0):Boolean
        {
            if (param2 > 0)
            {
                return (((this.var_1198 & param2) ^ param1) == 0);
            };
            return ((this.var_1198 & param1) == param1);
        }


    }
}