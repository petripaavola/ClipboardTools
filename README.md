# Powershell ClipboardTools Module

Welcome to `ClipboardTools` — a treasure trove of meticulously crafted PowerShell functions designed to supercharge your Graph API scripting and data manipulation tasks. Developed by Petri Paavola, a seasoned Microsoft MVP - Windows and Devices, this module is equipped with diverse tools, each tailored to cater to specific needs — be it validating and formatting various data formats like JSON, xml, base64, or effortlessly interacting with the Microsoft Graph API.

Of particular note are the functions:
- [ClipboardTools-EdgeDebuggerGraphAPIExtractPowershellIntuneModule](#clipboardtools-edgedebuggergraphapiextractpowershellintunemodule)
- [ClipboardTools-EdgeDebuggerGraphAPIExtractPowershellMGGraphModule](#clipboardtools-edgedebuggergraphapiextractpowershellmggraphmodule)

These gems effortlessly convert copied PowerShell scripts from the Edge Debugger into actionable PowerShell script syntax. 

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

Next module version will have Powershell 7 uncompatible commands fixed.

### Functions

- [ClipboardTools-CopyPaste](#clipboardtools-copypaste)
- [ClipboardTools-CopyPasteUrl](#clipboardtools-copypasteurl)
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
- [ClipboardTools-ObjectifyIntuneJsonReport](#clipboardtools-objectifyintunejsonreport)
- [ClipboardTools-EdgeDebuggerGraphAPIExtractPowershellIntuneModule](#clipboardtools-edgedebuggergraphapiextractpowershellintunemodule)
- [ClipboardTools-EdgeDebuggerGraphAPIExtractPowershellMGGraphModule](#clipboardtools-edgedebuggergraphapiextractpowershellmggraphmodule)

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
### ClipboardTools-EdgeDebuggerGraphAPIExtractPowershellIntuneModule

**Synopsis**:  
🔍 Directly interact with the Microsoft Graph API without the fuss! Use the `ClipboardTools-EdgeDebuggerGraphAPIExtractPowershellIntuneModule` to convert Edge Debugger's "Save as PowerShell" script to real, working PowerShell script syntax.

**Description**:  
The `ClipboardTools-EdgeDebuggerGraphAPIExtractPowershellIntuneModule` function assists you in transforming the Edge Debugger's "Save as PowerShell" script into an actual, operational PowerShell script. This tool is invaluable when extracting or inputting data to the Microsoft Graph API.

Upon processing, the newly crafted PowerShell code, which is compatible with the `Microsoft.Graph.Intune` PowerShell module, is copied back to your clipboard, ready for execution or further editing.

**Features**:  
   - **Purpose**: Converts Edge Debugger's clipboard saved PowerShell script to a usable script tailored for Microsoft's Intune PowerShell module.
   - **Operation**:
     - Reads clipboard content.
     - Distills the URI, Method (HTTP verb), and Body from the script.
     - Depending on the Method and the presence of a Body, crafts a new script to connect to the Graph API via the Microsoft Intune module. This process includes establishing a connection, forming the API request, and outputting the results.
     - Sends the polished script to the clipboard, prepped to be pasted into an editor or console.

**Note**: To successfully execute the resulting script, ensure you've installed the Intune PowerShell Module.

**Prerequisites**:  
To execute the created PowerShell code, you need to install the Intune PowerShell Module:
```powershell
Install-Module -Name Microsoft.Graph.Intune -Scope CurrentUser
```

**Usage**:
- Open Edge and go www page you want to extract Graph API call (or actually any REST API calls) from.  
- Any Intune management page is good to start with.  
- **F12** opens Edge Debugger
- In Edge Debugger open Network tab
- Click link to page where to capture network traffic
- Find network call you are interested on and right click on it and select "**Copy -> Copy as Powershell**"

```powershell
ClipboardTools-EdgeDebuggerGraphAPIExtractPowershellIntuneModule
```

**Inputs**:  
The function reads the Edge Debugger "Save as PowerShell" script directly from your clipboard.

**Outputs**:  
The transformed, runnable PowerShell code is placed back into your clipboard.

---
### ClipboardTools-EdgeDebuggerGraphAPIExtractPowershellMGGraphModule

**Synopsis**:  
🔍 Simplify your Microsoft Graph API interactions in PowerShell! With the `ClipboardTools-EdgeDebuggerGraphAPIExtractPowershellMGGraphModule`, convert Edge Debugger's "Save as PowerShell" scripts into real, actionable PowerShell commands.

**Description**:  
The `ClipboardTools-EdgeDebuggerGraphAPIExtractPowershellMGGraphModule` function acts as an enabler, converting scripts you extract from the Edge Debugger into fully-fledged PowerShell code. This is more than just a translation – it prepares the code to perform Graph API operations, mirroring those captured in the Debugger.

Importantly, the generated code is designed for seamless integration with the `Microsoft.Graph` PowerShell module. Ensure the Microsoft.Graph module is at your disposal before executing the crafted script.

**Key Features**:
   - **Purpose**: Transforms Edge Debugger's exported PowerShell scripts into actionable scripts, optimized for the Microsoft Graph PowerShell module.
   - **Process**:
     - Captures clipboard content.
     - Identifies the URI, Method (HTTP verb), and Body from the acquired script.
     - Forges a new script connecting to the Graph API via the Microsoft Graph module. This encompasses establishing the connection, navigating certain quirks like POST requests sometimes not producing output, creating the API request, and rendering the results.
     - Transmits the newly minted script back to the clipboard.

**Prerequisites**:  
For the generated PowerShell script to operate flawlessly, the installation of the `Microsoft.Graph` module is a prerequisite. Here's the command to add it:
```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
```

**Usage**:
- Open Edge and go www page you want to extract Graph API call (or actually any REST API calls) from.  
- Any Intune management page is good to start with.  
- **F12** opens Edge Debugger
- In Edge Debugger open Network tab
- Click link to page where to capture network traffic
- Find network call you are interested on and right click on it and select "**Copy -> Copy as Powershell**"
```powershell
ClipboardTools-EdgeDebuggerGraphAPIExtractPowershellMGGraphModule
```

**Inputs**:  
Feeds on the "Save as PowerShell" script directly copied from Edge Debugger and stored in your clipboard.

**Outputs**:  
Your clipboard will be replenished with a refashioned, execution-ready PowerShell script.

---
## Author
**Petri Paavola**  
- Senior Modern Management Principal  
- Microsoft MVP - Windows and Devices
- Email: Petri.Paavola@yodamiitti.fi  

---

## Contributions

Contributions are welcome! If you find any issues or have suggestions, please open an issue in the [GitHub repository](https://github.com/petripaavola/ClipboardTools).

## License

This project is licensed under the MIT License. Check out the [license file](https://github.com/petripaavola/ClipboardTools/blob/main/LICENSE) for more details.

### Acknowledgments 🤖
A special shoutout to GPT-4 from OpenAI for assisting in the creation of this GitHub documentation page. Yes, even in the world of PowerShell and APIs, AI finds a way to chip in!  

And yes, Acknowledgments texts were also created by GPT-4 :)

---

© 2023 Petri Paavola - Microsoft MVP - Windows and Devices
