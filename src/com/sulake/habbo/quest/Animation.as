package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;

    public class Animation implements IDisposable 
    {

        private var var_2895:IBitmapWrapperWindow;
        private var var_4435:int;
        private var var_4436:Boolean;
        private var var_3028:Array = new Array();

        public function Animation(param1:IBitmapWrapperWindow)
        {
            this.var_2895 = param1;
            this.var_2895.visible = false;
            if (param1.bitmap == null)
            {
                param1.bitmap = new BitmapData(param1.width, param1.height, true, 0);
            };
        }

        public function dispose():void
        {
            var _loc1_:AnimationObject;
            this.var_2895 = null;
            if (this.var_3028)
            {
                for each (_loc1_ in this.var_3028)
                {
                    _loc1_.dispose();
                };
                this.var_3028 = null;
            };
        }

        public function get disposed():Boolean
        {
            return (this.var_2895 == null);
        }

        public function addObject(param1:AnimationObject):void
        {
            this.var_3028.push(param1);
        }

        public function stop():void
        {
            this.var_4436 = false;
            this.var_2895.visible = false;
        }

        public function restart():void
        {
            var _loc1_:AnimationObject;
            this.var_4435 = 0;
            this.var_4436 = true;
            for each (_loc1_ in this.var_3028)
            {
                _loc1_.onAnimationStart();
            };
            this.draw();
            this.var_2895.visible = true;
        }

        public function update(param1:uint):void
        {
            if (this.var_4436)
            {
                this.var_4435 = (this.var_4435 + param1);
                this.draw();
            };
        }

        private function draw():void
        {
            var _loc1_:Boolean;
            var _loc2_:AnimationObject;
            var _loc3_:BitmapData;
            this.var_2895.bitmap.fillRect(this.var_2895.bitmap.rect, 0);
            if (this.var_4436)
            {
                _loc1_ = false;
                for each (_loc2_ in this.var_3028)
                {
                    if (!_loc2_.isFinished(this.var_4435))
                    {
                        _loc1_ = true;
                        _loc3_ = _loc2_.getBitmap(this.var_4435);
                        if (_loc3_ != null)
                        {
                            this.var_2895.bitmap.copyPixels(_loc3_, _loc3_.rect, _loc2_.getPosition(this.var_4435));
                        };
                    };
                };
            };
            this.var_2895.invalidate(this.var_2895.rectangle);
            this.var_4436 = _loc1_;
        }


    }
}