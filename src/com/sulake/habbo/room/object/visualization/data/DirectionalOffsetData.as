package com.sulake.habbo.room.object.visualization.data
{
    import flash.utils.Dictionary;

    public class DirectionalOffsetData 
    {

        private var _offsetX:Dictionary = new Dictionary();
        private var var_2703:Dictionary = new Dictionary();


        public function getOffsetX(param1:int, param2:int):int
        {
            if (this._offsetX[param1] == null)
            {
                return (param2);
            };
            return (this._offsetX[param1]);
        }

        public function getOffsetY(param1:int, param2:int):int
        {
            if (this.var_2703[param1] == null)
            {
                return (param2);
            };
            return (this.var_2703[param1]);
        }

        public function setOffset(param1:int, param2:int, param3:int):void
        {
            this._offsetX[param1] = param2;
            this.var_2703[param1] = param3;
        }


    }
}