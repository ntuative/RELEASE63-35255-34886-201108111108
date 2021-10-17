package com.sulake.habbo.room.object
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

    public class RoomPlaneBitmapMaskData 
    {

        public static const var_1064:String = "window";
        public static const var_483:String = "hole";

        private var var_3543:Vector3d = null;
        private var _type:String = null;
        private var _category:String = null;

        public function RoomPlaneBitmapMaskData(param1:String, param2:IVector3d, param3:String)
        {
            this.type = param1;
            this.loc = param2;
            this.category = param3;
        }

        public function get loc():IVector3d
        {
            return (this.var_3543);
        }

        public function set loc(param1:IVector3d):void
        {
            if (this.var_3543 == null)
            {
                this.var_3543 = new Vector3d();
            };
            this.var_3543.assign(param1);
        }

        public function get type():String
        {
            return (this._type);
        }

        public function set type(param1:String):void
        {
            this._type = param1;
        }

        public function get category():String
        {
            return (this._category);
        }

        public function set category(param1:String):void
        {
            this._category = param1;
        }

        public function dispose():void
        {
            this.var_3543 = null;
        }


    }
}