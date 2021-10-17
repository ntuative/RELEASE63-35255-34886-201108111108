package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.avatar.IPetImageListener;
    import com.sulake.habbo.avatar.pets.IPetDataListener;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenPetPackageMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionPetPackageEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetPackageUpdateEvent;
    import com.sulake.habbo.avatar.pets.IPetData;
    import flash.display.BitmapData;
    import flash.events.Event;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.room.utils.Vector3d;

    public class PetPackageFurniWidgetHandler implements IRoomWidgetHandler, IPetImageListener, IPetDataListener, IGetImageListener 
    {

        private var var_1023:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var var_1678:int = -1;
        private var var_3074:int = -1;
        private var var_2978:int = -1;
        private var _color:String = "";


        public function get type():String
        {
            return (RoomWidgetEnum.var_417);
        }

        public function set container(param1:IRoomWidgetHandlerContainer):void
        {
            this._container = param1;
        }

        public function getWidgetMessages():Array
        {
            return ([RoomWidgetOpenPetPackageMessage.var_1630]);
        }

        public function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _loc2_:RoomWidgetOpenPetPackageMessage;
            switch (param1.type)
            {
                case RoomWidgetOpenPetPackageMessage.var_1630:
                    _loc2_ = (param1 as RoomWidgetOpenPetPackageMessage);
                    if (((!(this._container == null)) && (!(this._container.roomSession == null))))
                    {
                        this._container.roomSession.sendOpenPetPackageMessage(_loc2_.objectId, _loc2_.name);
                    };
                    break;
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return ([RoomSessionPetPackageEvent.var_347, RoomSessionPetPackageEvent.var_348]);
        }

        public function processEvent(param1:Event):void
        {
            var _loc2_:RoomSessionPetPackageEvent;
            var _loc3_:RoomWidgetPetPackageUpdateEvent;
            var _loc4_:IPetData;
            var _loc5_:BitmapData;
            var _loc6_:int;
            var _loc7_:String;
            if (param1 == null)
            {
                return;
            };
            if ((((!(this._container == null)) && (!(this._container.events == null))) && (!(param1 == null))))
            {
                switch (param1.type)
                {
                    case RoomSessionPetPackageEvent.var_347:
                        _loc2_ = (param1 as RoomSessionPetPackageEvent);
                        this.var_1678 = _loc2_.objectId;
                        this.var_3074 = _loc2_.petType;
                        this.var_2978 = _loc2_.breed;
                        this._color = _loc2_.color;
                        _loc4_ = this._container.avatarRenderManager.petDataManager.getPetData(this.var_3074, this);
                        _loc5_ = this.getPetImage();
                        _loc3_ = new RoomWidgetPetPackageUpdateEvent(RoomWidgetPetPackageUpdateEvent.var_1627, this.var_1678, _loc5_, -1, null);
                        this._container.events.dispatchEvent(_loc3_);
                        return;
                    case RoomSessionPetPackageEvent.var_348:
                        _loc2_ = (param1 as RoomSessionPetPackageEvent);
                        this.var_1678 = _loc2_.objectId;
                        _loc6_ = _loc2_.nameValidationStatus;
                        _loc7_ = _loc2_.nameValidationInfo;
                        _loc3_ = new RoomWidgetPetPackageUpdateEvent(RoomWidgetPetPackageUpdateEvent.var_1628, this.var_1678, null, _loc6_, _loc7_);
                        this._container.events.dispatchEvent(_loc3_);
                        return;
                };
            };
        }

        public function update():void
        {
        }

        public function dispose():void
        {
            this.var_1023 = true;
            this._container = null;
            this.var_1678 = -1;
        }

        public function get disposed():Boolean
        {
            return (this.var_1023);
        }

        public function petImageReady(param1:String):void
        {
            var _loc2_:BitmapData = this.getPetImage();
            var _loc3_:RoomWidgetPetPackageUpdateEvent = new RoomWidgetPetPackageUpdateEvent(RoomWidgetPetPackageUpdateEvent.var_1629, this.var_1678, _loc2_, -1, null);
            this._container.events.dispatchEvent(_loc3_);
        }

        public function imageReady(param1:int, param2:BitmapData):void
        {
            var _loc3_:RoomWidgetPetPackageUpdateEvent = new RoomWidgetPetPackageUpdateEvent(RoomWidgetPetPackageUpdateEvent.var_1629, this.var_1678, param2, -1, null);
            this._container.events.dispatchEvent(_loc3_);
        }

        public function petDataReady():void
        {
            this.petImageReady("");
        }

        private function getPetImage():BitmapData
        {
            var _loc1_:uint;
            var _loc2_:IAvatarImage;
            var _loc3_:uint;
            var _loc4_:ImageResult;
            if (this.var_3074 < 8)
            {
                _loc1_ = parseInt(this._color, 16);
                _loc2_ = this._container.avatarRenderManager.createPetImage(this.var_3074, this.var_2978, _loc1_, AvatarScaleType.var_128, this);
                if (_loc2_ != null)
                {
                    return (_loc2_.getCroppedImage(AvatarSetType.var_129));
                };
            }
            else
            {
                _loc3_ = 0;
                _loc4_ = this._container.roomEngine.getPetImage(this.var_3074, this.var_2978, new Vector3d(90), 64, this, _loc3_);
                if (_loc4_ != null)
                {
                    return (_loc4_.data);
                };
            };
            return (null);
        }


    }
}