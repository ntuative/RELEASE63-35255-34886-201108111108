package com.sulake.habbo.room.utils
{
    import com.sulake.habbo.room.ISelectedRoomObjectData;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

    public class SelectedRoomObjectData implements ISelectedRoomObjectData 
    {

        private var _id:int = 0;
        private var _category:int = 0;
        private var var_4875:String = "";
        private var var_3543:Vector3d = null;
        private var var_3536:Vector3d = null;
        private var var_3174:int = 0;
        private var var_4484:String = null;

        public function SelectedRoomObjectData(param1:int, param2:int, param3:String, param4:IVector3d, param5:IVector3d, param6:int=0, param7:String=null)
        {
            this._id = param1;
            this._category = param2;
            this.var_4875 = param3;
            this.var_3543 = new Vector3d();
            this.var_3543.assign(param4);
            this.var_3536 = new Vector3d();
            this.var_3536.assign(param5);
            this.var_3174 = param6;
            this.var_4484 = param7;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get category():int
        {
            return (this._category);
        }

        public function get operation():String
        {
            return (this.var_4875);
        }

        public function get loc():Vector3d
        {
            return (this.var_3543);
        }

        public function get dir():Vector3d
        {
            return (this.var_3536);
        }

        public function get typeId():int
        {
            return (this.var_3174);
        }

        public function get instanceData():String
        {
            return (this.var_4484);
        }

        public function dispose():void
        {
            this.var_3543 = null;
            this.var_3536 = null;
        }


    }
}