Describe 'BW.Utils.OutJson' {
    Context 'Strict mode' {
        Set-StrictMode -Version latest
        It 'should load all functions' {
            $Commands = @( Get-Command -CommandType Function -Module BW.Utils.OutJson | Select-Object -ExpandProperty Name )
            $Commands.Count | Should -Be 1
            $Commands -contains 'Out-Json' | Should -Be $true
        }
        It 'should load all aliases' {
            $Commands = @( Get-Command -CommandType Alias -Module BW.Utils.OutJson | Select-Object -ExpandProperty Name )
            $Commands.Count | Should -Be 0
        }
    }
}

Describe 'Out-Json' {
    Context 'Strict mode' {
        Set-StrictMode -Version latest
        It 'should accept a positional parameter for -Path' {
            $TempFile = New-TemporaryFile
            { Out-Json $TempFile -InputObject 'test' } | Should -Not -Throw
            Remove-Item $TempFile
        }
        It 'should overwrite existing files by default' {
            $TempFile = New-TemporaryFile
            'CONTENT' | Set-Content $TempFile
            { 1..10 | Out-Json $TempFile } | Should -Not -Throw
            Get-Content $TempFile | Should -Not -Match 'CONTENT'
            Remove-Item $TempFile
        }
        It 'should NOT overwrite existing files if -NoClobber is specified' {
            $TempFile = New-TemporaryFile
            'CONTENT' | Set-Content $TempFile
            { 1..10 | Out-Json $TempFile -NoClobber } | Should -Throw
            Get-Content $TempFile | Should -Match 'CONTENT'
            Remove-Item $TempFile
        }
        It 'should accept pipeline input' {
            $TempFile = New-TemporaryFile
            { 1..10 | Out-Json $TempFile } | Should -Not -Throw
            Remove-Item $TempFile
        }
        It 'should have output that can be parsed as JSON' {
            $TempFile = New-TemporaryFile
            1..10 | Out-Json $TempFile
            { $ParsedOutput = Get-Content $TempFile | ConvertFrom-Json } | Should -Not -Throw
            $ParsedOutput | Should -HaveCount 10
            Remove-Item $TempFile
        }

    }
}

