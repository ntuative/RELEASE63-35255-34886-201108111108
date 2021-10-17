package com.sulake.habbo.room.object.visualization.furniture
{
    public class FurnitureCounterClockVisualization extends AnimatedFurnitureVisualization 
    {

        private static const var_1504:String = "seconds_sprite";
        private static const var_1505:String = "ten_seconds_sprite";
        private static const var_1506:String = "minutes_sprite";
        private static const var_1507:String = "ten_minutes_sprite";


        override public function get animationId():int
        {
            return (0);
        }

        override protected function getFrameNumber(param1:int, param2:int):int
        {
            var _loc3_:String = getSpriteTag(param1, direction, param2);
            var _loc4_:int = super.animationId;
            switch (_loc3_)
            {
                case var_1504:
                    return ((_loc4_ % 60) % 10);
                case var_1505:
                    return ((_loc4_ % 60) / 10);
                case var_1506:
                    return ((_loc4_ / 60) % 10);
                case var_1507:
                    return (((_loc4_ / 60) / 10) % 10);
                default:
                    return (super.getFrameNumber(param1, param2));
            };
        }


    }
}