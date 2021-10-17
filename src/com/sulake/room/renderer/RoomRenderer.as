package com.sulake.room.renderer
{
    import com.sulake.core.utils.Map;
    import com.sulake.core.runtime.Component;
    import com.sulake.room.object.IRoomObject;
    import flash.utils.getTimer;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.room.utils.RoomGeometry;

    public class RoomRenderer implements IRoomRenderer, IRoomSpriteCanvasContainer 
    {

        private var _objects:Map;
        private var var_2944:Map;
        private var var_4007:Component;
        private var _disposed:Boolean = false;
        private var _roomObjectVariableAccurateZ:String = null;

        public function RoomRenderer(param1:Component)
        {
            this._objects = new Map();
            this.var_2944 = new Map();
            if (param1 != null)
            {
                this.var_4007 = param1;
            };
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get roomObjectVariableAccurateZ():String
        {
            return (this._roomObjectVariableAccurateZ);
        }

        public function set roomObjectVariableAccurateZ(param1:String):void
        {
            this._roomObjectVariableAccurateZ = param1;
        }

        public function dispose():void
        {
            var _loc1_:int;
            var _loc2_:RoomSpriteCanvas;
            if (this.disposed)
            {
                return;
            };
            if (this.var_2944 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_2944.length)
                {
                    _loc2_ = (this.var_2944.getWithIndex(_loc1_) as RoomSpriteCanvas);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    };
                    _loc1_++;
                };
                this.var_2944.dispose();
                this.var_2944 = null;
            };
            if (this._objects != null)
            {
                this._objects.dispose();
                this._objects = null;
            };
            if (this.var_4007 != null)
            {
                this.var_4007 = null;
            };
            this._disposed = true;
        }

        public function reset():void
        {
            this._objects.reset();
        }

        public function feedRoomObject(param1:IRoomObject):void
        {
            if (param1 == null)
            {
                return;
            };
            this._objects.add(String(param1.getInstanceId()), param1);
        }

        public function removeRoomObject(param1:int):void
        {
            var _loc4_:RoomSpriteCanvas;
            var _loc2_:String = String(param1);
            this._objects.remove(_loc2_);
            var _loc3_:int;
            while (_loc3_ < this.var_2944.length)
            {
                _loc4_ = (this.var_2944.getWithIndex(_loc3_) as RoomSpriteCanvas);
                if (_loc4_ != null)
                {
                    _loc4_.roomObjectRemoved(_loc2_);
                };
                _loc3_++;
            };
        }

        public function getRoomObject(param1:String):IRoomObject
        {
            return (this._objects.getValue(param1) as IRoomObject);
        }

        public function getRoomObjectWithIndex(param1:int):IRoomObject
        {
            return (this._objects.getWithIndex(param1) as IRoomObject);
        }

        public function getRoomObjectIdWithIndex(param1:int):String
        {
            return (this._objects.getKey(param1) as String);
        }

        public function getRoomObjectCount():int
        {
            return (this._objects.length);
        }

        public function render():void
        {
            var _loc3_:IRoomRenderingCanvas;
            var _loc1_:int = getTimer();
            ErrorReportStorage.addDebugData("Canvas count", ("Canvas count: " + this.var_2944.length));
            var _loc2_:int = (this.var_2944.length - 1);
            while (_loc2_ >= 0)
            {
                _loc3_ = (this.var_2944.getWithIndex(_loc2_) as IRoomRenderingCanvas);
                if (_loc3_ != null)
                {
                    _loc3_.render(_loc1_);
                };
                _loc2_--;
            };
        }

        public function createCanvas(param1:int, param2:int, param3:int, param4:int):IRoomRenderingCanvas
        {
            var _loc6_:RoomGeometry;
            var _loc5_:IRoomRenderingCanvas = (this.var_2944.getValue(String(param1)) as IRoomRenderingCanvas);
            if (_loc5_ != null)
            {
                _loc5_.initialize(param2, param3);
                _loc6_ = (_loc5_.geometry as RoomGeometry);
                if (_loc6_)
                {
                    _loc6_.scale = param4;
                };
                return (_loc5_);
            };
            _loc5_ = new RoomSpriteCanvas(this, ("canvas_" + param1), param2, param3, param4);
            this.var_2944.add(String(param1), _loc5_);
            return (_loc5_);
        }

        public function getCanvas(param1:int):IRoomRenderingCanvas
        {
            return (this.var_2944.getValue(String(param1)) as IRoomRenderingCanvas);
        }

        public function disposeCanvas(param1:int):Boolean
        {
            var _loc2_:RoomSpriteCanvas = (this.var_2944.remove(String(param1)) as RoomSpriteCanvas);
            if (_loc2_ != null)
            {
                _loc2_.dispose();
            };
            return (false);
        }

        public function update(param1:uint):void
        {
            var _loc3_:RoomSpriteCanvas;
            this.render();
            var _loc2_:int = (this.var_2944.length - 1);
            while (_loc2_ >= 0)
            {
                _loc3_ = (this.var_2944.getWithIndex(_loc2_) as RoomSpriteCanvas);
                if (_loc3_ != null)
                {
                    _loc3_.update();
                };
                _loc2_--;
            };
        }


    }
}