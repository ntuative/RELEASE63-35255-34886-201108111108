package com.sulake.room.object.visualization
{
    import flash.display.BitmapData;
    import flash.display.BlendMode;
    import flash.geom.Point;

    public final class RoomObjectSprite implements IRoomObjectSprite 
    {

        private static var var_1451:int = 0;

        private var var_2736:BitmapData = null;
        private var var_2568:String = "";
        private var var_1169:Boolean = true;
        private var var_3491:String = "";
        private var var_4614:int = 0xFF;
        private var _color:int = 0xFFFFFF;
        private var var_2732:String = BlendMode.NORMAL;
        private var var_2574:Boolean = false;
        private var var_2575:Boolean = false;
        private var _offset:Point = new Point(0, 0);
        private var var_2731:int = 0;
        private var _height:int = 0;
        private var var_2989:Number = 0;
        private var var_5516:Boolean = false;
        private var var_5517:Boolean = true;
        private var var_4698:Boolean = false;
        private var _updateID:int = 0;
        private var var_3062:int = 0;
        private var var_5518:Array = null;

        public function RoomObjectSprite()
        {
            this.var_3062 = var_1451++;
        }

        public function dispose():void
        {
            this.var_2736 = null;
            this.var_2731 = 0;
            this._height = 0;
        }

        public function get asset():BitmapData
        {
            return (this.var_2736);
        }

        public function get assetName():String
        {
            return (this.var_2568);
        }

        public function get visible():Boolean
        {
            return (this.var_1169);
        }

        public function get tag():String
        {
            return (this.var_3491);
        }

        public function get alpha():int
        {
            return (this.var_4614);
        }

        public function get color():int
        {
            return (this._color);
        }

        public function get blendMode():String
        {
            return (this.var_2732);
        }

        public function get flipV():Boolean
        {
            return (this.var_2575);
        }

        public function get flipH():Boolean
        {
            return (this.var_2574);
        }

        public function get offsetX():int
        {
            return (this._offset.x);
        }

        public function get offsetY():int
        {
            return (this._offset.y);
        }

        public function get width():int
        {
            return (this.var_2731);
        }

        public function get height():int
        {
            return (this._height);
        }

        public function get relativeDepth():Number
        {
            return (this.var_2989);
        }

        public function get varyingDepth():Boolean
        {
            return (this.var_5516);
        }

        public function get capturesMouse():Boolean
        {
            return (this.var_5517);
        }

        public function get clickHandling():Boolean
        {
            return (this.var_4698);
        }

        public function get instanceId():int
        {
            return (this.var_3062);
        }

        public function get updateId():int
        {
            return (this._updateID);
        }

        public function get filters():Array
        {
            return (this.var_5518);
        }

        public function set asset(param1:BitmapData):void
        {
            if (param1 != null)
            {
                this.var_2731 = param1.width;
                this._height = param1.height;
            };
            this.var_2736 = param1;
            this._updateID++;
        }

        public function set assetName(param1:String):void
        {
            this.var_2568 = param1;
            this._updateID++;
        }

        public function set visible(param1:Boolean):void
        {
            this.var_1169 = param1;
            this._updateID++;
        }

        public function set tag(param1:String):void
        {
            this.var_3491 = param1;
            this._updateID++;
        }

        public function set alpha(param1:int):void
        {
            param1 = (param1 & 0xFF);
            this.var_4614 = param1;
            this._updateID++;
        }

        public function set color(param1:int):void
        {
            param1 = (param1 & 0xFFFFFF);
            this._color = param1;
            this._updateID++;
        }

        public function set blendMode(param1:String):void
        {
            this.var_2732 = param1;
            this._updateID++;
        }

        public function set filters(param1:Array):void
        {
            this.var_5518 = param1;
            this._updateID++;
        }

        public function set flipH(param1:Boolean):void
        {
            this.var_2574 = param1;
            this._updateID++;
        }

        public function set flipV(param1:Boolean):void
        {
            this.var_2575 = param1;
            this._updateID++;
        }

        public function set offsetX(param1:int):void
        {
            this._offset.x = param1;
            this._updateID++;
        }

        public function set offsetY(param1:int):void
        {
            this._offset.y = param1;
            this._updateID++;
        }

        public function set relativeDepth(param1:Number):void
        {
            this.var_2989 = param1;
            this._updateID++;
        }

        public function set varyingDepth(param1:Boolean):void
        {
            this.var_5516 = param1;
            this._updateID++;
        }

        public function set capturesMouse(param1:Boolean):void
        {
            this.var_5517 = param1;
            this._updateID++;
        }

        public function set clickHandling(param1:Boolean):void
        {
            this.var_4698 = param1;
            this._updateID++;
        }


    }
}