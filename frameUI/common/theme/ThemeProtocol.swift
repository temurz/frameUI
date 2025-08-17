//
//  ThemeProtocol.swift
//  Tedr
//
//  Created by GK on 11/03/25.
//

import Foundation
import UIKit
protocol ThemeProtocol: AnyObject {
    var backgroundColor: UIColor { get }
    var backgroundPrimaryColor: UIColor { get }
    var backgroundSecondaryColor: UIColor { get }
    var bgSecondaryTransparent20: UIColor { get }
    var backgroundTertiaryColor: UIColor { get }
    var darkTextColor: UIColor { get }
    var subTextColor: UIColor { get }
    var whiteColor: UIColor { get }
    var orangeColor: UIColor { get }
    var addDarkTextColor: UIColor { get }
    var addSubTextColor: UIColor { get }
    var systemBlueColor: UIColor { get }
    var systemRedColor: UIColor { get }
    var systemYellowColor: UIColor { get }
    var systemGreenColor: UIColor { get }
    var statusProcessingColor: UIColor { get }
    var statusClosedColor: UIColor { get }
    var statusDeliveredColor: UIColor { get }
    var statusReturnedColor: UIColor { get }
    var iconColor: UIColor { get }
    var contentPrimary: UIColor { get }
    var contentSecondary: UIColor { get }
    var contentWhite: UIColor { get }
    var contentTurquoise: UIColor { get }
    var contentPink: UIColor { get }
    var contentBlue: UIColor { get }
    var contentRed: UIColor { get }
    var contentYellow: UIColor { get }
    var contentPurple: UIColor { get }
    var reorderActionBackground: UIColor { get }
    var pinActionBackground: UIColor { get }
    var readActionBackground: UIColor { get }
    var trashActionBackground: UIColor { get }
    var muteActionBackground: UIColor { get }
    var pinkGradientUpColor: UIColor { get }
    var pinkGradientDownColor: UIColor { get }
    var blueGradientUpColor: UIColor { get }
    var blueGradientDownColor: UIColor { get }
    var purpleBackgroundColor: UIColor { get }
    var buttonTurquoiseColor: UIColor { get }
    var tabbarUnionBackgroundColor: UIColor { get }
    var textFieldBackgroundColor: UIColor { get }
    var ethereumNetworkColor: UIColor { get }
    var tronNetworkColor: UIColor { get }
    var bitcoinNetworkColor: UIColor { get }
    var tonNetworkColor: UIColor { get }
    var fiatNetworkColor: UIColor { get }
    var eosNetworkColor: UIColor { get }
    var bscNetworkColor: UIColor { get }
    var bgWhiteTransparent10: UIColor { get }
    var buttonQuaternaryTransparentDefaultContent: UIColor { get }
    var buttonQuaternaryTransparentDefaultBg: UIColor { get }
    var buttonSecondaryPinkDisabledContent: UIColor { get }
    var buttonSecondaryPinkDisabledBg: UIColor { get }
    var bgBlackTransparent20: UIColor { get }
    var chatBubbleOutcomingColor: UIColor { get }
    var chatBubbleIncomingColor: UIColor { get }
    var primaryBlueDefaultBg: UIColor { get }
    var modalBlueDefaultBg : UIColor { get }
    
    
    // MARK: - Images
    
    // MARK: System
    var adminIcon: UIImage? { get }
    var adsIcon: UIImage? { get }
    var archiveIcon: UIImage? { get }
    var attentionIcon: UIImage? { get }
    var backspaceIcon: UIImage? { get }
    var brushIcon: UIImage? { get }
    var calendarIcon: UIImage? { get }
    var clipIcon: UIImage? { get }
    var cellularIcon: UIImage? { get }
    var chatIcon: UIImage? { get }
    var computerIcon: UIImage? { get }
    var cropIcon: UIImage? { get }
    var dappsIcon: UIImage? { get }
    var depositIcon: UIImage? { get }
    var devicesIcon: UIImage? { get }
    var dotsVerticalIcon: UIImage? { get }
    var emailIcon: UIImage? { get }
    var errorIcon: UIImage? { get }
    var escrowIcon: UIImage? { get }
    var eyeOffIcon: UIImage? { get }
    var eyeIcon: UIImage? { get }
    var faceIDIcon: UIImage? { get }
    var fileIcon: UIImage? { get }
    var filter2Icon: UIImage? { get }
    var filterIcon: UIImage? { get }
    var folderIcon: UIImage? { get }
    var gearIcon: UIImage? { get }
    var gifIcon: UIImage? { get }
    var handIcon: UIImage? { get }
    var heartFillIcon: UIImage? { get }
    var historyIcon: UIImage? { get }
    var infoIcon: UIImage? { get }
    var info2Icon: UIImage? { get }
    var keyPermissionIcon: UIImage? { get }
    var layersMapIcon: UIImage? { get }
    var linkIcon: UIImage? { get }
    var loaderIcon: UIImage? { get }
    var loader2Icon: UIImage? { get }
    var locationFillIcon: UIImage? { get }
    var locationLiveIcon: UIImage? { get }
    var locationStopIcon: UIImage? { get }
    var locationIcon: UIImage? { get }
    var location2Icon: UIImage? { get }
    var lockIcon: UIImage? { get }
    var markIcon: UIImage? { get }
    var microphoneOffIcon: UIImage? { get }
    var microphoneOnIcon: UIImage? { get }
    var musicIcon: UIImage? { get }
    var networkUsageIcon: UIImage? { get }
    var notificationIcon: UIImage? { get }
    var paymeIcon: UIImage? { get }
    var phoneIcon: UIImage? { get }
    var phone2Icon: UIImage? { get }
    var photoIcon: UIImage? { get }
    var pictureIcon: UIImage? { get }
    var qrIcon: UIImage? { get }
    var readIcon: UIImage? { get }
    var redirectInChatIcon: UIImage? { get }
    var reportIcon: UIImage? { get }
    var sadIcon: UIImage? { get }
    var scanIcon: UIImage? { get }
    var searchIcon: UIImage? { get }
    var servicesIcon: UIImage? { get }
    var smileIcon: UIImage? { get }
    var storageUsageIcon: UIImage? { get }
    var swapIcon: UIImage? { get }
    var tagIcon: UIImage? { get }
    var telephoneOffIcon: UIImage? { get }
    var telephoneIcon: UIImage? { get }
    var telephone2Icon: UIImage? { get }
    var textIcon: UIImage? { get }
    var touchIDIcon: UIImage? { get }
    var transactionIcon: UIImage? { get }
    var typingIcon: UIImage? { get }
    var unlockIcon: UIImage? { get }
    var unreadIcon: UIImage? { get }
    var uploadIcon: UIImage? { get }
    var userIcon: UIImage? { get }
    var verificationIcon: UIImage? { get }
    var videoIcon: UIImage? { get }
    var walletIcon: UIImage? { get }
    var wifiIcon: UIImage? { get }
    var withdrawIcon: UIImage? { get }

    
    // MARK: Navigation
    var arrowDownBigIcon: UIImage? { get }
    var arrowDownLeftIcon: UIImage? { get }
    var arrowDownIcon: UIImage? { get }
    var arrowDownload2Icon: UIImage? { get }
    var arrowDownload3Icon: UIImage? { get }
    var arrowLeftBigIcon: UIImage? { get }
    var arrowLeftLIcon: UIImage? { get }
    var arrowLeftIcon: UIImage? { get }
    var arrowNavigationIcon: UIImage? { get }
    var arrowNextIcon: UIImage? { get }
    var arrowPreviousIcon: UIImage? { get }
    var arrowRightBigIcon: UIImage? { get }
    var arrowRightMIcon: UIImage? { get }
    var arrowRightIcon: UIImage? { get }
    var arrowUpBigIcon: UIImage? { get }
    var arrowUpRightIcon: UIImage? { get }
    var arrowUpIcon: UIImage? { get }
    var circleRecIcon: UIImage? { get }
    var commaIcon: UIImage? { get }
    var cornerUpLeftIcon: UIImage? { get }
    var cornerUpRightIcon: UIImage? { get }
    var crossCircleIcon: UIImage? { get }
    var crossIcon: UIImage? { get }
    var dotIcon: UIImage? { get }
    var openIcon: UIImage? { get }
    var pauseIcon: UIImage? { get }
    var playIcon: UIImage? { get }
    var plusIcon: UIImage? { get }
    var sendIcon: UIImage? { get }
    
    // MARK: Context Menu
    var addMemberIcon: UIImage? { get }
    var addStoriesIcon: UIImage? { get }
    var blockIcon: UIImage? { get }
    var clearIcon: UIImage? { get }
    var copyIcon: UIImage? { get }
    var downloadIcon: UIImage? { get }
    var editGroupIcon: UIImage? { get }
    var editIcon: UIImage? { get }
    var exitIcon: UIImage? { get }
    var forwardIcon: UIImage? { get }
    var muteIcon: UIImage? { get }
    var noteIcon: UIImage? { get }
    var palleteIcon: UIImage? { get }
    var pinListIcon: UIImage? { get }
    var pinIcon: UIImage? { get }
    var remindIcon: UIImage? { get }
    var reorderIcon: UIImage? { get }
    var replaceIcon: UIImage? { get }
    var replayIcon: UIImage? { get }
    var contextReportIcon: UIImage? { get }
    var rightHandIcon: UIImage? { get }
    var selectIcon: UIImage? { get }
    var shareIcon: UIImage? { get }
    var showMessageIcon: UIImage? { get }
    var trashIcon: UIImage? { get }
    var twitterBtnIcon: UIImage? { get }
    var twitterIcon: UIImage? { get }
    var unmuteIcon: UIImage? { get }
    var unpinIcon: UIImage? { get }
    
    // MARK: Chat List
    var alamIcon: UIImage? { get }
    var checkIcon: UIImage? { get }
    var doubleCheckIcon: UIImage? { get }
    var doublePinIcon: UIImage? { get }
    var groupIcon: UIImage? { get }
    var iconShieldIcon: UIImage? { get }
    var loadingIcon: UIImage? { get }
    var pinMeIcon: UIImage? { get }
    var soundOffIcon: UIImage? { get }
    var soundOnIcon: UIImage? { get }
    var volume1Icon: UIImage? { get }
    var volume2Icon: UIImage? { get }
    
    // MARK: Camera
    var _05Icon: UIImage? { get }
    var _1xIcon: UIImage? { get }
    var _2xIcon: UIImage? { get }
    var _3xIcon: UIImage? { get }
    var lightningOffIcon: UIImage? { get }
    var lightningIcon: UIImage? { get }
    var refreshIcon: UIImage? { get }
    
    // MARK: Common Icons
    var addIcon: UIImage? { get }
    var emptyCheckbox: UIImage? { get }
    var selectedCheckbox: UIImage? { get }
    var globe: UIImage? { get }
    var splashImage: UIImage? { get }
    var tedrLogo: UIImage? { get }
    
    
    // MARK: Avatar icons
    
    var avatar : UIImage? { get }
    
    var useAvatarIcon : UIImage? { get }
    
    //MARK: - Fonts
    func getFont(size: CGFloat, weight: UIFont.Weight, italic: Bool) -> UIFont
    func onestFont(size: CGFloat, weight: OnestWeight) -> UIFont
}
