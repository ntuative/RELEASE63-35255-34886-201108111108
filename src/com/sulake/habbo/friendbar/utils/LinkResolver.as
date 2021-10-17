package com.sulake.habbo.friendbar.utils
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.core.runtime.IID;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.iid.IIDHabboQuestEngine;
    import com.sulake.habbo.quest.IHabboQuestEngine;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.iid.IIDHabboEventStream;
    import com.sulake.habbo.friendbar.stream.IHabboEventStream;

    public class LinkResolver 
    {

        private static var _UNKNOWN:IUnknown;


        public static function set unknown(param1:IUnknown):void
        {
            _UNKNOWN = param1;
        }

        public static function open(linkTarget:LinkTarget):Boolean
        {
            var ownAvatarId:int;
            var userData:IUserData;
            var roomId:int;
            var roomCategory:int;
            if (((!(_UNKNOWN)) || (_UNKNOWN.disposed)))
            {
                return (false);
            };
            if (!linkTarget)
            {
                return (false);
            };
            var returnValue:Boolean;
            switch (linkTarget.type)
            {
                case LinkTarget.NONE:
                    break;
                case LinkTarget.var_1355:
                    _UNKNOWN.queueInterface(new IIDHabboFriendList(), function (param1:IID, param2:IUnknown):void
                    {
                        IHabboFriendList(param2).openFriendList();
                        param2.release(param1);
                    });
                    break;
                case LinkTarget.ROOM:
                    _UNKNOWN.queueInterface(new IIDHabboNavigator(), function (param1:IID, param2:IUnknown):void
                    {
                        IHabboNavigator(param2).goToRoom(linkTarget.identifier, false);
                        param2.release(param1);
                    });
                    break;
                case LinkTarget.ACHIEVEMENTS:
                    _UNKNOWN.queueInterface(new IIDHabboQuestEngine(), function (param1:IID, param2:IUnknown):void
                    {
                        IHabboQuestEngine(param2).showAchievements();
                        param2.release(param1);
                    });
                    break;
                case LinkTarget.var_1356:
                    ownAvatarId = linkTarget.identifier;
                    roomId = 0;
                    roomCategory = 0;
                    _UNKNOWN.queueInterface(new IIDRoomEngine(), function (param1:IID, param2:IUnknown):void
                    {
                        roomId = IRoomEngine(param2).activeRoomId;
                        roomCategory = IRoomEngine(param2).activeRoomCategory;
                        param2.release(param1);
                    });
                    _UNKNOWN.queueInterface(new IIDHabboRoomSessionManager(), function (param1:IID, param2:IUnknown):void
                    {
                        var _loc3_:IRoomSession = IRoomSessionManager(param2).getSession(roomId, roomCategory);
                        if (((!(_loc3_ == null)) && (!(_loc3_.userDataManager == null))))
                        {
                            userData = _loc3_.userDataManager.getUserData(ownAvatarId);
                        };
                        param2.release(param1);
                    });
                    if (userData != null)
                    {
                        _UNKNOWN.queueInterface(new IIDRoomEngine(), function (param1:IID, param2:IUnknown):void
                        {
                            IRoomEngine(param2).selectRoomObject(roomId, roomCategory, userData.id, RoomObjectCategoryEnum.OBJECT_CATEGORY_USER);
                            param2.release(param1);
                        });
                        _UNKNOWN.queueInterface(new IIDHabboEventStream(), function (param1:IID, param2:IUnknown):void
                        {
                            IHabboEventStream(param2).visible = false;
                            param2.release(param1);
                        });
                    };
                    break;
                case LinkTarget.var_374:
                    _UNKNOWN.queueInterface(new IIDHabboFriendList(), function (param1:IID, param2:IUnknown):void
                    {
                        IHabboFriendList(param2).askForAFriend(linkTarget.identifier, linkTarget.extraData);
                        param2.release(param1);
                    });
                    returnValue = true;
                    break;
                default:
                    throw (new Error("Don't forget to implement new link target types!"));
            };
            return (returnValue);
        }


    }
}