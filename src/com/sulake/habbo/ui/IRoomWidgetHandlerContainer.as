package com.sulake.habbo.ui
{
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.ISessionDataManager;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.avatar.IHabboAvatarEditor;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.moderation.IHabboModeration;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
    import com.sulake.core.communication.connection.IConnection;
    import flash.geom.Rectangle;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;

    public interface IRoomWidgetHandlerContainer 
    {

        function get habboTracking():IHabboTracking;
        function get roomSession():IRoomSession;
        function get sessionDataManager():ISessionDataManager;
        function get events():IEventDispatcher;
        function get roomEngine():IRoomEngine;
        function get friendList():IHabboFriendList;
        function get avatarRenderManager():IAvatarRenderManager;
        function get inventory():IHabboInventory;
        function get toolbar():IHabboToolbar;
        function get navigator():IHabboNavigator;
        function get roomWidgetFactory():IRoomWidgetFactory;
        function get roomSessionManager():IRoomSessionManager;
        function get avatarEditor():IHabboAvatarEditor;
        function get catalog():IHabboCatalog;
        function get localization():IHabboLocalizationManager;
        function get habboHelp():IHabboHelp;
        function get config():IHabboConfigurationManager;
        function get soundManager():IHabboSoundManager;
        function get moderation():IHabboModeration;
        function get windowManager():IHabboWindowManager;
        function get userDefinedRoomEvents():IHabboUserDefinedRoomEvents;
        function get connection():IConnection;
        function setRoomViewColor(param1:uint, param2:int):void;
        function getFirstCanvasId():int;
        function getRoomViewRect():Rectangle;
        function setInterstitialCompleted():void;
        function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent;
        function addUpdateListener(param1:IRoomWidgetHandler):void;
        function removeUpdateListener(param1:IRoomWidgetHandler):void;

    }
}