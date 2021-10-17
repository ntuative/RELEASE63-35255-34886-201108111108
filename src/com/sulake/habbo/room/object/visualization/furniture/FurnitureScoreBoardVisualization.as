package com.sulake.habbo.room.object.visualization.furniture
{
    public class FurnitureScoreBoardVisualization extends AnimatedFurnitureVisualization 
    {

        private static const var_1475:String = "ones_sprite";
        private static const var_1476:String = "tens_sprite";
        private static const var_1477:String = "hundreds_sprite";
        private static const var_1478:String = "thousands_sprite";


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
                case var_1475:
                    return (_loc4_ % 10);
                case var_1476:
                    return ((_loc4_ / 10) % 10);
                case var_1477:
                    return ((_loc4_ / 100) % 10);
                case var_1478:
                    return ((_loc4_ / 1000) % 10);
                default:
                    return (super.getFrameNumber(param1, param2));
            };
        }


    }
}