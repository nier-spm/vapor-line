import Foundation

/**
 [ComponentWidthAndHeight]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#component-width-and-height
 [MarginProperty]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#margin-property
 [Offset]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#component-offset
 [GravityProperty]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#gravity-property
 
 This component renders a button.
 
 When the user taps a button, a specified action is performed.
 
 - `type`: `button`
 - `action`: Action performed when this button is tapped. Specify an action object.
 - `flex`: The ratio to use for the width or height of this component within the parent element. By default, a horizontal box's components have their `flex` property set equal to `1`. By default, a vertical box's components have their `flex` property set equal to `0`. For more information, see [Width and height of components][ComponentWidthAndHeight] in the Messaging API documentation.
 - `margin`: The minimum amount of space to include before this component in its parent container. For more information, see [margin property for components][MarginProperty] in the Messaging API documentation.
 - `position`: Reference for `offsetTop`, `offsetBottom`, `offsetStart`, and `offsetEnd`. See **LineFlexMessageComponentPosition**.
 - `offsetTop`: The top offset. For more information, see [Offset] in the Messaging API documentation.
 - `offsetBottom`: The bottom offset. For more information, see [Offset] in the Messaging API documentation.
 - `offsetStart`: The left offset. For more information, see [Offset] in the Messaging API documentation.
 - `offsetEnd`: The right offset. For more information, see [Offset] in the Messaging API documentation.
 - `height`: Height of the button. You can specify `sm` or `md`. The default value is `md`.
 - `style`: Style of the button. See **Style**. The default value is `link`.
 - `color`: Character color when the `style` property is `link`. Background color when the `style` property is `primary` or `secondary`. Use a hexadecimal color code.
 - `gravity`: Alignment style in vertical direction. For more information, see [Vertical alignment][GravityProperty] in the Messaging API documentation.
 - `adjustMode`: The method by which to adjust the text font size. See **AdjustMode**.
 */
public struct LineFlexMessageButtonComponent: LineFlexMessageComponent {
    
    public var type: LineFlexMessageComponentType = .button
//    public var action: LineActionObject
    public var flex: Double?
    public var margin: String?
    public var position: LineFlexMessageComponentPosition?
    public var offsetTop: String?
    public var offsetBottom: String?
    public var offsetStart: String?
    public var offsetEnd: String?
    public var height: Height?
    public var style: Style?
    public var color: String?
    public var gravity: LineFlexMessageComponentVerticalAlignment?
    public var adjustMode: AdjustMode?
}

// MARK: - Height
extension LineFlexMessageButtonComponent {
    
    /**
     - `sm`
     - `md`
     */
    public enum Height: String, Codable {
        case sm
        case md
    }
}

// MARK: - Style
extension LineFlexMessageButtonComponent {
    
    /**
     - `primary`: Style for dark color buttons
     - `secondary`: Style for light color buttons
     - `link`: HTML link style
     */
    public enum Style: String, Codable {
        case primary
        case secondary
        case link
    }
}

// MARK: - shrink-to-fit
extension LineFlexMessageButtonComponent {
    
    /**
     [AdjustsFontsizeToFit]: https://developers.line.biz/en/docs/messaging-api/flex-message-layout/#adjusts-fontsize-to-fit
     
     - `shrinkToFit`: Automatically shrink the font size to fit the width of the component. This property takes a "best-effort" approach that may work differently—or not at all!—on some platforms. For more information, see [Automatically shrink fonts to fit][AdjustsFontsizeToFit] in the Messaging API documentation.
        - LINE 10.13.0 or later for iOS and Android
     */
    public enum AdjustMode: String, Codable {
        case shrinkToFit = "shrink-to-fit"
    }
}

// MARK: - Codable
extension LineFlexMessageButtonComponent: Codable {}
