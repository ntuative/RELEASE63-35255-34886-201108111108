package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

    public class RoomObjectRoomMaskUpdateMessage extends RoomObjectUpdateMessage 
    {

        public static const var_482:String = "RORMUM_ADD_MASK";
        public static const var_509:String = "RORMUM_ADD_MASK";
        public static const var_481:String = "door";
        public static const var_1064:String = "window";
        public static const var_483:String = "hole";

        private var _type:String = "";
        private var var_4502:String = "";
        private var var_4503:String = "";
        private var var_4504:Vector3d = null;
        private var var_4505:String = "window";

        public function RoomObjectRoomMaskUpdateMessage(param1:String, param2:String, param3:String=null, param4:IVector3d=null, param5:String="window")
        {
            super(null, null);
            this._type = param1;
            this.var_4502 = param2;
            this.var_4503 = param3;
            if (param4 != null)
            {
                this.var_4504 = new Vector3d(param4.x, param4.y, param4.z);
            };
            this.var_4505 = param5;
        }

        public function get type():String
        {
            return (this._type);
        }

        public function get maskId():String
        {
            return (this.var_4502);
        }

        public function get maskType():String
        {
            return (this.var_4503);
        }

        public function get maskLocation():IVector3d
        {
            return (this.var_4504);
        }

        public function get maskCategory():String
        {
            return (this.var_4505);
        }


    }
}