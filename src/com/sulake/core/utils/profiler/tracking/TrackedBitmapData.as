package com.sulake.core.utils.profiler.tracking
{
    import flash.display.BitmapData;

    public class TrackedBitmapData extends BitmapData 
    {

        public static const var_2417:int = 0xFFFFFF;
        public static const var_2418:int = 8191;
        public static const var_2419:int = 8191;
        public static const var_2420:int = 1;
        public static const var_2421:int = 1;
        public static const var_2422:int = 1;
        private static var var_2423:uint = 0;
        private static var var_611:uint = 0;

        private var _owner:Object;
        private var _disposed:Boolean = false;

        public function TrackedBitmapData(param1:*, param2:int, param3:int, param4:Boolean=true, param5:uint=0xFFFFFFFF)
        {
            if (param2 > var_2418)
            {
                param2 = var_2418;
            }
            else
            {
                if (param2 < var_2421)
                {
                    param2 = var_2421;
                };
            };
            if (param3 > var_2419)
            {
                param3 = var_2419;
            }
            else
            {
                if (param3 < var_2422)
                {
                    param3 = var_2422;
                };
            };
            super(param2, param3, param4, param5);
            var_2423++;
            var_611 = (var_611 + ((param2 * param3) * 4));
            this._owner = param1;
        }

        public static function get numInstances():uint
        {
            return (var_2423);
        }

        public static function get allocatedByteCount():uint
        {
            return (var_611);
        }


        override public function dispose():void
        {
            if (!this._disposed)
            {
                var_611 = (var_611 - ((width * height) * 4));
                var_2423--;
                this._disposed = true;
                this._owner = null;
                super.dispose();
            };
        }


    }
}