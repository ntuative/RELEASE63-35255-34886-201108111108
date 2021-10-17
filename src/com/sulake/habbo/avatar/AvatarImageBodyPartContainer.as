package com.sulake.habbo.avatar
{
    import flash.display.BitmapData;
    import flash.geom.Point;

    public class AvatarImageBodyPartContainer 
    {

        private var var_1033:BitmapData;
        private var var_2912:Point;
        private var _offset:Point = new Point(0, 0);

        public function AvatarImageBodyPartContainer(param1:BitmapData, param2:Point)
        {
            this.var_1033 = param1;
            this.var_2912 = param2;
            this.cleanPoints();
        }

        public function dispose():void
        {
            if (this.var_1033)
            {
                this.var_1033.dispose();
            };
            this.var_1033 = null;
            this.var_2912 = null;
            this._offset = null;
        }

        public function set image(param1:BitmapData):void
        {
            this.var_1033 = param1;
        }

        public function get image():BitmapData
        {
            return (this.var_1033);
        }

        public function setRegPoint(param1:Point):void
        {
            this.var_2912 = param1;
            this.cleanPoints();
        }

        public function get regPoint():Point
        {
            return (this.var_2912.add(this._offset));
        }

        public function set offset(param1:Point):void
        {
            this._offset = param1;
            this.cleanPoints();
        }

        private function cleanPoints():void
        {
            this.var_2912.x = int(this.var_2912.x);
            this.var_2912.y = int(this.var_2912.y);
            this._offset.x = int(this._offset.x);
            this._offset.y = int(this._offset.y);
        }


    }
}