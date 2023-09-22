# Powershell ClipboardTools Module

Welcome to `ClipboardTools`, an exceptional module crafted with some of the finest PowerShell functions designed to enhance and simplify your clipboard management tasks. Developed by a seasoned Microsoft MVP - Windows and Devices, the functions in this module offer diverse capabilities ranging from manipulating clipboard contents, validating and formatting various data types, and much more. Delve deeper to discover the amazing tools available for your daily use.

## Functions

### Clipboard-CopyPaste
- **Synopsis**: This function gets clipboard data and sets it back to the clipboard, removing any metadata. For example, it can convert HTTP smartlinks to their full URLs.
- **Usage**:
  ```powershell
  Clipboard-CopyPaste
  $FromClipboard = Clipboard-CopyPaste -PassThru
  ```

### Clipboard-NewGuidToClipboard
- **Synopsis**: Creates a new GUID and copies it to the clipboard.
- **Usage**:
  ```powershell
  Clipboard-NewGuidToClipboard
  ```

### Clipboard-CopyPasteUrl
- **Synopsis**: Extracts the title and URL from a smart HTML link and pastes them back to the clipboard in separate lines.
- **Usage**:
  ```powershell
  Clipboard-CopyPasteUrl
  ```

### Clipboard-CopyPasteJson
- **Synopsis**: Reads JSON data from the clipboard, extracts the JSON, and then sets it back. Also provides options to remove specific escape sequences.
- **Usage**:
  ```powershell
  Clipboard-CopyPasteJson
  $FromJson = Clipboard-CopyPasteJson -PassThru
  Clipboard-CopyPasteJson -RemovePowershellEscapes
  Clipboard-CopyPasteJson -RemoveDoubleJsonEscapes
  ```

### Clipboard-SaveImageToFile
- **Synopsis**: Reads image data from the clipboard and saves it to a file.
- **Usage**:
  ```powershell
  Clipboard-SaveImageToFile
  Clipboard-SaveImageToFile -Name 'ImageFileName'
  Clipboard-SaveImageToFile -Name 'ImageFileName' -FilePath D:\ScreenCaptures
  Clipboard-SaveImageToFile -OpenImageAfterSave
  ```

### Clipboard-Sort
- **Synopsis**: Sorts data in the clipboard either ascending (default) or descending.
- **Usage**:
  ```powershell
  Clipboard-Sort
  Clipboard-Sort -Descending
  ```

### Clipboard-ValidateJson
- **Synopsis**: Checks if clipboard data is valid JSON syntax.
- **Usage**:
  ```powershell
  Clipboard-ValidateJson
  ```

### Clipboard-ValidateCsv
- **Synopsis**: Checks if CSV copied to the clipboard is valid CSV syntax.
- **Usage**:
  ```powershell
  Clipboard-ValidateCsv
  Clipboard-ValidateCsv -Delimiter ','
  ```

### Clipboard-ConvertFromBase64
- **Synopsis**: Converts base64 encoded data in the clipboard to clear text.
- **Usage**:
  ```powershell
  Clipboard-ConvertFromBase64
  Clipboard-ConvertFromBase64 -PassThru
  ```

### Clipboard-ValidateXml
- **Synopsis**: Checks if XML file copied to the clipboard is valid XML syntax.
- **Usage**:
  ```powershell
  Clipboard-ValidateXml
  ```

### Clipboard-ValidatePowershellSyntax
- **Synopsis**: Checks if the PowerShell script copied to the clipboard is valid PowerShell syntax.
- **Usage**:
  ```powershell
  Clipboard-ValidatePowershellSyntax
  ```

## Author
**Petri Paavola**  
- Senior Modern Management Principal  
- Microsoft MVP - Windows and Devices for IT  
- [GitHub Project](https://github.com/petripaavola/ClipboardTools)  
- Email: Petri.Paavola@yodamiitti.fi  

---

© 2023 Petri Paavola
