package com.sulake.habbo.navigator.roomthumbnails
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import flash.utils.Dictionary;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomThumbnailData;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomThumbnailObjectData;
    import com.sulake.habbo.navigator.inroom.*;

    public class RoomThumbnailRenderer 
    {

        public static const var_944:int = 10;
        private static const var_945:int = 32;
        private static const var_946:int = 8;
        private static const var_949:int = -16;
        private static const var_950:int = 40;

        private var _navigator:HabboNavigator;
        private var var_4345:Dictionary;
        private var var_4346:ThumbnailImageConfigurations;
        private var _order:Dictionary = new Dictionary();
        private var var_4347:BitmapData;

        public function RoomThumbnailRenderer(param1:HabboNavigator)
        {
            this._navigator = param1;
            this.var_4346 = new ThumbnailImageConfigurations(this._navigator);
            this.initScreenLocsByPositions();
        }

        public function get imageConfigurations():ThumbnailImageConfigurations
        {
            return (this.var_4346);
        }

        private function initScreenLocsByPositions():void
        {
            var _loc1_:Dictionary = new Dictionary();
            _loc1_[0] = this.getLoc(1, 0);
            _loc1_[1] = this.getLoc(0, 1);
            _loc1_[2] = this.getLoc(1, 1);
            _loc1_[3] = this.getLoc(0, 2);
            _loc1_[4] = this.getLoc(1, 2);
            _loc1_[5] = this.getLoc(2, 2);
            _loc1_[6] = this.getLoc(0, 3);
            _loc1_[7] = this.getLoc(1, 3);
            _loc1_[8] = this.getLoc(0, 4);
            _loc1_[9] = this.getLoc(1, 4);
            _loc1_[10] = this.getLoc(2, 4);
            this.var_4345 = _loc1_;
        }

        private function getLoc(param1:int, param2:int):Point
        {
            var _loc3_:int = int((((param2 % 2) == 0) ? 0 : int((var_945 / 2))));
            return (new Point(((param1 * var_945) + _loc3_), (param2 * var_946)));
        }

        public function refreshThumbnail(param1:IWindowContainer, param2:RoomThumbnailData, param3:Boolean):void
        {
            var _loc7_:BitmapData;
            var _loc4_:String = "bitmap";
            var _loc5_:IBitmapWrapperWindow = IBitmapWrapperWindow(param1.getChildByName(_loc4_));
            if (_loc5_ == null)
            {
                _loc7_ = new BitmapData(64, 64);
                _loc5_ = IBitmapWrapperWindow(this._navigator.windowManager.createWindow(_loc4_, "", HabboWindowType.var_156, HabboWindowStyle.var_157, (HabboWindowParam.var_159 | ((param3) ? HabboWindowParam.var_158 : HabboWindowParam.var_157)), new Rectangle(0, 0, _loc7_.width, _loc7_.height)));
                _loc5_.bitmap = _loc7_;
                param1.addChild(_loc5_);
            };
            var _loc6_:String = param2.getAsString();
            if (_loc5_.tags[0] != _loc6_)
            {
                _loc5_.tags.splice(0, _loc5_.tags.length);
                _loc5_.tags.push(_loc6_);
                this.refreshBitmapContent(_loc5_.bitmap, param2);
                this.refreshCover(_loc5_.bitmap);
                this.roundEdges(_loc5_.bitmap);
                _loc5_.invalidate();
            };
        }

        public function refreshBitmapContent(param1:BitmapData, param2:RoomThumbnailData):void
        {
            this.refreshBg(param1, param2.bgImgId);
            this.refreshObjects(param1, param2.objects);
            this.refreshFront(param1, param2.frontImgId);
        }

        public function roundEdges(param1:BitmapData):void
        {
            var _loc3_:Boolean;
            var _loc4_:Boolean;
            var _loc2_:int;
            while (_loc2_ < 4)
            {
                _loc3_ = ((_loc2_ == 0) || (_loc2_ == 1));
                _loc4_ = ((_loc2_ == 1) || (_loc2_ == 3));
                this.paintCol(param1, 0, 5, _loc3_, _loc4_);
                this.paintCol(param1, 1, 3, _loc3_, _loc4_);
                this.paintCol(param1, 2, 2, _loc3_, _loc4_);
                this.paintCol(param1, 3, 1, _loc3_, _loc4_);
                this.paintCol(param1, 4, 1, _loc3_, _loc4_);
                _loc2_++;
            };
        }

        private function paintCol(param1:BitmapData, param2:int, param3:int, param4:Boolean=true, param5:Boolean=true):void
        {
            var _loc7_:int;
            var _loc8_:int;
            var _loc6_:int;
            while (_loc6_ < param3)
            {
                _loc7_ = ((param5) ? param2 : ((param1.width - param2) - 1));
                _loc8_ = ((param4) ? _loc6_ : ((param1.height - _loc6_) - 1));
                param1.setPixel32(_loc7_, _loc8_, 0);
                _loc6_++;
            };
        }

        private function refreshObjects(param1:BitmapData, param2:Array):void
        {
            var _loc3_:int;
            var _loc4_:RoomThumbnailObjectData;
            _loc3_ = 0;
            while (_loc3_ <= var_944)
            {
                this._order[_loc3_] = null;
                _loc3_++;
            };
            for each (_loc4_ in param2)
            {
                this._order[_loc4_.pos] = _loc4_;
            };
            _loc3_ = 0;
            while (_loc3_ <= var_944)
            {
                if (this._order[_loc3_] != null)
                {
                    this.refreshObj(param1, this._order[_loc3_]);
                };
                _loc3_++;
            };
        }

        private function refreshBg(param1:BitmapData, param2:int):void
        {
            if (param2 < 1)
            {
                param2 = 1;
            };
            var _loc3_:ThumbnailImageConfiguration = this.var_4346.getImage(ThumbnailEditorModel.var_947, param2);
            if (_loc3_ == null)
            {
                Logger.log(("Unknown bg image id: " + param2));
                _loc3_ = this.var_4346.getImage(ThumbnailEditorModel.var_947, 1);
            };
            var _loc4_:BitmapData = _loc3_.getImg();
            param1.copyPixels(_loc4_, _loc4_.rect, new Point(0, 0), null, null, true);
        }

        private function refreshFront(param1:BitmapData, param2:int):void
        {
            if (param2 < 1)
            {
                return;
            };
            var _loc3_:ThumbnailImageConfiguration = this.var_4346.getImage(ThumbnailEditorModel.var_948, param2);
            if (_loc3_ == null)
            {
                Logger.log(("Unknown top image id: " + param2));
                return;
            };
            var _loc4_:BitmapData = _loc3_.getImg();
            param1.copyPixels(_loc4_, _loc4_.rect, new Point(0, 0), null, null, true);
        }

        private function refreshCover(param1:BitmapData):void
        {
            if (this.var_4347 == null)
            {
                this.var_4347 = this._navigator.getButtonImage("rico_rnd");
            };
            param1.copyPixels(this.var_4347, this.var_4347.rect, new Point(0, 0), null, null, true);
        }

        private function refreshObj(param1:BitmapData, param2:RoomThumbnailObjectData):void
        {
            var _loc3_:ThumbnailImageConfiguration = this.var_4346.getImage(ThumbnailEditorModel.var_951, param2.imgId);
            if (_loc3_ == null)
            {
                Logger.log(("Unknown object image id: " + param2.imgId));
                return;
            };
            if (_loc3_.id == 0)
            {
                return;
            };
            var _loc4_:Point = this.getScreenLocForPos(param2.pos);
            if (_loc4_ == null)
            {
                Logger.log(("Unknown object position: " + param2.pos));
                return;
            };
            var _loc5_:BitmapData = _loc3_.getImg();
            if (_loc5_ == null)
            {
                Logger.log(("No image for " + param2.imgId));
                return;
            };
            Logger.log(((("Drawing object: " + param2.pos) + ", ") + _loc4_));
            param1.copyPixels(_loc5_, _loc5_.rect, new Point((_loc4_.x + var_949), ((_loc4_.y + var_950) - _loc5_.height)), null, null, true);
        }

        public function getScreenLocForPos(param1:int):Point
        {
            return (Point(this.var_4345[param1]));
        }


    }
}