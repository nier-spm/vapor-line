import Foundation

// MARK: - [ Protocol ] LineFlexMessageComponent
/**
 [FlexMessageElements]: https://developers.line.biz/en/docs/messaging-api/flex-message-elements/
 [FlexMessageLayout]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/
 
 Components are elements that make up a block.
 
 - `type`: Type of component. See **LineFlexMessageComponentType**.
 
 For JSON samples and usage of each component, see [Flex Message elements][FlexMessageElements] and [Flex Message layout][FlexMessageLayout] in the Messaging API documentation.
 */
public protocol LineFlexMessageComponent {
    var type: LineFlexMessageComponentType { get }
}

struct LineFlexMessageComponentPrototype: LineFlexMessageComponent, Codable {
    var type: LineFlexMessageComponentType
}

// MARK: - LineFlexMessageComponentType
/**
 - `box`
 - `button`
 - `image`
 - `icon`
 - `text`
 - `span`
 - `separator`
 - `filler`
 */
public enum LineFlexMessageComponentType: String, Codable {
    case box
    case button
    case image
    case icon
    case text
    case span
    case separator
    case filler
}

// MARK: - LineFlexMessageComponentPosition
/**
 [Offset]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#component-offset
 
 Reference position for placing this box.
 
 Specify one of the following values:
 - `relative`: Use the previous box as reference.
 - `absolute`: Use the top left of parent element as reference.
 
 The default value is `relative`. For more information, see [Offset] in the Messaging API documentation.
 */
public enum LineFlexMessageComponentPosition: String, Codable {
    case relative
    case absolute
}

// MARK: - LineFlexMessageComponentHorizontalAlignment
/**
 You can use the `align` property to specify how components should be aligned horizontally.
 
 The `align` property always applies to horizontal placement, regardless of how the parent element (box) has been configured. Specify one of these values:
 
 - `start`: Left-aligned
 - `end`: Right-aligned
 - `center`: Center-aligned (default value)
 */
public enum LineFlexMessageComponentHorizontalAlignment: String, Codable {
    case start
    case end
    case center
}

// MARK: - LineFlexMessageComponentVerticalAlignment
/**
 You can use the `gravity` property to specify how components should be aligned vertically.
 
 The `gravity` property always applies to vertical placement, regardless of how the parent element (box) has been configured. Specify one of these values:
 
 - `top`: Top-aligned (default value)
 - `bottom`: Bottom-aligned
 - `center`: Center-aligned
 */
public enum LineFlexMessageComponentVerticalAlignment: String, Codable {
    case top
    case bottom
    case center
}

// MARK: - LineFlexMessageComponentAspectMode
/**
 - `cover`: The image fills the entire drawing area. Parts of the image that do not fit in the drawing area are not displayed.
 - `fit`: The entire image is displayed in the drawing area. A background is displayed in the unused areas to the left and right of vertical images and in the areas above and below horizontal images.
 */
public enum LineFlexMessageComponentAspectMode: String, Codable {
    case cover
    case fit
}

// MARK: - LineFlexMessageComponentFontWeight
/**
 - `regular`
 - `bold`
 */
public enum LineFlexMessageComponentFontWeight: String, Codable {
    case regular
    case bold
}

// MARK: - LineFlexMessageComponentTextStyle
/**
 - `normal`
 - `italic`
 */
public enum LineFlexMessageComponentTextStyle: String, Codable {
    case normal
    case italic
}

// MARK: - LineFlexMessageComponentDecoration
/**
 - `none`
 - `underline`
 - `lineThrough`: Strikethrough
 */
public enum LineFlexMessageComponentDecoration: String, Codable {
    case none
    case underline
    case lineThrough = "line-through"
}

// MARK: - LineFlexMessageComponentAdjustMode
/**
 [AdjustsFontsizeToFit]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#adjusts-fontsize-to-fit
 
 - `shrinkToFit`: Automatically shrink the font size to fit the width of the component. This property takes a "best-effort" approach that may work differently—or not at all!—on some platforms. For more information, see [Automatically shrink fonts to fit][AdjustsFontsizeToFit] in the Messaging API documentation.
    - LINE 10.13.0 or later for iOS and Android
 */
public enum LineFlexMessageComponentAdjustMode: String, Codable {
    case shrinkToFit = "shrink-to-fit"
}
