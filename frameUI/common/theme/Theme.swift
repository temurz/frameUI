//
//  Theme.swift
//  Tedr
//
//  Created by GK on 11/03/25.
//
import Foundation
import UIKit
public final class Theme {
    public static var isDark: Bool {
        set {
            Pref.save("isDark", value: newValue ? "Y" : "N")
        }
        get {
            if Pref.get("isDark")?.isEmpty ?? true {
                return false
            }
            return Pref.get("isDark") == "Y"
        }
    }
    
    public static var colorPalette: ColorPalette {
        set {
            Pref.saveInteger("colorPalette", value: newValue.rawValue)
        }
        get {
            guard let value = Pref.getInteger("colorPalette") else {
                return .light
            }
            return ColorPalette(rawValue: value) ?? .light
        }
    }
    
    init() {
        self._theme = switch Theme.colorPalette {
        case .dark: DarkTheme()
        case .light: LightTheme()
        case .purple: PurpleTheme()
        }
    }
    
    private var _theme: ThemeProtocol// = DefaultTheme()
    
    func changeTheme(_ new: ThemeProtocol) {
        self._theme = new
        NotificationCenter.default.post(name: NSNotification.Name("updateTheme"), object: nil)
    }
}

// MARK: - Colors
extension Theme {
    var backgroundColor: UIColor {
        return _theme.backgroundColor
    }
    var backgroundPrimaryColor: UIColor {
        return _theme.backgroundPrimaryColor
    }
    var backgroundSecondaryColor: UIColor {
        return _theme.backgroundSecondaryColor
    }
    var bgSecondaryTransparent20: UIColor {
        return _theme.bgSecondaryTransparent20
    }
    var backgroundTertiaryColor: UIColor {
        return _theme.backgroundTertiaryColor
    }
    var darkTextColor: UIColor {
        return _theme.darkTextColor
    }
    var subTextColor: UIColor {
        return _theme.subTextColor
    }
    var whiteColor: UIColor {
        return _theme.whiteColor
    }
    var orangeColor: UIColor {
        return _theme.orangeColor
    }
    var addDarkTextColor: UIColor {
        return _theme.addDarkTextColor
    }
    var addSubTextColor: UIColor {
        return _theme.addSubTextColor
    }
    var systemBlueColor: UIColor {
        return _theme.systemBlueColor
    }
    var systemRedColor: UIColor {
        return _theme.systemRedColor
    }
    var systemYellowColor: UIColor {
        return _theme.systemYellowColor
    }
    var systemGreenColor: UIColor {
        return _theme.systemGreenColor
    }
    var statusProcessingColor: UIColor {
        return _theme.statusProcessingColor
    }
    var statusClosedColor: UIColor {
        return _theme.statusClosedColor
    }
    var statusDeliveredColor: UIColor {
        return _theme.statusDeliveredColor
    }
    var statusReturnedColor: UIColor {
        return _theme.statusReturnedColor
    }
    var iconColor: UIColor {
        return _theme.iconColor
    }
    
    var contentSecondary: UIColor {
        return _theme.contentSecondary
    }
    
    var contentPrimary: UIColor {
        return _theme.contentPrimary
    }
    
    var contentWhite: UIColor {
        return _theme.contentWhite
    }
    
    var contentTurquoise: UIColor {
        return _theme.contentTurquoise
    }
    
    var contentPink: UIColor {
        return _theme.contentPink
    }
    
    var contentBlue: UIColor {
        return _theme.contentBlue
    }
    
    var contentRed: UIColor {
        return _theme.contentRed
    }
    
    var contentYellow: UIColor {
        return _theme.contentYellow
    }
    
    var reorderActionBackground: UIColor {
        _theme.reorderActionBackground
    }
    
    var pinActionBackground: UIColor {
        _theme.pinActionBackground
    }
    
    var readActionBackground: UIColor {
        _theme.readActionBackground
    }
    
    var trashActionBackground: UIColor {
        _theme.trashActionBackground
    }
    
    var muteActionBackground: UIColor {
        _theme.muteActionBackground
    }
    
    var pinkGradientUpColor: UIColor {
        return _theme.pinkGradientUpColor
    }
    
    var pinkGradientDownColor: UIColor {
        return _theme.pinkGradientDownColor
    }
    
    var blueGradientUpColor: UIColor {
        return _theme.blueGradientUpColor
    }
    
    var blueGradientDownColor: UIColor {
        return _theme.blueGradientDownColor
    }
    
    var purpleBackgroundColor: UIColor {
        return _theme.purpleBackgroundColor
    }
    var buttonTurquoiseColor: UIColor {
        return _theme.buttonTurquoiseColor
    }
    var tabbarUnionBackgroundColor: UIColor {
        return _theme.tabbarUnionBackgroundColor
    }
    var textFieldBackgroundColor: UIColor {
        return _theme.textFieldBackgroundColor
    }
    var ethereumNetworkColor: UIColor {
        return _theme.ethereumNetworkColor
    }
    var tronNetworkColor: UIColor {
        return _theme.tronNetworkColor
    }
    var bitcoinNetworkColor: UIColor {
        return _theme.bitcoinNetworkColor
    }
    var tonNetworkColor: UIColor {
        return _theme.tonNetworkColor
    }
    var fiatNetworkColor: UIColor {
        return _theme.fiatNetworkColor
    }
    var eosNetworkColor: UIColor {
        return _theme.eosNetworkColor
    }
    var bscNetworkColor: UIColor {
        return _theme.bscNetworkColor
    }
    var bgWhiteTransparent10: UIColor {
        return _theme.bgWhiteTransparent10
    }
    var buttonQuaternaryTransparentDefaultContent: UIColor {
        return _theme.buttonQuaternaryTransparentDefaultContent
    }
    var buttonQuaternaryTransparentDefaultBg: UIColor {
        return _theme.buttonQuaternaryTransparentDefaultBg
    }
    var buttonSecondaryPinkDisabledContent: UIColor {
        return _theme.buttonSecondaryPinkDisabledContent
    }
    var buttonSecondaryPinkDisabledBg: UIColor {
        return _theme.buttonSecondaryPinkDisabledBg
    }
    var bgBlackTransparent20: UIColor {
        return _theme.bgBlackTransparent20
    }
    var chatBubbleOutcomingColor: UIColor {
        return _theme.chatBubbleOutcomingColor
    }
    var chatBubbleIncomingColor: UIColor {
        return _theme.chatBubbleIncomingColor
    }
}

// MARK: - Images
extension Theme {
    
    // MARK: System
    
    var adminIcon: UIImage? {
        return _theme.adminIcon
    }
    var adsIcon: UIImage? {
        return _theme.adsIcon
    }
    var archiveIcon: UIImage? {
        return _theme.archiveIcon
    }
    var attentionIcon: UIImage? {
        return _theme.attentionIcon
    }
    var backspaceIcon: UIImage? {
        return _theme.backspaceIcon
    }
    var brushIcon: UIImage? {
        return _theme.brushIcon
    }
    var calendarIcon: UIImage? {
        return _theme.calendarIcon
    }
    var clipIcon: UIImage? {
        return _theme.clipIcon
    }
    var cellularIcon: UIImage? {
        return _theme.cellularIcon
    }
    var chatIcon: UIImage? {
        return _theme.chatIcon
    }
    var computerIcon: UIImage? {
        return _theme.computerIcon
    }
    var cropIcon: UIImage? {
        return _theme.cropIcon
    }
    var dappsIcon: UIImage? {
        return _theme.dappsIcon
    }
    var depositIcon: UIImage? {
        return _theme.depositIcon
    }
    var devicesIcon: UIImage? {
        return _theme.devicesIcon
    }
    var dotsVerticalIcon: UIImage? {
        return _theme.dotsVerticalIcon
    }
    var emailIcon: UIImage? {
        return _theme.emailIcon
    }
    var errorIcon: UIImage? {
        return _theme.errorIcon
    }
    var escrowIcon: UIImage? {
        return _theme.escrowIcon
    }
    var eyeOffIcon: UIImage? {
        return _theme.eyeOffIcon
    }
    var eyeIcon: UIImage? {
        return _theme.eyeIcon
    }
    var faceIDIcon: UIImage? {
        return _theme.faceIDIcon
    }
    var fileIcon: UIImage? {
        return _theme.fileIcon
    }
    var filter2Icon: UIImage? {
        return _theme.filter2Icon
    }
    var filterIcon: UIImage? {
        return _theme.filterIcon
    }
    var folderIcon: UIImage? {
        return _theme.folderIcon
    }
    var gearIcon: UIImage? {
        return _theme.gearIcon
    }
    var gifIcon: UIImage? {
        return _theme.gifIcon
    }
    var handIcon: UIImage? {
        return _theme.handIcon
    }
    var heartFillIcon: UIImage? {
        return _theme.heartFillIcon
    }
    var historyIcon: UIImage? {
        return _theme.historyIcon
    }
    var infoIcon: UIImage? {
        return _theme.infoIcon
    }
    var info2Icon: UIImage? {
        return _theme.info2Icon
    }
    var keyPermissionIcon: UIImage? {
        return _theme.keyPermissionIcon
    }
    var layersMapIcon: UIImage? {
        return _theme.layersMapIcon
    }
    var linkIcon: UIImage? {
        return _theme.linkIcon
    }
    var loaderIcon: UIImage? {
        return _theme.loaderIcon
    }
    var loader2Icon: UIImage? {
        return _theme.loader2Icon
    }
    var locationFillIcon: UIImage? {
        return _theme.locationFillIcon
    }
    var locationLiveIcon: UIImage? {
        return _theme.locationLiveIcon
    }
    var locationStopIcon: UIImage? {
        return _theme.locationStopIcon
    }
    var locationIcon: UIImage? {
        return _theme.locationIcon
    }
    var location2Icon: UIImage? {
        return _theme.location2Icon
    }
    var lockIcon: UIImage? {
        return _theme.lockIcon
    }
    var markIcon: UIImage? {
        return _theme.markIcon
    }
    var microphoneOffIcon: UIImage? {
        return _theme.microphoneOffIcon
    }
    var microphoneOnIcon: UIImage? {
        return _theme.microphoneOnIcon
    }
    var musicIcon: UIImage? {
        return _theme.musicIcon
    }
    var networkUsageIcon: UIImage? {
        return _theme.networkUsageIcon
    }
    var notificationIcon: UIImage? {
        return _theme.notificationIcon
    }
    var paymeIcon: UIImage? {
        return _theme.paymeIcon
    }
    var phoneIcon: UIImage? {
        return _theme.phoneIcon
    }
    var phone2Icon: UIImage? {
        return _theme.phone2Icon
    }
    var photoIcon: UIImage? {
        return _theme.photoIcon
    }
    var pictureIcon: UIImage? {
        return _theme.pictureIcon
    }
    var qrIcon: UIImage? {
        return _theme.qrIcon
    }
    var readIcon: UIImage? {
        return _theme.readIcon
    }
    var redirectInChatIcon: UIImage? {
        return _theme.redirectInChatIcon
    }
    var reportIcon: UIImage? {
        return _theme.reportIcon
    }
    var sadIcon: UIImage? {
        return _theme.sadIcon
    }
    var scanIcon: UIImage? {
        return _theme.scanIcon
    }
    var searchIcon: UIImage? {
        return _theme.searchIcon
    }
    var servicesIcon: UIImage? {
        return _theme.servicesIcon
    }
    var smileIcon: UIImage? {
        return _theme.smileIcon
    }
    var storageUsageIcon: UIImage? {
        return _theme.storageUsageIcon
    }
    var swapIcon: UIImage? {
        return _theme.swapIcon
    }
    var tagIcon: UIImage? {
        return _theme.tagIcon
    }
    var telephoneOffIcon: UIImage? {
        return _theme.telephoneOffIcon
    }
    var telephoneIcon: UIImage? {
        return _theme.telephoneIcon
    }
    var telephone2Icon: UIImage? {
        return _theme.telephone2Icon
    }
    var textIcon: UIImage? {
        return _theme.textIcon
    }
    var touchIDIcon: UIImage? {
        return _theme.touchIDIcon
    }
    var transactionIcon: UIImage? {
        return _theme.transactionIcon
    }
    var typingIcon: UIImage? {
        return _theme.typingIcon
    }
    var unlockIcon: UIImage? {
        return _theme.unlockIcon
    }
    var unreadIcon: UIImage? {
        return _theme.unreadIcon
    }
    var uploadIcon: UIImage? {
        return _theme.uploadIcon
    }
    var userIcon: UIImage? {
        return _theme.userIcon
    }
    var verificationIcon: UIImage? {
        return _theme.verificationIcon
    }
    var videoIcon: UIImage? {
        return _theme.videoIcon
    }
    var walletIcon: UIImage? {
        return _theme.walletIcon
    }
    var wifiIcon: UIImage? {
        return _theme.wifiIcon
    }
    var withdrawIcon: UIImage? {
        return _theme.withdrawIcon
    }

    
    // MARK: Navigation
    
    var arrowDownBigIcon: UIImage? {
        return _theme.arrowDownBigIcon
    }
    var arrowDownLeftIcon: UIImage? {
        return _theme.arrowDownLeftIcon
    }
    var arrowDownIcon: UIImage? {
        return _theme.arrowDownIcon
    }
    var arrowDownload2Icon: UIImage? {
        return _theme.arrowDownload2Icon
    }
    var arrowDownload3Icon: UIImage? {
        return _theme.arrowDownload3Icon
    }
    var arrowLeftBigIcon: UIImage? {
        return _theme.arrowLeftBigIcon
    }
    var arrowLeftLIcon: UIImage? {
        return _theme.arrowLeftLIcon
    }
    var arrowLeftIcon: UIImage? {
        return _theme.arrowLeftIcon
    }
    var arrowNavigationIcon: UIImage? {
        return _theme.arrowNavigationIcon
    }
    var arrowNextIcon: UIImage? {
        return _theme.arrowNextIcon
    }
    var arrowPreviousIcon: UIImage? {
        return _theme.arrowPreviousIcon
    }
    var arrowRightBigIcon: UIImage? {
        return _theme.arrowRightBigIcon
    }
    var arrowRightMIcon: UIImage? {
        return _theme.arrowRightMIcon
    }
    var arrowRightIcon: UIImage? {
        return _theme.arrowRightIcon
    }
    var arrowUpBigIcon: UIImage? {
        return _theme.arrowUpBigIcon
    }
    var arrowUpRightIcon: UIImage? {
        return _theme.arrowUpRightIcon
    }
    var arrowUpIcon: UIImage? {
        return _theme.arrowUpIcon
    }
    var circleRecIcon: UIImage? {
        return _theme.circleRecIcon
    }
    var commaIcon: UIImage? {
        return _theme.commaIcon
    }
    var cornerUpLeftIcon: UIImage? {
        return _theme.cornerUpLeftIcon
    }
    var cornerUpRightIcon: UIImage? {
        return _theme.cornerUpRightIcon
    }
    var crossCircleIcon: UIImage? {
        return _theme.crossCircleIcon
    }
    var crossIcon: UIImage? {
        return _theme.crossIcon
    }
    var dotIcon: UIImage? {
        return _theme.dotIcon
    }
    var openIcon: UIImage? {
        return _theme.openIcon
    }
    var pauseIcon: UIImage? {
        return _theme.pauseIcon
    }
    var playIcon: UIImage? {
        return _theme.playIcon
    }
    var plusIcon: UIImage? {
        return _theme.plusIcon
    }
    var sendIcon: UIImage? {
        return _theme.sendIcon
    }
    
    // MARK: Context Menu
    
    var addMemberIcon: UIImage? {
        return _theme.addMemberIcon
    }
    var addStoriesIcon: UIImage? {
        return _theme.addStoriesIcon
    }
    var blockIcon: UIImage? {
        return _theme.blockIcon
    }
    var clearIcon: UIImage? {
        return _theme.clearIcon
    }
    var copyIcon: UIImage? {
        return _theme.copyIcon
    }
    var downloadIcon: UIImage? {
        return _theme.downloadIcon
    }
    var editGroupIcon: UIImage? {
        return _theme.editGroupIcon
    }
    var editIcon: UIImage? {
        return _theme.editIcon
    }
    var exitIcon: UIImage? {
        return _theme.exitIcon
    }
    var forwardIcon: UIImage? {
        return _theme.forwardIcon
    }
    var muteIcon: UIImage? {
        return _theme.muteIcon
    }
    var noteIcon: UIImage? {
        return _theme.noteIcon
    }
    var palleteIcon: UIImage? {
        return _theme.palleteIcon
    }
    var pinListIcon: UIImage? {
        return _theme.pinListIcon
    }
    var pinIcon: UIImage? {
        return _theme.pinIcon
    }
    var remindIcon: UIImage? {
        return _theme.remindIcon
    }
    var reorderIcon: UIImage? {
        return _theme.reorderIcon
    }
    var replaceIcon: UIImage? {
        return _theme.replaceIcon
    }
    var replayIcon: UIImage? {
        return _theme.replayIcon
    }
    var contextReportIcon: UIImage? {
        return _theme.contextReportIcon
    }
    var rightHandIcon: UIImage? {
        return _theme.rightHandIcon
    }
    var selectIcon: UIImage? {
        return _theme.selectIcon
    }
    var shareIcon: UIImage? {
        return _theme.shareIcon
    }
    var showMessageIcon: UIImage? {
        return _theme.showMessageIcon
    }
    var trashIcon: UIImage? {
        return _theme.trashIcon
    }
    var twitterBtnIcon: UIImage? {
        return _theme.twitterBtnIcon
    }
    var twitterIcon: UIImage? {
        return _theme.twitterIcon
    }
    var unmuteIcon: UIImage? {
        return _theme.unmuteIcon
    }
    var unpinIcon: UIImage? {
        return _theme.unpinIcon
    }
    
    // MARK: Chat List
    
    var alamIcon: UIImage? {
        return _theme.alamIcon
    }
    var checkIcon: UIImage? {
        return _theme.checkIcon
    }
    var doubleCheckIcon: UIImage? {
        return _theme.doubleCheckIcon
    }
    var doublePinIcon: UIImage? {
        return _theme.doublePinIcon
    }
    var groupIcon: UIImage? {
        return _theme.groupIcon
    }
    var iconShieldIcon: UIImage? {
        return _theme.iconShieldIcon
    }
    var loadingIcon: UIImage? {
        return _theme.loadingIcon
    }
    var pinMeIcon: UIImage? {
        return _theme.pinMeIcon
    }
    var soundOffIcon: UIImage? {
        return _theme.soundOffIcon
    }
    var soundOnIcon: UIImage? {
        return _theme.soundOnIcon
    }
    var volume1Icon: UIImage? {
        return _theme.volume1Icon
    }
    var volume2Icon: UIImage? {
        return _theme.volume2Icon
    }
    
    // MARK: Camera
    
    var _05Icon: UIImage? {
        return _theme._05Icon
    }
    var _1xIcon: UIImage? {
        return _theme._1xIcon
    }
    var _2xIcon: UIImage? {
        return _theme._2xIcon
    }
    var _3xIcon: UIImage? {
        return _theme._3xIcon
    }
    var lightningOffIcon: UIImage? {
        return _theme.lightningOffIcon
    }
    var lightningIcon: UIImage? {
        return _theme.lightningIcon
    }
    var refreshIcon: UIImage? {
        return _theme.refreshIcon
    }
    
    // MARK: Common Icons
    
    var addIcon: UIImage? {
        return _theme.addIcon
    }
    var emptyCheckbox: UIImage? {
        return _theme.emptyCheckbox
    }
    var selectedCheckbox: UIImage? {
        return _theme.selectedCheckbox
    }
    var globe: UIImage? {
        return _theme.globe
    }
    var splashImage: UIImage? {
        return _theme.splashImage
    }
    var tedrLogo: UIImage? {
        return _theme.tedrLogo
    }
    
    //MARK: - Fonts
    func getFont(size: CGFloat, weight: UIFont.Weight, italic: Bool = false) -> UIFont {
        return _theme.getFont(size: size, weight: weight, italic: italic)
    }

    func onestFont(size: CGFloat, weight: OnestWeight) -> UIFont {
        _theme.onestFont(size: size, weight: weight)
    }
}
