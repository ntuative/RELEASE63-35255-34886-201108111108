package com.sulake.habbo.room.object.visualization.pet
{
    import com.sulake.habbo.room.object.visualization.furniture.AnimatedFurnitureVisualizationData;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.room.object.visualization.data.SizeData;
    import com.sulake.habbo.room.object.visualization.data.AnimationSizeData;

    public class AnimatedPetVisualizationData extends AnimatedFurnitureVisualizationData 
    {

        private var var_4736:IAssetLibrary = null;


        public function set commonAssets(param1:IAssetLibrary):void
        {
            this.var_4736 = param1;
        }

        public function get commonAssets():IAssetLibrary
        {
            return (this.var_4736);
        }

        override protected function createSizeData(param1:int, param2:int, param3:int):SizeData
        {
            var _loc4_:SizeData;
            if (param1 > 1)
            {
                _loc4_ = new PetAnimationSizeData(param2, param3);
            }
            else
            {
                _loc4_ = new AnimationSizeData(param2, param3);
            };
            return (_loc4_);
        }

        override protected function processVisualizationElement(param1:SizeData, param2:XML):Boolean
        {
            var _loc3_:PetAnimationSizeData;
            if (((param1 == null) || (param2 == null)))
            {
                return (false);
            };
            switch (String(param2.name()))
            {
                case "postures":
                    _loc3_ = (param1 as PetAnimationSizeData);
                    if (_loc3_ != null)
                    {
                        if (!_loc3_.definePostures(param2))
                        {
                            return (false);
                        };
                    };
                    break;
                case "gestures":
                    _loc3_ = (param1 as PetAnimationSizeData);
                    if (_loc3_ != null)
                    {
                        if (!_loc3_.defineGestures(param2))
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

        public function getAnimationForPosture(param1:int, param2:String):int
        {
            var _loc3_:PetAnimationSizeData = (getSizeData(param1) as PetAnimationSizeData);
            if (_loc3_ != null)
            {
                return (_loc3_.getAnimationForPosture(param2));
            };
            return (PetAnimationSizeData.var_1484);
        }

        public function getAnimationForGesture(param1:int, param2:String):int
        {
            var _loc3_:PetAnimationSizeData = (getSizeData(param1) as PetAnimationSizeData);
            if (_loc3_ != null)
            {
                return (_loc3_.getAnimationForGesture(param2));
            };
            return (PetAnimationSizeData.var_1484);
        }

        public function getPostureForAnimation(param1:int, param2:int):String
        {
            var _loc3_:PetAnimationSizeData = (getSizeData(param1) as PetAnimationSizeData);
            if (_loc3_ != null)
            {
                return (_loc3_.getPostureForAnimation(param2));
            };
            return (null);
        }

        public function getGestureForAnimation(param1:int, param2:int):String
        {
            var _loc3_:PetAnimationSizeData = (getSizeData(param1) as PetAnimationSizeData);
            if (_loc3_ != null)
            {
                return (_loc3_.getGestureForAnimation(param2));
            };
            return (null);
        }

        public function getPostureCount(param1:int):int
        {
            var _loc2_:PetAnimationSizeData = (getSizeData(param1) as PetAnimationSizeData);
            if (_loc2_ != null)
            {
                return (_loc2_.getPostureCount());
            };
            return (0);
        }

        public function getGestureCount(param1:int):int
        {
            var _loc2_:PetAnimationSizeData = (getSizeData(param1) as PetAnimationSizeData);
            if (_loc2_ != null)
            {
                return (_loc2_.getGestureCount());
            };
            return (0);
        }


    }
}