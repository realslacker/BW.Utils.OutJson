using namespace System.Collections
using namespace System.Text

function Out-Json {
    # .ExternalHelp BW.Utils.OutJson-help.xml

    param(

        [Parameter(
            Mandatory,
            ParameterSetName  = 'Path',
            Position = 1
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('FilePath')]
        [string]
        $Path,
 
        [Parameter(
            Mandatory,
            ParameterSetName = 'LiteralPath',
            Position = 1
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('PSPath')]
        [string]
        $LiteralPath,

        [switch]
        $Compress,

        [int]
        $Depth = 2,

        [switch]
        $UnWrapSinglton,

        [switch]
        $Force,

        [switch]
        $NoClobber,

        [Parameter( Mandatory, ValueFromPipeline )]
        $InputObject,

        [switch]
        $PassThru

    )

    # note that we do everything in the process block to avoid this
    # PowerShell bug with -PipelineVariable:
    # https://github.com/PowerShell/PowerShell/issues/10932
    process {

        # create a path splat for the Set-Content command
        $PathSplat = @{}
        switch ( $PSCmdlet.ParameterSetName ) {
            'Path'        { $PathSplat.Path = $Path }
            'LiteralPath' { $PathSplat.LiteralPath = $LiteralPath }
        }

        # if -NoClobber is specified we won't overwrite existing files.
        if ( $NoClobber -and ( Test-Path @PathSplat -PathType Leaf ) ) {

            $ResolvedPath = Resolve-Path @PathSplat

            $ExceptionMessage = "The file '$($ResolvedPath.Path)' already exists."

            throw [System.IO.IOException]::new( $ExceptionMessage )

        }
    
        # collection to hold the input
        [ArrayList]$Collection = @()

        # process the input
        $InputObject | ForEach-Object {
    
            $Collection.Add( $_ ) > $null

            if ( $PassThru ) { $_ }
        
        }

        # Because of the way we process input the input will always
        # be contained in an array, even if it's a single item. If
        # the user specifies -UnWrapSingleton the first item will be
        # extracted from the array. This more closely matches the
        # output of ConvertTo-Json on the pipeline.
        if ( $Collection.Count -eq 1 -and $UnWrapSinglton ) {

            $InputObject = $Collection[0]

        } else {

            $InputObject = $Collection

        }

        # convert the input to json
        $JsonOutput = ConvertTo-Json -InputObject $InputObject -Depth $Depth -Compress:$Compress

        # convert the json to a byte array
        $JsonBytes = [UTF8Encoding]::new($false).GetBytes( $JsonOutput )

        # output to a file
        Set-Content @PathSplat -Value $JsonBytes -Encoding Byte
        
    }

}

