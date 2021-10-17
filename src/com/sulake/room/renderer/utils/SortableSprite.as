package com.sulake.room.renderer.utils
{
    import com.sulake.room.object.visualization.IRoomObjectSprite;

    public class SortableSprite 
    {

        public static const var_2513:Number = 100000000;

        public var x:int = 0;
        public var y:int = 0;
        public var z:Number = 0;
        public var name:String = "";
        public var sprite:IRoomObjectSprite = null;


        public function dispose():void
        {
            this.sprite = null;
            this.z = -(var_2513);
        }


    }
}