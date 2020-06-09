---
external help file: BW.Utils.OutJson-help.xml
Module Name: BW.Utils.OutJson
online version:
schema: 2.0.0
---

# Out-Json

## SYNOPSIS
Implements Out-Json as a function to support outputting JSON files that are standards compliant.

## SYNTAX

### Path
```
Out-Json [-Path] <String> [-Depth <Int32>] [-Compress] [-UnWrapSinglton] [-Force] -InputObject <Object>
 [-PassThru] [<CommonParameters>]
```

### LiteralPath
```
Out-Json [-LiteralPath] <String> [-Depth <Int32>] [-Compress] [-UnWrapSinglton] [-Force]
 -InputObject <Object> [-PassThru] [<CommonParameters>]
```

## DESCRIPTION
Implements Out-Json as a function to support outputting JSON files that are standards compliant.
By default all output is wrapped in an array. Solves issues with byte encoding that happen with
the "ConvertTo-Json | Set-Content" pipeline.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-Process explorer | Out-Json -Path .\explorer.json
```

Output a JSON file containing all of the output from Get-Process.

### Example 2
```powershell
PS C:\> $Process = Get-Process explorer | Select-Object -First 1
PS C:\> Out-Json -Path .\explorer.json -InputObject $Process -UnWrapSingleton
```

Output a JSON file containing just one explorer process. Note that by using -UnWrapSingleton the
resulting JSON is a single object, not an array of objects.

## PARAMETERS

### -Path
Specifies the path to the output file.

```yaml
Type: String
Parameter Sets: Path
Aliases: FilePath
Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath
Specifies the path to the output file. The LiteralPath parameter is used exactly as it is typed.
Wildcard characters are not accepted. If the path includes escape characters, enclose it in
single quotation marks. Single quotation marks tell PowerShell not to interpret any characters
as escape sequences. For more information, see [about_Quoting_Rules](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_quoting_rules).

```yaml
Type: String
Parameter Sets: LiteralPath
Aliases: PSPath
Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Compress
Omits white space and indented formatting in the output string.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Depth
Specifies how many levels of contained objects are included in the JSON representation. The default
value is 2.

```yaml
Type: Int32
Parameter Sets: (All)
Required: False
Position: Named
Default value: 2
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Overrides the read-only attribute and overwrites an existing read-only file. The Force parameter does
not override security restrictions.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoClobber
NoClobber prevents an existing file from being overwritten and displays a message that the file already exists.
By default, if a file exists in the specified path, Out-Json overwrites the file without warning.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies the objects to be written to the file. Enter a variable that contains the objects or expression that gets
the objects.

```yaml
Type: Object
Parameter Sets: (All)
Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -PassThru
Send the objects down the pipeline.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UnWrapSinglton
Because of the way we process input the input will always be contained in an array, even if it's a single item. If
the user specifies -UnWrapSingleton the first item will be extracted from the array. This more closely matches the
output of ConvertTo-Json on the pipeline.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
