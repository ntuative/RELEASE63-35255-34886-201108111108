package com.sulake.habbo.room.object.visualization.room.publicroom.rasterizer
{
    public class LayoutRasterizerData 
    {

        private var var_4752:XMLList;

        public function LayoutRasterizerData(param1:XML)
        {
            this.var_4752 = param1.elements.element;
        }

        public function get elementList():XMLList
        {
            return (this.var_4752);
        }

        public function dispose():void
        {
            this.var_4752 = null;
        }


    }
}