package com.sulake.room.object
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.object.visualization.IRoomObjectVisualization;
    import com.sulake.room.object.logic.IRoomObjectEventHandler;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.object.logic.IRoomObjectMouseHandler;
    import com.sulake.room.utils.*;

    public class RoomObject implements IRoomObjectController 
    {

        private static var var_1451:int = 0;

        private var _id:int;
        private var _type:String = "";
        private var var_3543:Vector3d;
        private var var_3536:Vector3d;
        private var var_5520:Vector3d;
        private var var_5521:Vector3d;
        private var var_5519:Array;
        private var var_2533:RoomObjectModel;
        private var _visualization:IRoomObjectVisualization;
        private var var_5522:IRoomObjectEventHandler;
        private var _updateID:int;
        private var var_3062:int = 0;

        public function RoomObject(param1:int, param2:int, param3:String)
        {
            this._id = param1;
            this.var_3543 = new Vector3d();
            this.var_3536 = new Vector3d();
            this.var_5520 = new Vector3d();
            this.var_5521 = new Vector3d();
            this.var_5519 = new Array(param2);
            var _loc4_:Number = (param2 - 1);
            while (_loc4_ >= 0)
            {
                this.var_5519[_loc4_] = 0;
                _loc4_--;
            };
            this._type = param3;
            this.var_2533 = new RoomObjectModel();
            this._visualization = null;
            this.var_5522 = null;
            this._updateID = 0;
            this.var_3062 = var_1451++;
        }

        public function dispose():void
        {
            this.var_3543 = null;
            this.var_3536 = null;
            if (this.var_2533 != null)
            {
                this.var_2533.dispose();
                this.var_2533 = null;
            };
            this.var_5519 = null;
            this.setVisualization(null);
            this.setEventHandler(null);
        }

        public function getId():int
        {
            return (this._id);
        }

        public function getType():String
        {
            return (this._type);
        }

        public function getInstanceId():int
        {
            return (this.var_3062);
        }

        public function getLocation():IVector3d
        {
            this.var_5520.assign(this.var_3543);
            return (this.var_5520);
        }

        public function getDirection():IVector3d
        {
            this.var_5521.assign(this.var_3536);
            return (this.var_5521);
        }

        public function getModel():IRoomObjectModel
        {
            return (this.var_2533);
        }

        public function getModelController():IRoomObjectModelController
        {
            return (this.var_2533);
        }

        public function getState(param1:int):int
        {
            if (((param1 >= 0) && (param1 < this.var_5519.length)))
            {
                return (this.var_5519[param1]);
            };
            return (-1);
        }

        public function getVisualization():IRoomObjectVisualization
        {
            return (this._visualization);
        }

        public function setLocation(param1:IVector3d):void
        {
            if (param1 == null)
            {
                return;
            };
            if ((((!(this.var_3543.x == param1.x)) || (!(this.var_3543.y == param1.y))) || (!(this.var_3543.z == param1.z))))
            {
                this.var_3543.x = param1.x;
                this.var_3543.y = param1.y;
                this.var_3543.z = param1.z;
                this._updateID++;
            };
        }

        public function setDirection(param1:IVector3d):void
        {
            if (param1 == null)
            {
                return;
            };
            if ((((!(this.var_3536.x == param1.x)) || (!(this.var_3536.y == param1.y))) || (!(this.var_3536.z == param1.z))))
            {
                this.var_3536.x = (((param1.x % 360) + 360) % 360);
                this.var_3536.y = (((param1.y % 360) + 360) % 360);
                this.var_3536.z = (((param1.z % 360) + 360) % 360);
                this._updateID++;
            };
        }

        public function setState(param1:int, param2:int):Boolean
        {
            if (((param2 >= 0) && (param2 < this.var_5519.length)))
            {
                if (this.var_5519[param2] != param1)
                {
                    this.var_5519[param2] = param1;
                    this._updateID++;
                };
                return (true);
            };
            return (false);
        }

        public function setVisualization(param1:IRoomObjectVisualization):void
        {
            if (param1 != this._visualization)
            {
                if (this._visualization != null)
                {
                    this._visualization.dispose();
                };
                this._visualization = param1;
                if (this._visualization != null)
                {
                    this._visualization.object = this;
                };
            };
        }

        public function setEventHandler(param1:IRoomObjectEventHandler):void
        {
            if (param1 == this.var_5522)
            {
                return;
            };
            var _loc2_:IRoomObjectEventHandler = this.var_5522;
            if (_loc2_ != null)
            {
                this.var_5522 = null;
                _loc2_.object = null;
            };
            this.var_5522 = param1;
            if (this.var_5522 != null)
            {
                this.var_5522.object = this;
            };
        }

        public function getEventHandler():IRoomObjectEventHandler
        {
            return (this.var_5522);
        }

        public function getUpdateID():int
        {
            return (this._updateID);
        }

        public function getMouseHandler():IRoomObjectMouseHandler
        {
            return (this.getEventHandler());
        }


    }
}