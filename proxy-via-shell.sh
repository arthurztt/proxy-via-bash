#!/bin/bash

# Define o endereço do Proxy
PROXY_SERVER="192.168.0.1:3128"

# Executa a verificação e alternância via PowerShell para evitar erros de registro no Windows
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "
    \$regPath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings'
    \$current = (Get-ItemProperty -Path \$regPath).ProxyEnable

    if (\$current -eq 0 -or \$null -eq \$current) {
        # Ativa o Proxy e define o IP/Porta
        Set-ItemProperty -Path \$regPath -Name ProxyServer -Value '$PROXY_SERVER'
        Set-ItemProperty -Path \$regPath -Name ProxyEnable -Value 1
        Write-Host '⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼'
        Write-Host 'Proxy Control ID: ATIVADO com sucesso!'
        Write-Host 'IP do Proxy : $PROXY_SERVER'
        Write-Host '⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼'
        Write-Host '     AVISO : Para desativar o Proxy, basta apertar no Icone na Área de Trabalho novamente!  '
    } else {
        # Desativa o Proxy
        Set-ItemProperty -Path \$regPath -Name ProxyEnable -Value 0
        Write-Host '⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼'
        Write-Host '    Proxy Control ID: DESATIVADO!⎸   '
        Write-Host '⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼⎼'
    }

    # Força a atualização da interface do Windows e navegadores sem reiniciar
    \$code = @'
    [DllImport(\"wininet.dll\", SetLastError = true)]
    public static extern bool InternetSetOption(IntPtr hInternet, int dwOption, IntPtr lpBuffer, int dwBufferLength);
'@
    \$type = Add-Type -MemberDefinition \$code -Name 'WinInet' -Namespace 'WinInet' -PassThru
    \$type::InternetSetOption([IntPtr]::Zero, 39, [IntPtr]::Zero, 0) | Out-Null
    \$type::InternetSetOption([IntPtr]::Zero, 37, [IntPtr]::Zero, 0) | Out-Null
"

sleep 1.5
