package com.sulake.habbo.friendbar.stream
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.IAssetLibrary;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.friendbar.utils.LinkTarget;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.AssetLoaderStruct;
    import flash.display.BitmapData;
    import flash.net.URLRequest;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.localization.ILocalization;
    import com.sulake.habbo.friendbar.utils.LinkResolver;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.ITextWindow;
    import __AS3__.vec.*;

    public class EventStreamEntity implements IDisposable 
    {

        public static var var_1346:IWindowContainer;
        public static var var_1347:IHabboLocalizationManager;
        public static var ASSETS:IAssetLibrary;
        public static var var_1348:IHabboEventStream;
        private static const var_2137:Vector.<EventStreamEntity> = new Vector.<EventStreamEntity>();
        private static const var_2128:String = "title";
        private static const var_2094:String = "message";
        private static const LINK:String = "link";
        private static const TEXT:String = "text";
        private static const var_2145:String = "time";
        private static const var_1329:String = "canvas";
        private static const LIKE_REGION:String = "like";
        private static const var_2140:String = "border";
        private static const var_2141:String = "label";
        private static const var_3903:String = "icon";
        private static const var_2138:uint = 4293519841;
        private static const var_2139:uint = 4292467926;
        private static const var_2146:uint = 0xFF0077B6;
        private static const var_2147:uint = 4283058242;
        private static const var_3904:uint = 0xFFFFFFFF;
        private static const var_2142:String = "minutes";
        private static const var_2144:String = "hours";
        private static const var_2143:String = "days";

        private var _window:IWindowContainer;
        private var _disposed:Boolean = false;
        private var var_2091:Boolean = false;
        private var _id:int = -1;
        private var var_2674:LinkTarget;
        private var var_3905:int;
        private var var_3393:String;

        public function EventStreamEntity():void
        {
            this._window = (var_1346.clone() as IWindowContainer);
            this._window.findChildByName(LINK).addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onLinkClicked);
        }

        public static function allocate():EventStreamEntity
        {
            var _loc1_:EventStreamEntity = ((var_2137.length > 0) ? var_2137.pop() : new (EventStreamEntity)());
            _loc1_.var_2091 = false;
            return (_loc1_);
        }


        public function set id(param1:int):void
        {
            this._id = param1;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function set even(param1:Boolean):void
        {
            this._window.color = ((param1) ? var_2138 : var_2139);
            this._window.findChildByName(var_2140).visible = false;
        }

        public function get even():Boolean
        {
            return (this._window.color == var_2138);
        }

        public function set title(param1:String):void
        {
            this._window.findChildByName(var_2128).caption = param1;
        }

        public function get title():String
        {
            return ((this._window) ? this._window.findChildByName(var_2128).caption : null);
        }

        public function set message(param1:String):void
        {
            this._window.findChildByName(var_2094).caption = param1;
        }

        public function get message():String
        {
            return ((this._window) ? this._window.findChildByName(var_2094).caption : null);
        }

        public function set numberOfLikes(param1:int):void
        {
            IWindowContainer(this._window.findChildByName(LIKE_REGION)).findChildByName(var_2141).caption = String(param1);
        }

        public function get numberOfLikes():int
        {
            return ((this._window) ? parseInt(IWindowContainer(this._window.findChildByName(LIKE_REGION)).findChildByName(var_2141).caption) : 0);
        }

        public function set isLikable(param1:Boolean):void
        {
            this.setIsLikable(param1);
        }

        public function set isLikingEnabled(param1:Boolean):void
        {
            if (this._window)
            {
                this._window.findChildByName(LIKE_REGION).visible = param1;
            };
        }

        public function set linkTarget(param1:LinkTarget):void
        {
            this.var_2674 = param1;
            var _loc2_:IWindowContainer = IWindowContainer(this._window.findChildByName(LINK));
            if (this.var_2674.type == LinkTarget.NONE)
            {
                _loc2_.visible = false;
            }
            else
            {
                _loc2_.visible = true;
                _loc2_.getChildByName(TEXT).caption = param1.text;
            };
        }

        public function get linkTarget():LinkTarget
        {
            return (this.var_2674);
        }

        public function set imageFilePath(param1:String):void
        {
            var _loc2_:IAsset;
            var _loc3_:AssetLoaderStruct;
            if (param1 != this.var_3393)
            {
                this.var_3393 = param1;
                _loc2_ = ASSETS.getAssetByName(param1);
                if (_loc2_)
                {
                    this.image = (_loc2_.content as BitmapData);
                }
                else
                {
                    _loc3_ = ASSETS.loadAssetFromFile(param1, new URLRequest(param1));
                    _loc3_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onImageFileLoaded);
                    _loc3_.addEventListener(AssetLoaderEvent.var_34, this.onImageFileLoaded);
                };
            };
        }

        public function set image(param1:BitmapData):void
        {
            var _loc2_:IBitmapWrapperWindow;
            var _loc3_:int;
            var _loc4_:int;
            if ((((!(this.disposed)) && (this._window)) && (param1)))
            {
                _loc2_ = (this._window.findChildByName(var_1329) as IBitmapWrapperWindow);
                _loc3_ = int((_loc2_.x + (_loc2_.width / 2)));
                _loc4_ = int((_loc2_.y + (_loc2_.height / 2)));
                _loc2_.bitmap = param1;
                _loc2_.x = (_loc3_ - (param1.width / 2));
                _loc2_.y = (_loc4_ - (param1.height / 2));
                _loc2_.width = param1.width;
                _loc2_.height = param1.height;
                this.var_3393 = null;
            };
        }

        public function get window():IWindow
        {
            return (this._window);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get recycled():Boolean
        {
            return (this.var_2091);
        }

        public function set minutesElapsed(param1:int):void
        {
            this.var_3905 = param1;
            var _loc2_:String = var_2142;
            if (this.var_3905 >= (24 * 60))
            {
                _loc2_ = var_2143;
                param1 = int((param1 / (24 * 60)));
            }
            else
            {
                if (this.var_3905 >= 60)
                {
                    _loc2_ = var_2144;
                    param1 = int((param1 / 60));
                };
            };
            var _loc3_:ILocalization = var_1347.getLocalization((("friendbar.stream." + _loc2_) + ".ago"));
            this._window.findChildByName(var_2145).caption = ((_loc3_) ? _loc3_.raw.replace("%value%", String(param1)) : "...?");
        }

        public function get minutesElapsed():int
        {
            return (this.var_3905);
        }

        public function recycle():void
        {
            if (!this.var_2091)
            {
                if (!this._disposed)
                {
                    this._window.parent = null;
                    IBitmapWrapperWindow(this._window.findChildByName(var_1329)).bitmap = null;
                    this.setIsLikable(false);
                    this.var_2091 = true;
                    var_2137.push(this);
                };
            };
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this.setIsLikable(false);
                if (this._window)
                {
                    this._window.findChildByName(LINK).removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onLinkClicked);
                    this._window.dispose();
                    this._window = null;
                };
                if (this.var_2091)
                {
                    var_2137.splice(var_2137.indexOf(this), 1);
                    this.var_2091 = false;
                };
                this._disposed = true;
            };
        }

        private function onLinkClicked(param1:WindowMouseEvent):void
        {
            var _loc2_:IWindow;
            if (LinkResolver.open(this.var_2674))
            {
                _loc2_ = this._window.findChildByName(LINK);
                _loc2_.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onLinkClicked);
                _loc2_.visible = false;
            };
        }

        private function onLikeMouseEvent(param1:WindowMouseEvent):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                if (((var_1348) && (!(var_1348.disposed))))
                {
                    var_1348.likeStreamEvent(this);
                };
            }
            else
            {
                if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
                {
                    IWindowContainer(this._window.findChildByName(LIKE_REGION)).findChildByName(var_2140).visible = true;
                }
                else
                {
                    if (param1.type == WindowMouseEvent.var_624)
                    {
                        IWindowContainer(this._window.findChildByName(LIKE_REGION)).findChildByName(var_2140).visible = false;
                    };
                };
            };
        }

        private function setIsLikable(param1:Boolean):void
        {
            var _loc2_:IRegionWindow = (this._window.findChildByName(LIKE_REGION) as IRegionWindow);
            _loc2_.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onLikeMouseEvent);
            _loc2_.removeEventListener(WindowMouseEvent.var_624, this.onLikeMouseEvent);
            _loc2_.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onLikeMouseEvent);
            ITextWindow(_loc2_.findChildByName(var_2141)).underline = param1;
            ITextWindow(_loc2_.findChildByName(var_2141)).textColor = ((param1) ? var_2146 : var_2147);
            if (param1)
            {
                _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onLikeMouseEvent);
                _loc2_.addEventListener(WindowMouseEvent.var_624, this.onLikeMouseEvent);
                _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onLikeMouseEvent);
                _loc2_.enable();
            }
            else
            {
                _loc2_.disable();
            };
        }

        private function onImageFileLoaded(param1:AssetLoaderEvent):void
        {
            var _loc2_:AssetLoaderStruct;
            var _loc3_:IAsset;
            if (param1.type == AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE)
            {
                _loc2_ = (param1.target as AssetLoaderStruct);
                if (_loc2_.assetName == this.var_3393)
                {
                    _loc3_ = ASSETS.getAssetByName(this.var_3393);
                    if (_loc3_)
                    {
                        this.image = (_loc3_.content as BitmapData);
                    };
                };
            };
        }


    }
}