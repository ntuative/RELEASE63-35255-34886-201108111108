package com.sulake.habbo.room.object.visualization.furniture
{
    public class FurnitureQueueTileVisualization extends AnimatedFurnitureVisualization 
    {

        private static const var_1481:int = 3;
        private static const var_1485:int = 2;
        private static const var_1486:int = 1;
        private static const var_1487:int = 15;

        private var var_4627:Array = new Array();
        private var var_4692:int;


        override protected function setAnimation(param1:int):void
        {
            if (param1 == var_1485)
            {
                this.var_4627 = new Array();
                this.var_4627.push(var_1486);
                this.var_4692 = var_1487;
            };
            super.setAnimation(param1);
        }

        override protected function updateAnimation(param1:Number):int
        {
            if (this.var_4692 > 0)
            {
                this.var_4692--;
            };
            if (this.var_4692 == 0)
            {
                if (this.var_4627.length > 0)
                {
                    super.setAnimation(this.var_4627.shift());
                };
            };
            return (super.updateAnimation(param1));
        }

        override protected function usesAnimationResetting():Boolean
        {
            return (true);
        }


    }
}