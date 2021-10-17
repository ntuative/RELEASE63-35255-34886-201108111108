package com.sulake.habbo.room.object.visualization.pet
{
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.text.TextFormat;
    import flash.text.TextField;
    import flash.geom.Matrix;

    public class ExperienceData 
    {

        private var var_2895:BitmapData;
        private var var_4737:Boolean;
        private var _copy:BitmapData;
        private var var_3774:int = -1;
        private var var_4614:int;

        public function ExperienceData(param1:BitmapData, param2:Boolean=true)
        {
            this.var_2895 = param1;
            this.var_4737 = param2;
            if (this.var_2895 != null)
            {
                this._copy = this.var_2895.clone();
            };
            this.setExperience(0);
        }

        public function dispose():void
        {
            if (this._copy)
            {
                this._copy.dispose();
                this._copy = null;
            };
            if (this.var_2895 != null)
            {
                if (this.var_4737)
                {
                    this.var_2895.dispose();
                };
                this.var_2895 = null;
            };
        }

        public function get alpha():int
        {
            return (this.var_4614);
        }

        public function set alpha(param1:int):void
        {
            this.var_4614 = param1;
        }

        public function get image():BitmapData
        {
            return (this.var_2895);
        }

        public function setExperience(param1:int):void
        {
            if (((this.var_3774 == param1) || (this.var_2895 == null)))
            {
                return;
            };
            this.var_2895.copyPixels(this._copy, this._copy.rect, new Point(0, 0));
            var _loc2_:TextFormat = new TextFormat();
            _loc2_.font = "Volter";
            _loc2_.color = 0xFFFFFF;
            _loc2_.size = 9;
            var _loc3_:TextField = new TextField();
            _loc3_.embedFonts = true;
            _loc3_.width = 30;
            _loc3_.height = 12;
            _loc3_.background = true;
            _loc3_.backgroundColor = 0xE6C0B500;
            _loc3_.defaultTextFormat = _loc2_;
            _loc3_.text = ("+" + param1);
            var _loc4_:Matrix = new Matrix();
            _loc4_.translate(15, 19);
            this.var_2895.draw(_loc3_, _loc4_);
        }


    }
}