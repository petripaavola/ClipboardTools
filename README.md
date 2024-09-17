# Powershell ClipboardTools Module

Welcome to `ClipboardTools` — a treasure trove of meticulously crafted PowerShell functions designed to supercharge your Graph API scripting and data manipulation tasks. Developed by Petri Paavola, a seasoned Microsoft MVP - Windows and Intune, this module is equipped with diverse tools, each tailored to cater to specific needs — be it validating and formatting various data formats like JSON, xml, base64, or effortlessly interacting with the Microsoft Graph API.

Of particular note is the function:
- [ClipboardTools-EdgeDebuggerMGGraphPowerShellScript](#clipboardtools-edgedebuggermggraphpowershellscript)


This gem effortlessly convert copied PowerShell scripts from the Edge Debugger into actionable PowerShell script syntax. 

**Dive in and discover the very helper tools that underpin Petri's renowned Intune and Graph API solutions and reports. Your scripting endeavors will never be the same!**

## Features
Especially, the `ClipboardTools` module shines when you're working with Graph Explorer, Graph API, JSON files, and other data formats. All the operations are processed through the clipboard, ensuring seamless integration into your workflows.

- Clipboard management: Copy, paste, and manipulate clipboard contents with ease.
- Data validation: Validate JSON, XML, and even PowerShell syntax directly from your clipboard.
- Data conversion: Convert between different data formats, like converting to and from Base64.
- Graph API integration: Extract and adapt API calls from Edge Debugger for use in your scripts with Graph API.

## Installation 📦

Before diving into the functionalities, here's how you can get **ClipboardTools**:

```powershell
# Install from PowerShell Gallery
Install-Module -Name ClipboardTools -Scope CurrentUser

# If you already have the module and want to update
Update-Module -Name ClipboardTools
```
### Supported Powershell versions
There are few commands which are not supported in Powershell 7. **For now this module is officially supported only in Windows Powershell.**

Some next module version will have Powershell 7 uncompatible commands fixed.

### Functions

- [ClipboardTools-CopyPaste](#clipboardtools-copypaste)
- [ClipboardTools-CopyPasteUrl](#clipboardtools-copypasteurl)
- [ClipboardTools-PasteObjectToExcel](#clipboardtools-pasteobjecttoexcel)
- [ClipboardTools-NewGuidToClipboard](#clipboardtools-newguidtoclipboard)
- [ClipboardTools-JsonUncompress](#clipboardtools-jsonuncompress)
- [ClipboardTools-JsonCompress](#clipboardtools-jsoncompress)
- [ClipboardTools-SaveImageToFile](#clipboardtools-saveimagetofile)
- [ClipboardTools-SaveTextToFile](#clipboardtools-savetexttofile)
- [ClipboardTools-Sort](#clipboardtools-sort)
- [ClipboardTools-ValidateJson](#clipboardtools-validatejson)
- [ClipboardTools-ValidateXml](#clipboardtools-validatexml)
- [ClipboardTools-ValidatePowershellSyntax](#clipboardtools-validatepowershellsyntax)
- [ClipboardTools-ConvertFromBase64](#clipboardtools-convertfrombase64)
- [ClipboardTools-ConvertToBase64](#clipboardtools-converttobase64)
- [ClipboardTools-ConvertStringToHex](#clipboardtools-convertstringtohex)
- [ClipboardTools-ConvertHexToString](#clipboardtools-converthextostring)
- [ClipboardTools-ObjectifyIntuneJsonReport](#clipboardtools-objectifyintunejsonreport)
- [ClipboardTools-EdgeDebuggerMGGraphPowerShellScript](#clipboardtools-edgedebuggermggraphpowershellscript)

---

## Functions 📋

### ClipboardTools-CopyPaste

**Synopsis**:
This function retrieves clipboard data and resets it to the clipboard, effectively removing any metadata. For instance, from HTTP smartlinks, it will paste the full URL instead of the URL smartlink (URL name and actual URL).

**Description**:
ClipboardTools-CopyPaste is designed to be a handy tool for cleaning up your clipboard data. Whether you've copied a smart link or some other data format with extra metadata, this function will simplify the contents, ensuring you're pasting exactly what you see.

**Parameters**:

- `PassThru`: 
  - This switch will output the clipboard data to the PowerShell pipeline, often used to save results to a variable.
  - Example: `$FromClipboard = ClipboardTools-CopyPaste -PassThru`

**Usage**:
```powershell
ClipboardTools-CopyPaste
$FromClipboard = ClipboardTools-CopyPaste -PassThru
```

**Inputs**: Reads clipboard data.

**Outputs**: Data is reset to the clipboard. With the `-PassThru` switch, the output is also sent to the PowerShell pipeline.

---

### ClipboardTools-CopyPasteUrl

**Synopsis**:  
This function extracts a smart HTML link's title and URL and pastes them back to the clipboard, with each piece of information on a separate line. It's a handy trick for when you want to paste the title and URL of a smart HTML link separately into a document.

**Description**:  
Using `ClipboardTools-CopyPasteUrl`, you can efficiently extract the title and actual URL from a smart HTML link saved on your clipboard. After extraction, the function resets both pieces of information to your clipboard in two distinct lines.

**Usage**:
```powershell
ClipboardTools-CopyPasteUrl
```

**Inputs**:  
This function reads clipboard data looking specifically for a smart HTML link.

**Outputs**:  
Two separate lines are sent to your clipboard. The first line is the smart HTML link's title, and the second line is the actual URL.

Here's the GitHub markdown documentation for the `ClipboardTools-PasteObjectToExcel` function, with a bit of humor and flair added as requested:

---
### ClipboardTools-PasteObjectToExcel

**Synopsis**:  
🔍 Ever wish you could magically translate your PowerShell gibberish into a format your manager can understand? With `ClipboardTools-PasteObjectToExcel`, you can do just that! This function transforms complex PowerShell objects into an Excel-friendly format — no more trying to explain matrix-like scripts to non-tech folks!

**Description**:  
The `ClipboardTools-PasteObjectToExcel` function takes your PowerShell objects and converts them into a tab-delimited CSV format, perfectly aligned for Excel. Simply pipe your objects into this function, and voila! It’s like translating the Matrix into clear text — all those rows and columns get neatly organized for reporting, analysis, or to impress your manager with a "user-friendly" Excel sheet. The function copies the CSV directly to your clipboard, ready to paste into Excel, where each property of the object will automatically go into its own column.

No more awkward screenshots or trying to explain PowerShell output to management — just paste it into Excel, create a table with a click, and take the day off!

**Key Features**:
- **Transforms PowerShell objects**: Converts pipeline objects into a tab-delimited format, perfect for pasting into Excel.
- **Clipboard Magic**: Automatically copies the CSV to your clipboard so you can paste it directly into Excel, turning raw data into instant spreadsheets.
- **Excel-Ready**: Just paste it in Excel, hit the "Create Table" button, and you’ve got a management-ready report in seconds.

**Usage**:
```powershell
Get-Service | ClipboardTools-PasteObjectToExcel
```
```powershell
$myData | ClipboardTools-PasteObjectToExcel
```

#### Parameters:  
- `-PowershellObjects`: Specifies the objects to be converted to tab-delimited CSV format. These objects can be passed via the pipeline.

#### Inputs:  
- Accepts PowerShell objects from the pipeline. The objects are converted to a tab-delimited CSV format.

#### Outputs:  
- Tab-delimited CSV data is copied to the clipboard, ready to be pasted into Excel.

**Notes**:  
- Perfect for quickly exporting PowerShell data into a format that’s easily digestible for Excel. No more intimidating PowerShell output — just nice, clean spreadsheets.

---
### ClipboardTools-NewGuidToClipboard

**Synopsis**:  
This function generates a new globally unique identifier (GUID) and immediately copies it to the clipboard, making it available for you to paste anywhere you need.

**Description**:  
Using `ClipboardTools-NewGuidToClipboard`, you can effortlessly generate a new GUID and have it ready on your clipboard. It eliminates the need for additional tools or online generators. A simple command in PowerShell and you have a fresh GUID available to be pasted.

**Usage**:
```powershell
ClipboardTools-NewGuidToClipboard
```

**Inputs**:  
The function generates a new GUID, so no specific inputs from the clipboard are required.

**Outputs**:  
The newly generated GUID is sent to your clipboard.

---

### ClipboardTools-JsonUncompress

**🔥 Highlight**:  
This function is a daily driver for anyone working with JSONs, especially from the Graph API. It elegantly deciphers compressed JSON and turns it into a more human-readable format. With Graph API’s penchant for compacted data, `ClipboardTools-JsonUncompress` proves to be an indispensable tool in every administrator's arsenal.

**Synopsis**:  
Reads compressed JSON data from the clipboard and sets it to a more legible uncompressed JSON format.

**Description**:  
The `ClipboardTools-JsonUncompress` is a handy function that doesn't only expand compacted JSON but also ensures that its syntax remains accurate during the transition. Through its use, you can confidently validate and transform compressed JSON. The function also integrates the flexibility of saving the result directly to a PowerShell variable with the `-PassThru` parameter.

**Parameters**:
- `-PassThru`: Outputs the transformed JSON to the PowerShell pipeline, typically to store the results in a variable.
- `-RemovePowershellEscapes`: Eradicates PowerShell escape characters from JSON, often required when extracting data from tools like the Edge Debugger.
- `-RemoveDoubleJsonEscapes`: In some rare instances where the original JSON data contains nested JSON properties, they might get double-escaped. This switch ensures the integrity of such data.

**Usage**:
```powershell
ClipboardTools-JsonUncompress
```
```powershell
$FromJson = ClipboardTools-JsonUncompress -PassThru
```
```powershell
ClipboardTools-JsonUncompress -RemovePowershellEscapes
```
```powershell
ClipboardTools-JsonUncompress -RemoveDoubleJsonEscapes
```

**Inputs**:  
Extracts JSON data from the clipboard.

**Outputs**:  
Releases syntax-verified and uncompressed JSON back to the clipboard.

---
### ClipboardTools-JsonCompress

**Synopsis**:  
Convert JSON data from your clipboard into a compacted JSON format used in some services and/or scripts.

**Description**:  
The `ClipboardTools-JsonCompress` is essential for those looking to trim down JSON data without compromising its integrity. While it efficiently shrinks the data, it never skips the step to validate the JSON syntax, ensuring that the compacted data remains error-free.

**Parameters**:
- `-PassThru`: Use this switch if you wish to output the compressed JSON directly to the PowerShell pipeline. This can be particularly handy if you intend to immediately store the result in a PowerShell variable.

**Usage**:
```powershell
ClipboardTools-JsonCompress
```
```powershell
$CompressedJson = ClipboardTools-JsonCompress -PassThru
```

**Inputs**:  
Pulls JSON data directly from the clipboard.

**Outputs**:  
Releases a validated and compressed JSON format back to the clipboard.

---
### ClipboardTools-SaveImageToFile

**Synopsis**:  
📸 A hassle-free method to quickly save clipboard images to files, possibly even replacing your current screenshot software.

**Description**:  
With `ClipboardTools-SaveImageToFile`, the ability to directly save images from your clipboard to specified file paths becomes a reality. By default, images are saved in the present directory, named in the format `{timestamp}-ImageCapture.png`. However, users have the freedom to set their own filename and destination folder using `-FileName` and `-FilePath` parameters respectively. Post saving, the function even offers the convenience of instantly viewing the saved image via the `-OpenFileAfterSave` parameter.

**Parameters**:
- `-FileName`: Decide on a custom filename for the saved image.
- `-FilePath`: Specify a different folder to store the image in.
- `-OpenFileAfterSave`: Upon saving, the image gets automatically opened in the default image viewer for quick access.

**Usage**:
```powershell
ClipboardTools-SaveImageToFile
```
```powershell
ClipboardTools-SaveImageToFile -FileName 'ImageFileName'
```
```powershell
ClipboardTools-SaveImageToFile -FileName 'ImageFileName' -FilePath D:\ScreenCaptures
```
```powershell
ClipboardTools-SaveImageToFile -OpenFileAfterSave
```

**Inputs**:  
Grabs image data from the clipboard.

**Outputs**:  
Saves the image to the desired file.

---
### ClipboardTools-SaveTextToFile

**Synopsis**:  
📝 A simple way to save or append clipboard text directly to a file.

**Description**:  
The `ClipboardTools-SaveTextToFile` function allows for a seamless experience in extracting text from the clipboard and saving it directly to a text file. Users can define the filename and its path, with defaults being `textfile.txt` and the current working directory, respectively. The utility provides options to append text to pre-existing files, forcefully overwrite files, or simply create new ones. Moreover, after the save operation, the file can be instantly viewed in the default text editor using the `-OpenFileAfterSave` parameter.

**Parameters**:
- `-FileName`: Decide on a custom filename for the saved text file.
- `-FilePath`: Specify a different directory to store the text file in.
- `-Append`: Append the clipboard text to an existing file or create a new one.
- `-Force`: Overwrite an existing file.
- `-OpenFileAfterSave`: Open the saved file in the default text editor.

**Usage**:
```powershell
ClipboardTools-SaveTextToFile
```
```powershell
ClipboardTools-SaveTextToFile -FileName 'TextFile.txt'
```
```powershell
ClipboardTools-SaveTextToFile -FileName 'TextFile.txt' -FilePath D:\temp
```
```powershell
ClipboardTools-SaveTextToFile -OpenFileAfterSave
```
```powershell
ClipboardTools-SaveTextToFile -FileName 'TextFile.txt' -FilePath D:\temp -Append
```
```powershell
ClipboardTools-SaveTextToFile -FileName 'TextFile.txt' -FilePath D:\temp -Force
```

**Inputs**:  
Takes in text data from the clipboard.

**Outputs**:  
Safely saves or appends the text to the chosen file.

---
### ClipboardTools-Sort

**Synopsis**:  
📜 Need your clipboard text sorted quickly? `ClipboardTools-Sort` is the answer.

**Description**:  
The `ClipboardTools-Sort` function is a fantastic utility for those quick moments when you need to sort your clipboard text. The default behavior is to sort in ascending order, but with the `-Descending` flag, you can instantly change the order.

**Parameters**:
- `-Descending`: Toggle to sort the clipboard text in descending order.

**Usage**:
```powershell
ClipboardTools-Sort
```
```powershell
ClipboardTools-Sort -Descending
```

**Inputs**:  
Reads the clipboard text data.

**Outputs**:  
Sends the sorted text right back to the clipboard, ready for your use.

---
### ClipboardTools-ValidateJson

**Synopsis**:  
📜 Is your clipboard text a valid JSON? Don't guess, check with `ClipboardTools-ValidateJson`.

**Description**:  
The `ClipboardTools-ValidateJson` function is the easiest way to quickly verify if the content you have copied to the clipboard is a valid JSON or not.

**Usage**:
```powershell
ClipboardTools-ValidateJson
```

**Inputs**:  
Reads the clipboard text.

**Outputs**:  
Outputs the validation result in your terminal, letting you know whether your clipboard contains valid JSON.

---
### ClipboardTools-ValidateXml

**Synopsis**:  
📜 Dealing with XML content on your clipboard? Use `ClipboardTools-ValidateXml` to quickly validate its syntax.

**Description**:  
The `ClipboardTools-ValidateXml` function allows you to validate the XML syntax of content stored in your clipboard. Syntax errors can be quite the puzzle, but this tool will provide details on where the issue lies. Whether it's a misplaced tag or an incorrect attribute, this function will point it out.

**Usage**:
```powershell
ClipboardTools-ValidateXml
```
```powershell
$xml = ClipboardTools-ValidateXml -PassThru
```

**Parameters**:  
- `-PassThru`: Use this switch if you want to output the XML content to the PowerShell pipeline, perhaps to save it to a variable or process it further.

**Inputs**:  
Reads the clipboard text.

**Outputs**:  
Validates the XML and, if the `-PassThru` parameter is used, outputs the XML to the PowerShell pipeline.

---
### ClipboardTools-ValidatePowershellSyntax

**Synopsis**:  
🔍 Ever deployed script to some automation (for example Intune application) and then wondered why script is not working. And then noticed error was missing " or ' in the script. The `ClipboardTools-ValidatePowershellSyntax` is here to help find these errors before your brain hurts too much!

**Description**:  
The `ClipboardTools-ValidatePowershellSyntax` function inspects the syntax of a PowerShell script stored in your clipboard. It does so by creating a temporary `.ps1` file, saving the clipboard content to it, and using the `Get-Command -Syntax` command to check its validity. Importantly, this function **doesn't execute the script**, ensuring your system's safety. After the check, the temporary file gets deleted.

**Usage**:  
```powershell
ClipboardTools-ValidatePowershellSyntax
```

**Inputs**:  
- Reads the PowerShell script from your clipboard.

**Outputs**:  
- Provides an output to indicate whether the script's syntax is valid or not. 
- A temporary PowerShell script file is created in the `$env:temp` directory and deleted after the syntax check.

**Notes**:  
While this function is super handy to ensure that your script doesn't have glaring syntax errors, always remember to test your scripts in a controlled environment before running them on a production system.

---
### ClipboardTools-ConvertFromBase64

**Synopsis**:  
🔍 Base64 encoding can be a mystery, but not anymore. `ClipboardTools-ConvertFromBase64` decodes it right from your clipboard into clear text.

**Description**:  
The `ClipboardTools-ConvertFromBase64` function decodes base64 encoded text present in your clipboard and places the clear text back, ready for use. Useful for scenarios like dealing with API responses, encrypted data, or other situations where base64 encoding is commonly found. Common example are Intune Powershell scripts which base64 encoded in Graph API.

**Usage**:
```powershell
ClipboardTools-ConvertFromBase64
```
```powershell
$ClearTextFromBase64 = ClipboardTools-ConvertFromBase64 -PassThru
```

**Parameters**:  
- `-PassThru`: Use this switch to send the decoded base64 text to the PowerShell pipeline. Commonly used for further processing or saving the output to a variable.

**Inputs**:  
Interprets and decodes base64 text from the clipboard.

**Outputs**:  
Places the decoded text back onto the clipboard. Using the `-PassThru` parameter, the decoded base64 text is also sent to the PowerShell pipeline.

---
### ClipboardTools-ConvertToBase64

**Synopsis**:  
🔍 Need to turn your clipboard text into base64 encoding? The `ClipboardTools-ConvertToBase64` function makes this process seamless, converting clear text from your clipboard into a base64 string and copying it back to your clipboard.

**Description**:  
The `ClipboardTools-ConvertToBase64` function converts any plain text stored in your clipboard to a base64 encoded string. After the conversion, the base64 string is copied back to the clipboard, ensuring you can easily paste the encoded text wherever needed. Additionally, the function can output the base64 string directly to the PowerShell pipeline using the `-PassThru` parameter, which is helpful for saving the result to a variable or for further processing.

**Usage**:
```powershell
ClipboardTools-ConvertToBase64
```
```powershell
$Base64String = ClipboardTools-ConvertToBase64 -PassThru
```

#### Parameters:  
- `-PassThru`: Use this switch to output the base64 encoded string to the PowerShell pipeline for further processing or to save it to a variable.

#### Inputs:  
- Reads clear text from the clipboard and converts it to a base64 string.

#### Outputs:  
- The base64 encoded string is copied to the clipboard.
- If the `-PassThru` parameter is used, the base64 encoded string is also sent to the PowerShell pipeline.

#### Notes:  
This function is useful for encoding clear text in base64 format, especially when dealing with APIs, scripts, or other use cases where base64 encoding is required. Always ensure your clipboard contains valid text before running the function.

---
### ClipboardTools-ConvertStringToHex

**Synopsis**:  
🔍 Need to convert clipboard text into a hexadecimal representation? The `ClipboardTools-ConvertStringToHex` function converts text from your clipboard into a hexadecimal string using either UTF-8 or UTF-16 encoding, with options for output formats like comma-separated values or a format suitable for Windows registry (Regedit).

**Description**:  
The `ClipboardTools-ConvertStringToHex` function retrieves text from the clipboard and converts it into a hexadecimal string. You can choose between UTF-8 or UTF-16 encoding, with UTF-16 as the default if no encoding is specified. The function also offers output in a comma-separated format or a format suitable for Windows registry modifications. The converted hexadecimal string is copied back to the clipboard for easy access.

**Usage**:
```powershell
ClipboardTools-ConvertStringToHex -UTF8
```
```powershell
ClipboardTools-ConvertStringToHex -UTF16 -CommaSeparated
```
```powershell
ClipboardTools-ConvertStringToHex -Regedit
```

#### Parameters:  
- `-UTF8`: Converts the string to a hexadecimal string using UTF-8 encoding.
- `-UTF16`: Converts the string to a hexadecimal string using UTF-16 encoding (default).
- `-CommaSeparated`: Outputs the hexadecimal string as a comma-separated string.
- `-Regedit`: Outputs the hexadecimal string in a format suitable for the Windows registry, prepending `hex(2):` to the output.

#### Inputs:  
- Reads text from the clipboard and converts it into a hexadecimal string.

#### Outputs:  
- The converted hexadecimal string is copied to the clipboard.

#### Notes:  
- If no encoding is specified, UTF-16 encoding will be used by default.

---
### ClipboardTools-ConvertHexToString

**Synopsis**:  
🔍 Have a hexadecimal string in your clipboard that you need to convert back to readable text? The `ClipboardTools-ConvertHexToString` function retrieves a hexadecimal string from the clipboard, cleans it up, and converts it back into its original text representation.

**Description**:  
The `ClipboardTools-ConvertHexToString` function reads a hexadecimal string from the clipboard, removes unwanted characters, and converts it into a readable text string. It automatically detects whether the string is encoded in UTF-8 or UTF-16LE based on byte patterns and then decodes it accordingly. The function handles both single-line and multi-line clipboard content and places the decoded string back into the clipboard for easy use.

**Usage**:
```powershell
ClipboardTools-ConvertHexToString
```

#### Inputs:  
- Reads a hexadecimal string from the clipboard and converts it into a readable text string.

#### Outputs:  
- The converted text string is copied back to the clipboard.

#### Notes:  
- This function automatically detects whether the clipboard contents are in UTF-8 or UTF-16LE encoding and decodes them accordingly.
- The function handles single-line and multi-line clipboard content and removes unnecessary characters.

---
### ClipboardTools-ObjectifyIntuneJsonReport

**Synopsis**:  
🔍 Simplify your Intune JSON report processing tasks. `ClipboardTools-ObjectifyIntuneJsonReport` takes Intune report formatted JSON data from the clipboard and transforms it into a more "objectified" format.

**Description**:  
The `ClipboardTools-ObjectifyIntuneJsonReport` function processes Intune report formatted JSON data from the clipboard and converts it into a structured, "objectified" format. The transformed data is then placed back into the clipboard, ready for further processing or visualization. You can also send the processed data to the PowerShell pipeline with the `-PassThru` parameter.

One example for this kind of data is Intune Device Configuration information from Graph API.

**Usage**:
```powershell
ClipboardTools-ObjectifyIntuneJsonReport
```
```powershell
$IntuneReport = ClipboardTools-ObjectifyIntuneJsonReport -PassThru
```

**Parameters**:  
- `-PassThru`: If you wish to output the transformed JSON report data to the PowerShell pipeline, use this switch. This can be useful if you want to save the data to a variable or manipulate it further.

**Inputs**:  
Processes (Intune report format) JSON data taken directly from the clipboard.

**Outputs**:  
If the `-PassThru` parameter is utilized, the transformed Intune report JSON data is sent directly to the PowerShell pipeline.

---
### ClipboardTools-EdgeDebuggerMGGraphPowerShellScript

**Synopsis**:  
🔍 Convert Edge Debugger's "Save as PowerShell" export into actionable Microsoft Graph API commands! The `ClipboardTools-EdgeDebuggerMGGraphPowerShellScript` function helps transform the exported script into a "real" PowerShell script using the Microsoft.Graph.Authentication PowerShell module.

**Description**:  
The `ClipboardTools-EdgeDebuggerMGGraphPowerShellScript` function converts the PowerShell script generated from Edge Debugger's "Save as PowerShell" option into a fully functional PowerShell script that can interact with the Microsoft Graph API. This new version generates PowerShell code specifically for use with the `Microsoft.Graph.Authentication` module, enabling you to replicate the exact Graph API calls captured in the Edge Debugger. The resulting PowerShell code is then copied back to the clipboard, allowing you to paste it into your script editor or console.

This function parses essential parts of the Edge Debugger script, such as:
- The **URI** of the Graph API endpoint.
- The **HTTP method** (e.g., GET, POST, PATCH, DELETE).
- The **Body** (if applicable) for POST, PATCH, and PUT requests.

The output is tailored to work seamlessly with the Microsoft Graph PowerShell SDK. It includes handling for potential issues with POST requests that may not immediately return data, suggesting workarounds using `-OutputFilePath` to capture the response.

**Key Features**:
- **Purpose**: Converts the Edge Debugger PowerShell export into a script compatible with the Microsoft Graph Authentication PowerShell module.
- **Process**:
  - Extracts the clipboard content from the Edge Debugger.
  - Parses the URI, HTTP Method, and Body (if applicable).
  - Generates PowerShell commands to perform the exact Graph API request using `Invoke-MgGraphRequest`.
  - Automatically adds the necessary scopes for Microsoft Graph API authentication (`Connect-MgGraph`).
  - Outputs the generated script back to the clipboard, ready for immediate use.
  
**Prerequisites**:  
To execute the generated PowerShell script, ensure that the `Microsoft.Graph.Authentication` module is installed. Here's the command to install it:
```powershell
Install-Module -Name Microsoft.Graph.Authentication -Scope CurrentUser
```

**Usage**:
1. Open Edge and navigate to a web page where you want to extract a Graph API (or any REST API) call.
2. Open the Edge Debugger by pressing **F12** and navigate to the **Network** tab.
3. Perform an action that triggers a network request (such as loading a page or submitting a form).
4. Right-click on the network call you're interested in and select "**Copy -> Copy as PowerShell**".
5. Run the following command to transform the copied script:
```powershell
ClipboardTools-EdgeDebuggerMGGraphPowerShellScript
```
6. Paste the generated script into your editor or console.

**Inputs**:  
Reads the PowerShell script exported from Edge Debugger and stored in the clipboard.

**Outputs**:  
The function generates a PowerShell script ready for execution, based on the Microsoft Graph API call from Edge Debugger. The script is copied to the clipboard.

**Example Code for GET Request**:
```powershell
# Connect to Graph API using Microsoft Graph module

# Install Microsoft.Graph.Authentication module with command
# Install-Module -Name Microsoft.Graph.Authentication -Scope CurrentUser
#Connect-MgGraph

Connect-MgGraph -Scopes "DeviceManagementManagedDevices.Read.All", "DeviceManagementApps.Read.All", "DeviceManagementConfiguration.Read.All", "User.Read.All", "Group.Read.All", "GroupMember.Read.All", "Directory.Read.All"

$Uri = "https://graph.microsoft.com/v1.0/deviceManagement/managedDevices"

# Get data from Graph API
$MgGraphRequest = Invoke-MgGraphRequest -Uri $Uri -Method 'GET' -OutputType PSObject

if($MgGraphRequest) {
    # Print results
    # Usually you want to check values from $MgGraphRequest.value
    Write-Host "Print variable MgGraphRequest values:"
    $MgGraphRequest
} else {
    Write-Host "Did not get any results from Graph API!" -ForegroundColor Yellow
}
```

**Example Code for POST Request**:
```powershell
# Connect to Graph API using Microsoft Graph module

# Install Microsoft.Graph.Authentication module with command
# Install-Module -Name Microsoft.Graph.Authentication -Scope CurrentUser
#Connect-MgGraph

Connect-MgGraph -Scopes "DeviceManagementManagedDevices.Read.All", "DeviceManagementApps.Read.All", "DeviceManagementConfiguration.Read.All", "User.Read.All", "Group.Read.All", "GroupMember.Read.All", "Directory.Read.All"

$Uri = "https://graph.microsoft.com/v1.0/deviceManagement/managedDevices"

$Body = @{
    "@odata.type" = "#microsoft.graph.managedDevice"
    "deviceName" = "TestDevice"
} | ConvertTo-Json

# Note: POST requests may not immediately return data. Workaround:
$OutputFilePath = "$($pwd.path)/MgGraphRequest_$(Get-Random).json"
$MgGraphRequest = Invoke-MgGraphRequest -Uri $Uri -Body $Body.ToString() -Method 'POST' -OutputFilePath $OutputFilePath

# Read and convert JSON data from the temporary text file
$MgGraphRequest = Get-Content $OutputFilePath -Raw | ConvertFrom-Json

# Remove temporary file
Remove-Item -Path $OutputFilePath

if($MgGraphRequest) {
    # Print results
    Write-Host "Print variable MgGraphRequest values:"
    $MgGraphRequest
} else {
    Write-Host "Did not get any results from Graph API!" -ForegroundColor Yellow
}
```

---
## Author
**Petri Paavola**  
- Senior Modern Management Principal  
- Microsoft MVP - Windows and Intune
- Email: Petri.Paavola@yodamiitti.fi  

---

## Contributions

Contributions are welcome! If you find any issues or have suggestions, please open an issue in the [GitHub repository](https://github.com/petripaavola/ClipboardTools).

## License

This project is licensed under the MIT License. Check out the [license file](https://github.com/petripaavola/ClipboardTools/blob/main/LICENSE) for more details.

### Acknowledgments 🤖

A special shoutout to GPT-4 from OpenAI for being a trusty co-pilot in the creation of this GitHub documentation page. From PowerShell scripts to Graph API calls, AI lent a hand in refining and organizing every detail.

And yes, even the Acknowledgments were crafted by GPT-4 – AI doesn’t miss a beat, not even for the credits!

---

© 2024 Petri Paavola - Microsoft MVP - Windows and Intune
