$pw =(Read-Host �p�X���[�h����͂��Ă������� -AsSecureString)
$encpw = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pw)
$decpw  = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($encpw)
$str1 = (([string]::concat(([security.cryptography.SHA1]::create().computehash([text.encoding]::ascii.getbytes($decpw))|%{ $_.tostring("x2")}))).ToUpper().Substring(0, 5))
$str2 = (([string]::concat(([security.cryptography.SHA1]::create().computehash([text.encoding]::ascii.getbytes($decpw))|%{ $_.tostring("x2")}))).ToUpper().Substring(6, 34))
[System.Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls11
$api = (curl https://api.pwnedpasswords.com/range/$str1)
if($api | select-string -CaseSensitive $str2 ){
	echo "`r`n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!`r`n���o���Ă��܂��B`r`n�����Ƀp�X���[�h��ύX���Ă�������`r`n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!`r`n"
}else{
	echo "���o���Ă��܂���"
}

echo "�I������ɂ͉����L�[�������Ă������� . . ."
$host.UI.RawUI.ReadKey()
