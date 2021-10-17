package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetPetPackageUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1627:String = "RWOPPUE_OPEN_PET_PACKAGE_REQUESTED";
        public static const var_1628:String = "RWOPPUE_OPEN_PET_PACKAGE_RESULT";
        public static const var_1629:String = "RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE";

        private var var_1678:int = -1;
        private var var_1033:BitmapData = null;
        private var var_3822:int = 0;
        private var var_3186:String = null;

        public function RoomWidgetPetPackageUpdateEvent(param1:String, param2:int, param3:BitmapData, param4:int, param5:String, param6:Boolean=false, param7:Boolean=false)
        {
            super(param1, param6, param7);
            this.var_1678 = param2;
            this.var_1033 = param3;
            this.var_3822 = param4;
            this.var_3186 = param5;
        }

        public function get nameValidationStatus():int
        {
            return (this.var_3822);
        }

        public function get nameValidationInfo():String
        {
            return (this.var_3186);
        }

        public function get image():BitmapData
        {
            return (this.var_1033);
        }

        public function get objectId():int
        {
            return (this.var_1678);
        }


    }
}