@{
    # ============================================================
    # Atlas PC Support - PSScriptAnalyzer settings
    # Compartido por desarrollo local y CI para que el lint sea identico.
    #   Uso local:  Invoke-ScriptAnalyzer -Path src -Recurse -Settings PSScriptAnalyzerSettings.psd1
    # ============================================================

    # Reglas excluidas (justificadas para este proyecto):
    #   PSAvoidUsingWriteHost            -> las tools son CLI interactivas; Write-Host es la UX correcta.
    #   PSUseBOMForUnicodeEncodedFile    -> launcher distribuible es BOM-less a proposito (irm | iex en PS 5.1).
    #   PSUseSingularNouns               -> ruido en helpers existentes; se puede reactivar tras refactor.
    ExcludeRules = @(
        'PSAvoidUsingWriteHost'
        'PSUseBOMForUnicodeEncodedFile'
        'PSUseSingularNouns'
    )

    # Severidades reportadas. El CI solo BLOQUEA en 'Error' (ver build.yml);
    # Warning/Information se muestran como anotaciones para ir mejorando.
    Severity = @('Error', 'Warning', 'Information')
}
