package com.sulake.habbo.room.object.visualization.furniture
{
    public class FurnitureHabboWheelVisualization extends AnimatedFurnitureVisualization 
    {

        private static const var_1483:int = 10;
        private static const var_1482:int = 20;
        private static const var_1480:int = 31;
        private static const var_1481:int = 32;

        private var var_4627:Array = new Array();
        private var var_2581:Boolean = false;


        override protected function setAnimation(param1:int):void
        {
            if (param1 == -1)
            {
                if (!this.var_2581)
                {
                    this.var_2581 = true;
                    this.var_4627 = new Array();
                    this.var_4627.push(var_1480);
                    this.var_4627.push(var_1481);
                    return;
                };
            };
            if (((param1 > 0) && (param1 <= var_1483)))
            {
                if (this.var_2581)
                {
                    this.var_2581 = false;
                    this.var_4627 = new Array();
                    this.var_4627.push((var_1483 + param1));
                    this.var_4627.push((var_1482 + param1));
                    this.var_4627.push(param1);
                    return;
                };
                super.setAnimation(param1);
            };
        }

        override protected function updateAnimation(param1:Number):int
        {
            if ((((super.getLastFramePlayed(1)) && (super.getLastFramePlayed(2))) && (super.getLastFramePlayed(3))))
            {
                if (this.var_4627.length > 0)
                {
                    super.setAnimation(this.var_4627.shift());
                };
            };
            return (super.updateAnimation(param1));
        }


    }
}