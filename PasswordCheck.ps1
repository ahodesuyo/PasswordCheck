$pw =(Read-Host パスワードを入力してください -AsSecureString)
$encpw = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pw)
$decpw  = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($encpw)
$str1 = (([string]::concat(([security.cryptography.SHA1]::create().computehash([text.encoding]::ascii.getbytes($decpw))|%{ $_.tostring("x2")}))).ToUpper().Substring(0, 5))
$str2 = (([string]::concat(([security.cryptography.SHA1]::create().computehash([text.encoding]::ascii.getbytes($decpw))|%{ $_.tostring("x2")}))).ToUpper().Substring(6, 34))
[System.Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls11
$api = (curl https://api.pwnedpasswords.com/range/$str1)
if($api | select-string -CaseSensitive $str2 ){
	echo "`r`n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!`r`n            流出しています。`r`n   直ちにパスワードを変更してください`r`n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!`r`n"
}else{
	echo "`r`n流出していません`r`n"
}

echo "終了するには何かキーを押してください . . ."
$host.UI.RawUI.ReadKey()
