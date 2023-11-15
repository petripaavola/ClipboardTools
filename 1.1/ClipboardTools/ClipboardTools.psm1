<#
.Synopsis
   This function gets clipboard data and sets it back to clipboard removing any metadata

.DESCRIPTION
	This function gets clipboard data and sets it back to clipboard.

	This trick should remove metadata from clipboard data.
	For example from http smartlinks it will paste full url instead of url smartlink (url name and url)


	Author:
	Petri.Paavola@yodamiitti.fi
	Senior Modern Management Principal
	Microsoft MVP - Windows and Devices

	2023-09-24

	https://github.com/petripaavola/ClipboardTools

.PARAMETER PassThru
	PassThru parameter will also output clipboard data to Powershell pipeline.
	Usually this is used with saving results to variable.
	For example
	$FromClipboard = ClipboardTools-CopyPaste -PassThru

.EXAMPLE
	ClipboardTools-CopyPaste
   
.EXAMPLE
	$FromClipboard = ClipboardTools-CopyPaste -PassThru

.INPUTS
	Reads clipboard data

.OUTPUTS
	Outputs data to clipboard
	With parameter -PassThru output is sent to Powershell pipeline

.NOTES
	None

.LINK
	https://github.com/petripaavola/ClipboardTools
#>
Function ClipboardTools-CopyPaste {
	[CmdletBinding()]
    Param (
		[Parameter(Mandatory=$false)]
		[Switch]$PassThru
    )

	
	if(Get-Clipboard) {
		Get-Clipboard | Set-Clipboard
		
		if(-not $PassThru) {
			Write-Host "Clipboard ready to paste:" -Foregroundcolor Green
			Get-Clipboard
		}
	} else {
		Write-Host "Clipboard was empty" -ForeGroundColor Yellow
		return $null
	}
	
	if($PassThru) {
		return Get-Clipboard
	}
}


<#
.Synopsis
	This function extracs smart html link's title and url and pastes them back to clipboard

.DESCRIPTION
	This function extracs smart html link's title and url and
	pastes them back to clipboard in 2 separate lines
	
	This is good trick to paste smart html link title and url separately to document.


	Author:
	Petri.Paavola@yodamiitti.fi
	Senior Modern Management Principal
	Microsoft MVP - Windows and Devices

	2023-09-24

	https://github.com/petripaavola/ClipboardTools

.EXAMPLE
	ClipboardTools-CopyPasteUrl

.INPUTS
	Reads clipboard data

.OUTPUTS
	Outputs extracted smart html link's title and url to clipboard

.NOTES
   None

.LINK
   https://github.com/petripaavola/ClipboardTools
#>
Function ClipboardTools-CopyPasteUrl {

	# Example string in Array
	# <!--StartFragment--><a href="https://learn.microsoft.com/en-us/powershell/module/psreadline/about/about_psreadline?source=recommendations&amp;view=powershell-7.3">about PSReadLine - PowerShell | Microsoft Learn</a><!--EndFragment-->

	$Clipboard = Get-Clipboard -TextFormatType Html

	# Get line containing html fragment using normal Array filtering
	$HtmlFragment = $Clipboard | Where-Object { $_ -like "<!--StartFragment-->*<!--EndFragment-->" }

	if($HtmlFragment) {
		# Use -Match (regex) to extract Title and Url
		# Test regex in https://regex101.com
		# Using String:
		# <!--StartFragment--><a href="https://learn.microsoft.com/en-us/powershell/module/psreadline/about/about_psreadline?source=recommendations&amp;view=powershell-7.3">about PSReadLine - PowerShell | Microsoft Learn</a><!--EndFragment-->
		
		$Matches = $null
		$regex = '^<!--StartFragment--><a href="(.*)">(.*)<\/a><!--EndFragment-->$'
		if($HtmlFragment -Match $regex) {
			$Topic = $Matches[2]
			Set-Clipboard $Topic

			$url = $Matches[1]
			Set-Clipboard $url -Append
			
			Write-Host "Clipboard ready to paste:" -Foregroundcolor Green
			Get-Clipboard
		} else {
			Write-Host "Warning: did not find url type clipboard information" -Foregroundcolor Yellow
		}
	} else {
		Write-Host "Did not find url type clipboard information" -Foregroundcolor Yellow
	}
}


<#
.Synopsis
	This function creates new GUID and copies it to clipboard

.DESCRIPTION
	This function creates new GUID and copies it to clipboard.
	
	You can then paste it to anywhere.


	Author:
	Petri.Paavola@yodamiitti.fi
	Senior Modern Management Principal
	Microsoft MVP - Windows and Devices

	2023-09-24

	https://github.com/petripaavola/ClipboardTools

.EXAMPLE
	ClipboardTools-NewGuidToClipboard

.INPUTS
	Reads clipboard data

.OUTPUTS
	Outputs new GUID to clipboard

.NOTES
   None

.LINK
   https://github.com/petripaavola/ClipboardTools
#>	
Function ClipboardTools-NewGuidToClipboard {

     $Guid = (New-Guid).Guid
     $Guid | Set-Clipboard
     $Success = $?
     if($Success) {
          Write-Host "$Guid copied to clipboard" -ForegroundColor Green
     }
}


<#
.Synopsis
	This function reads JSON data from clipboard and sets uncompressed JSON back to clipboard

.DESCRIPTION
	This function reads JSON data from clipboard and sets uncompressed JSON back to clipboard
	
	This is good trick to extract compressed JSON and also do JSON syntax validation.

	Conversion checks that JSON syntax is valid at the same time.

	With -PassThru parameter converted JSON data is sent to Powershell pipeline
	and can be saved to Powershell variable.


	Author:
	Petri.Paavola@yodamiitti.fi
	Senior Modern Management Principal
	Microsoft MVP - Windows and Devices

	2023-09-24

	https://github.com/petripaavola/ClipboardTools

.PARAMETER PassThru
	PassThru parameter will also output converted JSON data to Powershell pipeline.
	Usually this is used with saving results to variable.
	For example
	$FromJson = ClipboardTools-JsonUncompress -PassThru
	
.PARAMETER RemovePowershellEscapes
	Remove Powershell escape character ` from JSON before converting data
	We can get escaped JSON for example from Edge Debugger
	This is for special cases

.PARAMETER RemoveDoubleJsonEscapes
	Replace double JSON escape \\\\ to \\ from JSON data before converting JSON
	This is super rare case but sometimes when original JSON data
	has nested JSON data in properties they get double escaped
	which causes problems later.
	
.EXAMPLE
	ClipboardTools-JsonUncompress
	
.EXAMPLE
	$FromJson = ClipboardTools-JsonUncompress -PassThru
	
.EXAMPLE
	ClipboardTools-JsonUncompress -RemovePowershellEscapes

.EXAMPLE
	ClipboardTools-JsonUncompress -RemoveDoubleJsonEscapes
	
.INPUTS
	Reads clipboard JSON data

.OUTPUTS
	Outputs syntax checked and uncompressed JSON to clipboard

.NOTES
   None

.LINK
   https://github.com/petripaavola/ClipboardTools
#>
Function ClipboardTools-JsonUncompress {
    Param (
		[Parameter(Mandatory=$false)]
		[Switch] $PassThru,
		[Parameter(Mandatory=$false)]
		[Switch] $RemovePowershellEscapes,
		[Parameter(Mandatory=$false)]
		[Switch] $RemoveDoubleJsonEscapes
    )

	$Clipboard = Get-Clipboard

	if($Clipboard) {
		# Remove Powershell ` escape characters
		if($RemoveEscapes) {
			$Clipboard = $Clipboard.Replace('`','')
		}

		# Remove Json double escapes \\\\ -> \\
		if($RemoveDoubleJsonEscapes) {
			$Clipboard = $Clipboard -replace('\\\\', '\\')
		}

		# Convert Clipboard Json data to variable
		Try {
			$json = $Clipboard | ConvertFrom-Json
			$Success = $?
			
			if($Success) {
				$json | ConvertTo-Json -Depth 10 | Set-Clipboard
				
				if($PassThru) {
					return $json
				} else {
					Write-Host "Paste uncompressed JSON to text editor with Ctrl-v" -Foregroundcolor Green	
				}
			} else {
				Write-Host "Warning: Could not convert JSON data from clipboard" -ForegroundColor Yellow
			}
			
		} Catch {
			Write-Host "Warning: Clipboard data is not valid JSON" -ForegroundColor Yellow
			return $null
		}

	} else {
		Write-Host "Clipboard was empty" -ForeGroundColor Yellow
	}
}


<#
.Synopsis
	This function reads JSON data from clipboard and puts compressed JSON back to clipboard

.DESCRIPTION
	This function reads JSON data from clipboard and puts compressed JSON back to clipboard
	
	Conversion also checks that JSON syntax is valid.

	With -PassThru parameter compressed JSON data is sent to Powershell pipeline
	and can be saved to Powershell variable.


	Author:
	Petri.Paavola@yodamiitti.fi
	Senior Modern Management Principal
	Microsoft MVP - Windows and Devices

	2023-09-24

	https://github.com/petripaavola/ClipboardTools

.PARAMETER PassThru
	PassThru parameter will also output converted JSON data to Powershell pipeline.
	Usually this is used with saving results to variable.
	For example
	$CompressedJson = ClipboardTools-JsonCompress -PassThru
	
.EXAMPLE
	ClipboardTools-JsonCompress
	
.EXAMPLE
	$FromJson = ClipboardTools-JsonCompress -PassThru
	
.INPUTS
	Reads clipboard JSON data

.OUTPUTS
	Outputs syntax checked and compressed JSON to clipboard

.NOTES
   None

.LINK
   https://github.com/petripaavola/ClipboardTools
#>
Function ClipboardTools-JsonCompress {
    Param (
		[Parameter(Mandatory=$false)]
		[Switch] $PassThru
    )

	$Clipboard = Get-Clipboard

	if($Clipboard) {

		# Convert Compressed Clipboard Json data to variable
		Try {
			$json = $Clipboard | ConvertFrom-Json
			$Success = $?
			
			if($Success) {
				$json | ConvertTo-Json -Depth 10 -Compress | Set-Clipboard
				
				if($PassThru) {
					return $json
				} else {
					Write-Host "Paste compressed JSON to text editor with Ctrl-v" -Foregroundcolor Green	
				}
			} else {
				Write-Host "Warning: Could not convert JSON data from clipboard" -ForegroundColor Yellow
			}
			
		} Catch {
			Write-Host "Warning: Clipboard data is not valid JSON" -ForegroundColor Yellow
			return $null
		}

	} else {
		Write-Host "Clipboard was empty" -ForeGroundColor Yellow
	}
}


<#
.Synopsis
	This function reads image from clipboard and saves image to image file

.DESCRIPTION
	This function reads image from clipboard and saves image to image file
	
	You can specify filename and folder with parameters -FileName and -FilePath
	
	By default file is saved to current directory and filename is {timestamp}-ImageCapture
	Example Filename: 20230922-ImageCapture.png
	
	Timestamp is always added before FileName.

	With parameter -OpenFileAfterSave file is opened to default image viewer application


	Author:
	Petri.Paavola@yodamiitti.fi
	Senior Modern Management Principal
	Microsoft MVP - Windows and Devices

	2023-09-24

	https://github.com/petripaavola/ClipboardTools

.PARAMETER FileName
	FileName for saved image
	
.PARAMETER FilePath
	FilePath for saved image

.PARAMETER OpenImageAfterSave
	Opens saved image in default image application
	
.EXAMPLE
	ClipboardTools-SaveImageToFile
	
.EXAMPLE
	ClipboardTools-SaveImageToFile -Name 'ImageFileName'

.EXAMPLE
	ClipboardTools-SaveImageToFile -Name 'ImageFileName' -FilePath D:\ScreenCaptures
	
.EXAMPLE
	ClipboardTools-SaveImageToFile -OpenFileAfterSave
	
.INPUTS
	Reads clipboard picture data

.OUTPUTS
	Outputs image to file

.NOTES
   None

.LINK
   https://github.com/petripaavola/ClipboardTools
#>
Function ClipboardTools-SaveImageToFile {
	Param(
		[Parameter(Mandatory=$false)]
		$FileName = 'ImageCapture',
		[Parameter(Mandatory=$false)]
		$FilePath,
		[Parameter(Mandatory=$false)]
		[switch]$OpenFileAfterSave
	)
	
	# Get image from clipboard
	$ImageFromClipboard = Get-Clipboard -Format Image

	if($ImageFromClipboard) {

		# Set image path, timestamp and filename to saved image file
		$timestamp = Get-Date -Format yyyyMMdd-HHmmss
		
		# Set current path for FilePath if parameter was not specified
		if(-not $FilePath) {
			 $FilePath = $pwd.Path
		}
		
		
		# Check if destination folder exists
		if(-not (Test-Path $FilePath)) {
			Write-Host "Warning: destination directory $FilePath does not exist!" -ForegroundColor Yellow
			Write-Host "Defaulting to current folder $($pwd.Path)"
			$FilePath = $pwd.Path
		}

		$FileSavePath = "$($FilePath)\$($timestamp)-$($FileName).png"
		$ImageFromClipboard.Save($FileSavePath)
		$Success = $?
		
		if($Success) {
			Write-Host "Successfully saved file: $FileSavePath" -ForegroundColor Green
			
			if($OpenFileAfterSave) {
				Write-Host "Opening image to default image application`n"
				
				# Sleep 1 seconds to make sure image file is saved to folder
				# For example saving to slow USB drive may take some time to complete
				Start-Sleep -Seconds 1

				if(Test-Path $FileSavePath) {
					# Open image to default image application
					Invoke-Item $FileSavePath
				} else {
					Write-Host "Warning: File save was not completed before opening image" -ForeGroundColor Yellow
					Write-Host "Skipping image opening...`n"
				}
			}
		} else {
			Write-Host "Failed to save file: $FileSavePath`n" -ForegroundColor Red
		}
	} else {
		Write-Host "Did not detect image from clipboard`n" -ForeGroundColor Yellow
	}
}


<#
.Synopsis
	This function reads text from clipboard and saves text to text file

.DESCRIPTION
	This function reads text from clipboard and saves text to text file
	
	You can specify filename and folder with parameters -FileName and -FilePath
	
	Default FileName is textfile.txt and default FilePath is current working directory
	
	With parameter -Append you can add text data to (new or) existing files
	
	With parameter -Force you can overwrite existing file
	
	With parameter -OpenFileAfterSave file is opened to default text editor


	Author:
	Petri.Paavola@yodamiitti.fi
	Senior Modern Management Principal
	Microsoft MVP - Windows and Devices

	2023-09-24

	https://github.com/petripaavola/ClipboardTools

.PARAMETER FileName
	FileName for saved text file
	
.PARAMETER FilePath
	FilePath for saved text file

.PARAMETER Append
	Append text to existing file or create new text file

.PARAMETER Force
	Overwrite existing file

.PARAMETER OpenFileAfterSave
	Opens saved text file in default text editor
	
.EXAMPLE
	ClipboardTools-SaveTextToFile
	
.EXAMPLE
	ClipboardTools-SaveTextToFile -Name 'TextFile.txt'

.EXAMPLE
	ClipboardTools-SaveTextToFile -Name 'TextFile.txt' -FilePath D:\temp
	
.EXAMPLE
	ClipboardTools-SaveTextToFile -OpenFileAfterSave

.EXAMPLE
	ClipboardTools-SaveTextToFile -Name 'TextFile.txt' -FilePath D:\temp -Append

.EXAMPLE
	ClipboardTools-SaveTextToFile -Name 'TextFile.txt' -FilePath D:\temp -Force
	
.INPUTS
	Reads clipboard text data

.OUTPUTS
	Outputs clipboard text to file

.NOTES
   None

.LINK
   https://github.com/petripaavola/ClipboardTools
#>
Function ClipboardTools-SaveTextToFile {
	Param(
		[Parameter(Mandatory=$false)]
		$FileName = 'textfile.txt',
		[Parameter(Mandatory=$false)]
		$FilePath,
		[Parameter(Mandatory=$false)]
		[Switch]$Append,
		[Parameter(Mandatory=$false)]
		[Switch]$Force,
		[Parameter(Mandatory=$false)]
		[switch]$OpenFileAfterSave
	)
	
	# Get Clipboard text
	$TextFromClipboard = Get-Clipboard -Format Text

	if($TextFromClipboard) {
		if(-not $FilePath) {
			 $FilePath = $pwd.Path
		}
		
		$FileSavePath = "$FilePath\$FileName"
		
		if(((Test-Path $FileSavePath) -and (-not $Force)) -and ((Test-Path $FileSavePath) -and (-not $Append))){
			Write-Host "Warning: Destination file already exists and -Force or -Append parameter NOT specified." -ForeGroundColor Yellow
			Write-Host "Will not overwrite file $filePath`n"
		} else {
			if($Append) {
				# Append clipboard text to possible existing file
				$TextFromClipboard | Add-Content -Path $FileSavePath
				$Success = $?
				
				if($Success) {
					Write-Host "Successfully appended text to file: $FileSavePath`n" -ForegroundColor Green
				} else {
					Write-Host "Failed to append text to file: $FileSavePath`n" -ForegroundColor Red
				}
			} elseif ($Force -and (-not $Append)) {
				# Overwrite possible existing files
				$TextFromClipboard | Set-Content -Path $FileSavePath -Force
				$Success = $?
				
				if($Success) {
					Write-Host "Successfully saved file: $FileSavePath`n" -ForegroundColor Green
				} else {
					Write-Host "Failed to save file: $FileSavePath`n" -ForegroundColor Red
				}
			} else {
				$TextFromClipboard | Set-Content -Path $FileSavePath
				$Success = $?
				
				if($Success) {
					Write-Host "Successfully saved file: $FileSavePath`n" -ForegroundColor Green
				} else {
					Write-Host "Failed to save file: $FileSavePath`n" -ForegroundColor Red
				}
			}
			
			Start-Sleep -Seconds 1
			
			Write-Host "Opening text file to default text editor`n"
				
			# Sleep 1 seconds to make sure text file is saved to folder
			# For example saving to slow USB drive may take some time to complete
			if($OpenFileAfterSave) {
				if(Test-Path $FileSavePath) {
					# Open text file to default text editor
					Invoke-Item $FileSavePath				
				} else {
					Write-Host "Warning: File save was not completed before opening" -ForeGroundColor Yellow
					Write-Host "Skipping text file opening...`n"
				}
			}
		}
	} else {
		Write-Host "Did not detect text from clipboard`n" -ForeGroundColor Yellow
	}
}


<#
.Synopsis
	This function sorts text in clipboard either ascending (default) or descending order

.DESCRIPTION
	This function sorts text in clipboard either ascending (default) or descending order

	With parameter -Descending you can set descending sort


	Author:
	Petri.Paavola@yodamiitti.fi
	Senior Modern Management Principal
	Microsoft MVP - Windows and Devices

	2023-09-24

	https://github.com/petripaavola/ClipboardTools

.PARAMETER Descending
	Sort clipboard text descending
	
.EXAMPLE
	ClipboardTools-Sort
	
.EXAMPLE
	ClipboardTools-Sort -Descending

.INPUTS
	Reads clipboard text data

.OUTPUTS
	Outputs sorted clipboard text back to clipboard

.NOTES
   None

.LINK
   https://github.com/petripaavola/ClipboardTools
#>
Function ClipboardTools-Sort {
	Param(
		[Parameter(Mandatory=$false)]
		[Switch]$Descending = $false
	)
	
	if(Get-Clipboard  -Format Text) {
		if(-not $Descending) {
			Get-Clipboard  -Format Text| Sort-Object | Set-Clipboard
			$Success = $?
		} else {
			Get-Clipboard  -Format Text| Sort-Object -Descending | Set-Clipboard	
			$Success = $?
		}
				
		if($Success) {
			if($Descending) {
				Write-Host "Clipboard text is now sorted in descending order`n" -ForegroundColor Green
			} else  {
				Write-Host "Clipboard text is now sorted`n" -ForegroundColor Green
			}
		} else {
			Write-Host "Failed to sort Clipboard text`n" -ForegroundColor Red
		}
		
	} else {
		Write-Host "Clipboard did not contain any text`n" -ForeGroundColor Yellow
	}
}


<#
.Synopsis
	This function checks if clipboard text has valid JSON syntax

.DESCRIPTION
	This function checks if clipboard text has valid JSON syntax


	Author:
	Petri.Paavola@yodamiitti.fi
	Senior Modern Management Principal
	Microsoft MVP - Windows and Devices

	2023-09-24

	https://github.com/petripaavola/ClipboardTools

.EXAMPLE
	ClipboardTools-ValidateJson
	
.INPUTS
	Reads clipboard text

.OUTPUTS
	None

.NOTES
   None

.LINK
   https://github.com/petripaavola/ClipboardTools
#>
Function ClipboardTools-ValidateJson {

	# Read Clipboard text
	$ClipboardText = Get-Clipboard -Format Text
	
	if($ClipboardText) {
		try {
			$json = $ClipboardText | ConvertFrom-Json
			$Success = $?
			
			if($Success) {
				Write-Host "Clipboard text has valid JSON syntax" -ForegroundColor Green
			} else {
				Write-Host "Clipboard text is NOT valid JSON syntax" -ForegroundColor Red
			}
		} catch {
			Write-Host "Clipboard text is NOT valid JSON syntax" -ForegroundColor Red
		}
	} else {
		Write-Host "Clipboard did not contain any text`n" -ForeGroundColor Yellow
	}
}


<#
.Synopsis
	This function checks if XML file in clipboard has valid xml syntax

.DESCRIPTION
	This function checks if XML file in clipboard has valid xml syntax

	With parameter -PassThru converted XML is sent to Powershell pipeline
	and can be saved to Powershell variable.	


	Author:
	Petri.Paavola@yodamiitti.fi
	Senior Modern Management Principal
	Microsoft MVP - Windows and Devices

	2023-09-24

	https://github.com/petripaavola/ClipboardTools

.PARAMETER PassThru
	PassThru parameter outputs converted XML text to Powershell pipeline.
	Usually this is used with saving results to variable.

.EXAMPLE
	ClipboardTools-ValidateXml
	
.EXAMPLE
	$xml = ClipboardTools-ValidateXml -PassThru
	
.INPUTS
	Reads clipboard data

.OUTPUTS
	With parameter -PassThru converted XML is sent to Powershell pipeline.

.NOTES
   None

.LINK
   https://github.com/petripaavola/ClipboardTools
#>
Function ClipboardTools-ValidateXml {
	Param(
		[Parameter(Mandatory=$false)]
		[Switch]$PassThru
	)
	
	# Read Clipboard text
	$ClipboardText = Get-Clipboard -Format Text
	
	if($ClipboardText) {
		try {
			[xml]$xml = $ClipboardText
			$Success = $?
			
			if($Success) {
				Write-Host "Clipboard text has valid XML syntax" -ForegroundColor Green
				
				if($PassThru) {
					return $xml
				}
			} else {
				Write-Host "Clipboard text is NOT valid XML syntax" -ForegroundColor Red
			}
		} catch {
			Write-Host "Clipboard text is NOT valid XML syntax`n" -ForegroundColor Red
			Write-Host "$($_.Exception.Message)" -ForegroundColor Red
		}
	} else {
		Write-Host "Clipboard did not contain any text`n" -ForeGroundColor Yellow
	}
}


<#
.Synopsis
	This function checks if Powershell script copied to clipboard has valid Powershell syntax

.DESCRIPTION
	This function checks if Powershell script copied to clipboard has valid Powershell syntax
	
	This is done by using command: Get-Command -Syntax temporary_scriptfile.ps1

	Text/Powershell script from clipboard is saved to temporary file in TEMP directory
	Powershell Syntax check is done to this temporary .ps1 file
	Temporary file is deleted after syntax check.
	
	This will NOT run the script.
	

	Author:
	Petri.Paavola@yodamiitti.fi
	Senior Modern Management Principal
	Microsoft MVP - Windows and Devices

	2023-09-24

	https://github.com/petripaavola/ClipboardTools

.EXAMPLE
	ClipboardTools-ValidatePowershellSyntax
	
.INPUTS
	Reads Powershell script from clipboard

.OUTPUTS
	None
	But script will create temporary Powershell script file to $env:temp which is deleted after syntax check

.NOTES
   None

.LINK
   https://github.com/petripaavola/ClipboardTools
#>
Function ClipboardTools-ValidatePowershellSyntax {
	# Copy Clipboard text
	$PowershellScriptFromClipboard = Get-Clipboard -Format Text

	if($PowershellScriptFromClipboard) {

		# Copy file to temp directory and run it from there
		$PowershellScriptPath = "$env:Temp\TestPowershellScriptSyntax_$((New-Guid).Guid).ps1"
		$PowershellScriptFromClipboard | Out-String | Set-Content -Path $PowershellScriptPath
		$Success = $?

		if($Success) {
			# Do Powershell syntax check to temporary Powershell file
			$GetCommand = Get-Command -Syntax $PowershellScriptPath
			$Success = $?

			if($Success) {
				Write-Host "Powershell syntax is valid`n" -ForegroundColor Green
			} else {
				Write-Host "Powershell syntax is NOT valid`n" -ForegroundColor Red
			}

			# Delete Powershell script from Temp folder
			Remove-Item -Path $PowershellScriptPath -Force
		} else {
			Write-Host "Something went wrong when saving temporary file: $PowershellScriptPath" -ForeGroundColor Red
			Write-Host "Powershell syntax validation was aborted" -ForeGroundColor Yellow
		}
	} else {
		Write-Host "Clipboard did not contain any text`n" -ForeGroundColor Yellow
	}
}


<#
.Synopsis
	This function converts base64 encoded text in clipboard to clear text

.DESCRIPTION
	This function converts base64 encoded text in clipboard to clear text
	and copies converted text back to clipboard
	
	
	Author:
	Petri.Paavola@yodamiitti.fi
	Senior Modern Management Principal
	Microsoft MVP - Windows and Devices

	2023-09-24

	https://github.com/petripaavola/ClipboardTools

.PARAMETER PassThru
	PassThru parameter will output converted base64 text to Powershell pipeline.
	Usually this is used with saving results to variable.

.EXAMPLE
	ClipboardTools-ConvertFromBase64
	
.EXAMPLE
	$ClearTextFromBase64 = ClipboardTools-ConvertFromBase64 -PassThru

.INPUTS
	Reads clipboard base64 text and converts it to clear text

.OUTPUTS
	Converted base64 text is copied to clipboard
	With parameter -PassThru converted base64 text is sent to Powershell pipeline.

.NOTES
   None

.LINK
   https://github.com/petripaavola/ClipboardTools
#>
Function ClipboardTools-ConvertFromBase64 {
	Param(
		[Parameter(Mandatory=$false)]
		[Switch]$PassThru
	)

	[String]$Base64 = Get-Clipboard -Format Text
	$Success = $?
	
	if($Success) {
		if($Base64) {
			$ConvertedString = [Text.Encoding]::Utf8.GetString([Convert]::FromBase64String($Base64))
			$Success = $?
			if($Success) {
				Write-Host "Converted base64 is copied to clipboard`n" -ForegroundColor Green
				$ConvertedString | Set-Clipboard
				
				if($PassThru) {
					return $ConvertedString
				}
			} else {
				Write-Host "Error converting from base64`n" -ForegroundColor Red
			}
		} else {
			Write-Host "Clipboard did not contain any data to convert`n" -ForeGroundColor Yellow
		}
	} else {
		Write-Host "Clipboard did not contain any data to convert`n" -ForeGroundColor Yellow
	}		
}


<#
.Synopsis
	This function converts Intune report format JSON from clipboard to "objectified" data

.DESCRIPTION
	This function converts Intune report format JSON from clipboard to "objectified" data
	and then sets converted JSON report back to clipboard
	
	With parameter -PassThru processed JSON report data is sent to Powershell pipeline
	where you can for example save data to variable
	
	
	Author:
	Petri.Paavola@yodamiitti.fi
	Senior Modern Management Principal
	Microsoft MVP - Windows and Devices

	2023-09-24

	https://github.com/petripaavola/ClipboardTools

.EXAMPLE
	ClipboardTools-ObjectifyIntuneJsonReport
	
.EXAMPLE
	$IntuneReport = ClipboardTools-ObjectifyIntuneJsonReport -PassThru

.INPUTS
	Reads clipboard (Intune report format) JSON data

.OUTPUTS
	With parameter -PassThru processed Intune report JSON data is sent to Powershell pipeline.

.NOTES
   None

.LINK
   https://github.com/petripaavola/ClipboardTools
#>
function ClipboardTools-ObjectifyIntuneJsonReport {
	Param(
		[Parameter(Mandatory=$false)]
		[Switch]$PassThru
	)

	# Read Clipboard text
	$ClipboardJSON = Get-Clipboard -Format Text
	
	if($ClipboardJSON) {
		try {
			$json = $ClipboardJSON | ConvertFrom-Json
			$Success = $?
			
			if($Success) {
				Write-Host "Clipboard text has valid JSON syntax" -ForegroundColor Green
				
				if($Json.Schema) {
					$JsonSchema = $Json.Schema
				} else {
					Write-Host "Warning: Did not detect valid Intune/Graph API report formatted JSON data" -ForeGroundColor Yellow
					Write-Host "Warning: Schema property missing." -ForeGroundColor Yellow
					return $null
				}

				if($Json.Values) {
					$JsonValues = $Json.Values
				} else {
					Write-Host "Warning: Did not detect valid Intune/Graph API report formatted JSON data" 
					Write-Host "Warning: Values property missing." -ForeGroundColor Yellow
					return $null
				}
				

				# Create empty arrayList
				# ArrayList should be quicker if we have a huge data set
				# because using array and += always creates new array with added array value/object
				$JsonObjectArrayList = New-Object -TypeName "System.Collections.ArrayList"

				# Convert json data to Powershell objects in $JsonObjectArrayList
				foreach($Value in $JsonValues) {
					# We use this counter to get property name value from Schema array
					$i=0

					# Add values to HashTable which we use to create custom Powershell object later
					$ValuesHashTable = @{}

					foreach($ValueEntry in $Value) {
						# Create variables
						$PropertyName = $JsonSchema[$i].Column
						$ValuePropertyType = $JsonSchema[$i].PropertyType
						$PropertyValue = $ValueEntry -as $ValuePropertyType
						
						# Add hashtable entry
						$ValuesHashTable.add($PropertyName, $PropertyValue)

						# Create Powershell custom object from hashtable
						$CustomObject = new-object psobject -Property $ValuesHashTable
						
						$i++
					}

					# Add custom Powershell object to ArrayList
					$JsonObjectArrayList.Add($CustomObject) | Out-Null
				}

				# Set processed report JSON data to clipboard
				$JsonObjectArrayList | ConvertTo-Json -Depth 10 | Set-Clipboard
				
				if($PassThru) {
					$JsonObjectArrayList
				}
			} else {
				Write-Host "Clipboard text is NOT valid JSON syntax" -ForegroundColor Red
			}
		} catch {
			Write-Host "Clipboard text is NOT valid JSON syntax" -ForegroundColor Red
		}
	} else {
		Write-Host "Clipboard did not contain any text`n" -ForeGroundColor Yellow
	}
}


<#
.Synopsis
	This function converts Edge Debugger Save as Powershell -script to "real" Powershell script syntax

.DESCRIPTION
	This function converts Edge Debugger Save as Powershell -script to "real" Powershell script syntax
	
	This function version creates Microsoft.Graph.Intune Powershell Module compatible code.
	
	"Real" Powershell syntax means real Powershell commands you can use in your scripts.
	Commands will do same Graph API call which you copied from Edge debugger data.
	
	Converted commands are set to clipboard so you can paste actual Powershell code to your code editor.
	And you can also run Powershell commands in Powershell console.
	
	Prerequisite for created Powershell code to work you need to install Intune Powershell Module

	You can install module with command:
	Install-Module -Name Microsoft.Graph.Intune -Scope CurrentUser
	
	
	Author:
	Petri.Paavola@yodamiitti.fi
	Senior Modern Management Principal
	Microsoft MVP - Windows and Devices

	2023-09-27

	https://github.com/petripaavola/ClipboardTools

.EXAMPLE
	ClipboardTools-EdgeDebuggerGraphAPIExtractPowershellIntuneModule
	
.INPUTS
	Reads clipboard text (Edge Debugger -> Save as Powershell -data)

.OUTPUTS
	"Powershell script ready" Powershell code is sent to Clipboard

.NOTES
   None

.LINK
   https://github.com/petripaavola/ClipboardTools
#>
Function ClipboardTools-EdgeDebuggerGraphAPIExtractPowershellIntuneModule {

	# We will get array of strings
	$Clipboard = Get-Clipboard -Format Text
	
	if(-not $Clipboard) {
		Write-Host "Clipboard did not contain any text`n" -ForeGroundColor Yellow
		return $null
	}

	# Remove escapes
	$Clipboard = $Clipboard.Replace('`','')

	# Find Invoke-WebRequest string
	$InvokeWebRequest = $Clipboard | Where-Object { $_ -like "Invoke-WebRequest *" }
	
	# Find uri
	$regex = '^Invoke-WebRequest.*-Uri "(.*)".*$'
	if($InvokeWebRequest -match $regex) {
			$Uri = $Matches[1]
			
			# Add escapes before $ character
			$Uri = $Uri.Replace('$','`$')

	} else {
		$Uri=$null
		Write-Host "Could not parse Uri from Edge Debugger Powershell copy" -ForegroundColor Red
		return $null
	}


	# Extract Method (=POST, PATCH, PUT, DELETE)
	$MethodString = $Clipboard | Where-Object { $_ -like "-Method *" }
	if($MethodString) {
		$regex = '^-Method "(.*)".*$'
		if($MethodString -match $regex) {
			$Method = $Matches[1]
		} else {
			# There is no Method parameter with Get method
			$Method="Get"
		}
	} else {
		# There is no Method parameter with Get method
		$Method="Get"
	}


	# Extract body json
	$BodyString = $Clipboard | Where-Object { $_ -like "-Body *" }
	if($BodyString) {
		# Examples
		# -Body ([System.Text.Encoding]::UTF8.GetBytes("{`"@odata.type`":`"#microsoft.graph.winGetApp`"}}"))

		if(($BodyString -match '^-Body "(.*)".*$') -or ($BodyString -match '^-Body \(\[System.Text.Encoding\]::UTF8\.GetBytes\("(.*)"\)\)$')) {
			$Body = $Matches[1]
			$BodyJson = $Body | ConvertFrom-Json | ConvertTo-Json -Depth 10
			
			# Add escapes to $ characters
			$BodyJson = $BodyJson.Replace('$','`$')
		} else {
			# There is no Body parameter with Get method
			$Body=$null
		}
	} else {
		# There is no Body parameter with Get method
		$Body=$null
	}

	# DEBUG
	#Write-Host "Uri=$Uri"
	#Write-Host "Method=$Method"
	#Write-Host "Body=$Body"
	#Write-Host "BodyJson=$BodyJson"

	if($BodyJson){
		# Method is POST, PUT, PATCH or DELETE with Body information
		$Paste = @"
# Connect to Graph API using Microsoft Intune module

Update-MSGraphEnvironment -SchemaVersion 'beta'
Connect-MSGraph

`$Url = `"$Uri`"
`$Body = `@`"
$BodyJson
`"`@

# Get data from Graph API
`$MSGraphRequest = `$null
`$MSGraphRequest = Invoke-MSGraphRequest -Url `$url -Content `$Body.ToString() -HttpMethod '$Method'

if(`$MSGraphRequest) {
	# Print results
	`$MSGraphRequest

} else {
	Write-Host "Did not get any results from Graph API!" -ForegroundColor Yellow
}


"@	
	} else {
		# Method is GET or DELETE without Body in request
		$Paste = @"
# Connect to Graph API using Microsoft Intune module

Update-MSGraphEnvironment -SchemaVersion 'beta'
Connect-MSGraph

`$Url = `"$Uri`"

# Get data from Graph API
`$MSGraphRequest = `$null
`$MSGraphRequest = Invoke-MSGraphRequest -Url `$url -HttpMethod '$Method'

if(`$MSGraphRequest) {
	# Print results
	`$MSGraphRequest

} else {
	Write-Host "Did not get any results from Graph API!" -ForegroundColor Yellow
}


# Get all data from Graph API (gets all paged data)
# This can be used to get all paged results from Graph API
#`$AllMSGraphRequest = Get-MSGraphAllPages -SearchResult `$MSGraphRequest
#
# Or if you used Get-MSGraphAllPages
#`$AllMSGraphRequest


"@
	}
	# DEBUG
	#Write-Host "Paste=$Paste"
	
	# Set edited info back to Clipboard
	$Paste | Set-Clipboard
}


<#
.Synopsis
	This function converts Edge Debugger Save as Powershell -script to "real" Powershell script syntax

.DESCRIPTION
	This function converts Edge Debugger Save as Powershell -script to "real" Powershell script syntax
	
	This function version creates Microsoft.Graph Powershell Module compatible code.
	
	"Real" Powershell syntax means real Powershell commands you can use in your scripts.
	Commands will do same Graph API call which you copied from Edge debugger data.
	
	Converted commands are set to clipboard so you can paste actual Powershell code to your code editor.
	And you can also run Powershell commands in Powershell console.
	
	Prerequisite for created Powershell code to work you need to install Intune Powershell Module

	You can install module with command:
	Install-Module Microsoft.Graph -Scope CurrentUser
	
	
	Author:
	Petri.Paavola@yodamiitti.fi
	Senior Modern Management Principal
	Microsoft MVP - Windows and Devices

	2023-09-27

	https://github.com/petripaavola/ClipboardTools

.EXAMPLE
	ClipboardTools-EdgeDebuggerGraphAPIExtractPowershellMGGraphModule
	
.INPUTS
	Reads clipboard text (Edge Debugger -> Save as Powershell -data)

.OUTPUTS
	"Powershell script ready" Powershell code is sent to Clipboard

.NOTES
   None

.LINK
   https://github.com/petripaavola/ClipboardTools
#>
Function ClipboardTools-EdgeDebuggerGraphAPIExtractPowershellMGGraphModule {

	# We will get array of strings
	$Clipboard = Get-Clipboard -Format Text

	if(-not $Clipboard) {
		Write-Host "Clipboard did not contain any text`n" -ForeGroundColor Yellow
		return $null
	}

	# Remove escapes
	$Clipboard = $Clipboard.Replace('`','')

	# Find Invoke-WebRequest string
	$InvokeWebRequest = $Clipboard | Where-Object { $_ -like "Invoke-WebRequest *" }
	
	# Find uri
	$regex = '^Invoke-WebRequest.*-Uri "(.*)".*$'
	if($InvokeWebRequest -match $regex) {
			$Uri = $Matches[1]
			
			# Add escapes before $ character
			$Uri = $Uri.Replace('$','`$')

	} else {
		$Uri=$null
		Write-Host "Could not parse Uri from Edge Debugger Powershell copy" -ForegroundColor Red
		return $null
	}


	# Extract Method (=POST, PATCH, PUT, DELETE)
	$MethodString = $Clipboard | Where-Object { $_ -like "-Method *" }
	if($MethodString) {
		$regex = '^-Method "(.*)".*$'
		if($MethodString -match $regex) {
			$Method = $Matches[1]
		} else {
			# There is no Method parameter with Get method
			$Method="Get"
		}
	} else {
		# There is no Method parameter with Get method
		$Method="Get"
	}


	# Extract body json
	$BodyString = $Clipboard | Where-Object { $_ -like "-Body *" }
	if($BodyString) {
		# Examples
		# -Body ([System.Text.Encoding]::UTF8.GetBytes("{`"@odata.type`":`"#microsoft.graph.winGetApp`"}}"))

		if(($BodyString -match '^-Body "(.*)".*$') -or ($BodyString -match '^-Body \(\[System.Text.Encoding\]::UTF8\.GetBytes\("(.*)"\)\)$')) {
			$Body = $Matches[1]
			$BodyJson = $Body | ConvertFrom-Json | ConvertTo-Json -Depth 10
			
			# Add escapes to $ characters
			$BodyJson = $BodyJson.Replace('$','`$')
		} else {
			# There is no Body parameter with Get method
			$Body=$null
		}
	} else {
		# There is no Body parameter with Get method
		$Body=$null
	}

	# DEBUG
	#Write-Host "Uri=$Uri"
	#Write-Host "Method=$Method"
	#Write-Host "Body=$Body"
	#Write-Host "BodyJson=$BodyJson"

	if($BodyJson){
		# Method is POST, PUT, PATCH or DELETE with Body information
		$Paste = @"
# Connect to Graph API using Microsoft Graph module

# Install Microsoft Graph module with command
# Install-Module Microsoft.Graph -Scope CurrentUser
#Connect-MgGraph

Connect-MgGraph -Scopes "DeviceManagementManagedDevices.Read.All", "DeviceManagementApps.Read.All", "DeviceManagementConfiguration.Read.All", "User.Read.All", "Group.Read.All", "GroupMember.Read.All", "Directory.Read.All"

# Install Graph Beta module with command
# Install-Module Microsoft.Graph.Beta -Scope CurrentUser
#Select-MgProfile beta

`$Uri = `"$Uri`"
`$Body = `@`"
$BodyJson
`"`@


# Note! There seems to be either a bug or a feature with POST requests with Invoke-MgGraphRequest
# In some testings command succeeds but does not return anything to Powershell pipeline
# but with -Debug option you can see that the data has been fetched from Graph API
# For now one workaround is to save data to text file which we'll do here


# Get data from Graph API
# Original request
#`$MgGraphRequest = Invoke-MgGraphRequest -Uri `$Uri -Body `$Body.ToString() -Method '$Method' -OutputType PSObject


# Workaround to save data to random named text file first with parameter -OutputFilePath
`$OutputFilePath = `"`$(`$pwd.path)/MgGraphRequest_`$(Get-Random).json`"

`$MgGraphRequest = Invoke-MgGraphRequest -Uri `$Uri -Body `$Body.ToString() -Method '$Method' -OutputFilePath `$OutputFilePath

# Read and convert json data from temporary text file
`$MgGraphRequest = Get-Content `$OutputFilePath -Raw | ConvertFrom-Json

# Remove temporary file
Remove-Item -Path `$OutputFilePath


if(`$MgGraphRequest) {
	# Print results
	# Usually you want to check values from `$MgGraphRequest.value
	Write-Host `"Print variable: MgGraphRequest`"
	`$MgGraphRequest

} else {
	Write-Host "Did not get any results from Graph API!" -ForegroundColor Yellow
}


"@	
	} else {
		# Method is GET or DELETE without Body in request
		$Paste = @"
# Connect to Graph API using Microsoft Graph module

# Install Microsoft Graph module with command
# Install-Module Microsoft.Graph -Scope CurrentUser
#Connect-MgGraph

Connect-MgGraph -Scopes "DeviceManagementManagedDevices.Read.All", "DeviceManagementApps.Read.All", "DeviceManagementConfiguration.Read.All", "User.Read.All", "Group.Read.All", "GroupMember.Read.All", "Directory.Read.All"

# Install Graph Beta module with command
# Install-Module Microsoft.Graph.Beta -Scope CurrentUser
#Select-MgProfile beta

`$Uri = `"$Uri`"

# Get data from Graph API
`$MgGraphRequest = Invoke-MgGraphRequest -Uri `$Uri -Method '$Method' -OutputType PSObject

if(`$MgGraphRequest) {
	# Print results
	# Usually you want to check values from `$MgGraphRequest.value
	Write-Host `"Print variable: MgGraphRequest`"
	`$MgGraphRequest

} else {
	Write-Host "Did not get any results from Graph API!" -ForegroundColor Yellow
}



"@
	}
	# DEBUG
	#Write-Host "Paste=$Paste"
	
	# Set edited info back to Clipboard
	$Paste | Set-Clipboard
}
