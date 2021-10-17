package com.sulake.habbo.room.object.visualization.data
{
    public class LayerData 
    {

        public static const var_1443:String = "";
        public static const var_1444:int = 0;
        public static const var_1445:int = 0xFF;
        public static const var_1447:Boolean = false;
        public static const var_1448:int = 0;
        public static const var_1449:int = 0;
        public static const var_1450:int = 0;
        public static const var_1453:int = 1;
        public static const var_1454:int = 2;
        public static const INK_DARKEN:int = 3;

        private var var_3491:String = "";
        private var var_2861:int = 0;
        private var var_4614:int = 0xFF;
        private var var_4615:Boolean = false;
        private var var_4616:int = 0;
        private var var_4617:int = 0;
        private var var_4618:Number = 0;


        public function set tag(param1:String):void
        {
            this.var_3491 = param1;
        }

        public function get tag():String
        {
            return (this.var_3491);
        }

        public function set ink(param1:int):void
        {
            this.var_2861 = param1;
        }

        public function get ink():int
        {
            return (this.var_2861);
        }

        public function set alpha(param1:int):void
        {
            this.var_4614 = param1;
        }

        public function get alpha():int
        {
            return (this.var_4614);
        }

        public function set ignoreMouse(param1:Boolean):void
        {
            this.var_4615 = param1;
        }

        public function get ignoreMouse():Boolean
        {
            return (this.var_4615);
        }

        public function set xOffset(param1:int):void
        {
            this.var_4616 = param1;
        }

        public function get xOffset():int
        {
            return (this.var_4616);
        }

        public function set yOffset(param1:int):void
        {
            this.var_4617 = param1;
        }

        public function get yOffset():int
        {
            return (this.var_4617);
        }

        public function set zOffset(param1:Number):void
        {
            this.var_4618 = param1;
        }

        public function get zOffset():Number
        {
            return (this.var_4618);
        }

        public function copyValues(param1:LayerData):void
        {
            if (param1 != null)
            {
                this.tag = param1.tag;
                this.ink = param1.ink;
                this.alpha = param1.alpha;
                this.ignoreMouse = param1.ignoreMouse;
                this.xOffset = param1.xOffset;
                this.yOffset = param1.yOffset;
                this.zOffset = param1.zOffset;
            };
        }


    }
}