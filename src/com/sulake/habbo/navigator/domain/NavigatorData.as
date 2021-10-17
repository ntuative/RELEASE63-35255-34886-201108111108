package com.sulake.habbo.navigator.domain
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.habbo.communication.messages.incoming.navigator.MsgWithRequestId;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventData;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.communication.messages.incoming.navigator.PublicRoomShortData;
    import flash.utils.Dictionary;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomEntryData;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsData;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultData;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomsData;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
    import com.sulake.habbo.communication.messages.parser.navigator.FavouritesMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.*;
    import com.sulake.habbo.navigator.*;
    import com.sulake.habbo.communication.messages.parser.navigator.*;

    public class NavigatorData 
    {

        private static const var_4219:int = 10;

        private var _navigator:HabboNavigator;
        private var var_4220:MsgWithRequestId;
        private var var_4221:RoomEventData;
        private var var_4222:Boolean;
        private var var_4223:Boolean;
        private var _currentRoomOwner:Boolean;
        private var var_3408:int;
        private var var_4224:GuestRoomData;
        private var var_4225:PublicRoomShortData;
        private var var_4226:int;
        private var var_4227:Boolean;
        private var var_4228:int;
        private var var_4229:Boolean;
        private var var_3768:int;
        private var var_4230:Boolean;
        private var var_3016:Array = new Array();
        private var var_4231:Array = new Array();
        private var var_4232:int;
        private var var_4233:int;
        private var _favouriteIds:Dictionary = new Dictionary();
        private var var_4234:Boolean;
        private var var_4235:int;
        private var var_4236:Boolean;
        private var var_4237:int = 0;
        private var var_3769:OfficialRoomEntryData;

        public function NavigatorData(param1:HabboNavigator)
        {
            this._navigator = param1;
        }

        public function get canAddFavourite():Boolean
        {
            return ((!(this.var_4224 == null)) && (!(this._currentRoomOwner)));
        }

        public function get canEditRoomSettings():Boolean
        {
            return ((!(this.var_4224 == null)) && (this._currentRoomOwner));
        }

        public function onRoomEnter(param1:RoomEntryInfoMessageParser):void
        {
            this.var_4225 = null;
            this.var_4224 = null;
            this._currentRoomOwner = false;
            if (param1.privateRoom)
            {
                this._currentRoomOwner = param1.owner;
            }
            else
            {
                this.var_4225 = param1.publicSpace;
                this.var_4221 = null;
            };
        }

        public function onRoomExit():void
        {
            if (this.var_4221 != null)
            {
                this.var_4221.dispose();
                this.var_4221 = null;
            };
            if (this.var_4225 != null)
            {
                this.var_4225.dispose();
                this.var_4225 = null;
            };
            if (this.var_4224 != null)
            {
                this.var_4224.dispose();
                this.var_4224 = null;
            };
            this._currentRoomOwner = false;
        }

        public function set enteredRoom(param1:GuestRoomData):void
        {
            if (this.var_4224 != null)
            {
                this.var_4224.dispose();
            };
            this.var_4224 = param1;
        }

        public function set roomEventData(param1:RoomEventData):void
        {
            if (this.var_4221 != null)
            {
                this.var_4221.dispose();
            };
            this.var_4221 = param1;
        }

        public function get popularTagsArrived():Boolean
        {
            return ((!(this.var_4220 == null)) && (!((this.var_4220 as PopularRoomTagsData) == null)));
        }

        public function get guestRoomSearchArrived():Boolean
        {
            return ((!(this.var_4220 == null)) && (!((this.var_4220 as GuestRoomSearchResultData) == null)));
        }

        public function get officialRoomsArrived():Boolean
        {
            return ((!(this.var_4220 == null)) && (!((this.var_4220 as OfficialRoomsData) == null)));
        }

        public function set guestRoomSearchResults(param1:GuestRoomSearchResultData):void
        {
            this.disposeCurrentMsg();
            this.var_4220 = param1;
            this.var_3769 = param1.ad;
            this.var_4234 = false;
        }

        public function set popularTags(param1:PopularRoomTagsData):void
        {
            this.disposeCurrentMsg();
            this.var_4220 = param1;
            this.var_4234 = false;
        }

        public function set officialRooms(param1:OfficialRoomsData):void
        {
            this.disposeCurrentMsg();
            this.var_4220 = param1;
            this.var_4234 = false;
        }

        private function disposeCurrentMsg():void
        {
            if (this.var_4220 == null)
            {
                return;
            };
            this.var_4220.dispose();
            this.var_4220 = null;
        }

        public function set adRoom(param1:OfficialRoomEntryData):void
        {
            this.var_3769 = param1;
        }

        public function get adRoom():OfficialRoomEntryData
        {
            return (this.var_3769);
        }

        public function get guestRoomSearchResults():GuestRoomSearchResultData
        {
            return (this.var_4220 as GuestRoomSearchResultData);
        }

        public function get popularTags():PopularRoomTagsData
        {
            return (this.var_4220 as PopularRoomTagsData);
        }

        public function get officialRooms():OfficialRoomsData
        {
            return (this.var_4220 as OfficialRoomsData);
        }

        public function get roomEventData():RoomEventData
        {
            return (this.var_4221);
        }

        public function get avatarId():int
        {
            return (this.var_3408);
        }

        public function get eventMod():Boolean
        {
            return (this.var_4222);
        }

        public function get roomPicker():Boolean
        {
            return (this.var_4223);
        }

        public function get currentRoomOwner():Boolean
        {
            return (this._currentRoomOwner);
        }

        public function get enteredGuestRoom():GuestRoomData
        {
            return (this.var_4224);
        }

        public function get enteredPublicSpace():PublicRoomShortData
        {
            return (this.var_4225);
        }

        public function get hcMember():Boolean
        {
            return (this.var_4227);
        }

        public function get createdFlatId():int
        {
            return (this.var_4228);
        }

        public function get homeRoomId():int
        {
            return (this.var_3768);
        }

        public function get hotRoomPopupOpen():Boolean
        {
            return (this.var_4229);
        }

        public function get currentRoomRating():int
        {
            return (this.var_4235);
        }

        public function get publicSpaceNodeId():int
        {
            return (this.var_4226);
        }

        public function get settingsReceived():Boolean
        {
            return (this.var_4230);
        }

        public function get adIndex():int
        {
            return (this.var_4237);
        }

        public function get currentRoomIsStaffPick():Boolean
        {
            return (this.var_4236);
        }

        public function set avatarId(param1:int):void
        {
            this.var_3408 = param1;
        }

        public function set createdFlatId(param1:int):void
        {
            this.var_4228 = param1;
        }

        public function set hcMember(param1:Boolean):void
        {
            this.var_4227 = param1;
        }

        public function set eventMod(param1:Boolean):void
        {
            this.var_4222 = param1;
        }

        public function set roomPicker(param1:Boolean):void
        {
            this.var_4223 = param1;
        }

        public function set hotRoomPopupOpen(param1:Boolean):void
        {
            this.var_4229 = param1;
        }

        public function set homeRoomId(param1:int):void
        {
            this.var_3768 = param1;
        }

        public function set currentRoomRating(param1:int):void
        {
            this.var_4235 = param1;
        }

        public function set publicSpaceNodeId(param1:int):void
        {
            this.var_4226 = param1;
        }

        public function set settingsReceived(param1:Boolean):void
        {
            this.var_4230 = param1;
        }

        public function set adIndex(param1:int):void
        {
            this.var_4237 = param1;
        }

        public function set currentRoomIsStaffPick(param1:Boolean):void
        {
            this.var_4236 = param1;
        }

        public function set categories(param1:Array):void
        {
            var _loc2_:FlatCategory;
            this.var_3016 = param1;
            this.var_4231 = new Array();
            for each (_loc2_ in this.var_3016)
            {
                if (_loc2_.visible)
                {
                    this.var_4231.push(_loc2_);
                };
            };
        }

        public function get allCategories():Array
        {
            return (this.var_3016);
        }

        public function get visibleCategories():Array
        {
            return (this.var_4231);
        }

        public function onFavourites(param1:FavouritesMessageParser):void
        {
            var _loc2_:int;
            this.var_4232 = param1.limit;
            this.var_4233 = param1.favouriteRoomIds.length;
            this._favouriteIds = new Dictionary();
            for each (_loc2_ in param1.favouriteRoomIds)
            {
                this._favouriteIds[_loc2_] = "yes";
            };
        }

        public function favouriteChanged(param1:int, param2:Boolean):void
        {
            this._favouriteIds[param1] = ((param2) ? "yes" : null);
            this.var_4233 = (this.var_4233 + ((param2) ? 1 : -1));
        }

        public function isCurrentRoomFavourite():Boolean
        {
            var _loc1_:int = this.var_4224.flatId;
            return (!(this._favouriteIds[_loc1_] == null));
        }

        public function isCurrentRoomHome():Boolean
        {
            if (this.var_4224 == null)
            {
                return (false);
            };
            var _loc1_:int = this.var_4224.flatId;
            return (this.var_3768 == _loc1_);
        }

        public function isRoomFavourite(param1:int):Boolean
        {
            return (!(this._favouriteIds[param1] == null));
        }

        public function isFavouritesFull():Boolean
        {
            return (this.var_4233 >= this.var_4232);
        }

        public function startLoading():void
        {
            this.var_4234 = true;
        }

        public function isLoading():Boolean
        {
            return (this.var_4234);
        }


    }
}