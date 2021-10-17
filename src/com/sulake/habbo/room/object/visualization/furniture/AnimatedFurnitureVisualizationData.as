package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.habbo.room.object.visualization.data.SizeData;
    import com.sulake.habbo.room.object.visualization.data.AnimationSizeData;
    import com.sulake.habbo.room.object.visualization.data.AnimationFrame;

    public class AnimatedFurnitureVisualizationData extends FurnitureVisualizationData 
    {


        override protected function createSizeData(param1:int, param2:int, param3:int):SizeData
        {
            var _loc4_:SizeData;
            return (new AnimationSizeData(param2, param3));
        }

        override protected function processVisualizationElement(param1:SizeData, param2:XML):Boolean
        {
            var _loc3_:AnimationSizeData;
            if (((param1 == null) || (param2 == null)))
            {
                return (false);
            };
            switch (String(param2.name()))
            {
                case "animations":
                    _loc3_ = (param1 as AnimationSizeData);
                    if (_loc3_ != null)
                    {
                        if (!_loc3_.defineAnimations(param2))
                        {
                            return (false);
                        };
                    };
                    break;
                default:
                    if (!super.processVisualizationElement(param1, param2))
                    {
                        return (false);
                    };
            };
            return (true);
        }

        public function hasAnimation(param1:int, param2:int):Boolean
        {
            var _loc3_:AnimationSizeData = (getSizeData(param1) as AnimationSizeData);
            if (_loc3_ != null)
            {
                return (_loc3_.hasAnimation(param2));
            };
            return (false);
        }

        public function getAnimationCount(param1:int):int
        {
            var _loc2_:AnimationSizeData = (getSizeData(param1) as AnimationSizeData);
            if (_loc2_ != null)
            {
                return (_loc2_.getAnimationCount());
            };
            return (0);
        }

        public function getAnimationId(param1:int, param2:int):int
        {
            var _loc3_:AnimationSizeData = (getSizeData(param1) as AnimationSizeData);
            if (_loc3_ != null)
            {
                return (_loc3_.getAnimationId(param2));
            };
            return (0);
        }

        public function isImmediateChange(param1:int, param2:int, param3:int):Boolean
        {
            var _loc4_:AnimationSizeData = (getSizeData(param1) as AnimationSizeData);
            if (_loc4_ != null)
            {
                return (_loc4_.isImmediateChange(param2, param3));
            };
            return (false);
        }

        public function getStartFrame(param1:int, param2:int, param3:int):int
        {
            var _loc4_:AnimationSizeData = (getSizeData(param1) as AnimationSizeData);
            if (_loc4_ != null)
            {
                return (_loc4_.getStartFrame(param2, param3));
            };
            return (0);
        }

        public function getFrame(param1:int, param2:int, param3:int, param4:int, param5:int):AnimationFrame
        {
            var _loc6_:AnimationSizeData = (getSizeData(param1) as AnimationSizeData);
            if (_loc6_ != null)
            {
                return (_loc6_.getFrame(param2, param3, param4, param5));
            };
            return (null);
        }

        public function getFrameFromSequence(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int):AnimationFrame
        {
            var _loc8_:AnimationSizeData = (getSizeData(param1) as AnimationSizeData);
            if (_loc8_ != null)
            {
                return (_loc8_.getFrameFromSequence(param2, param3, param4, param5, param6, param7));
            };
            return (null);
        }


    }
}