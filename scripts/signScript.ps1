dir Cert:\CurrentUser

$params = @{
    Type = 'Custom'
    Container = 'test*'
    Subject = 'E=ricardo.maximino@brasatech.es,CN=Ricardo Maximino'
    TextExtension = @(
        '2.5.29.37={text}1.3.6.1.5.5.7.3.3'
        )
    KeyUsage = 'DigitalSignature'
    KeyAlgorithm = 'RSA'
    KeyLength = 2048
    NotAfter = (Get-Date).AddMonths(6)
}

$cert=New-SelfSignedCertificate @params 


dir Cert:\CurrentUser\My -OutVariable certificates

$certificate=$certificates[5]


Set-AuthenticodeSignature -Certificate $Certificate -FilePath C:\Users\ricardomaximino\work\git\powershell\scripts\script.ps1